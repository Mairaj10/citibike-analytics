-- Fails if the weather join creates more than one row
-- for the same date and rider type.

select
    ride_date,
    rider_type,
    count(*) as row_count
from {{ ref('mart_daily_rider_weather') }}
group by
    ride_date,
    rider_type
having count(*) > 1