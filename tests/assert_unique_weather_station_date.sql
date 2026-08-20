-- Fails if the same weather station has more than one row for the same date.

select
    station,
    weather_date,
    count(*) as row_count
from {{ ref('stg_weather_daily') }}
group by
    station,
    weather_date
having count(*) > 1