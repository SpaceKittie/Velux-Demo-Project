with relation_columns as (

        
        select
            cast('READING_ID' as TEXT) as relation_column,
            cast('VARCHAR' as TEXT) as relation_column_type
        union all
        
        select
            cast('TIME_ID' as TEXT) as relation_column,
            cast('VARCHAR' as TEXT) as relation_column_type
        union all
        
        select
            cast('LOCATION_ID' as TEXT) as relation_column,
            cast('VARCHAR' as TEXT) as relation_column_type
        union all
        
        select
            cast('SENSOR_ID' as TEXT) as relation_column,
            cast('VARCHAR' as TEXT) as relation_column_type
        union all
        
        select
            cast('DEVICE_ID' as TEXT) as relation_column,
            cast('VARCHAR' as TEXT) as relation_column_type
        union all
        
        select
            cast('EVENT_TIMESTAMP' as TEXT) as relation_column,
            cast('TIMESTAMP_NTZ' as TEXT) as relation_column_type
        union all
        
        select
            cast('EVENT_DATE' as TEXT) as relation_column,
            cast('DATE' as TEXT) as relation_column_type
        union all
        
        select
            cast('SENSOR_VALUE' as TEXT) as relation_column,
            cast('FLOAT' as TEXT) as relation_column_type
        union all
        
        select
            cast('OUTDOOR_TEMPERATURE_CELSIUS' as TEXT) as relation_column,
            cast('FLOAT' as TEXT) as relation_column_type
        union all
        
        select
            cast('DEW_POINT_TEMPERATURE_CELSIUS' as TEXT) as relation_column,
            cast('FLOAT' as TEXT) as relation_column_type
        union all
        
        select
            cast('MEAN_SEA_LEVEL_PRESSURE_HPA' as TEXT) as relation_column,
            cast('FLOAT' as TEXT) as relation_column_type
        union all
        
        select
            cast('WIND_SPEED_MS' as TEXT) as relation_column,
            cast('FLOAT' as TEXT) as relation_column_type
        union all
        
        select
            cast('VISIBILITY_KM' as TEXT) as relation_column,
            cast('FLOAT' as TEXT) as relation_column_type
        union all
        
        select
            cast('SOLAR_IRRADIANCE_W_M2' as TEXT) as relation_column,
            cast('FLOAT' as TEXT) as relation_column_type
        union all
        
        select
            cast('UV_INDEX' as TEXT) as relation_column,
            cast('FLOAT' as TEXT) as relation_column_type
        union all
        
        select
            cast('SUNSHINE_DURATION_MINUTES' as TEXT) as relation_column,
            cast('FLOAT' as TEXT) as relation_column_type
        union all
        
        select
            cast('PRECIPITATION_TYPE_DESCRIPTION' as TEXT) as relation_column,
            cast('VARCHAR' as TEXT) as relation_column_type
        
        
    ),
    test_data as (

        select
            *
        from
            relation_columns
        where
            relation_column = 'SENSOR_VALUE'
            and
            relation_column_type not in ('FLOAT')

    )
    select *
    from test_data