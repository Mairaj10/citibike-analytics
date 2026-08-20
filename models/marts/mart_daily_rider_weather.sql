SELECT
r.ride_date,
    r.rider_type,
    r.total_rides,
    r.median_ride_duration_minutes,
    w.precipitation_inches,
    w.snowfall_inches,
    w.max_temperature_f,
    w.min_temperature_f

FROM {{ ref('mart_daily_rider_behavior') }} r
LEFT JOIN {{ ref('stg_weather_daily') }} w
    ON r.ride_date = w.weather_date