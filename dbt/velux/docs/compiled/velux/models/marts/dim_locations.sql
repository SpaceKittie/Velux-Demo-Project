

WITH location_data AS (
    SELECT DISTINCT
        city,
        country
    FROM VELUX_DEV.STAGING.int_iot_data_with_weather
)

SELECT
    md5(cast(coalesce(cast(city as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(country as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS location_id,
    city,
    country

FROM location_data