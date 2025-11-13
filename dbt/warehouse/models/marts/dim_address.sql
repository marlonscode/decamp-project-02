{{
    config(
        materialized="table"
    )
}}

select
    {{ dbt_utils.generate_surrogate_key(['address.address_id']) }} as address_key,
	address.address,
	address.district,
	city.city as city,
	country.country as country,
	address.last_update
from {{ ref('address') }}
inner join {{ ref('city') }} on city.city_id = address.city_id
inner join {{ ref('country') }} on country.country_id = city.country_id