/* What are the total sales and average sales by month and quarter? */

--- Quarterly Sales
SELECT
    t.quarter,
    SUM(total_price) AS sales,
    CAST(AVG(total_price) AS INT) AS avg_sales
FROM
    fact_table f
JOIN time_dim t ON f.time_key = t.time_key
GROUP BY
    t.quarter;

--- Monthly Sales
SELECT
    t.month,
    SUM(total_price) AS sales,
    CAST(AVG(total_price) AS INT) AS avg_sales
FROM
    fact_table f
JOIN time_dim t ON f.time_key = t.time_key
GROUP BY
    t.month;

/* What is the revenue generated by each item in each year before 2017? */
SELECT
    t.year,
    i.item_name,
    SUM(total_price) AS revenue
FROM
    fact_table f
JOIN time_dim t ON f.time_key = t.time_key
JOIN item_dim i ON f.item_key = i.item_key
WHERE
    t.year < 2017
GROUP BY
    t.year, i.item_name;

/* What is the yearly quantity for each supplier? 
Also, provide the average unit price per item for each supplier. */
SELECT
    i.supplier,
    EXTRACT(YEAR FROM t.date) AS year,
    SUM(f.quantity) AS total_quantity,
    ROUND(AVG(f.unit_price), 2) AS avg_unit_price
FROM
    fact_table f
JOIN item_dim i ON f.item_key = i.item_key
JOIN time_dim t ON f.time_key = t.time_key
GROUP BY
    i.supplier, EXTRACT(YEAR FROM t.date)
ORDER BY
    i.supplier, year;





