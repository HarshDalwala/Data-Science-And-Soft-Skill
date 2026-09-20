
-- Create a database for Section A SQL questions
CREATE DATABASE food_delivery;

-- Select the database
USE food_delivery;

-- Create restaurants table

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    category VARCHAR(50)
);

-- Create orders table

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_value DECIMAL(10,2),

    -- Connect orders with restaurants
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurants(restaurant_id)
);

-- Insert restaurants
-- Restaurant 4 has no orders
-- Restaurant 5 has no orders
-- This helps us demonstrate LEFT JOIN

INSERT INTO restaurants
(restaurant_id, name, city, category)
VALUES
(1, 'Spice Hub', 'Surat', 'Indian'),
(2, 'Pizza House', 'Surat', 'Italian'),
(3, 'China Bowl', 'Surat', 'Chinese'),
(4, 'Royal Dine', 'Surat', 'Indian'),
(5, 'Food Corner', 'Surat', 'Fast Food');


-- Insert orders

INSERT INTO orders
(order_id, customer_id, restaurant_id, order_value)
VALUES
(101, 1, 1, 450.00),
(102, 2, 1, 600.00),
(103, 3, 2, 800.00),
(104, 4, 2, 500.00),
(105, 5, 3, 350.00),
(106, 6, 1, 700.00),
(107, 7, 3, 400.00);

-- Check restaurants
SELECT * FROM restaurants;

-- Check orders
SELECT * FROM orders;


-- Q4:
-- Show every restaurant and its total revenue,
-- including restaurants that have no orders.

SELECT
    r.name AS restaurant_name,

    -- Convert NULL revenue into 0
    COALESCE(SUM(o.order_value), 0) AS total_revenue

FROM restaurants AS r

-- LEFT JOIN keeps ALL restaurants
LEFT JOIN orders AS o
    ON r.restaurant_id = o.restaurant_id

GROUP BY
    r.restaurant_id,
    r.name;