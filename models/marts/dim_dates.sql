{{ config(distributed_replicated=true) }}
{% set orders = ref('stg_shop__orders') %}
{% set start_date = "(SELECT MIN(order_date) FROM " ~ orders ~ ")" %}
{% set end_date = "(SELECT MAX(order_date) + 1 FROM " ~ orders ~ ")" %}

WITH calendar AS (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date=start_date,
        end_date=end_date
    ) }}
)

SELECT
    date_day::date AS order_date,
    EXTRACT(YEAR FROM date_day)::int AS year,
    EXTRACT(QUARTER FROM date_day)::int AS quarter,
    EXTRACT(MONTH FROM date_day)::int AS month,
    EXTRACT(ISODOW FROM date_day)::int AS day_of_week,
    EXTRACT(ISODOW FROM date_day) IN (6, 7) AS is_weekend
FROM calendar