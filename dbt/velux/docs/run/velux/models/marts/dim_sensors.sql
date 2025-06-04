
  
    

        create or replace transient table VELUX_DEV.MARTS.dim_sensors
          
  (
    sensor_id text,
    device_id text,
    room text,
    sensor_type text,
    measurement_unit text
    
    )

          
        
         as
        (
    select sensor_id, device_id, room, sensor_type, measurement_unit
    from (
        

WITH sensor_types AS (
    SELECT
        sensor_type,
        CASE
            WHEN sensor_type = 'co2(parts per million)' THEN 'ppm'
            WHEN sensor_type = 'relative_humidity(percent)' THEN '%'
            WHEN sensor_type = 'temperature(celsius)' THEN '°C'
            ELSE 'unknown'
        END AS measurement_unit
    FROM (
        SELECT DISTINCT sensor_type
        FROM VELUX_DEV.STAGING.int_iot_data_with_weather
    )
),

rooms AS (
    SELECT DISTINCT room
    FROM VELUX_DEV.STAGING.int_iot_data_with_weather
    WHERE room IS NOT NULL
),

sensor_data AS (
    SELECT DISTINCT
        room,
        sensor_type,
        device_id
    FROM VELUX_DEV.STAGING.int_iot_data_with_weather
)

SELECT
    md5(cast(coalesce(cast(sd.sensor_type as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(sd.device_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(sd.room as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS sensor_id,
    sd.device_id,
    sd.room,
    sd.sensor_type,
    st.measurement_unit

FROM sensor_data sd
JOIN sensor_types st ON sd.sensor_type = st.sensor_type
    ) as model_subq
        );
      
  