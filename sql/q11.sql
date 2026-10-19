-- Use INNER JOIN because only completed orders with matching customers are needed.
-- COUNT(DISTINCT customer_id) is necessary because a customer may place multiple orders in the same region and month.
-- q11.sql

SELECT
    c.region,
    o.order_month,
    COUNT(o.order_id) AS number_of_orders,
    COUNT(DISTINCT c.customer_id) AS number_of_customers,
    SUM(o.amount) AS total_revenue,
    AVG(o.amount) AS average_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.status = 'completed'
GROUP BY c.region, o.order_month
ORDER BY c.region, o.order_month;