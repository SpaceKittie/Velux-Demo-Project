

WITH base_time AS (
    SELECT DISTINCT event_timestamp
    FROM VELUX_DEV.STAGING.int_iot_data_with_weather
)

SELECT
    md5(cast(coalesce(cast(event_timestamp as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) AS time_id,
    DATE(event_timestamp) AS event_date,
    event_timestamp,
    EXTRACT(HOUR FROM event_timestamp) AS hour_of_day,
    EXTRACT(DOW FROM event_timestamp) AS day_of_week,
    EXTRACT(DAY FROM event_timestamp) AS day_of_month,
    EXTRACT(MONTH FROM event_timestamp) AS month_number,
    EXTRACT(YEAR FROM event_timestamp) AS year_number,
    CASE 
        WHEN EXTRACT(DOW FROM event_timestamp) IN (0, 6) THEN TRUE 
        ELSE FALSE 
    END AS is_weekend,
    CASE
        WHEN EXTRACT(MONTH FROM event_timestamp) IN (12, 1, 2) THEN 'Winter'
        WHEN EXTRACT(MONTH FROM event_timestamp) IN (3, 4, 5) THEN 'Spring'
        WHEN EXTRACT(MONTH FROM event_timestamp) IN (6, 7, 8) THEN 'Summer'
        WHEN EXTRACT(MONTH FROM event_timestamp) IN (9, 10, 11) THEN 'Fall'
    END AS season,
    DAYNAME(event_timestamp) AS day_name,
    MONTHNAME(event_timestamp) AS month_name
    
FROM base_time