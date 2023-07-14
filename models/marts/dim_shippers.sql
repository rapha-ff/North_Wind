with 
    shippers as (
        select 
        ship_id
        , company_name
        from {{ ref('stg_erp__shippers') }}
    )

select *
from shippers