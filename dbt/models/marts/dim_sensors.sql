{{ config(
    tags=['marts'],
    meta={
        'snowflake_tags': {
            'GOV.TAGS.data_domain': 'VELUX_IOT',
            'GOV.TAGS.data_sensitivity': ("public" if target.name == 'prod' else "internal"),
            'GOV.TAGS.environment': ("prod" if target.name == 'prod' else "dev"),
            'GOV.TAGS.retention_days': '365'
        }
    },
    post_hook=["{{ apply_snowflake_tags() }}"]
) }}

WITH sensor_types AS (
    SELECT
        sensor_type,
        CASE
            WHEN sensor_type = 'co2(parts per million)' THEN 'ppm'
            WHEN sensor_type = 'relative_humidity(percent)' THEN '%'
            WHEN sensor_type = 'temperature(celsius)' THEN '°C'
            ELSE 'unknown'
        END AS measurement_unit
    FROM (
        SELECT DISTINCT sensor_type
        FROM {{ ref('int_iot_data_with_weather') }}
    )
),

sensor_data AS (
    SELECT DISTINCT
        room,
        sensor_type,
        device_id
    FROM {{ ref('int_iot_data_with_weather') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['sd.sensor_type', 'sd.device_id', 'sd.room']) }} AS sensor_id,
    sd.device_id,
    sd.room,
    sd.sensor_type,
    st.measurement_unit

FROM sensor_data sd
JOIN sensor_types st ON sd.sensor_type = st.sensor_type
