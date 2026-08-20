SELECT 
DATE(started_at) AS ride_date,
    member_casual AS rider_type,
     MEDIAN(ride_duration_minutes) AS median_ride_duration_minutes,
     COUNT(*) AS total_rides
     FROM {{ ref('fct_citibike_trips') }}
GROUP BY 1, 2

