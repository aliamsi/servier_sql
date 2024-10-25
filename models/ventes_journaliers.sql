WITH daily_sales AS (
    SELECT 
        t.date,
        SUM(t.prod_price * t.prod_qty) as ventes
    FROM {{ source('raw', 'transactions') }} t
    WHERE t.date BETWEEN '2019-01-01' AND '2019-12-31'
    GROUP BY 1
)

SELECT 
    date,
    ventes
FROM daily_sales
ORDER BY date ASC