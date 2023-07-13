with 
    employees as (
        select
        *
        from {{ ref('stg_erp__employees') }}
    )
 
    , managements as (
        select
        *
        from {{ ref('stg_erp__employees') }}
    )

    , join_table as (
        select 
        employees.employee_id
        , employees.first_name
        , employees.last_name
        , employees.employee_full_name 
        , managements.employee_full_name as management_full_name
        , employees.birth_date
        , employees.hire_date
        , employees.address
        , employees.city
        , employees.region
        , employees.postal_code
        , employees.country
        , employees.notes
        from employees
        left join managements 
        on employees.management_id = managements.employee_id
    )

select *
from join_table
