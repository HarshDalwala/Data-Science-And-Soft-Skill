USE music_streaming_app;


-- TASK 1: CTE using WITH
-- Products with rating above 4.5

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    rating DECIMAL(3,1),
    price DECIMAL(10,2)
);

INSERT INTO Products
(id, product_name, rating, price)
VALUES
(1, 'iPhone 15', 4.7, 65000),
(2, 'Samsung Galaxy', 4.6, 55000),
(3, 'HP Laptop', 4.3, 60000),
(4, 'Sony Headphones', 4.8, 8000),
(5, 'Dell Laptop', 4.2, 58000),
(6, 'Apple Watch', 4.9, 35000);

-- CTE
WITH TopRatedProducts AS (
    SELECT *
    FROM Products
    WHERE rating > 4.5
)
SELECT *
FROM TopRatedProducts;


-- TASK 2: Subquery vs CTE
-- Restaurants in Ahmedabad
-- with delivery charges under 50

DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    delivery_charge DECIMAL(10,2)
);

INSERT INTO Restaurants
(id, name, city, delivery_charge)
VALUES
(1, 'Swagat Restaurant', 'Ahmedabad', 40),
(2, 'Spice Hub', 'Ahmedabad', 60),
(3, 'Food Junction', 'Surat', 30),
(4, 'Royal Dine', 'Ahmedabad', 45),
(5, 'Tasty Corner', 'Mumbai', 35);


-- Using SUBQUERY
SELECT *
FROM (
    SELECT *
    FROM Restaurants
    WHERE city = 'Ahmedabad'
) AS AhmedabadRestaurants
WHERE delivery_charge < 50;


-- Using CTE
WITH AhmedabadRestaurants AS (
    SELECT *
    FROM Restaurants
    WHERE city = 'Ahmedabad'
)
SELECT *
FROM AhmedabadRestaurants
WHERE delivery_charge < 50;


-- TASK 3: Two CTEs
-- Top 3 most-followed users
-- Top 3 most-liked posts

DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    id INT PRIMARY KEY,
    username VARCHAR(100),
    followers INT
);

CREATE TABLE Posts (
    id INT PRIMARY KEY,
    username VARCHAR(100),
    likes INT
);

INSERT INTO Users (id, username, followers) VALUES
(1, 'Harsh', 2500),
(2, 'Rahul', 5000),
(3, 'Priya', 7500),
(4, 'Amit', 3000),
(5, 'Neha', 9000);

INSERT INTO Posts (id, username, likes) VALUES
(1, 'Harsh', 1200),
(2, 'Rahul', 4500),
(3, 'Priya', 3000),
(4, 'Amit', 6000),
(5, 'Neha', 8000),
(6, 'Rahul', 5500);

-- Two CTEs
WITH TopUsers AS (
    SELECT
        username,
        followers
    FROM Users
    ORDER BY followers DESC
    LIMIT 3
),
TopPosts AS (
    SELECT
        username,
        likes
    FROM Posts
    ORDER BY likes DESC
    LIMIT 3
)

SELECT
    'Top Users' AS list_type,
    username,
    followers AS value
FROM TopUsers

UNION ALL

SELECT
    'Top Posts' AS list_type,
    username,
    likes AS value
FROM TopPosts;


-- TASK 4: Recursive CTE
-- Generate dates for next 7 days

WITH RECURSIVE DateList AS (

    -- Base case: today's date
    SELECT CURDATE() AS booking_date

    UNION ALL

    -- Recursive part: add one day
    SELECT DATE_ADD(booking_date, INTERVAL 1 DAY)
    FROM DateList
    WHERE booking_date < DATE_ADD(CURDATE(), INTERVAL 6 DAY)
)

SELECT booking_date
FROM DateList;


-- TASK 5: Refactor query using CTE
-- Users with more than 1000 followers

-- Messy / direct query
SELECT *
FROM Users
WHERE followers > 1000;


-- Refactored using CTE
WITH PopularUsers AS (
    SELECT
        id,
        username,
        followers
    FROM Users
)
SELECT *
FROM PopularUsers
WHERE followers > 1000;