SELECT
    shf.station_id,
    shf.station_hour,
    shf.departures,
    shf.arrivals,
    shf.net_flow,
    d.station_name,
    d.latitude,
    d.longitude,

    shf.departures + shf.arrivals AS total_activity,

    CASE
        WHEN shf.net_flow > 0 THEN 'net_inbound'
        WHEN shf.net_flow < 0 THEN 'net_outbound'
        ELSE 'balanced'
    END AS flow_direction

FROM {{ ref('int_station_hourly_flow') }} shf

LEFT JOIN {{ ref('dim_station') }} d
    ON shf.station_id = d.station_id