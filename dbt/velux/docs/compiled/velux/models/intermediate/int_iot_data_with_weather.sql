

WITH iot_unpivotted_data AS (
    SELECT
        event_timestamp,
        country,
        city,
        device_id,
        room,
        sensor_type,
        sensor_value
    FROM VELUX_DEV.STAGING.int_iot_data_unpivotted
),

staged_weather_data AS (
    SELECT
        weather_timestamp,
        city_name,
        country_code,
        outdoor_temperature_celsius,
        dew_point_temperature_celsius,
        mean_sea_level_pressure_hpa,
        wind_speed_ms,
        visibility_km,
        solar_irradiance_w_m2,
        uv_index,
        sunshine_duration_minutes,
        precipitation_type_description
    FROM VELUX_DEV.STAGING.stg_accuweather_hourly
)
SELECT
    iot_unpivotted_data.event_timestamp,
    iot_unpivotted_data.country,
    iot_unpivotted_data.city,      
    iot_unpivotted_data.device_id,
    iot_unpivotted_data.room,
    iot_unpivotted_data.sensor_type,
    iot_unpivotted_data.sensor_value,

    staged_weather_data.outdoor_temperature_celsius,
    staged_weather_data.dew_point_temperature_celsius,
    staged_weather_data.mean_sea_level_pressure_hpa,
    staged_weather_data.wind_speed_ms,
    staged_weather_data.visibility_km,
    staged_weather_data.solar_irradiance_w_m2,
    staged_weather_data.uv_index,
    staged_weather_data.sunshine_duration_minutes,
    staged_weather_data.precipitation_type_description

FROM iot_unpivotted_data
LEFT JOIN staged_weather_data
    ON iot_unpivotted_data.city = staged_weather_data.city_name
    AND iot_unpivotted_data.event_timestamp = staged_weather_data.weather_timestamp
    AND iot_unpivotted_data.country = staged_weather_data.country_code