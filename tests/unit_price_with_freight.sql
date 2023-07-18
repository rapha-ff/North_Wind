with
    unit_price_with_freight_more_unit_price as (
        select unit_price_with_freight, unit_price
        from {{ ref('fct_sales') }}
        where unit_price > unit_price_with_freight
    )

select *
from unit_price_with_freight_more_unit_price