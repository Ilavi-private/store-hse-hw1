SELECT
    customers.customer_id,
    customers.registered_at,
    customers.city,
    customers.acquisition_channel,
    purchases.first_confirmed_order_id,
    purchases.first_confirmed_at,
    COALESCE(purchases.confirmed_orders_count, 0) AS confirmed_orders_count,
    COALESCE(purchases.confirmed_revenue, 0) AS confirmed_revenue,
    purchases.customer_id IS NOT NULL AS is_buyer
FROM {{ ref('stg_shop__customers') }} AS customers
LEFT JOIN {{ ref('int_customer_purchases') }} AS purchases
    ON customers.customer_id = purchases.customer_id