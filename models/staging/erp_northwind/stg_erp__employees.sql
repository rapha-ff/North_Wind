with
    source_employees as (
        select 
              cast(employee_id as int)
            , cast(reports_to as int) as management_id
            , cast(last_name as string)
            , cast(first_name as string)
            , cast(first_name || ' ' || last_name as string) as full_name
            --, title
            --, title_of_courtesy
            , cast(birth_date as date)
            , cast(hire_date as date)
            , cast(address as string)
            , cast(city as string)
            , cast(region as string)
            , postal_code
            , cast(country as string)
            --, home_phone
            --, extension
            --, photo
            , cast(notes as string)
            --, photo_path
        from {{ source('erp', 'employees') }}
) 

select *
from source_employees
