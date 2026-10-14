-- 8. Sales, profit, and margin by category.
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(profit) / NULLIF(SUM(sales), 0) AS profit_margin
FROM public.orders
GROUP BY category
ORDER BY total_profit DESC;

-- Sales, profit, and margin by sub-category.
SELECT
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(profit) / NULLIF(SUM(sales), 0) AS profit_margin
FROM public.orders
GROUP BY sub_category
ORDER BY total_profit DESC;

-- 9. Sub-categories with negative total profit.
SELECT
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM public.orders
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit;

-- 10. Sales and profit by region.
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM public.orders
GROUP BY region
ORDER BY total_profit DESC;

-- Sales and profit by region and category.
SELECT
    region,
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM public.orders
GROUP BY region, category
ORDER BY region, total_profit DESC;

-- 11. Top 10 customers by sales.
SELECT
    customer_id,
    customer_name,
    SUM(sales) AS total_sales
FROM public.orders
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC, customer_id
LIMIT 10;

-- Top 10 customers by profit.
SELECT
    customer_id,
    customer_name,
    SUM(profit) AS total_profit
FROM public.orders
GROUP BY customer_id, customer_name
ORDER BY total_profit DESC, customer_id
LIMIT 10;

-- 12. Monthly sales and profit.
SELECT
    DATE_TRUNC('month', order_dt)::DATE AS order_month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM public.orders
GROUP BY DATE_TRUNC('month', order_dt)
ORDER BY order_month;

-- 13. Average order value overall.
SELECT
    SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0) AS average_order_value
FROM public.orders;

-- Average order value by segment.
SELECT
    segment,
    SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0) AS average_order_value
FROM public.orders
GROUP BY segment
ORDER BY average_order_value DESC;

-- 14. Average shipping days by ship mode.
SELECT
    ship_mode,
    AVG(ship_dt - order_dt) AS average_shipping_days
FROM public.orders
GROUP BY ship_mode
ORDER BY average_shipping_days;