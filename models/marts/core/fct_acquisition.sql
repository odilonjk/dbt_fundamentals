select
    artwork_id,
    name as artwork_name,
    acquisition_date,
    credit
from {{ ref('stg_artwork') }}