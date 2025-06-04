
  
    

create or replace transient table VELUX_DEV.STAGE.int_combined_home_data
    

    
    as (

with home_data as (
    select * from VELUX_DEV.STAGE.stg_iot_raw__home_data
),

home_data_2 as (
    select * from VELUX_DEV.STAGE.stg_iot_raw__home_data_2
),

-- Combine data from home_data table
home_data_transformed as (
    select
        home_data_id,
        -- Create a timestamp from date and time
        

    dateadd(
        second,
        datediff(second, cast('00:00:00' as time), event_time),
        event_date
        )

 as event_timestamp,
        'dining' as room,
        co2_dining_ppm as co2_ppm,
        indoor_temp_c as temperature_c,
        rel_humidity_dining_pct as humidity_pct,
        light_dining_lux as light_lux
    from home_data
    
    union all
    
    select
        home_data_id,
        

    dateadd(
        second,
        datediff(second, cast('00:00:00' as time), event_time),
        event_date
        )

 as event_timestamp,
        'room' as room,
        co2_room_ppm as co2_ppm,
        indoor_temp_c as temperature_c,
        rel_humidity_room_pct as humidity_pct,
        light_room_lux as light_lux
    from home_data
),

-- Process data from home_data_2 table
home_data_2_transformed as (
    select
        home_data_2_id as home_data_id,
        datetime_utc as event_timestamp,
        room,
        -- For simplicity, we're assuming these are the measurements when sensor = 'CO2'
        case when sensor = 'CO2' then average_value end as co2_ppm,
        case when sensor = 'Temperature' then average_value end as temperature_c,
        case when sensor = 'Humidity' then average_value end as humidity_pct,
        case when sensor = 'Light' then average_value end as light_lux
    from home_data_2
),

-- Combine both datasets
combined as (
    select * from home_data_transformed
    
    union all
    
    select * from home_data_2_transformed
    where co2_ppm is not null 
       or temperature_c is not null 
       or humidity_pct is not null 
       or light_lux is not null
)

select
    -- Generate a surrogate key for the combined record
    md5(cast(coalesce(cast(event_timestamp as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(room as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as home_data_id,
    event_timestamp,
    room,
    co2_ppm,
    temperature_c,
    humidity_pct,
    light_lux
from combined
    )
;


  