select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select device_id
from VELUX_DEV.STAGING.int_iot_data_with_weather
where device_id is null



      
    ) dbt_internal_test