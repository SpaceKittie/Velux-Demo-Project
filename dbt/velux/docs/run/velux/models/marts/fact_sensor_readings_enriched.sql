
  
    

        create or replace transient table VELUX_DEV.MARTS.fact_sensor_readings_enriched
         as
        (-- models/marts/fact_sensor_readings_enriched.sql
-- Enhanced view of sensor readings with descriptive information included

WITH sensor_readings AS (
    SELECT * FROM VELUX_DEV.MARTS.fact_sensor_readings
),

dim_sensors AS (
    SELECT * FROM VELUX_DEV.MARTS.dim_sensors
),

dim_locations AS (
    SELECT * FROM VELUX_DEV.MARTS.dim_locations
),

dim_times AS (
    SELECT * FROM VELUX_DEV.MARTS.dim_time
)

SELECT
    ---------- ids
    sr.reading_id,
    sr.time_id,
    sr.location_id,
    sr.sensor_id,
    sr.device_id,
    
    ---------- timestamps
    sr.event_timestamp,
    sr.weather_timestamp,
    
    ---------- descriptive fields
    ds.sensor_type,
    ds.room,
    ds.measurement_unit,
    dl.city,
    dl.country,
    dt.hour_of_day,
    dt.day_of_week,
    dt.is_weekend,


    -- Weather metrics
    sr.outdoor_temperature_celsius,
    sr.dew_point_temperature_celsius,
    sr.mean_sea_level_pressure_hpa,
    sr.wind_speed_ms,
    sr.visibility_km,
    sr.solar_irradiance_w_m2,
    sr.uv_index,
    sr.sunshine_duration_minutes,
    sr.precipitation_type_description

FROM sensor_readings sr
JOIN dim_sensors ds ON sr.sensor_id = ds.sensor_id
JOIN dim_locations dl ON sr.location_id = dl.location_id
JOIN dim_times dt ON sr.time_id = dt.time_id
        );
      
  