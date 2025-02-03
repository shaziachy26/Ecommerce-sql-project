/* What are the total sales for each store and state? */
SELECT
    s.store_key,
    s.state,
    SUM(total_price) AS sales
FROM
    fact_table f
JOIN store_dim s ON f.store_key = s.store_key
GROUP BY
    s.store_key, s.state;

/* What is the purchase frequency and total sales for each state? */
SELECT
    s.state,
    COUNT(DISTINCT f.customer_key) AS purchase_frequency,
    SUM(total_price) AS sales
FROM
    fact_table f
JOIN store_dim s ON f.store_key = s.store_key
GROUP BY
    s.state
ORDER BY
    purchase_frequency DESC;

/* What is the frequency of each payment type by store and state? */
SELECT
    s.store_key,
    s.state,
    t.trans_type,
    COUNT(t.trans_type) AS method_count
FROM
    fact_table f
JOIN store_dim s ON f.store_key = s.store_key
JOIN trans_dim t ON f.payment_key = t.payment_key
GROUP BY
    s.store_key, s.state, t.trans_type;

/* Which store has the highest sales, and what are its best-selling items(top 3 items)? */
WITH ranked_price AS ( Select
	s.store_key, 
	i.item_name,
	ROW_NUMBER() OVER(Partition by s.store_key Order BY Sum(total_price) DESC) as ranking,
	CAST(SUM(total_price) as int) as sales,
	CAST(avg(i.unit_price) as int) as unit_price
FROM 
	fact_table f
JOIN store_dim s ON f.store_key = s.store_key
JOIN item_dim i ON f.item_key = i.item_key
GROUP BY
	s.store_key, i.item_name
ORDER BY
	s.store_key )
SELECT
	store_key, item_name, sales, unit_price
FROM
	ranked_price
WHERE
	ranking < 4;





















