{{
    config(
        materialized="table"
    )
}}

with base as (
    select
        film_title,
        sum(fact_sale.payment_amount) as total_sales,
    from {{ ref('fact_sale') }} as fact_sale
    inner join {{ ref('dim_film') }} as dim_film on dim_film.film_key = fact_sale.film_key
    group by film_title
    order by total_sales desc
)

select
    film_title,
    total_sales,
    dense_rank() over (order by total_sales desc) as total_sales_rank
from base