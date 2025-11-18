{{
    config(
        materialized="table"
    )
}}

select
	{{ dbt_utils.generate_surrogate_key(['staff_id']) }} as staff_key,
	first_name as staff_first_name,
	last_name as staff_last_name,
	email as staff_email,
	last_update
from {{ ref('staff') }}