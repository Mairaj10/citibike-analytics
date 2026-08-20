-- Fails if any ride ends before it starts,
-- producing a negative ride duration.

select
    ride_id,
    started_at,
    ended_at,
    ride_duration_minutes
from {{ ref('fct_citibike_trips') }}
where ride_duration_minutes < 0