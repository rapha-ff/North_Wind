with
    source_products as (
        select
            cast(product_id as int) as product_id
            , cast(supplier_id as int) as supplier_id
            , cast(category_id as int) as category_id
 
            , cast(unit_price as numeric) as unit_price
            , cast(units_in_stock as int) as units_in_stock
            , cast(units_on_order as int) as units_on_order
 
            , cast(quantity_per_unit as string) as quantity_per_unit
            , cast(product_name as string) as product_name
            , cast(reorder_level as int) as reorder_level
            , case
                when discontinued = 0 then False 
                else True 
                END as is_discontinued
        from {{ source('erp', 'products') }}
    )

select *
from source_products