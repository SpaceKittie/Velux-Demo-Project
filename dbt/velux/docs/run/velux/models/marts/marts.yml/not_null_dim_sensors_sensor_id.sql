select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select sensor_id
from VELUX_DEV.MARTS.dim_sensors
where sensor_id is null



      
    ) dbt_internal_test