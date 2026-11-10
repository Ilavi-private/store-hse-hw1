{{ config(distributed_replicated=true) }}

SELECT
    p.product_id,
    p.product_name,
    p.brand,
    p.category_name,
    c.parent_category_name,
    c.root_category_name
FROM {{ref('stg_shop__products') }} AS p
LEFT JOIN {{ ref('int_product_category_tree') }} AS c
    ON p.category_name = c.category_name