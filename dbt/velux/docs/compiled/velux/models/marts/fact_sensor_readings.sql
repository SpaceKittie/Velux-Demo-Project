-- models/marts/fact_sensor_readings.sql
-- Fact table containing sensor readings with weather data

WITH combined_data AS (
    SELECT * FROM VELUX_DEV.STAGING.int_iot_data_with_weather
),

dim_times AS (
    SELECT * FROM VELUX_DEV.MARTS.dim_time
),

dim_locations AS (
    SELECT * FROM VELUX_DEV.MARTS.dim_locations
),

dim_sensors AS (
    SELECT * FROM VELUX_DEV.MARTS.dim_sensors
)

SELECT
    ---------- ids
    md5(cast(coalesce(cast(combined_data.event_timestamp as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(combined_data.device_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(combined_data.room as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(combined_data.sensor_type as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS reading_id,
    dim_times.time_id,
    dim_locations.location_id,
    dim_sensors.sensor_id,
    combined_data.device_id,
    
    ---------- timestamps
    combined_data.event_timestamp,
    combined_data.weather_timestamp,
    
    ---------- numerics
    combined_data.sensor_value,
    
    -- Weather metrics
    combined_data.outdoor_temperature_celsius,
    combined_data.dew_point_temperature_celsius,
    combined_data.mean_sea_level_pressure_hpa,
    combined_data.wind_speed_ms,
    combined_data.visibility_km,
    combined_data.solar_irradiance_w_m2,
    combined_data.uv_index,
    combined_data.sunshine_duration_minutes,
    
    ---------- strings
    combined_data.precipitation_type_description

FROM combined_data
JOIN dim_times ON combined_data.event_timestamp = dim_times.event_timestamp
JOIN dim_locations ON combined_data.iot_city = dim_locations.city AND combined_data.iot_country = dim_locations.country
JOIN dim_sensors ON combined_data.room = dim_sensors.room AND combined_data.sensor_type = dim_sensors.sensor_type