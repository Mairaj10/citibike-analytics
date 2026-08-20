{{
    config(
        materialized='incremental',
        unique_key='ride_id',
        incremental_strategy='merge'
    )
}}

select
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    DATEDIFF('second', started_at, ended_at) / 60.0 AS ride_duration_minutes,
    start_station_name,
    start_station_id,
    end_station_name,
    end_station_id,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual,
    source_filename,
    loaded_at

from {{ ref('stg_citibike_trips') }}

{% if is_incremental() %}

where loaded_at > (
    select max(loaded_at)
    from {{ this }}
)

{% endif %}