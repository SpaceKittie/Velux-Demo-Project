select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      





with validation_errors as (

    select
        event_timestamp, device_id
    from VELUX_DEV.STAGING.stg_iot_data
    group by event_timestamp, device_id
    having count(*) > 1

)

select *
from validation_errors



      
    ) dbt_internal_test