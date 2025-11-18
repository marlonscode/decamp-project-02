{{
    config(
        materialized="table"
    )
}}

with base_payment as (
    select
        payment.payment_id,
        payment.customer_id,
        customer.address_id as customer_address_id,
        payment.staff_id,
        store.store_id as store_id,
        payment.rental_id,
        payment.amount as payment_amount,
        cast(payment.payment_date as date) as payment_date
    from {{ ref('payment') }} as payment
    inner join {{ ref('staff') }} as staff on staff.staff_id = payment.staff_id
    inner join {{ ref('store') }} as store on store.store_id = staff.store_id
    inner join {{ ref('customer') }} as customer on customer.customer_id = payment.customer_id
),

base_rental as (
    select
        rental.rental_id,
        rental.rental_date,
        rental.inventory_id,
        inventory.film_id,
        rental.customer_id,
        rental.return_date,
        rental.staff_id,
        rental.last_update
    from {{ ref('rental') }}
    inner join {{ ref('inventory') }} on rental.inventory_id = inventory.inventory_id
)

select
    {{ dbt_utils.generate_surrogate_key(['base_payment.payment_id']) }} as sale_key,
    {{ dbt_utils.generate_surrogate_key(['base_payment.customer_id']) }} as customer_key,
    {{ dbt_utils.generate_surrogate_key(['base_payment.customer_address_id']) }} as customer_address_key,
    {{ dbt_utils.generate_surrogate_key(['base_payment.staff_id']) }} as staff_key,
    {{ dbt_utils.generate_surrogate_key(['base_payment.store_id']) }} as store_key,
    {{ dbt_utils.generate_surrogate_key(['base_rental.film_id']) }} as film_key,
    {{ dbt_utils.generate_surrogate_key(['base_rental.inventory_id']) }} as inventory_key,
    base_payment.payment_amount as payment_amount,
    base_payment.payment_date as payment_date
from base_payment
inner join base_rental on base_payment.rental_id = base_rental.rental_id