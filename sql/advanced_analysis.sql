-- 15. Discount buckets.
WITH bucketed_orders AS (
    SELECT
        CASE
            WHEN discount = 0 THEN 'none'
            WHEN discount <= 0.20 THEN 'up to 20%'
            ELSE 'over 20%'
        END AS discount_bucket,
        profit
    FROM public.orders
)
SELECT
    discount_bucket,
    COUNT(*) AS line_count,
    AVG(profit) AS average_profit,
    SUM(profit) AS total_profit
FROM bucketed_orders
GROUP BY discount_bucket
ORDER BY
    CASE
        WHEN discount_bucket = 'none' THEN 1
        WHEN discount_bucket = 'up to 20%' THEN 2
        ELSE 3
    END;

-- 16. Profitability labels by region.
SELECT
    region,
    CASE
        WHEN profit < 0 THEN 'Loss'
        WHEN profit_margin < 0.10 THEN 'Low margin'
        ELSE 'Healthy'
    END AS profitability_label,
    COUNT(*) AS line_count,
    SUM(sales) AS total_sales
FROM public.orders
GROUP BY
    region,
    CASE
        WHEN profit < 0 THEN 'Loss'
        WHEN profit_margin < 0.10 THEN 'Low margin'
        ELSE 'Healthy'
    END
ORDER BY region, profitability_label;

-- 17. Total sales, calculated separately for the top-customer share.
SELECT SUM(sales) AS total_sales
FROM public.orders;

-- Share of total sales from the top 10 customers.
WITH top_customers AS (
    SELECT customer_id, SUM(sales) AS customer_sales
    FROM public.orders
    GROUP BY customer_id
    ORDER BY customer_sales DESC
    LIMIT 10
)
SELECT
    SUM(customer_sales) AS top_10_customer_sales,
    (SUM(customer_sales) / NULLIF((SELECT SUM(sales) FROM public.orders), 0)) * 100
        AS top_10_sales_share_percent
FROM top_customers;

-- 18. Sales, profit, and margin by year.
SELECT
    EXTRACT(YEAR FROM order_dt)::INTEGER AS order_year,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(profit) / NULLIF(SUM(sales), 0) AS profit_margin
FROM public.orders
GROUP BY EXTRACT(YEAR FROM order_dt)
ORDER BY order_year;

-- The year with the worst margin.
WITH yearly_results AS (
    SELECT
        EXTRACT(YEAR FROM order_dt)::INTEGER AS order_year,
        SUM(profit) / NULLIF(SUM(sales), 0) AS profit_margin
    FROM public.orders
    GROUP BY EXTRACT(YEAR FROM order_dt)
)
SELECT order_year, profit_margin
FROM yearly_results
ORDER BY profit_margin
LIMIT 1;