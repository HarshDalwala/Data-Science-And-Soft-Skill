USE music_streaming_app;

-- TASK 1: Create Orders table

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    total_amount DECIMAL(10,2),
    order_date DATE
);

-- Insert 5 sample orders
-- One order has NULL total_amount

INSERT INTO Orders (order_id, user_name, total_amount, order_date) VALUES
(1, 'Harsh', 2500.00, '2026-09-01'),
(2, 'Rahul', 1800.00, '2026-09-02'),
(3, 'Harsh', 3200.00, '2026-09-03'),
(4, 'Priya', NULL,    '2026-09-04'),
(5, 'Rahul', 1500.00, '2026-09-05');

-- Check the table
SELECT * FROM Orders;


-- TASK 2: Count orders placed by each user

SELECT
    user_name,
    COUNT(order_id) AS order_count
FROM Orders
GROUP BY user_name;


-- TASK 3: Calculate average order amount
-- NULL values are automatically ignored by AVG()

SELECT
    AVG(total_amount) AS average_order_amount
FROM Orders;


-- TASK 4: Find highest and lowest order amount

SELECT
    MAX(total_amount) AS highest_order_amount,
    MIN(total_amount) AS lowest_order_amount
FROM Orders;


-- TASK 5: Calculate total sales
-- Only include orders where total_amount is NOT NULL

SELECT
    SUM(total_amount) AS total_sales
FROM Orders
WHERE total_amount IS NOT NULL;