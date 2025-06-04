
  
    

        create or replace transient table VELUX_DEV.MARTS.dim_device
         as
        (-- models/marts/dim_device.sql

WITH distinct_devices AS (
    SELECT DISTINCT
        device_id
    FROM VELUX_DEV.STAGING.int_iot_data_unpivotted
    WHERE device_id IS NOT NULL
)

SELECT
    ----------  ids
    md5(cast(coalesce(cast(distinct_devices.device_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS device_id, -- Surrogate primary key

    ---------- strings
    distinct_devices.device_id AS device_natural_key -- Natural key from source

    -- No numerics, booleans, dates, or timestamps in this dimension
FROM distinct_devices
ORDER BY distinct_devices.device_id -- Order by the natural key for consistency
        );
      
  