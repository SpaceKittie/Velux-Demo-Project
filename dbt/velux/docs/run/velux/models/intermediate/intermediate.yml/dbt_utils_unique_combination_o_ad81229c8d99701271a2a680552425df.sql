select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      





with validation_errors as (

    select
        event_timestamp, device_id, room, sensor_type
    from VELUX_DEV.STAGING.int_iot_data_unpivotted
    group by event_timestamp, device_id, room, sensor_type
    having count(*) > 1

)

select *
from validation_errors



      
    ) dbt_internal_test