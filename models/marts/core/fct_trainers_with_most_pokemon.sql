with trainers as (
    select
        trainer_id,
        trainer_name
    from {{ ref('stg_trainers') }}
),

pokemons_caught_amount as (
    select
        trainer_id,
        sum(case when caught = true then 1 end) as count
    from {{ ref('stg_caught_attempt') }}
    group by trainer_id
),

final as (
    select
        trainer_id,
        trainer_name,
        coalesce(pokemons_caught_amount.count, 0) as total_pokemons_caught
    from trainers
    left join pokemons_caught_amount using (trainer_id)
)

select * from final
order by total_pokemons_caught desc
