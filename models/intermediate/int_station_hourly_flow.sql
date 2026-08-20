with departures as (

    SELECT
    start_station_id AS station_id,
    DATE_TRUNC('hour', started_at) AS station_hour,
    COUNT(*) AS departures
FROM {{ ref('fct_citibike_trips') }}
WHERE NULLIF(TRIM(start_station_id), '') IS NOT NULL AND started_at IS NOT NULL
GROUP BY
    start_station_id,
    DATE_TRUNC('hour', started_at)

),

arrivals as (

    SELECT
    end_station_id AS station_id,
    DATE_TRUNC('hour', ended_at) AS station_hour,
    COUNT(*) AS arrivals
FROM {{ ref('fct_citibike_trips') }}
WHERE NULLIF(TRIM(end_station_id), '') IS NOT NULL AND ended_at IS NOT NULL
GROUP BY
    end_station_id,
    DATE_TRUNC('hour', ended_at)    
),

combined as (

    SELECT
        COALESCE(d.station_id, a.station_id) AS station_id,
        COALESCE(d.station_hour, a.station_hour) AS station_hour,
        COALESCE(d.departures, 0) AS departures,
        COALESCE(a.arrivals, 0) AS arrivals
    FROM departures d
    FULL OUTER JOIN arrivals a
    ON d.station_id = a.station_id AND d.station_hour = a.station_hour

)

select 
    station_id,
    station_hour,
    departures,
    arrivals,
    arrivals - departures AS net_flow
from combined