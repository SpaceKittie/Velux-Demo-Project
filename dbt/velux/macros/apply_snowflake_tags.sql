{% macro apply_snowflake_tags() %}
  {% if execute %}
    {% if model.config.materialized != 'ephemeral' %}
      {# Apply table tags #}
      {% if model.meta.snowflake_tags is defined %}
        {% for tag_name, tag_value in model.meta.snowflake_tags.items() %}
          {% set set_tag_sql %}
            ALTER TABLE {{ this }} SET TAG {{ tag_name }} = '{{ tag_value }}';
          {% endset %}
          {% do run_query(set_tag_sql) %}
          {% do log("Applied TABLE tag " ~ tag_name ~ " to " ~ this, info=true) %}
        {% endfor %}
      {% endif %}

      {# Apply column tags #}
      {% for column_name, column_def in model.columns.items() %}
        {% if column_def.meta.snowflake_tags is defined %}
          {% for tag_name, tag_value in column_def.meta.snowflake_tags.items() %}
            {% set set_column_tag_sql %}
              ALTER TABLE {{ this }}
                ALTER COLUMN {{ column_name }} SET TAG {{ tag_name }} = '{{ tag_value }}';
            {% endset %}
            {% do run_query(set_column_tag_sql) %}
            {% do log("Applied COLUMN tag " ~ tag_name ~ " to " ~ this ~ "." ~ column_name, info=true) %}
          {% endfor %}
        {% endif %}
      {% endfor %}

    {% endif %}
  {% endif %}
{% endmacro %}