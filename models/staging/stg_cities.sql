select
    id as city_id,
    name as city_name
from {{ source('pokemon', 'raw_cities') }}