{{
    config(
        materialized="table"
    )
}}

select
	{{ dbt_utils.generate_surrogate_key(['staff_id']) }} as staff_key,
	first_name,
	last_name,
	email,
	store_id,
	last_update
from {{ ref('staff') }}