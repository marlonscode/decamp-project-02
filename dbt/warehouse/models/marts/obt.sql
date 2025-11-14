{{
    config(
        materialized="table"
    )
}}

select
	{{ dbt_utils.star(from=ref('fact_sale'), relation_alias='fact_sale', except=["customer_key", "customer_address_key", "staff_key", "store_key", "film_key", "inventory_key"]) }},
    {{ dbt_utils.star(from=ref('dim_film'), relation_alias='dim_film', except=["film_key"]) }},
    {{ dbt_utils.star(from=ref('dim_customer'), relation_alias='dim_customer', except=["customer_key"]) }},
    {{ dbt_utils.star(from=ref('dim_address'), relation_alias='dim_address', except=["address_key"]) }},
    {{ dbt_utils.star(from=ref('dim_staff'), relation_alias='dim_staff', except=["staff_key"]) }},
    {{ dbt_utils.star(from=ref('dim_store'), relation_alias='dim_store', except=["store_key"]) }},
    {{ dbt_utils.star(from=ref('dim_inventory'), relation_alias='dim_inventory', except=["inventory_key"]) }},
    {{ dbt_utils.star(from=ref('dim_date'), relation_alias='dim_date', except=["date_key"]) }}
from {{ ref('fact_sale') }} as fact_sale
inner join {{ ref('dim_film') }} as dim_film on fact_sale.film_key = dim_film.film_key
inner join {{ ref('dim_customer') }} as dim_customer on fact_sale.customer_key = dim_customer.customer_key
inner join {{ ref('dim_address') }} as dim_address on fact_sale.customer_address_key = dim_address.address_key
inner join {{ ref('dim_staff') }} as dim_staff on fact_sale.staff_key = dim_staff.staff_key
inner join {{ ref('dim_store') }} as dim_store on fact_sale.store_key = dim_store.store_key
inner join {{ ref('dim_inventory') }} as dim_inventory on fact_sale.inventory_key = dim_inventory.inventory_key
inner join {{ ref('dim_date') }} as dim_date on fact_sale.payment_date = dim_date.date_day