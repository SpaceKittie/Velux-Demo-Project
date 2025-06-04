
    
    

select
    location_id as unique_field,
    count(*) as n_records

from VELUX_DEV.MARTS.fct_readings
where location_id is not null
group by location_id
having count(*) > 1


