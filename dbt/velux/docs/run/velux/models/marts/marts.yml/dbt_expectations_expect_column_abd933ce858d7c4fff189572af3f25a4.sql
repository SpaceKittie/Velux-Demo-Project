select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      

with all_values as (

    select
        precipitation_type_description as value_field

    from VELUX_DEV.MARTS.fct_readings
    

),
set_values as (

    select
        cast('rain' as TEXT) as value_field
    union all
    select
        cast('snow' as TEXT) as value_field
    union all
    select
        cast('none' as TEXT) as value_field
    union all
    select
        cast('mixed' as TEXT) as value_field
    union all
    select
        cast('sleet' as TEXT) as value_field
    union all
    select
        cast('hail' as TEXT) as value_field
    union all
    select
        cast('unknown' as TEXT) as value_field
    
    
),
validation_errors as (
    -- values from the model that are not in the set
    select
        v.value_field
    from
        all_values v
        left join
        set_values s on v.value_field = s.value_field
    where
        s.value_field is null

)

select *
from validation_errors


      
    ) dbt_internal_test