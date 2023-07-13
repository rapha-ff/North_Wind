with 
    orders as (
        select *
        from {{ ref('stg_erp__orders') }}
    )

    , order_details as (
        select *
        from {{ ref('stg_erp__orders_details') }}
    )

    , join_orders as (
        select 
            orders.order_id
            , order_details.product_id
            , orders.customer_id
            , orders.employee_id
            , orders.ship_id
            , order_details.unit_price
            , order_details.quantity
            , order_details.discount
            , orders.freight
            , orders.order_date
            , orders.required_date
            , orders.shipped_date            
            , orders.ship_name
            , orders.ship_address
            , orders.ship_city
            , orders.ship_region
            , orders.ship_postal_code
            , orders.ship_country
        from order_details
        right join orders 
        using(order_id)       
    )

    , order_surrogate_key as (
        select 
        {{ dbt_utils.generate_surrogate_key(['order_id', 'product_id']) }} as surrogate_key
        , *
        from join_orders
    )

select *
from order_surrogate_key