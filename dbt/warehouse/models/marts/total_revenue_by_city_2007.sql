{{
    config(
        materialized="table"
    )
}}

select
    dim_address.country,
    dim_address.city,
    sum(fact_sale.payment_amount) as total_sales
from {{ ref('fact_sale') }} as fact_sale
inner join {{ ref('dim_address') }} as dim_address on dim_address.address_key = fact_sale.customer_address_key
where year(fact_sale.payment_date) = 2007
group by dim_address.city, dim_address.country
order by dim_address.country, dim_address.city asc
