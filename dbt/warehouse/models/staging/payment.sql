{{
    config(
        materialized="table",
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

