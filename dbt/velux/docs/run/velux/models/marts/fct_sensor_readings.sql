
  
    

        create or replace transient table VELUX_DEV.MARTS.fct_sensor_readings
         as
        (-- models/marts/fct_sensor_readings.sql

WITH source_data AS (
    SELECT
        -- IoT Core Fields
        event_timestamp,
        iot_country AS country, -- Renaming for consistency with existing joins in this model
        iot_city AS city,       -- Renaming for consistency with existing joins in this model
        device_id,
        room,
        sensor_type,
        sensor_value,

        -- Weather Fields from int_iot_data_with_weather
        weather_timestamp_hour,
        weather_latitude,
        weather_longitude,
        gmt_offset,
        outdoor_temperature_celsius,
        dew_point_temperature_celsius,
        mean_sea_level_pressure_hpa,
        wind_speed_m_s,
        wind_gust_m_s,
        wind_direction_degrees,
        visibility_km,
        solar_irradiance_w_m2,
        uv_index,
        sunshine_duration_minutes,
        precipitation_lwe_mm,
        precipitation_lwe_rate_mm_hr,
        precipitation_type_description

    FROM VELUX_DEV.STAGING.int_iot_data_with_weather
    WHERE sensor_value IS NOT NULL -- Ensure we only process records with actual readings
      AND sensor_type != 'unknown' -- Exclude unknown sensor types that won't match dim_sensor_attributes
),

-- Add a CTE to parse sensor_type from source_data for joining with dim_sensor_attributes
parsed_source_data AS (
    SELECT
        -- Pass through all columns from the enriched source_data CTE
        source_data.*,

        -- Parse sensor_type for joining with dim_sensor_attributes
        CASE
            WHEN POSITION('(' IN source_data.sensor_type) > 0
            THEN TRIM(SUBSTRING(source_data.sensor_type, 1, POSITION('(' IN source_data.sensor_type) - 1))
            ELSE TRIM(source_data.sensor_type)
        END AS parsed_sensor_type_name,
        CASE
            WHEN POSITION('(' IN source_data.sensor_type) > 0 AND POSITION(')' IN source_data.sensor_type) > POSITION('(' IN source_data.sensor_type)
            THEN TRIM(SUBSTRING(source_data.sensor_type, POSITION('(' IN source_data.sensor_type) + 1, POSITION(')' IN source_data.sensor_type) - POSITION('(' IN source_data.sensor_type) - 1))
            ELSE 'N/A'
        END AS parsed_sensor_unit
    FROM source_data
),

final_joins AS (
    SELECT
        -- Foreign Keys from Dimensions
        dim_date.date_id,
        dim_device.device_id AS device_fk_id, 
        dim_location.location_id,
        dim_sensor_attributes.sensor_attributes_id,

        -- Degenerate Dimension (Timestamps from IoT)
        psd.event_timestamp, 

        -- Measure (Numerics from IoT)
        psd.sensor_value,

        -- Weather Metrics & Context (Degenerate Dimensions & Measures from Weather)
        psd.weather_timestamp_hour,
        psd.weather_latitude,
        psd.weather_longitude,
        psd.gmt_offset,
        psd.outdoor_temperature_celsius,
        psd.dew_point_temperature_celsius,
        psd.mean_sea_level_pressure_hpa,
        psd.wind_speed_m_s,
        psd.wind_gust_m_s,
        psd.wind_direction_degrees,
        psd.visibility_km,
        psd.solar_irradiance_w_m2,
        psd.uv_index,
        psd.sunshine_duration_minutes,
        psd.precipitation_lwe_mm,
        psd.precipitation_lwe_rate_mm_hr,
        psd.precipitation_type_description

    FROM parsed_source_data psd -- Alias for brevity
    LEFT JOIN VELUX_DEV.MARTS.dim_date AS dim_date
        ON CAST(psd.event_timestamp AS DATE) = dim_date.event_date 
    LEFT JOIN VELUX_DEV.MARTS.dim_device AS dim_device
        ON psd.device_id = dim_device.device_natural_key 
    LEFT JOIN VELUX_DEV.MARTS.dim_location AS dim_location
        ON psd.country = dim_location.country 
        AND psd.city = dim_location.city 
    LEFT JOIN VELUX_DEV.MARTS.dim_sensor_attributes AS dim_sensor_attributes
        ON COALESCE(psd.room, 'N/A') = dim_sensor_attributes.room
        AND psd.parsed_sensor_type_name = dim_sensor_attributes.sensor_type_name
        AND psd.parsed_sensor_unit = dim_sensor_attributes.sensor_unit 
)

SELECT
    ---------- foreign_keys
    fj.date_id,
    fj.device_fk_id,
    fj.location_id,
    fj.sensor_attributes_id,

    ---------- degenerate_dimensions_timestamps
    fj.event_timestamp,         -- IoT event timestamp
    fj.weather_timestamp_hour,  -- Hourly weather timestamp

    ---------- degenerate_dimensions_geo_context
    fj.weather_latitude,
    fj.weather_longitude,
    fj.gmt_offset,

    ---------- degenerate_dimensions_weather_strings
    fj.precipitation_type_description,

    ---------- measures_iot_numerics
    fj.sensor_value,

    ---------- measures_weather_numerics
    fj.outdoor_temperature_celsius,
    fj.dew_point_temperature_celsius,
    fj.mean_sea_level_pressure_hpa,
    fj.wind_speed_m_s,
    fj.wind_gust_m_s,
    fj.wind_direction_degrees,
    fj.visibility_km,
    fj.solar_irradiance_w_m2,
    fj.uv_index,
    fj.sunshine_duration_minutes,
    fj.precipitation_lwe_mm,
    fj.precipitation_lwe_rate_mm_hr

FROM final_joins fj -- Alias for brevity
-- No specific order needed for fact tables unless for specific loading/query patterns
        );
      
  