with source as (
    select * from {{ source('raw', 'orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_status,
        order_purchase_timestamp::timestamp   as purchased_at,
        order_approved_at::timestamp          as approved_at,
        order_delivered_carrier_date::timestamp as delivered_carrier_at,
        order_delivered_customer_date::timestamp as delivered_customer_at,
        order_estimated_delivery_date::timestamp as estimated_delivery_at,

        case
            when order_delivered_customer_date is not null
            then order_delivered_customer_date::timestamp - order_purchase_timestamp::timestamp
        end as delivery_time

    from source
    where order_status != 'unavailable'
)

select * from renamed