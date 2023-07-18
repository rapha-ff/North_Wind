with
    time_to_ship as (
        select shipped_date, order_date
        from {{ ref('fct_sales') }}
        where time_to_ship <= 0
    )

select *
from time_to_ship