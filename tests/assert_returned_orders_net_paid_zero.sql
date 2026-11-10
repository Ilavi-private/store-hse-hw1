SELECT
    order_id,
    paid_amount,
    refunded_amount,
    net_paid_amount
FROM {{ ref('fct_orders') }}
WHERE order_status = 'returned'
  AND net_paid_amount IS DISTINCT FROM 0