with 
    unit_price_positive as (
        select unit_price
        from {{ ref('fct_sales') }}
        where unit_price <= 0
    )

select * 
from unit_price_positive