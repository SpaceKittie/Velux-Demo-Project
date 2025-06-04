-- models/staging/stg_accuweather_hourly.sql

WITH source_data AS (
    -- Ensure your source is correctly defined in sources.yml
    -- Example: source('accuweather_marketplace', 'TOP_CITY_HOURLY_METRIC')
    SELECT * FROM SAMPLE_OF_ACCUWEATHERS_HISTORICAL_WEATHER_DATA.HISTORICAL.TOP_CITY_HOURLY_METRIC
)
SELECT
    -- Identifiers & Context
    CITY_NAME AS city_name,
    COUNTRY_CODE AS country_code,
    DATE_TRUNC('hour', DATETIME) AS weather_timestamp_hour, -- Standardize to hourly grain
    LATITUDE AS latitude,
    LONGITUDE AS longitude,
    OFFSET_GMT AS gmt_offset,

    -- Selected Weather Metrics (units are assumed based on common standards)
    TEMPERATURE AS outdoor_temperature_celsius,             -- Assuming Celsius
    TEMPERATURE_DEW_POINT AS dew_point_temperature_celsius, -- Assuming Celsius
    PRESSURE_MSL AS mean_sea_level_pressure_hpa,          -- Assuming Hectopascals
    WIND_SPEED AS wind_speed_m_s,                         -- Assuming meters per second
    WIND_GUST AS wind_gust_m_s,                           -- Assuming meters per second
    WIND_DIRECTION AS wind_direction_degrees,               -- Assuming degrees
    VISIBILITY AS visibility_km,                            -- Assuming kilometers
    SOLAR_IRRADIANCE AS solar_irradiance_w_m2,              -- Assuming Watts per square meter
    INDEX_UV AS uv_index,
    MINUTES_OF_SUN AS sunshine_duration_minutes,
    PRECIPITATION_LWE AS precipitation_lwe_mm,              -- Assuming Liquid Water Equivalent in millimeters
    PRECIPITATION_LWE_RATE AS precipitation_lwe_rate_mm_hr, -- Assuming millimeters per hour
    PRECIPITATION_TYPE_DESC AS precipitation_type_description

FROM source_data
-- Optional: Add any basic filtering if necessary, e.g., for specific date ranges during development
-- WHERE DATETIME >= '2023-01-01' -- Example filter