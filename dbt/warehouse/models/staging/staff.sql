{{
    config(
        materialized="table"
    )
}}

select
    staff_id,
    first_name,
    last_name,
    username,
    email,
    address_id,
    store_id,
    password,
    active,
    last_update
from {{ source('dvd_rental', 'staff') }}