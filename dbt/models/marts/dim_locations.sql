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

WITH location_data AS (
    SELECT DISTINCT
        city,
        country
    FROM {{ ref('int_iot_data_with_weather') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['city', 'country']) }} AS location_id,
    city,
    country

FROM location_data
