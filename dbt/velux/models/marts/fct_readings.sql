{{ config(
    materialized='incremental',
    unique_key='reading_id',
    cluster_by=['event_date'],
    tags=['marts', 'dev'],
    meta={
        'snowflake_tags': {
            'GOV.TAGS.data_domain': 'VELUX_IOT',
            'GOV.TAGS.data_sensitivity': ("public" if target.name == 'prod' else "internal"),
            'GOV.TAGS.environment': ("prod" if target.name == 'prod' else "dev"),
            'GOV.TAGS.retention_days': '365'
        }
    },
    post_hook=["{{ apply_snowflake_tags() }}"]
) }}

WITH iot_combined AS (
    SELECT 
        iw.country,
        iw.city,
        iw.sensor_type,
        iw.sensor_value,
        iw.room,
        iw.device_id,
        iw.outdoor_temperature_celsius,
        iw.dew_point_temperature_celsius,
        iw.mean_sea_level_pressure_hpa,
        iw.wind_speed_ms,
        iw.visibility_km,
        iw.solar_irradiance_w_m2,
        iw.uv_index,
        iw.sunshine_duration_minutes,
        iw.precipitation_type_description,
        iw.event_timestamp AS iot_event_timestamp, 

        {{ dbt_utils.generate_surrogate_key([
            'iw.event_timestamp', 
            'iw.sensor_type', 
            'iw.room',
            'iw.device_id'
        ]) }} AS reading_id

     FROM {{ ref('int_iot_data_with_weather') }} iw 
    {% if is_incremental() %}
    WHERE iw.event_timestamp > (SELECT MAX(t.event_timestamp) FROM {{ this }} AS t)
    {% endif %}
),

dim_time AS (
    SELECT * FROM {{ ref('dim_time') }}
),

dim_locations AS (
    SELECT * FROM {{ ref('dim_locations') }}
),

dim_sensors AS (
    SELECT * FROM {{ ref('dim_sensors') }}
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
    ON iot_combined.iot_event_timestamp = dim_time.event_timestamp
LEFT JOIN dim_locations 
    ON iot_combined.city = dim_locations.city 
   AND iot_combined.country = dim_locations.country
LEFT JOIN dim_sensors 
    ON iot_combined.room = dim_sensors.room 
   AND iot_combined.sensor_type = dim_sensors.sensor_type
   AND iot_combined.device_id = dim_sensors.device_id
