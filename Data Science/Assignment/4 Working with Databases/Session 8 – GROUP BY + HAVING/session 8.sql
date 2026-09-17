USE music_streaming_app;

-- TASK 1: Create Orders table

-- Remove old Orders table from Session 7
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    payment_method VARCHAR(50),
    amount DECIMAL(10,2)
);

-- Insert 8 sample records
INSERT INTO Orders (order_id, user_id, payment_method, amount) VALUES
(1, 101, 'UPI', 500.00),
(2, 102, 'Card', 750.00),
(3, 101, 'Wallet', 250.00),
(4, 103, 'COD', 400.00),
(5, 102, 'UPI', 600.00),
(6, 104, 'Card', 200.00),
(7, 103, 'UPI', 350.00),
(8, 104, 'Wallet', 450.00);

-- Check the data
SELECT * FROM Orders;


-- TASK 2: Count orders by payment method

SELECT
    payment_method,
    COUNT(order_id) AS order_count
FROM Orders
GROUP BY payment_method;


-- TASK 3: Total amount spent by each user

SELECT
    user_id,
    SUM(amount) AS total_spend
FROM Orders
GROUP BY user_id;


-- TASK 4: Payment methods where
-- average order amount is greater than 300

SELECT
    payment_method,
    AVG(amount) AS average_order_amount
FROM Orders
GROUP BY payment_method
HAVING AVG(amount) > 300;


-- TASK 5: Difference between WHERE and HAVING

-- WHERE:
-- Filters individual rows BEFORE GROUP BY

-- Example: Show orders where amount is greater than 300
SELECT *
FROM Orders
WHERE amount > 300;


-- HAVING:
-- Filters groups AFTER GROUP BY

-- Example: Show users whose total spending is greater than 500
SELECT
    user_id,
    SUM(amount) AS total_spend
FROM Orders
GROUP BY user_id
HAVING SUM(amount) > 500;