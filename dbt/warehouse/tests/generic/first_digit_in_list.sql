{% test first_digit_in_list(model, column_name, allowed_digits) %}

select *
from {{ model }}
where substring(cast({{ column_name }} as string), 1, 1) not in (
    {% for d in allowed_digits %}
        '{{ d }}'{% if not loop.last %}, {% endif %}
    {% endfor %}
)

{% endtest %}