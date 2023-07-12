with
    suppliers as (
        select
        *
        from {{ ref('stg_erp__suppliers') }}
    )

    , products as (
        select
        *
        from {{ ref('stg_erp__products') }}
    )

    , categories as (
        select
        *
        from {{ ref('stg_erp__categories') }}
    )

    , join_table_products as (
        select 
            products.product_id
            , products.supplier_id
            , products.category_id
            , products.unit_price
            , products.units_in_stock
            , products.units_on_order
            , products.quantity_per_unit
            , products.product_name
            , products.reorder_level
            , products.is_discontinued
            , categories.category_name
            , categories.description
            , suppliers.company_name
            , suppliers.contact_name
            , suppliers.contact_title
            , suppliers.address
            , suppliers.city
            , suppliers.region
            , suppliers.postal_code
            , suppliers.country
        from products
        left join suppliers
        using(supplier_id)
        left join categories 
        using(category_id)
    )

select *
from join_table_products