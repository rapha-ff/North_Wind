with 
    source_shippers as (
        select
          cast(shipper_id as int) as shipper_id
        , cast(company_name as string) as company_name
        --, phone
        from {{ source('erp', 'shippers') }}
    )

select *
from source_shippers