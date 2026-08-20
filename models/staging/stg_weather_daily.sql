select
    station,

    nullif(trim(weather_date), '')::date as weather_date,

    nullif(trim(precipitation), '')::double as precipitation_inches,

    nullif(trim(snowfall), '')::double as snowfall_inches,

    nullif(trim(max_temperature), '')::double as max_temperature_f,

    nullif(trim(min_temperature), '')::double as min_temperature_f,

    source_filename,
    loaded_at

from {{ source('weather', 'weather_daily') }}