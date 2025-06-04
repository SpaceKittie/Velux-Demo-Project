






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and wind_speed_ms >= 0 and wind_speed_ms <= 100
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







