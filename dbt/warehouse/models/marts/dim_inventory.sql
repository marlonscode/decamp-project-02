{{
    config(
        materialized="table"
    )
}}

select
    {{ dbt_utils.generate_surrogate_key(['inventory.inventory_id']) }} as inventory_key,
    inventory.film_id,
    inventory.store_id,
    film.title as film_title,
    inventory.last_update
from {{ ref('inventory') }}
inner join {{ ref('film') }} on inventory.film_id = film.film_id