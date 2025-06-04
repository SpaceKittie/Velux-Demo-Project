select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select country_code
from VELUX_DEV.STAGING.stg_accuweather_hourly
where country_code is null



      
    ) dbt_internal_test