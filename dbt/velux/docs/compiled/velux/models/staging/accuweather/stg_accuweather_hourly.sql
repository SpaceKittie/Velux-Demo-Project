


WITH source_data AS (
    SELECT * FROM SAMPLE_OF_ACCUWEATHERS_HISTORICAL_WEATHER_DATA.HISTORICAL.TOP_CITY_HOURLY_METRIC
)
SELECT
    DATETIME AS weather_timestamp,
    CITY_NAME AS city_name,
    COUNTRY_CODE AS country_code,
    TEMPERATURE::FLOAT AS outdoor_temperature_celsius,           
    TEMPERATURE_DEW_POINT::FLOAT AS dew_point_temperature_celsius, 
    PRESSURE_MSL::FLOAT AS mean_sea_level_pressure_hpa,          
    WIND_SPEED::FLOAT AS wind_speed_ms,                                                             
    VISIBILITY::FLOAT AS visibility_km,                            
    SOLAR_IRRADIANCE::FLOAT AS solar_irradiance_w_m2,              
    INDEX_UV::FLOAT AS uv_index,
    MINUTES_OF_SUN::FLOAT AS sunshine_duration_minutes,
    PRECIPITATION_TYPE_DESC AS precipitation_type_description

FROM source_data