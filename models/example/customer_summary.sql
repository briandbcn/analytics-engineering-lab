select
    customer_id,
    customer_name,
    count(*) as total_orders,
    sum(order_amount) as total_spend,
    avg(order_amount) as avg_order_amount
from {{ ref('customer_orders') }}
group by 1, 2