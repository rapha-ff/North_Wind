with
    source_employees as (
        select 
              cast(employee_id as int) as employee_id
            , cast(reports_to as int) as management_id
            , cast(last_name as string) as last_name
            , cast(first_name as string) as first_name
            , cast(first_name || ' ' || last_name as string) as employee_full_name
            --, title
            --, title_of_courtesy
            , cast(birth_date as date) as birth_date
            , cast(hire_date as date) as hire_date
            , cast(address as string) as address
            , cast(city as string) as city
            , cast(region as string) as region
            , cast(postal_code as string) as postal_code
            , cast(country as string) as country
            --, home_phone
            --, extension
            --, photo
            , cast(notes as string) as notes
            --, photo_path
        from {{ source('erp', 'employees') }}
    )

select *
from source_employees
