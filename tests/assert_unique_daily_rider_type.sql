-- Fails if more than one row exists for the same date and rider type,
-- which would violate the mart grain.

select
    ride_date,
    rider_type,
    count(*) as row_count
from {{ ref('mart_daily_rider_behavior') }}
group by
    ride_date,
    rider_type
having count(*) > 1