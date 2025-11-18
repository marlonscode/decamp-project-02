{{
    config(
        materialized="table"
    )
}}

select
	{{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
	first_name as customer_first_name,
	last_name as customer_last_name,
	email as customer_email,
	address_id as customer_address_id,
	last_update
from {{ ref('customer') }}