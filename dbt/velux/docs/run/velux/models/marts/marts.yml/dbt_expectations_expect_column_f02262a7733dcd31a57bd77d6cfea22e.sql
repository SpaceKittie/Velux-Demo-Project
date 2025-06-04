select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and visibility_km >= 0 and visibility_km <= 200
)
 as expression


    from VELUX_DEV.MARTS.fct_readings
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors








      
    ) dbt_internal_test