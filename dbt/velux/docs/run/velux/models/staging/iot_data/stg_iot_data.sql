
  create or replace   view VELUX_DEV.STAGING.stg_iot_data
  
    
    
(
  
    "EVENT_TIMESTAMP" COMMENT $$Timestamp of the IoT sensor reading.$$, 
  
    "COUNTRY" COMMENT $$Country where the IoT device is located.$$, 
  
    "CITY" COMMENT $$City where the IoT device is located.$$, 
  
    "DEVICE_ID" COMMENT $$Unique identifier for the IoT device.$$, 
  
    "CO2_BEDROOM_PPM" COMMENT $$CO2 level in bedroom (parts per million).$$, 
  
    "CO2_KITCHEN_PPM" COMMENT $$CO2 level in kitchen (parts per million).$$, 
  
    "RH_BEDROOM_PCT" COMMENT $$Relative humidity in bedroom (percentage).$$, 
  
    "RH_KITCHEN_PCT" COMMENT $$Relative humidity in kitchen (percentage).$$, 
  
    "RH_OUTDOOR_PCT" COMMENT $$Outdoor relative humidity (percentage).$$, 
  
    "INDOOR_TEMPERATURE_C" COMMENT $$Indoor temperature (Celsius).$$, 
  
    "OUTDOOR_TEMPERATURE_C" COMMENT $$Outdoor temperature (Celsius) reported by IoT device.$$
  
)

   as (
    


with source_data as (
    select *
    from velux_dev.raw.iot_data
)

select
    datetime::timestamp_ntz as event_timestamp,
    country::varchar as country,
    city::varchar as city,
    device_id::varchar as device_id,
    co2_bedroom_ppm::float as co2_bedroom_ppm,
    co2_kitchen_ppm::float as co2_kitchen_ppm,
    rh_bedroom_pct::float as rh_bedroom_pct,
    rh_kitchen_pct::float as rh_kitchen_pct,
    rh_outdoor_pct::float as rh_outdoor_pct,
    indoor_temperature_c::float as indoor_temperature_c,
    outdoor_temperature_c::float as outdoor_temperature_c

from source_data
  );

