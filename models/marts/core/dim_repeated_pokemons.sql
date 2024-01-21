with pokemons as (
    select * from {{ ref('stg_pokemon') }}
),

trainers as (
    select * from {{ ref('stg_trainers') }}
),

pokemon_count as (
    select
        trainer_id,
        trainers.trainer_name as trainer_name,
        pokemon_id,
        count(1) as count
    from {{ ref('stg_caught_attempt') }}
    inner join trainers using (trainer_id)
    inner join pokemons using (pokemon_id)
    where caught = true
    group by trainer_id, trainers.trainer_name, pokemon_id 
),

final as (
    select
        trainer_id,
        trainer_name,
        pokemon_id,
        pokemons.pokemon_name,
        max(count) as count
    from pokemon_count
    inner join pokemons using (pokemon_id)
    where count > 1
    group by trainer_id, trainer_name, pokemon_id, pokemons.pokemon_name
)

select * from final
order by count desc