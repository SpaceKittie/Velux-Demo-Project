{{ config(
    tags=['staging'],
    meta={
        'snowflake_tags': {
            'GOV.TAGS.data_domain': 'VELUX_IOT',
            'GOV.TAGS.data_sensitivity': 'internal',
            'GOV.TAGS.environment': 'dev' if target.name != 'prod' else 'prod',
            'GOV.TAGS.retention_days': '365'
        }
    },
    post_hook=["{{ apply_snowflake_tags() }}"]
) }}

SELECT
    datetime::timestamp_ntz       AS event_timestamp,
    country::varchar              AS country,
    city::varchar                 AS city,
    device_id::varchar            AS device_id,
    co2_bedroom_ppm::float        AS co2_bedroom_ppm,
    co2_kitchen_ppm::float        AS co2_kitchen_ppm,
    rh_bedroom_pct::float         AS rh_bedroom_pct,
    rh_kitchen_pct::float         AS rh_kitchen_pct,
    rh_outdoor_pct::float         AS rh_outdoor_pct,
    indoor_temperature_c::float   AS indoor_temperature_c,
    outdoor_temperature_c::float  AS outdoor_temperature_c
FROM {{ source('iot_data', 'iot_data') }}
