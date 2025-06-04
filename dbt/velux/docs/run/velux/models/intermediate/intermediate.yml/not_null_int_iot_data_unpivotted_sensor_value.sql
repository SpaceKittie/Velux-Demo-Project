select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select sensor_value
from VELUX_DEV.STAGING.int_iot_data_unpivotted
where sensor_value is null



      
    ) dbt_internal_test