{{
    config(
        materialized="table"
    )
}}

with base_1 as (
    select
        film_category,
        sum(fact_sale.payment_amount) over (partition by film_category) as category_sales,
	    sum(fact_sale.payment_amount) over () as total_sales
    from {{ ref('fact_sale') }} as fact_sale
    inner join {{ ref('dim_film') }} as dim_film on dim_film.film_key = fact_sale.film_key
),

base_2 as (
select
	film_category,
	category_sales,
	total_sales,
	round((100 * category_sales/total_sales), 1) as category_share_of_sales
from base_1
)

select
	film_category,
	category_sales,
	total_sales,
	category_share_of_sales
from base_2
group by
	film_category,
	category_sales,
	total_sales,
	category_share_of_sales
order by category_share_of_sales desc