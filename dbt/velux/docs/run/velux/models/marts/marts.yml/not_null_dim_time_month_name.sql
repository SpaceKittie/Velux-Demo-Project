select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select month_name
from VELUX_DEV.MARTS.dim_time
where month_name is null



      
    ) dbt_internal_test