{% macro current_date_formatted(format='YYYY-MM-DD') %}
  TO_CHAR(CURRENT_DATE, '{{ format }}')
{% endmacro %}