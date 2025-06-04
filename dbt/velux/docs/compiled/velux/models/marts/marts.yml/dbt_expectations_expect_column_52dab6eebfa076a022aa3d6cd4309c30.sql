






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and sensor_value >= -100 and sensor_value <= 10000
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







