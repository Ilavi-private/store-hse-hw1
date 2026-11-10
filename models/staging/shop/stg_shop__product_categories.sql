SELECT
    category_id,
    category_name,
    parent_category_id
FROM {{ source('shop', 'product_categories') }}