

with source as (
    select * from VELUX_DEV.RAW.HOME_DATA
),

renamed as (
    select
        -- IDs
        id as home_data_id,
        
        -- Dates and times
        event_date,
        event_time,
        
        -- CO2 measurements
        co2_dining_ppm,
        co2_room_ppm,
        
        -- Temperature
        indoor_temp_c,
        
        -- Humidity
        rel_humidity_dining_pct,
        rel_humidity_room_pct,
        outdoor_rel_humidity_pct,
        
        -- Light
        light_dining_lux,
        light_room_lux,
        
        -- Meteorological data
        meteo_rain_mm,
        meteo_sun_dusk_wm2,
        meteo_sun_east_wm2,
        meteo_sun_south_wm2,
        meteo_sun_west_wm2,
        meteo_wind_ms,
        meteo_irradiance_wm2,
        
        -- Time dimensions
        day_of_week
    from source
)

select * from renamed