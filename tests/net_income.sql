with 
    net_income_more_gross_income as (
        select net_income, gross_income
        from {{ ref('fct_sales') }}
        where net_income > gross_income
    )

select *
from net_income_more_gross_income