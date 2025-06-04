select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select city_name
from VELUX_DEV.STAGING.stg_accuweather_hourly
where city_name is null



      
    ) dbt_internal_test