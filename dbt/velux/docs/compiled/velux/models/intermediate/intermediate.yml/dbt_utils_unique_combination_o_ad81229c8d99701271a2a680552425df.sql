





with validation_errors as (

    select
        event_timestamp, device_id, room, sensor_type
    from VELUX_DEV.STAGING.int_iot_data_unpivotted
    group by event_timestamp, device_id, room, sensor_type
    having count(*) > 1

)

select *
from validation_errors


