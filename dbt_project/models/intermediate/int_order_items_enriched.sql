with order_items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

translations as (
    select * from {{ ref('stg_product_category_translation') }}
),

sellers as (
    select * from {{ ref('stg_sellers') }}
),

enriched as (
    select
        oi.order_id,
        oi.item_number,
        oi.product_id,
        oi.seller_id,
        coalesce(t.category_name_english, p.category_name, 'unknown') as category,
        p.weight_g,
        oi.price,
        oi.freight_value,
        oi.total_value,
        oi.shipping_limit_at,
        s.city   as seller_city,
        s.state  as seller_state
    from order_items oi
    left join products p     using (product_id)
    left join translations t on p.category_name = t.product_category_name
    left join sellers s      using (seller_id)
)

select * from enriched