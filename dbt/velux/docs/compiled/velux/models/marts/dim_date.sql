-- models/marts/dim_date.sql

WITH unpivotted_data AS (
    -- We only need distinct dates from the source to build the dimension
    SELECT DISTINCT
        CAST(event_timestamp AS DATE) AS event_date
    FROM VELUX_DEV.STAGING.int_iot_data_unpivotted
),

date_dimension AS (
    SELECT
        event_date,
        EXTRACT(YEAR FROM event_date) AS year,
        EXTRACT(MONTH FROM event_date) AS month_of_year,
        TO_CHAR(event_date, 'Month') AS month_name,
        EXTRACT(DAY FROM event_date) AS day_of_month,
        EXTRACT(DAYOFWEEK FROM event_date) AS day_of_week, -- Sunday=0, Saturday=6 (Snowflake specific)
        TO_CHAR(event_date, 'Dy') AS day_name_short, -- Mon, Tue, etc.
        EXTRACT(QUARTER FROM event_date) AS quarter_of_year,
        EXTRACT(WEEKOFYEAR FROM event_date) AS week_of_year,
        EXTRACT(DAYOFYEAR FROM event_date) AS day_of_year,
        DATE_TRUNC('MONTH', event_date) AS first_day_of_month,
        LAST_DAY(event_date, 'MONTH') AS last_day_of_month,
        DATE_TRUNC('QUARTER', event_date) AS first_day_of_quarter,
        LAST_DAY(event_date, 'QUARTER') AS last_day_of_quarter,
        DATE_TRUNC('YEAR', event_date) AS first_day_of_year,
        LAST_DAY(event_date, 'YEAR') AS last_day_of_year
    FROM unpivotted_data
)

SELECT
    ----------  ids
    md5(cast(coalesce(cast(event_date as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS date_id,

    ---------- strings
    TRIM(date_dimension.month_name) AS month_name, -- TRIM potential whitespace from TO_CHAR
    TRIM(date_dimension.day_name_short) AS day_name_short, -- TRIM potential whitespace from TO_CHAR

    ---------- numerics
    date_dimension.year,
    date_dimension.month_of_year,
    date_dimension.day_of_month,
    date_dimension.day_of_week, -- Refers to the column from date_dimension CTE (Sunday=0, Saturday=6)
    date_dimension.quarter_of_year,
    date_dimension.week_of_year,
    date_dimension.day_of_year,

    ---------- dates
    date_dimension.event_date,
    date_dimension.first_day_of_month,
    date_dimension.last_day_of_month,
    date_dimension.first_day_of_quarter,
    date_dimension.last_day_of_quarter,
    date_dimension.first_day_of_year,
    date_dimension.last_day_of_year
    
    -- No booleans or direct timestamps in this dimension other than what's derived into dates/numerics
FROM date_dimension
ORDER BY date_dimension.event_date