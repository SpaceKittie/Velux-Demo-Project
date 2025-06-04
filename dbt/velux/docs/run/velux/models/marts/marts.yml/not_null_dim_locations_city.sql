select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select city
from VELUX_DEV.MARTS.dim_locations
where city is null



      
    ) dbt_internal_test