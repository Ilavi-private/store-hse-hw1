WITH ranked_purchases AS (
    SELECT
        customer_id,
        order_id,
        ordered_at,
        COUNT(*) OVER (PARTITION BY customer_id) AS confirmed_orders_count,
        SUM(order_amount) OVER (PARTITION BY customer_id) AS confirmed_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY ordered_at, order_id
        ) AS purchase_number
    FROM {{ ref('fct_orders') }}
    WHERE is_confirmed
)
SELECT
    customer_id,
    order_id AS first_confirmed_order_id,
    ordered_at AS first_confirmed_at,
    confirmed_orders_count,
    confirmed_revenue
FROM ranked_purchases
WHERE purchase_number = 1