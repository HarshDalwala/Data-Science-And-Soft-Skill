-- SESSION 14: WINDOW FUNCTIONS - PART 2

USE music_streaming_app;


-- TASK 1: CREATE ORDERS TABLE

DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);


-- Insert sample food orders
INSERT INTO Orders
(order_id, user_id, order_date, total_amount)
VALUES
(1, 101, '2026-09-01', 450.00),
(2, 101, '2026-09-03', 650.00),
(3, 101, '2026-09-05', 300.00),
(4, 102, '2026-09-02', 800.00),
(5, 102, '2026-09-04', 500.00),
(6, 103, '2026-09-01', 250.00),
(7, 103, '2026-09-06', 700.00),
(8, 103, '2026-09-08', 400.00);


-- Check the table
SELECT * FROM Orders;


-- TASK 2: LAG()
-- Show previous order amount for each user

SELECT
    order_id,
    user_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
    ) AS previous_order_amount
FROM Orders
ORDER BY user_id, order_date;


-- TASK 3: LEAD()
-- Show next order amount for each user

SELECT
    order_id,
    user_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
    ) AS next_order_amount
FROM Orders
ORDER BY user_id, order_date;


-- TASK 4: RUNNING TOTAL
-- Calculate cumulative order amount for each user

SELECT
    order_id,
    user_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM Orders
ORDER BY user_id, order_date;


-- TASK 5: 3-ORDER MOVING AVERAGE

SELECT
    order_id,
    user_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    )
    /
    COUNT(total_amount) OVER (
        PARTITION BY user_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM Orders
ORDER BY user_id, order_date;