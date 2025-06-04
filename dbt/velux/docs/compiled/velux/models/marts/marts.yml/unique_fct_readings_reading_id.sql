
    
    

select
    reading_id as unique_field,
    count(*) as n_records

from VELUX_DEV.MARTS.fct_readings
where reading_id is not null
group by reading_id
having count(*) > 1


