with 
    order_to_required as (
        select order_to_required
        from {{ ref('fct_sales') }}
        where order_to_required not in (14,28,42)
    )

select *
from order_to_required