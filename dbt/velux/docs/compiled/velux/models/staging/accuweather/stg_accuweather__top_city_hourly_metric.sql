

with source as (
    select * from SAMPLE_OF_ACCUWEATHERS_HISTORICAL_WEATHER_DATA.HISTORICAL.TOP_CITY_HOURLY_METRIC
),

renamed as (
    select
        -- Location data
        latitude,
        longitude,
        offset_gmt,
        
        -- Precipitation data
        precipitation_type,
        precipitation_type_desc,
        precipitation_intensity,
        precipitation_lwe,
        precipitation_lwe_rate,
        minutes_of_precipitation,
        minutes_of_rain,
        minutes_of_snow,
        minutes_of_ice,
        minutes_of_sleet,
        minutes_of_freezing_rain,
        rain_lwe,
        rain_lwe_rate,
        snow_lwe,
        snow_lwe_rate,
        ice_lwe,
        ice_lwe_rate,
        sleet_lwe,
        sleet_lwe_rate,
        
        -- Snow data
        snow,
        snow_depth,
        snow_cover,
        snow_drifting_intensity,
        snow_type_desc,
        snow_liquid_ratio_accuweather,
        snow_liquid_ratio_cobb_2005,
        snow_liquid_ratio_cobb_2011,
        snow_liquid_ratio_kuchera,
        snow_liquid_ratio_ncep,
        
        -- Temperature data
        temperature,
        temperature_dew_point,
        temperature_heat_index,
        temperature_realfeel,
        temperature_realfeel_shade,
        temperature_wetbulb,
        temperature_wetbulb_globe,
        temperature_wind_chill,
        
        -- Soil data
        temperature_soil_1,
        temperature_soil_2,
        temperature_soil_3,
        temperature_soil_4,
        moisture_soil_1,
        moisture_soil_2,
        moisture_soil_3,
        moisture_soil_4,
        
        -- Wind data
        wind_direction,
        wind_speed,
        wind_gust,
        wind_gust_instantaneous,
        
        -- Other atmospheric data
        pressure,
        pressure_msl,
        visibility,
        index_uv,
        
        -- Solar data
        minutes_of_sun,
        solar_irradiance,
        solar_radiation_net
    from source
)

select * from renamed