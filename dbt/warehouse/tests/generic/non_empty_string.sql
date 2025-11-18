{% test non_empty_string(model, column_name) %}
    select
        *
    from {{ model }} where len({{ column_name }}) = 0
{% endtest %}