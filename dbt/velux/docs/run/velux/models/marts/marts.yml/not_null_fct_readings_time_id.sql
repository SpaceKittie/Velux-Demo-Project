select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select time_id
from VELUX_DEV.MARTS.fct_readings
where time_id is null



      
    ) dbt_internal_test