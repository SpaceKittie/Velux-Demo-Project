
    
    

with all_values as (

    select
        sensor_type as value_field,
        count(*) as n_records

    from VELUX_DEV.STAGING.int_iot_data_unpivotted
    group by sensor_type

)

select *
from all_values
where value_field not in (
    'co2','relative_humidity','temperature','unknown'
)


