select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select weather_timestamp
from VELUX_DEV.STAGING.stg_accuweather_hourly
where weather_timestamp is null



      
    ) dbt_internal_test