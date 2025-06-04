select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select room
from VELUX_DEV.MARTS.dim_sensors
where room is null



      
    ) dbt_internal_test