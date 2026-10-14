-- 1. First 10 rows
SELECT *
FROM public.orders
ORDER BY row_id
LIMIT 10;

-- Distinct regions
SELECT DISTINCT region
FROM public.orders
ORDER BY region;

-- Distinct segments
SELECT DISTINCT segment
FROM public.orders
ORDER BY segment;

-- Distinct ship modes
SELECT DISTINCT ship_mode
FROM public.orders
ORDER BY ship_mode;

-- 2. Row count and distinct entity counts
SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT order_id) AS distinct_order_count,
    COUNT(DISTINCT customer_id) AS distinct_customer_count,
    COUNT(DISTINCT product_id) AS distinct_product_count
FROM public.orders;

-- 3. Earliest and latest order dates
SELECT
    MIN(TO_DATE(order_date, 'MM/DD/YYYY')) AS earliest_order_date,
    MAX(TO_DATE(order_date, 'MM/DD/YYYY')) AS latest_order_date
FROM public.orders;

-- 4. Five highest-sales lines
SELECT
    row_id,
    order_id,
    product_name,
    sales,
    profit
FROM public.orders
ORDER BY sales DESC, row_id
LIMIT 5;

-- Five lowest-profit lines
SELECT
    row_id,
    order_id,
    product_name,
    sales,
    profit
FROM public.orders
ORDER BY profit ASC, row_id
LIMIT 5;
