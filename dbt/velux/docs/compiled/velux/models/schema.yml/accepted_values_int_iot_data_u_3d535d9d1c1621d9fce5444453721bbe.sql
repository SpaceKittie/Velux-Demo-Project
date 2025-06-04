
    
    

with all_values as (

    select
        room as value_field,
        count(*) as n_records

    from VELUX_DEV.STAGING.int_iot_data_unpivotted
    group by room

)

select *
from all_values
where value_field not in (
    'kitchen','bedroom','outdoor','unknown'
)


