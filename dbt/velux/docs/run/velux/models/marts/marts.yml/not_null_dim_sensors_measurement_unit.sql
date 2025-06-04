select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select measurement_unit
from VELUX_DEV.MARTS.dim_sensors
where measurement_unit is null



      
    ) dbt_internal_test