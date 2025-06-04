
  
    

        create or replace transient table VELUX_DEV.MARTS.dim_sensor_attributes
         as
        (-- models/marts/dim_sensor_attributes.sql

WITH int_data AS (
    SELECT
        room,
        sensor_type -- This is the combined field e.g., 'co2(parts per million)'
    FROM VELUX_DEV.STAGING.int_iot_data_unpivotted
    WHERE room IS NOT NULL 
      AND sensor_type IS NOT NULL 
      AND sensor_type != 'unknown' -- Exclude records that won't be classifiable
),

parsed_sensor_attributes AS (
    SELECT DISTINCT
        COALESCE(int_data.room, 'N/A') AS room, -- Use COALESCE as a safeguard, though filtered in int_data
        
        -- Extract sensor name (part before '(')
        CASE
            WHEN POSITION('(' IN int_data.sensor_type) > 0
            THEN TRIM(SUBSTRING(int_data.sensor_type, 1, POSITION('(' IN int_data.sensor_type) - 1))
            ELSE TRIM(int_data.sensor_type) -- Handle cases where there might not be a unit in parentheses
        END AS sensor_type_name,
        
        -- Extract unit (part inside '()')
        CASE
            WHEN POSITION('(' IN int_data.sensor_type) > 0 AND POSITION(')' IN int_data.sensor_type) > POSITION('(' IN int_data.sensor_type)
            THEN TRIM(SUBSTRING(int_data.sensor_type, POSITION('(' IN int_data.sensor_type) + 1, POSITION(')' IN int_data.sensor_type) - POSITION('(' IN int_data.sensor_type) - 1))
            ELSE 'N/A' -- Default if no unit is found or format is unexpected
        END AS sensor_unit
    FROM int_data
)

SELECT
    ----------  ids
    md5(cast(coalesce(cast(parsed_sensor_attributes.room as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(parsed_sensor_attributes.sensor_type_name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(parsed_sensor_attributes.sensor_unit as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS sensor_attributes_id, -- Surrogate primary key

    ---------- strings
    parsed_sensor_attributes.room,
    parsed_sensor_attributes.sensor_type_name,
    parsed_sensor_attributes.sensor_unit

    -- No numerics, booleans, dates, or timestamps in this dimension
FROM parsed_sensor_attributes
ORDER BY 
    parsed_sensor_attributes.room, 
    parsed_sensor_attributes.sensor_type_name, 
    parsed_sensor_attributes.sensor_unit
        );
      
  