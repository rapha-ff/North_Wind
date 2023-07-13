with
    source_orders as (
        select
        cast(order_id as int) as order_id 
        , cast(customer_id as string) as customer_id 
        , cast(employee_id as int) as employee_id 
        , cast(order_date as date) as order_date 
        , cast(required_date as date) as required_date 
        , cast(shipped_date as date) as shipped_date 
        , cast(ship_via as int) as ship_id 
        , cast(freight as numeric) as freight 
        , cast(ship_name as string) as ship_name 
        , cast(ship_address as string) as ship_address 
        , cast(ship_city as string) as ship_city 
        , cast(ship_region as string) as ship_region 
        , cast(ship_postal_code as string) as ship_postal_code 
        , cast(ship_country as string) as ship_country 
        from {{ source('erp', 'orders') }}
    )

select *
from source_orders
