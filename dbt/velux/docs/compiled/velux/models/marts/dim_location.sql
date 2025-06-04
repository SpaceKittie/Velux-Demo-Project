-- models/marts/dim_location.sql

WITH distinct_locations AS (
    SELECT DISTINCT
        country,
        city
    FROM VELUX_DEV.STAGING.int_iot_data_unpivotted
    WHERE country IS NOT NULL AND city IS NOT NULL -- Ensuring key attributes are present
)

SELECT
    ----------  ids
    md5(cast(coalesce(cast(distinct_locations.country as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(distinct_locations.city as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS location_id, -- Surrogate primary key

    ---------- strings
    distinct_locations.country,
    distinct_locations.city

    -- No numerics, booleans, dates, or timestamps in this dimension
FROM distinct_locations
ORDER BY distinct_locations.country, distinct_locations.city