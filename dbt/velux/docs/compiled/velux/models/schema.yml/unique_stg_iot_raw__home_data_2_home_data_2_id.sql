
    
    

select
    home_data_2_id as unique_field,
    count(*) as n_records

from VELUX_DEV.STAGE.stg_iot_raw__home_data_2
where home_data_2_id is not null
group by home_data_2_id
having count(*) > 1


