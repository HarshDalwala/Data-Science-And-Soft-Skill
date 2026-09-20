
USE food_delivery;
SHOW TABLES;

-- Q6: Find the top 5 restaurant categories
-- by total order count
-- Then retrieve full order details
-- for restaurants belonging to those categories.

WITH top_categories AS (

    -- Step 1: Count orders for each restaurant category
    SELECT
        r.category,
        COUNT(o.order_id) AS total_orders

    FROM restaurants AS r

    -- Connect restaurants with their orders
    LEFT JOIN orders AS o
        ON r.restaurant_id = o.restaurant_id

    -- Group orders by restaurant category
    GROUP BY r.category

    -- Highest order count first
    ORDER BY total_orders DESC

    -- Keep only top 5 categories
    LIMIT 5
)

-- Step 2: Get full order details
SELECT
    o.order_id,
    o.customer_id,
    o.restaurant_id,
    o.order_value,
    r.name AS restaurant_name,
    r.category,
    r.city

FROM orders AS o

-- Get restaurant information
JOIN restaurants AS r
    ON o.restaurant_id = r.restaurant_id

-- Keep only orders from the top 5 categories
WHERE r.category IN (
    SELECT category
    FROM top_categories
);