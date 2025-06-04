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
    DATETIME                                        AS WEATHER_TIMESTAMP,
    CITY_NAME,
    COUNTRY_CODE,
    TEMPERATURE::FLOAT                              AS OUTDOOR_TEMPERATURE_CELSIUS,
    TEMPERATURE_DEW_POINT::FLOAT                    AS DEW_POINT_TEMPERATURE_CELSIUS,
    PRESSURE_MSL::FLOAT                             AS MEAN_SEA_LEVEL_PRESSURE_HPA,
    WIND_SPEED::FLOAT                               AS WIND_SPEED_MS,
    VISIBILITY::FLOAT                               AS VISIBILITY_KM,
    SOLAR_IRRADIANCE::FLOAT                         AS SOLAR_IRRADIANCE_W_M2,
    INDEX_UV::FLOAT                                 AS UV_INDEX,
    MINUTES_OF_SUN::FLOAT                           AS SUNSHINE_DURATION_MINUTES,
    PRECIPITATION_TYPE_DESC                         AS PRECIPITATION_TYPE_DESCRIPTION
FROM {{ source('accuweather', 'TOP_CITY_HOURLY_METRIC') }}
