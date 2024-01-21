select
    id as trainer_id,
    name as trainer_name,
    city_id,
    age
from {{ source('pokemon', 'raw_trainers') }}