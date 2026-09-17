USE music_streaming_app;


-- TASK 1: Subquery in WHERE clause
-- Find restaurants whose rating is higher
-- than the average rating of all restaurants

DROP TABLE IF EXISTS Restaurants;

CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    rating DECIMAL(3,1)
);

INSERT INTO Restaurants (id, name, city, rating) VALUES
(1, 'Swagat Restaurant', 'Surat', 4.5),
(2, 'Spice Hub', 'Ahmedabad', 4.2),
(3, 'Food Junction', 'Mumbai', 3.8),
(4, 'Royal Dine', 'Surat', 4.7),
(5, 'Tasty Corner', 'Ahmedabad', 3.5);

-- Subquery calculates the average rating
-- Main query finds restaurants above that average

SELECT
    name,
    city,
    rating
FROM Restaurants
WHERE rating > (
    SELECT AVG(rating)
    FROM Restaurants
);


-- TASK 2: Subquery in SELECT statement
-- Display each user's name and their
-- total number of orders

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    id INT PRIMARY KEY,
    username VARCHAR(100)
);

CREATE TABLE Orders (
    id INT PRIMARY KEY,
    user_id INT,
    order_date DATE
);

INSERT INTO Users (id, username) VALUES
(1, 'Harsh'),
(2, 'Rahul'),
(3, 'Priya'),
(4, 'Amit');

INSERT INTO Orders (id, user_id, order_date) VALUES
(101, 1, '2026-09-01'),
(102, 1, '2026-09-03'),
(103, 2, '2026-09-05'),
(104, 2, '2026-09-07'),
(105, 2, '2026-09-08'),
(106, 3, '2026-09-10');

-- Subquery counts orders for each user

SELECT
    u.username,
    (
        SELECT COUNT(*)
        FROM Orders o
        WHERE o.user_id = u.id
    ) AS order_count
FROM Users u;


-- TASK 3: IN with subquery
-- Find movies having at least one 5-star review

DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Movies;

CREATE TABLE Movies (
    id INT PRIMARY KEY,
    movie_name VARCHAR(100),
    release_year INT
);

CREATE TABLE Reviews (
    id INT PRIMARY KEY,
    movie_id INT,
    rating INT
);

INSERT INTO Movies (id, movie_name, release_year) VALUES
(1, '3 Idiots', 2009),
(2, 'Dangal', 2016),
(3, 'Jawan', 2023),
(4, '12th Fail', 2023),
(5, 'Pathaan', 2023);

INSERT INTO Reviews (id, movie_id, rating) VALUES
(1, 1, 5),
(2, 1, 4),
(3, 2, 5),
(4, 3, 3),
(5, 4, 5),
(6, 5, 4);

-- Subquery finds movie IDs having 5-star reviews
-- IN matches those IDs with Movies

SELECT
    movie_name,
    release_year
FROM Movies
WHERE id IN (
    SELECT movie_id
    FROM Reviews
    WHERE rating = 5
);


-- TASK 4: Nested subquery
-- Find sellers who have sold products in
-- EVERY category

DROP TABLE IF EXISTS SellerProducts;
DROP TABLE IF EXISTS Sellers;
DROP TABLE IF EXISTS Categories;

CREATE TABLE Sellers (
    id INT PRIMARY KEY,
    seller_name VARCHAR(100)
);

CREATE TABLE Categories (
    id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE SellerProducts (
    id INT PRIMARY KEY,
    seller_id INT,
    category_id INT
);

-- Sellers
INSERT INTO Sellers (id, seller_name) VALUES
(1, 'ABC Electronics'),
(2, 'XYZ Store'),
(3, 'Super Mart');

-- Categories
INSERT INTO Categories (id, category_name) VALUES
(1, 'Mobiles'),
(2, 'Laptops'),
(3, 'Headphones');

-- Seller products/categories
INSERT INTO SellerProducts
(id, seller_id, category_id)
VALUES
-- ABC Electronics sold in all 3 categories
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),

-- XYZ Store sold only in 2 categories
(4, 2, 1),
(5, 2, 2),

-- Super Mart sold in all 3 categories
(6, 3, 1),
(7, 3, 2),
(8, 3, 3);

-- Nested subquery:
-- Find sellers whose number of DISTINCT categories
-- equals the total number of categories

SELECT
    seller_name
FROM Sellers
WHERE id IN (
    SELECT seller_id
    FROM SellerProducts
    GROUP BY seller_id
    HAVING COUNT(DISTINCT category_id) = (
        SELECT COUNT(*)
        FROM Categories
    )
);