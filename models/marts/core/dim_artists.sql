with artists as (
    select * from {{ ref('stg_artists') }}
),

artwork as (
    select * from {{ ref('stg_artwork') }} 
),

artist_artworks as (
    select
        artist_id,
        min(date) as oldest_artwork_date,
        max(date) as newest_artwork_date,
        count(artwork_id) as number_of_artworks
    from artwork
    group by 1
),

final as (
    select
       artists.artist_id,
       artists.name, 
       artists.birth_year,
       artist_artworks.oldest_artwork_date,
       artist_artworks.newest_artwork_date,
       coalesce(artist_artworks.number_of_artworks, 0) as number_of_artworks
    from artists
    left join artist_artworks using (artist_id)
)

select * from final
