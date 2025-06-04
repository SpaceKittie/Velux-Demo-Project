






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and solar_irradiance_w_m2 >= 0 and solar_irradiance_w_m2 <= 2000
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







