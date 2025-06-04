

with home_data as (
    select * from VELUX_DEV.STAGE.int_combined_home_data
),

weather_data as (
    select 
        -- We need to transform the weather data to match our home data timestamps
        -- This is a simplified approach assuming we can match by closest hour
        latitude,
        longitude,
        temperature as outdoor_temp_c,
        precipitation_type,
        precipitation_type_desc,
        wind_speed,
        pressure,
        solar_irradiance,
        -- For this example, we're creating a fake timestamp
        -- In a real implementation, you would join on actual timestamps
        date_trunc('hour', convert_timezone('UTC', current_timestamp())) as weather_timestamp
    from VELUX_DEV.STAGE.stg_accuweather__top_city_hourly_metric
),

-- Join home data with closest weather data
-- In a real implementation, you would join based on location and timestamp proximity
combined as (
    select
        h.home_data_id,
        h.event_timestamp,
        h.room,
        h.temperature_c as indoor_temp_c,
        w.outdoor_temp_c,
        h.humidity_pct as indoor_humidity_pct,
        -- Assuming a constant outdoor humidity for this example
        -- In a real implementation, this would come from weather data
        cast(null as float) as outdoor_humidity_pct,
        h.co2_ppm,
        h.light_lux,
        w.solar_irradiance,
        w.precipitation_type_desc,
        w.wind_speed
    from home_data h
    -- This is a cross join for demonstration purposes
    -- In a real implementation, you would join on location and timestamp
    cross join weather_data w
    -- Limit for demonstration purposes
    limit 1000
)

select
    -- Generate a surrogate key for the fact record
    md5(cast(coalesce(cast(event_timestamp as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(room as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as id,
    event_timestamp,
    room,
    indoor_temp_c,
    outdoor_temp_c,
    indoor_humidity_pct,
    outdoor_humidity_pct,
    co2_ppm,
    light_lux,
    solar_irradiance,
    precipitation_type_desc,
    wind_speed
from combined