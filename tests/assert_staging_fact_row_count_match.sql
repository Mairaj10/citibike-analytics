with staging as (
    select count(*) as row_count
    from {{ ref('stg_citibike_trips') }}
),

fact as (
    select count(*) as row_count
    from {{ ref('fct_citibike_trips') }}
)

select
    staging.row_count as staging_count,
    fact.row_count as fact_count
from staging
cross join fact
where staging.row_count <> fact.row_count