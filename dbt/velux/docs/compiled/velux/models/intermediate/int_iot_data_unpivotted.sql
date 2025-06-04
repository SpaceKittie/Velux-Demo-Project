

WITH base AS (
    SELECT
        event_timestamp,
        country,
        city,
        device_id,
        co2_bedroom_ppm,
        co2_kitchen_ppm,
        rh_bedroom_pct,
        rh_kitchen_pct,
        rh_outdoor_pct,
        indoor_temperature_c,
        outdoor_temperature_c
    FROM VELUX_DEV.STAGING.stg_iot_data
),

unpivoted AS (
    select
        event_timestamp,
        device_id,
        country,
        city,

      cast('CO2_BEDROOM_PPM' as TEXT) as sensor_name,
      cast(  
           CO2_BEDROOM_PPM
             
           as float) as sensor_value

    from VELUX_DEV.STAGING.stg_iot_data

    union all
    select
        event_timestamp,
        device_id,
        country,
        city,

      cast('CO2_KITCHEN_PPM' as TEXT) as sensor_name,
      cast(  
           CO2_KITCHEN_PPM
             
           as float) as sensor_value

    from VELUX_DEV.STAGING.stg_iot_data

    union all
    select
        event_timestamp,
        device_id,
        country,
        city,

      cast('RH_BEDROOM_PCT' as TEXT) as sensor_name,
      cast(  
           RH_BEDROOM_PCT
             
           as float) as sensor_value

    from VELUX_DEV.STAGING.stg_iot_data

    union all
    select
        event_timestamp,
        device_id,
        country,
        city,

      cast('RH_KITCHEN_PCT' as TEXT) as sensor_name,
      cast(  
           RH_KITCHEN_PCT
             
           as float) as sensor_value

    from VELUX_DEV.STAGING.stg_iot_data

    union all
    select
        event_timestamp,
        device_id,
        country,
        city,

      cast('RH_OUTDOOR_PCT' as TEXT) as sensor_name,
      cast(  
           RH_OUTDOOR_PCT
             
           as float) as sensor_value

    from VELUX_DEV.STAGING.stg_iot_data

    union all
    select
        event_timestamp,
        device_id,
        country,
        city,

      cast('INDOOR_TEMPERATURE_C' as TEXT) as sensor_name,
      cast(  
           INDOOR_TEMPERATURE_C
             
           as float) as sensor_value

    from VELUX_DEV.STAGING.stg_iot_data

    union all
    select
        event_timestamp,
        device_id,
        country,
        city,

      cast('OUTDOOR_TEMPERATURE_C' as TEXT) as sensor_name,
      cast(  
           OUTDOOR_TEMPERATURE_C
             
           as float) as sensor_value

    from VELUX_DEV.STAGING.stg_iot_data

    
),

classified AS (
    SELECT
        event_timestamp,
        country,
        city,
        device_id,
        CASE
            WHEN lower(sensor_name) ilike 'co2_bedroom%' THEN 'bedroom'
            WHEN lower(sensor_name) ilike 'co2_kitchen%' THEN 'kitchen'
            WHEN lower(sensor_name) ilike 'rh_bedroom%' THEN 'bedroom'
            WHEN lower(sensor_name) ilike 'rh_kitchen%' THEN 'kitchen'
            WHEN lower(sensor_name) ilike 'rh_outdoor%' THEN 'outdoor'
            WHEN lower(sensor_name) = 'indoor_temperature_c' THEN 'indoor'
            WHEN lower(sensor_name) = 'outdoor_temperature_c' THEN 'outdoor'
            ELSE 'unknown'
        END AS room,
        CASE
            WHEN lower(sensor_name) ilike 'co2_%' THEN 'co2(parts per million)'
            WHEN lower(sensor_name) ilike 'rh_%' THEN 'relative_humidity(percent)'
            WHEN lower(sensor_name) ilike '%temperature_c' THEN 'temperature(celsius)'
            ELSE 'unknown'
        END AS sensor_type,
        sensor_value
    FROM unpivoted
    WHERE sensor_value IS NOT NULL
)

SELECT
  event_timestamp,
  country,
  city,
  device_id,
  room,
  sensor_type,
  sensor_value
FROM classified