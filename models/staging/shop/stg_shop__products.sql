SELECT
    product_id,
    product_name,
    brand,
    category AS category_name
FROM {{ source('shop', 'products') }}