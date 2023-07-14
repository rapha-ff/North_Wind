with
    employees as (
        select *
        from {{ ref('dim_employees') }}
    )

    , customers as (
        select *
        from {{ ref('dim_customers') }}
    )

    , products as (
        select *
        from {{ ref('dim_products') }}
    )

    , shippers as (
        select *
        from {{ ref('dim_shippers') }}
    )

    , sell_orders as (
        select *
        from {{ ref('int_sell__orders_details') }}
    )

    , join_fact as (
        select 
            sell_orders.surrogate_key
            , employees.employee_id
            , customers.customer_id
            , products.product_id
            , shippers.ship_id
            , sell_orders.unit_price
            , sell_orders.quantity
            , sell_orders.discount
            , sell_orders.freight
            , sell_orders.order_date
            , sell_orders.required_date
            , sell_orders.shipped_date            
            , sell_orders.ship_name
            , sell_orders.ship_address
            , sell_orders.ship_city
            , sell_orders.ship_region
            , sell_orders.ship_postal_code
            , sell_orders.ship_country

        from sell_orders
        left join employees using(employee_id)
        left join customers using(customer_id)
        left join products using(product_id)
        left join shippers using(ship_id)
    )

select *
from join_fact