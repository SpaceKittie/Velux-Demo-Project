{{ config(tags=['intermediate']) }}

WITH unpivoted AS (
    {{ dbt_utils.unpivot(
        relation       = ref('stg_iot_data'),
        cast_to        = 'float',
        exclude        = ['event_timestamp', 'device_id', 'country', 'city'],
        field_name     = 'sensor_name',
        value_name     = 'sensor_value'
    ) }}
),

classified AS (
    SELECT
        event_timestamp,
        country,
        city,
        device_id,
        sensor_value,
        CASE
            WHEN lower(sensor_name) ILIKE 'co2_bedroom%'    THEN 'bedroom'
            WHEN lower(sensor_name) ILIKE 'co2_kitchen%'    THEN 'kitchen'
            WHEN lower(sensor_name) ILIKE 'rh_bedroom%'     THEN 'bedroom'
            WHEN lower(sensor_name) ILIKE 'rh_kitchen%'     THEN 'kitchen'
            WHEN lower(sensor_name) ILIKE 'rh_outdoor%'     THEN 'outdoor'
            WHEN lower(sensor_name) = 'indoor_temperature_c'  THEN 'indoor'
            WHEN lower(sensor_name) = 'outdoor_temperature_c' THEN 'outdoor'
            ELSE 'unknown'
        END AS room,
        CASE
            WHEN lower(sensor_name) ILIKE 'co2_%'           THEN 'co2(parts per million)'
            WHEN lower(sensor_name) ILIKE 'rh_%'            THEN 'relative_humidity(percent)'
            WHEN lower(sensor_name) ILIKE '%temperature_c'   THEN 'temperature(celsius)'
            ELSE 'unknown'
        END AS sensor_type
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
