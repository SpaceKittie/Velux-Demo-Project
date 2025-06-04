
  create or replace   view VELUX_DEV.STAGE.stg_iot_raw__home_data_2
  
   as (
    

with source as (
    select * from VELUX_DEV.RAW.HOME_DATA_2
),

renamed as (
    select
        -- IDs
        id as home_data_2_id,
        
        -- Dates and times
        datetime_utc,
        
        -- Dimensions
        country,
        room,
        sensor,
        
        -- Metrics
        min_value,
        average_value,
        max_value
    from source
)

select * from renamed
  );

