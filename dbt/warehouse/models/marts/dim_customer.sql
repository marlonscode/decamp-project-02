{{
    config(
        materialized="table"
    )
}}

select
	{{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
	first_name,
	last_name,
	email,
	address_id,
	last_update
from {{ ref('customer') }}