/* How has the average order quantity changed on a quarterly basis for the last year? */
SELECT
    EXTRACT(YEAR FROM t.date) AS year,
    EXTRACT(QUARTER FROM t.date) AS quarter,
    ROUND(AVG(f.quantity),2) AS average_order_quantity
FROM
    fact_table f
JOIN time_dim t ON f.time_key = t.time_key
WHERE
    EXTRACT(YEAR FROM t.date) = (SELECT MAX(EXTRACT(YEAR FROM t.date)) -1  FROM time_dim t)
GROUP BY
    EXTRACT(YEAR FROM t.date), EXTRACT(QUARTER FROM t.date)
ORDER BY
    year DESC, quarter DESC;

/* What is the monthly revenue trend for the past two years? */
SELECT
    EXTRACT(YEAR FROM t.date) AS year,
    EXTRACT(MONTH FROM t.date) AS month,
    SUM(f.total_price) AS total_revenue
FROM
    fact_table f
JOIN time_dim t ON f.time_key = t.time_key
WHERE
    t.date >= (SELECT MAX(t.date) FROM time_dim t) - INTERVAL '2 years' 
GROUP BY
    EXTRACT(YEAR FROM t.date), EXTRACT(MONTH FROM t.date)
ORDER BY
    year ASC, month ASC;

/* What is the weekly purchase frequency trend over the last 6 months? */
SELECT
    EXTRACT(YEAR FROM t.date) AS year,
    EXTRACT(WEEK FROM t.date) AS week,
    COUNT(DISTINCT f.customer_key) AS purchase_frequency,
    COUNT(DISTINCT f.customer_key) - 
        COALESCE(LAG(COUNT(DISTINCT f.customer_key)) OVER (ORDER BY EXTRACT(YEAR FROM t.date), EXTRACT(WEEK FROM t.date)), 0) AS purchase_frequency_diff
FROM
    fact_table f
JOIN time_dim t ON f.time_key = t.time_key
WHERE
    t.date >= (SELECT MAX(t.date) FROM time_dim t) - INTERVAL '6 months'  
GROUP BY
    EXTRACT(YEAR FROM t.date), EXTRACT(WEEK FROM t.date)
ORDER BY
    year ASC, week ASC;


/* Are there time periods (e.g., hours of the day or days of the week) with unusually 
low or high sales? */
WITH time_analysis AS (
    SELECT
        time_key,
        date,
        TO_CHAR(date + hour * INTERVAL '1 hour', 'HH12 AM') AS hour_of_day,
        EXTRACT(DOW FROM date) AS day_of_week_num, 
        TO_CHAR(date, 'Day') AS day_of_week
    FROM
        time_dim)
SELECT
    t.day_of_week,
    t.hour_of_day,
    SUM(f.total_price) AS total_sales
FROM
    time_analysis t
JOIN
    fact_table f ON t.time_key = f.time_key
GROUP BY
    t.day_of_week,
    t.day_of_week_num, 
    t.hour_of_day
ORDER BY
    t.day_of_week_num, 
    TO_TIMESTAMP(t.hour_of_day, 'HH12 AM')::TIME; 
