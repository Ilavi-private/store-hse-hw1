{{ config(severity='warn') }}

SELECT
    order_id,
    order_amount,
    paid_amount,
    paid_amount - order_amount AS overpaid_amount
FROM {{ ref('fct_orders') }}
WHERE is_confirmed
  AND paid_amount > order_amount