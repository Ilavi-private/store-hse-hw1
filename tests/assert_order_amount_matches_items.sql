WITH item_totals AS (
    SELECT
        order_id,
        SUM(line_amount) AS items_amount
    FROM {{ ref('fct_order_items') }}
    GROUP BY order_id
)

SELECT
    orders.order_id,
    orders.order_amount,
    item_totals.items_amount
FROM {{ ref('fct_orders') }} AS orders
LEFT JOIN item_totals
    ON orders.order_id = item_totals.order_id
WHERE orders.order_amount
    IS DISTINCT FROM COALESCE(item_totals.items_amount, 0)