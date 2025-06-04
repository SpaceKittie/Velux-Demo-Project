select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select event_timestamp
from VELUX_DEV.STAGING.int_iot_data_with_weather
where event_timestamp is null



      
    ) dbt_internal_test