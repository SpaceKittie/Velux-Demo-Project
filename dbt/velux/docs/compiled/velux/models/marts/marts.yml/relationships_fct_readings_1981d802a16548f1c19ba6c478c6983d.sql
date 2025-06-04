
    
    

with child as (
    select location_id as from_field
    from VELUX_DEV.MARTS.fct_readings
    where location_id is not null
),

parent as (
    select location_id as to_field
    from VELUX_DEV.MARTS.dim_locations
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


