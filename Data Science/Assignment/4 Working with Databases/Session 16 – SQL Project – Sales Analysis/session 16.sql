-- SESSION 16: SQL PROJECT - SALES ANALYSIS

USE music_streaming_app;


-- TASK 1
-- Create FoodOrders table

DROP TABLE IF EXISTS FoodOrders;

CREATE TABLE FoodOrders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    customer_name VARCHAR(100),
    order_amount DECIMAL(10,2),
    order_date DATE
);


-- Sample food delivery orders
INSERT INTO FoodOrders
(order_id, restaurant_name, customer_name, order_amount, order_date)
VALUES
(1, 'Dominos', 'Harsh', 650.00, '2026-09-01'),
(2, 'Swiggy Restaurant', 'Rahul', 450.00, '2026-09-01'),
(3, 'Pizza Hut', 'Priya', 800.00, '2026-09-02'),
(4, 'Dominos', 'Harsh', 550.00, '2026-09-03'),
(5, 'Burger King', 'Amit', 350.00, '2026-09-03'),
(6, 'Pizza Hut', 'Rahul', 700.00, '2026-09-04'),
(7, 'Dominos', 'Priya', 900.00, '2026-09-05'),
(8, 'Burger King', 'Harsh', 400.00, '2026-09-06'),
(9, 'Pizza Hut', 'Amit', 600.00, '2026-09-07'),
(10, 'Dominos', 'Rahul', 750.00, '2026-09-08');


-- Check FoodOrders
SELECT * FROM FoodOrders;


-- TASK 2
-- Create TopSongs table

DROP TABLE IF EXISTS TopSongs;

CREATE TABLE TopSongs (
    song_id INT PRIMARY KEY,
    song_title VARCHAR(150),
    artist VARCHAR(100),
    streams BIGINT,
    release_date DATE
);


-- Insert 5 popular tracks
INSERT INTO TopSongs
(song_id, song_title, artist, streams, release_date)
VALUES
(1, 'Blinding Lights', 'The Weeknd', 4000000000, '2019-11-29'),
(2, 'Shape of You', 'Ed Sheeran', 3800000000, '2017-01-06'),
(3, 'One Dance', 'Drake', 3200000000, '2016-04-05'),
(4, 'Starboy', 'The Weeknd', 3000000000, '2016-09-22'),
(5, 'As It Was', 'Harry Styles', 2800000000, '2022-03-31');


-- Check TopSongs
SELECT * FROM TopSongs;


-- TASK 3
-- TOP 3 CUSTOMERS BY TOTAL SPENDING

SELECT
    customer_name,
    SUM(order_amount) AS total_spent
FROM FoodOrders
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 3;


-- TASK 4
-- RESTAURANT PERFORMANCE REPORT

SELECT
    restaurant_name,
    COUNT(order_id) AS number_of_orders,
    SUM(order_amount) AS total_order_amount
FROM FoodOrders
GROUP BY restaurant_name
ORDER BY total_order_amount DESC;


-- TASK 5
-- KPI DASHBOARD
-- Average Order Amount
-- Unique Customers

SELECT
    'Average Order Amount' AS kpi_name,
    ROUND(AVG(order_amount), 2) AS kpi_value
FROM FoodOrders

UNION ALL

SELECT
    'Total Unique Customers' AS kpi_name,
    COUNT(DISTINCT customer_name) AS kpi_value
FROM FoodOrders;