/* What are the sales, quantity, and average unit price for the 12 least-performing items? */
SELECT
    i.item_name,
    SUM(total_price) AS sales,
    SUM(quantity) AS quantity,
    CAST(AVG(f.unit_price) AS INT) AS unit_price
FROM
    fact_table f
JOIN item_dim i ON f.item_key = i.item_key
GROUP BY
    i.item_name
ORDER BY
    sales ASC
LIMIT 12;

/* What is the average transaction amount for each payment method? */
SELECT
    t.trans_type,
    CAST(AVG(f.total_price) AS INT) AS avg_amount
FROM
    fact_table f
JOIN trans_dim t ON f.payment_key = t.payment_key
GROUP BY
    t.trans_type
ORDER BY
    avg_amount DESC;

/* What is the transaction frequency for each payment method by state? */
SELECT
    s.state,
    t.trans_type,
    COUNT(f.payment_key) AS transaction_freq
FROM
    fact_table f
JOIN store_dim s ON f.store_key = s.store_key
JOIN trans_dim t ON f.payment_key = t.payment_key
GROUP BY
    s.state, t.trans_type
ORDER BY
    transaction_freq DESC;

