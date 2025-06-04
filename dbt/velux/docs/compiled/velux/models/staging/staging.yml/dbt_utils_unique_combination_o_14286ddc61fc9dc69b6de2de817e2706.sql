





with validation_errors as (

    select
        weather_timestamp, city_name, country_code
    from VELUX_DEV.STAGING.stg_accuweather_hourly
    group by weather_timestamp, city_name, country_code
    having count(*) > 1

)

select *
from validation_errors


