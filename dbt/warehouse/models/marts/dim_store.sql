{{
    config(
        materialized="table"
    )
}}

select
	{{ dbt_utils.generate_surrogate_key(['store_id']) }} as store_key,
	manager_staff_id,
	last_update
from {{ ref('store') }}