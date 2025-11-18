{{
    config(
        materialized="incremental",
        unique_key=["payment_id"],
        incremental_strategy="delete+insert"
    )
}}

select
    payment_id,
    rental_id,
    customer_id,
    staff_id,
    amount,
    payment_date
from {{ source('dvd_rental', 'payment') }}

{% if is_incremental() %}
    where payment_date > (select max(payment_date) from {{ this }} ) - interval '48 hours'
{% endif %}



