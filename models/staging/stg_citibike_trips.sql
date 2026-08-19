select
    ride_id,
    rideable_type,

    started_at::timestamp_ntz as started_at,
    ended_at::timestamp_ntz as ended_at,

    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,

    start_lat::double as start_lat,
    start_lng::double as start_lng,
    end_lat::double as end_lat,
    end_lng::double as end_lng,
    member_casual,

    source_filename,
    loaded_at
from {{ source('citibike', 'citibike_trips') }}