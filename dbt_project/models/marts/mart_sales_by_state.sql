with orders as (
    select * from {{ ref('int_orders_enriched') }}
),

items as (
    select * from {{ ref('int_order_items_enriched') }}
),

final as (
    select
        o.customer_state                 as state,
        o.purchase_month,
        count(distinct o.order_id)       as total_orders,
        count(distinct o.customer_id)    as total_customers,
        sum(i.total_value)               as gmv,
        avg(o.avg_review_score)          as avg_review_score,
        avg(extract(epoch from o.delivery_time) / 86400) as avg_delivery_days
    from orders o
    join items i using (order_id)
    where o.order_status = 'delivered'
    group by 1, 2
)

select * from final