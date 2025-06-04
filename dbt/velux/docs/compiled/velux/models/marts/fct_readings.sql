



WITH iot_combined AS (
    SELECT 
        event_timestamp,
        country,
        city,
        sensor_type,
        sensor_value,
        room,
        device_id,
        outdoor_temperature_celsius,
        dew_point_temperature_celsius,
        mean_sea_level_pressure_hpa,
        wind_speed_ms,
        visibility_km,
        solar_irradiance_w_m2,
        uv_index,
        sunshine_duration_minutes,
        precipitation_type_description,

        md5(cast(coalesce(cast(event_timestamp as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(sensor_type as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(room as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(device_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS reading_id


     FROM VELUX_DEV.STAGING.int_iot_data_with_weather
    
    WHERE event_timestamp > (SELECT MAX(event_timestamp) FROM VELUX_DEV.MARTS.fct_readings)
    
),

dim_time AS (
    SELECT * FROM VELUX_DEV.MARTS.dim_time
),

dim_locations AS (
    SELECT * FROM VELUX_DEV.MARTS.dim_locations
),

dim_sensors AS (
    SELECT * FROM VELUX_DEV.MARTS.dim_sensors
)

SELECT
    iot_combined.reading_id,

    dim_time.time_id,
    dim_locations.location_id,
    dim_sensors.sensor_id,
    dim_time.event_date,
    dim_time.event_timestamp,
    dim_sensors.device_id,

    iot_combined.sensor_value,
    iot_combined.outdoor_temperature_celsius,
    iot_combined.dew_point_temperature_celsius,
    iot_combined.mean_sea_level_pressure_hpa,
    iot_combined.wind_speed_ms,
    iot_combined.visibility_km,
    iot_combined.solar_irradiance_w_m2,
    iot_combined.uv_index,
    iot_combined.sunshine_duration_minutes,
    iot_combined.precipitation_type_description

FROM iot_combined
LEFT JOIN dim_time 
    ON iot_combined.event_timestamp = dim_time.event_timestamp
LEFT JOIN dim_locations 
    ON iot_combined.city = dim_locations.city 
   AND iot_combined.country = dim_locations.country
LEFT JOIN dim_sensors 
    ON iot_combined.room = dim_sensors.room 
   AND iot_combined.sensor_type = dim_sensors.sensor_type
   AND iot_combined.device_id = dim_sensors.device_id -- Added device_id to join condition