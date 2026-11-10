WITH source_revenue AS (
    SELECT COALESCE(SUM(o.total_amount), 0) AS revenue
    FROM {{ source('shop', 'orders') }} AS o
    WHERE o.status = 'paid'
      AND EXISTS (
          SELECT 1
          FROM {{ source('shop', 'payments') }} AS p
          WHERE p.order_id = o.order_id
            AND p.payment_status = 'success'
            AND p.amount >= 0
      )
),
mart_revenue AS (
    SELECT COALESCE(SUM(order_amount), 0) AS revenue
    FROM {{ ref('fct_orders') }}
    WHERE is_confirmed
)
SELECT
    s.revenue AS expected_revenue,
    m.revenue AS actual_revenue
FROM source_revenue AS s
CROSS JOIN mart_revenue AS m
WHERE s.revenue IS DISTINCT FROM m.revenue