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

    , dates as (
        select *
        from {{ ref('dim_date') }}
    )

    , join_fact as (
        select 
            sell_orders.surrogate_key
            , employees.employee_id
            , customers.customer_id
            , products.product_id
            , shippers.ship_id
            , sell_orders.order_id
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
            , employees.employee_full_name
            , employees.management_full_name
            , products.product_name
            , products.category_name
            , products.company_name
            , products.is_discontinued

        from sell_orders
        left join employees using(employee_id)
        left join customers using(customer_id)
        left join products using(product_id)
        left join shippers using(ship_id)
        left join dates on sell_orders.order_date = dates.date_day
    )

    , metrics as (
        select
        *
        , round((freight/(count(*) over(partition by order_id))),2) as freight_per_product 
        , (unit_price * quantity) as gross_income
        , (unit_price * quantity * (1-discount)) as net_income
        , (unit_price * quantity * discount) as total_discount
        , (unit_price + round((freight/(count(*) over(partition by order_id))/quantity),2)) as unit_price_with_freight
        , date_diff(shipped_date, order_date, day) as time_to_ship
        , date_diff(required_date, shipped_date, day) as shipped_to_required
        , date_diff(required_date, order_date, day) as order_to_required
        , case 
            when date_diff(required_date, order_date, day) = 14 then "Fast"
            when date_diff(required_date, order_date, day) = 28 then "Normal"
            when date_diff(required_date, order_date, day) = 42 then "Slow"
            else "" end as shipped_category   
        from join_fact
    )

    , final_select as (
        select
            surrogate_key as sk_orders
            , employee_id as fk_employee
            , customer_id as fk_customer
            , product_id as fk_product
            , ship_id as fk_shippers
            , order_id

            , unit_price
            , unit_price_with_freight
            , quantity
            , gross_income
            , discount
            , net_income
            , total_discount
            , freight_per_product
            , time_to_ship
            , shipped_to_required
            , order_to_required
            , shipped_category

            , order_date
            , required_date
            , shipped_date   

            , ship_name
            , ship_address
            , ship_city
            , ship_region
            , ship_postal_code
            , ship_country
            , employee_full_name
            , management_full_name
            , product_name
            , category_name
            , company_name
            , is_discontinued
        from metrics
    )

select *
from final_select
