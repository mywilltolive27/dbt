
WITH
payments as(
    select * from {{ ref('stg_payments')}}
),

orders as (

    select * from {{ ref('stg_orders')}}
),

outputs as (
select order_id, customer_id, SUM(amount) AS amount
from orders
inner join payments using (order_id)
where payments.payment_status = "success"
group by order_id, customer_id
order by order_id
)

select * from outputs
    