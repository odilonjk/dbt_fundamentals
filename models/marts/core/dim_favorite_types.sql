with pokemons as (
    select * from {{ ref('stg_pokemon') }}
),

trainers as (
    select * from {{ ref('stg_trainers') }}
),

type_counts as (
    select
        trainer_id,
        trainers.trainer_name as trainer_name,
        pokemons.type_1 as pokemon_type,
        count(1) as count
    from {{ ref('stg_caught_attempt') }}
    inner join trainers using (trainer_id)
    inner join pokemons using (pokemon_id)
    where caught = true and pokemons.type_1 is not null
    group by trainer_id, trainers.trainer_name, pokemons.type_1 

    union all

    select
        trainer_id,
        trainers.trainer_name as trainer_name,
        pokemons.type_2 as pokemon_type,
        count(1) as count
    from {{ ref('stg_caught_attempt') }}
    inner join trainers using (trainer_id)
    inner join pokemons using (pokemon_id)
    where caught = true and pokemons.type_2 is not null
    group by trainer_id, trainers.trainer_name, pokemons.type_2
),

final as (
    select
        trainer_id,
        trainer_name,
        max(pokemon_type) as favorite_type,
        max(count) as count
    from type_counts
    where count > 1
    group by trainer_id, trainer_name
)

select * from final
order by count desc
