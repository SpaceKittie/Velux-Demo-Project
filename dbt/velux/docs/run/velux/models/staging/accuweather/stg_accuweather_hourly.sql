
  create or replace   view VELUX_DEV.STAGING.stg_accuweather_hourly
  
    
    
(
  
    "WEATHER_TIMESTAMP" COMMENT $$Timestamp of the weather reading.$$, 
  
    "CITY_NAME" COMMENT $$Name of the city for the weather reading.$$, 
  
    "COUNTRY_CODE" COMMENT $$Country code for weather reading.$$, 
  
    "OUTDOOR_TEMPERATURE_CELSIUS" COMMENT $$Outdoor temperature in Celsius.$$, 
  
    "DEW_POINT_TEMPERATURE_CELSIUS" COMMENT $$Dew point temperature in Celsius.$$, 
  
    "MEAN_SEA_LEVEL_PRESSURE_HPA" COMMENT $$Mean sea level pressure in hPa.$$, 
  
    "WIND_SPEED_MS" COMMENT $$Wind speed in meters per second.$$, 
  
    "VISIBILITY_KM" COMMENT $$Visibility in kilometers.$$, 
  
    "SOLAR_IRRADIANCE_W_M2" COMMENT $$Solar irradiance in Watts per square meter.$$, 
  
    "UV_INDEX" COMMENT $$UV index.$$, 
  
    "SUNSHINE_DURATION_MINUTES" COMMENT $$Duration of sunshine in minutes.$$, 
  
    "PRECIPITATION_TYPE_DESCRIPTION" COMMENT $$Description of precipitation type.$$
  
)

   as (
    


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
  );

