select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select country
from VELUX_DEV.STAGING.stg_iot_data
where country is null



      
    ) dbt_internal_test