select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    sensor_id as unique_field,
    count(*) as n_records

from VELUX_DEV.MARTS.dim_sensors
where sensor_id is not null
group by sensor_id
having count(*) > 1



      
    ) dbt_internal_test