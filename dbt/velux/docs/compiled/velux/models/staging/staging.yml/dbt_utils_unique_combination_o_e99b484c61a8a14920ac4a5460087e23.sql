





with validation_errors as (

    select
        event_timestamp, device_id
    from VELUX_DEV.STAGING.stg_iot_data
    group by event_timestamp, device_id
    having count(*) > 1

)

select *
from validation_errors


