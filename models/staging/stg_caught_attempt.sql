select
    pokedex_number as pokemon_id,
    caught,
    trainer_id
from {{ source('pokemon', 'raw_caught_attempt') }}