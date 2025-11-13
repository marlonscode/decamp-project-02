{{
    config(
        materialized="table"
    )
}}

select
	{{ dbt_utils.generate_surrogate_key(['film.film_id']) }} as film_key,
	film.title,
	category.name as category,
	film.release_year,
	film.rating,
	language.name as language,
	film.rental_duration,
	film.rental_rate,
	film.replacement_cost,
	film.last_update
from {{ ref('film') }}
inner join {{ ref('film_category') }} on film.film_id = film_category.film_id
inner join {{ ref('catgory') }} on category.category_id = film_category.category_id
inner join {{ ref('language') }} on language.language_id = film.language_id