# Superstore Sales Analysis

## Business problem

The business needs to understand sales performance, profitability, customer
value, discount impact, regional performance, and shipping speed across its
orders. The analysis identifies products and segments that drive revenue and
profit, as well as areas where discounts or product categories create losses.

## Objective

Use PostgreSQL to clean and analyze the Superstore order data and produce
reproducible findings that can support pricing, product, customer, regional,
and operational decisions.

## Dataset

The project uses the Sample Superstore CSV locally. The dataset is not included
in this repository:

- Expected local file: `data/Sample - Superstore-utf8.csv`
- Rows: 9,994 orders lines
- Date range: January 3, 2014 to December 30, 2017
- Geographic scope: United States

To reproduce the analysis, obtain the Sample Superstore dataset separately and
place its UTF-8 version at `data/Sample - Superstore-utf8.csv` before importing
it into PostgreSQL.

The UTF-8 copy is used for import because the original CSV contains
Windows-1252 characters.

## Tools

- PostgreSQL 17
- SQLTools for Visual Studio Code
- SQL
- `psql` command-line client

## Schema

The data is stored in `public.orders`.

| Column | Type | Description |
|---|---|---|
| `row_id` | `INTEGER` | Line identifier |
| `order_id` | `VARCHAR(50)` | Order identifier |
| `order_date` | `TEXT` | Original order date |
| `ship_date` | `TEXT` | Original ship date |
| `ship_mode` | `VARCHAR(50)` | Shipping method |
| `customer_id` | `VARCHAR(50)` | Customer identifier |
| `customer_name` | `VARCHAR(100)` | Customer name |
| `segment` | `VARCHAR(50)` | Customer segment |
| `country` | `VARCHAR(100)` | Country |
| `city` | `VARCHAR(100)` | City |
| `state` | `VARCHAR(100)` | State |
| `postal_code` | `VARCHAR(20)` | Postal code |
| `region` | `VARCHAR(50)` | Sales region |
| `product_id` | `VARCHAR(50)` | Product identifier |
| `category` | `VARCHAR(100)` | Product category |
| `sub_category` | `VARCHAR(100)` | Product sub-category |
| `product_name` | `TEXT` | Product name |
| `sales` | `NUMERIC(12, 4)` | Line sales |
| `quantity` | `INTEGER` | Quantity sold |
| `discount` | `NUMERIC(5, 2)` | Discount rate |
| `profit` | `NUMERIC(12, 4)` | Line profit |
| `order_dt` | `DATE` | Converted order date |
| `ship_dt` | `DATE` | Converted ship date |
| `profit_margin` | `NUMERIC(12, 6)` | Profit divided by sales |

## SQL techniques used

- `SELECT`, `WHERE`, `ORDER BY`, and `LIMIT`
- `GROUP BY` and aggregate functions such as `SUM`, `AVG`, and `COUNT`
- `COUNT(DISTINCT ...)`
- `HAVING` for filtering aggregated results
- `CASE` expressions for discount and profitability buckets
- `TO_DATE` for converting text dates
- `DATE_TRUNC` for monthly analysis
- `EXTRACT` for yearly analysis
- Common table expressions (`WITH`)
- `NULLIF` to prevent division-by-zero errors
- PostgreSQL `FILTER` clauses for NULL checks
- `ALTER TABLE` and `UPDATE` for derived columns

## Key questions

1. What are the main regions, customer segments, and shipping modes?
2. How many order lines, orders, customers, and products are represented?
3. What are the earliest and latest order dates?
4. Which products have the highest sales and lowest profit?
5. Which categories and sub-categories are most profitable?
6. Which sub-categories generate negative total profit?
7. How do sales and profit vary by region and category?
8. Which customers contribute the most sales and profit?
9. How do sales and profit change by month and year?
10. How does discounting affect profit?
11. What share of sales comes from the top 10 customers?
12. How quickly are orders shipped by shipping mode?

## Key findings

- The dataset contains **9,994 lines**, **5,009 distinct orders**,
  **793 customers**, and **1,862 products**.
- Total sales are **$2,297,201.07**.
- Technology is the most profitable category, with **$145,454.95** profit.
- The West region has the highest sales and profit:
  **$725,457.93** in sales and **$108,418.45** in profit.
- Tables, Bookcases, and Supplies have negative total profit.
- Discounts over 20% produce negative total profit:
  **-$135,376.06** across 1,393 lines.
- The top 10 customers account for **6.70%** of total sales.
- The highest-sales month is November 2017, with **$118,447.81**.
- The lowest yearly profit margin is in 2014 at **10.23%**.
- Average order value is **$458.61** overall.
- Standard Class has the longest average shipping time at approximately
  **5.01 days**.

## Recommendations

1. Review pricing, costs, and product mix for Tables, Bookcases, and Supplies.
2. Set approval thresholds or margin guardrails for discounts above 20%.
3. Investigate the West region's successful products and sales practices for
   possible replication elsewhere.
4. Protect high-margin Technology products while identifying opportunities to
   improve Furniture margins.
5. Monitor customer concentration even though the top 10 customers currently
   represent only 6.70% of sales.
6. Investigate the lower 2014 margin and compare product mix, discounting, and
   regional performance with later years.
7. Review Standard Class fulfillment processes to identify opportunities to
   reduce delivery time.

## Screenshots

Screenshots can be added here to document:

- The PostgreSQL connection and `public.orders` table
- The import process
- Query results for the main findings

Suggested location: [`screenshots/`](screenshots/).

## How to reproduce

1. Install PostgreSQL 17 and create a database named `superstore`.
2. Connect to the database as a user with permission to create and update
   tables.
3. Import [`data/Sample - Superstore-utf8.csv`](data/Sample%20-%20Superstore-utf8.csv)
   into `public.orders` as CSV with the header enabled.
4. Run [`sql/data_cleaning.sql`](sql/data_cleaning.sql) to add typed dates,
   validate NULLs, and calculate profit margins.
5. Run [`sql/analysis.sql`](sql/analysis.sql) for category, regional,
   customer, monthly, order-value, and shipping analysis.
6. Run [`sql/advanced_analysis.sql`](sql/advanced_analysis.sql) for discount,
   profitability-label, customer-share, and yearly analysis.

The original CSV is Windows-1252 encoded. If importing the original file,
select `WIN1252` as the file encoding. The UTF-8 copy avoids that import
configuration issue.

Do not store database passwords in this repository. Use a local password
prompt, environment variable, or an uncommitted local configuration.