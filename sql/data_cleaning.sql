-- 5. Add typed date columns and populate them from the text dates.
ALTER TABLE public.orders
    ADD COLUMN IF NOT EXISTS order_dt DATE,
    ADD COLUMN IF NOT EXISTS ship_dt DATE;

UPDATE public.orders
SET
    order_dt = TO_DATE(order_date, 'MM/DD/YYYY'),
    ship_dt = TO_DATE(ship_date, 'MM/DD/YYYY');

-- 6. Check required columns for NULL values.
SELECT
    COUNT(*) FILTER (WHERE sales IS NULL) AS null_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS null_profit,
    COUNT(*) FILTER (WHERE discount IS NULL) AS null_discount,
    COUNT(*) FILTER (WHERE region IS NULL) AS null_region,
    COUNT(*) FILTER (WHERE category IS NULL) AS null_category
FROM public.orders;

-- 7. Add and populate profit margin. NULLIF avoids division by zero.
ALTER TABLE public.orders
    ADD COLUMN IF NOT EXISTS profit_margin NUMERIC(12, 6);

UPDATE public.orders
SET profit_margin = profit / NULLIF(sales, 0);

SELECT
    COUNT(*) AS row_count,
    COUNT(profit_margin) AS populated_profit_margin_count,
    COUNT(*) FILTER (WHERE sales = 0) AS zero_sales_count
FROM public.orders;