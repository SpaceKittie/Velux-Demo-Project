select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select season
from VELUX_DEV.MARTS.dim_time
where season is null



      
    ) dbt_internal_test