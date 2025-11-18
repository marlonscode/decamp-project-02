{{
    config(
        materialized="table"
    )
}}

select
	date(payment_date) as date,
	sum(payment_amount) as total_sales
from {{ ref('fact_sale') }} as fact_sale
group by date
order by date asc