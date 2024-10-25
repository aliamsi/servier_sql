WITH sales_with_type AS (
    SELECT 
        t.client_id,
        SUM(IF(product_type = 'MEUBLE', prod_qty, 0)) AS ventes_meuble,
        SUM(IF(product_type = 'DECO', prod_qty, 0)) AS ventes_deco
    FROM {{ source('raw', 'transactions') }} t
    LEFT JOIN {{ source('raw', 'product_nomenclature') }} p
        ON t.prod_id = p.product_id
    WHERE t.date BETWEEN '2019-01-01' AND '2019-12-31'
    GROUP BY 1
)

SELECT 
    client_id,
    product_type,
    total_amount,
    total_quantity,
    nb_orders
FROM sales_with_type