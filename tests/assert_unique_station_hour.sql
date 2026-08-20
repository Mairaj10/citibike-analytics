-- Fails when more than one row exists for the same station and hour,
-- which would violate the model grain.

SELECT
    station_id,
    station_hour,
    COUNT(*) AS row_count
FROM {{ ref('int_station_hourly_flow') }}
GROUP BY
    station_id,
    station_hour
HAVING COUNT(*) > 1