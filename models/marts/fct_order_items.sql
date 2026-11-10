SELECT
    items.order_item_id,
    items.order_id,
    items.product_id,
    orders.customer_id,
    orders.order_date,
    items.quantity,
    items.unit_price,
    items.discount_amount,
    items.line_amount,
    orders.is_confirmed
FROM {{ ref('stg_shop__order_items') }} AS items
JOIN {{ ref('fct_orders') }} AS orders
    ON items.order_id = orders.order_id