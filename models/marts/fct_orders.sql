{{ config(distributed_by='order_id') }}
-- Задание 4. Факт заказов: одна строка — один заказ. Тестовые заказы в витрину не попадают.
-- Материализация — table (задана для папки marts в dbt_project.yml).
select
    orders.order_id,
    customer_id,
    order_date,
    ordered_at,
    order_status,
    order_amount,
    paid_amount,
    refunded_amount,
    net_paid_amount,
    successful_payments_count,
    first_paid_at,
    is_confirmed,
    COALESCE(item_counts.items_count, 0) AS items_count
FROM {{ ref('int_orders_with_payments') }} AS orders
LEFT JOIN {{ ref('int_order_item_counts') }} AS item_counts
    ON orders.order_id = item_counts.order_id
WHERE NOT orders.is_test_order
