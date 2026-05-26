with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

payments as (
    select
        order_id,
        sum(payment_value)                              as total_payment,
        count(distinct payment_sequential)              as payment_count,
        max(installments)                               as max_installments,
        mode() within group (order by payment_type)    as main_payment_type
    from {{ ref('stg_order_payments') }}
    group by order_id
),

reviews as (
    select
        order_id,
        avg(review_score) as avg_review_score
    from {{ ref('stg_order_reviews') }}
    group by order_id
),

enriched as (
    select
        o.order_id,
        o.customer_id,
        c.customer_unique_id,
        c.city       as customer_city,
        c.state      as customer_state,
        o.order_status,
        o.purchased_at,
        o.approved_at,
        o.delivered_customer_at,
        o.estimated_delivery_at,
        o.delivery_time,
        p.total_payment,
        p.payment_count,
        p.max_installments,
        p.main_payment_type,
        r.avg_review_score,
        date_trunc('month', o.purchased_at) as purchase_month,
        date_trunc('week', o.purchased_at)  as purchase_week
    from orders o
    left join customers c using (customer_id)
    left join payments p  using (order_id)
    left join reviews r   using (order_id)
)

select * from enriched