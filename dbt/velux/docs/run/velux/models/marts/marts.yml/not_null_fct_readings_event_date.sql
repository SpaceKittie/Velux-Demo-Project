select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select event_date
from VELUX_DEV.MARTS.fct_readings
where event_date is null



      
    ) dbt_internal_test