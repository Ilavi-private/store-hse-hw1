SELECT
    order_id,
    COUNT(DISTINCT product_id) AS items_count
FROM {{ ref('stg_shop__order_items') }}
GROUP BY order_id