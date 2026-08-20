select
    ride_id,
    rideable_type,

    nullif(trim(started_at), '')::timestamp_ntz as started_at,
    nullif(trim(ended_at), '')::timestamp_ntz as ended_at,

    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,

    nullif(trim(start_lat), '')::double as start_lat,
    nullif(trim(start_lng), '')::double as start_lng,
    nullif(trim(end_lat), '')::double as end_lat,
    nullif(trim(end_lng), '')::double as end_lng,
    member_casual,

    source_filename,
    loaded_at
from {{ source('citibike', 'citibike_trips') }}