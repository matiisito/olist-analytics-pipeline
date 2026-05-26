with orders as (
    select * from {{ ref('int_orders_enriched') }}
),

items as (
    select * from {{ ref('int_order_items_enriched') }}
),

final as (
    select
        i.seller_id,
        i.seller_city,
        i.seller_state,
        count(distinct o.order_id)       as total_orders,
        count(distinct i.product_id)     as total_products,
        sum(i.total_value)               as gmv,
        avg(i.price)                     as avg_price,
        avg(o.avg_review_score)          as avg_review_score,
        avg(extract(epoch from o.delivery_time) / 86400) as avg_delivery_days
    from orders o
    join items i using (order_id)
    where o.order_status = 'delivered'
    group by 1, 2, 3
)

select * from final