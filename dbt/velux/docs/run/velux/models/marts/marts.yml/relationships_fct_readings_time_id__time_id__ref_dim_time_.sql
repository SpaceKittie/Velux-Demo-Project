select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select time_id as from_field
    from VELUX_DEV.MARTS.fct_readings
    where time_id is not null
),

parent as (
    select time_id as to_field
    from VELUX_DEV.MARTS.dim_time
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) dbt_internal_test