select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select day_of_week
from VELUX_DEV.MARTS.dim_time
where day_of_week is null



      
    ) dbt_internal_test