with station_observations as (

    select 
        start_station_id as station_id,
        start_station_name as station_name,
        start_lat as latitude,
        start_lng as longitude,
        started_at as observed_at
    from {{ ref('fct_citibike_trips') }}

    union all

    select
        end_station_id as station_id,
        end_station_name as station_name,
        end_lat as latitude,
        end_lng as longitude,
        ended_at as observed_at
    from {{ ref('fct_citibike_trips') }}

),
ranked_stations as (

    select
        *,
        row_number() over (
            partition by station_id
            order by observed_at desc
        ) as row_num
    from station_observations
   where nullif(trim(station_id), '') is not null
    and observed_at is not null

)

select
    station_id,
    station_name,
    latitude,
    longitude,
    observed_at as last_observed_at
from ranked_stations
where row_num = 1
