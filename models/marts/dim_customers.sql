with
    customers as (
        select 
        company_name
        , contact_name
        , contact_title
        , address
        , city
        , region
        , postal_code
        , country
        from {{ ref('stg_erp__customers') }}
    )                

select *
from customers