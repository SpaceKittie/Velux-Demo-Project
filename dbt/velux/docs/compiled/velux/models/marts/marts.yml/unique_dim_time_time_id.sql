
    
    

select
    time_id as unique_field,
    count(*) as n_records

from VELUX_DEV.MARTS.dim_time
where time_id is not null
group by time_id
having count(*) > 1


