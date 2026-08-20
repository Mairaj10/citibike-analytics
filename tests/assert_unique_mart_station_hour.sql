-- Fails if more than one row exists for the same station and hour,
-- which would violate the mart grain.

select
    station_id,
    station_hour,
    count(*) as row_count
from {{ ref('mart_station_hourly_demand') }}
group by
    station_id,
    station_hour
having count(*) > 1