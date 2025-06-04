{% macro grant_select_to_role() %}
  {% if execute %}
    {% if target.name == 'dev' %}
      grant select on {{ this }} to role VELUX_DEV;
    {% elif target.name == 'prod' %}
      grant select on {{ this }} to role VELUX_PROD_ADMIN;
    {% else %}
      {{ log("Unknown target environment: " ~ target.name ~ " — no GRANT applied", info=True) }}
    {% endif %}
  {% endif %}
{% endmacro %}
