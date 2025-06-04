select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select sensor_type
from VELUX_DEV.STAGING.int_iot_data_with_weather
where sensor_type is null



      
    ) dbt_internal_test