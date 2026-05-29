with orders as (

    select *
    from {{ ref('customer_orders') }}
    where order_amount >= 100

),

customers as (

    select *
    from {{ ref('customer_segments') }}
    where is_active = true
      and customer_segment in ('Premium', 'Standard')

),

joined as (

    select
        o.customer_id,
        o.customer_name,
        c.customer_segment,
        c.region,
        count(*) as qualifying_order_count,
        sum(o.order_amount) as qualifying_total_spend,
        avg(o.order_amount) as qualifying_avg_order_amount
    from orders o
    inner join customers c
        on o.customer_id = c.customer_id
    group by
        o.customer_id,
        o.customer_name,
        c.customer_segment,
        c.region

)

select *
from joined
where qualifying_order_count > 1