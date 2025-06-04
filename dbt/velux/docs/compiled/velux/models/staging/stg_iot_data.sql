with source_data as (
    select *
    from velux_dev.raw.iot_data
)

select
    datetime::timestamp_ntz as event_timestamp,
    country::varchar as country,
    city::varchar as city,
    device_id::varchar as device_id,
    co2_bedroom_ppm::float as co2_bedroom_ppm,
    co2_kitchen_ppm::float as co2_kitchen_ppm,
    rh_bedroom_pct::float as rh_bedroom_pct,
    rh_kitchen_pct::float as rh_kitchen_pct,
    rh_outdoor_pct::float as rh_outdoor_pct,
    indoor_temperature_c::float as indoor_temperature_c,
    outdoor_temperature_c::float as outdoor_temperature_c

from source_data