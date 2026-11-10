WITH RECURSIVE category_tree AS (
    SELECT
        category_id,
        category_name,
        NULL::text AS parent_category_name,
        category_name AS root_category_name
    FROM {{ ref('stg_shop__product_categories') }}
    WHERE parent_category_id IS NULL

    UNION ALL


    SELECT
        child.category_id,
        child.category_name,
        parent.category_name::text AS parent_category_name,
        parent.root_category_name
    FROM {{ ref('stg_shop__product_categories') }} AS child
    JOIN category_tree AS parent
        ON child.parent_category_id = parent.category_id
)
SELECT
    category_id,
    category_name,
    parent_category_name,
    root_category_name
FROM category_tree