USE music_streaming_app;


-- TASK 1: FULL JOIN
-- Influencers + Collaborations

DROP TABLE IF EXISTS Collaborations;
DROP TABLE IF EXISTS Influencers;

CREATE TABLE Influencers (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Collaborations (
    id INT PRIMARY KEY,
    influencer1_id INT,
    influencer2_id INT,
    collab_date DATE
);

-- Insert influencers
INSERT INTO Influencers (id, name) VALUES
(1, 'Rahul'),
(2, 'Priya'),
(3, 'Amit'),
(4, 'Neha'),
(5, 'Karan');

-- Insert collaborations
INSERT INTO Collaborations
(id, influencer1_id, influencer2_id, collab_date)
VALUES
(1, 1, 2, '2026-01-10'),
(2, 2, 3, '2026-02-15'),
(3, 1, 4, '2026-03-20');

-- MySQL does not support FULL OUTER JOIN directly.
-- LEFT JOIN + RIGHT JOIN + UNION simulates FULL JOIN.

SELECT
    i1.name AS influencer,
    i2.name AS collaboration_partner,
    c.collab_date
FROM Influencers i1
LEFT JOIN Collaborations c
    ON i1.id = c.influencer1_id
LEFT JOIN Influencers i2
    ON c.influencer2_id = i2.id

UNION

SELECT
    i1.name AS influencer,
    i2.name AS collaboration_partner,
    c.collab_date
FROM Influencers i1
RIGHT JOIN Collaborations c
    ON i1.id = c.influencer1_id
LEFT JOIN Influencers i2
    ON c.influencer2_id = i2.id;


-- TASK 2: SELF JOIN
-- Playlist with parent playlist name

DROP TABLE IF EXISTS Playlists;

CREATE TABLE Playlists (
    id INT PRIMARY KEY,
    user_id INT,
    playlist_name VARCHAR(100),
    parent_playlist_id INT
);

INSERT INTO Playlists
(id, user_id, playlist_name, parent_playlist_id)
VALUES
(1, 101, 'My Music', NULL),
(2, 101, 'Bollywood Hits', 1),
(3, 101, 'Party Songs', 1),
(4, 102, 'Workout Music', NULL),
(5, 102, 'Gym Motivation', 4);

-- SELF JOIN
SELECT
    child.playlist_name AS playlist_name,
    parent.playlist_name AS parent_playlist_name
FROM Playlists child
LEFT JOIN Playlists parent
    ON child.parent_playlist_id = parent.id;


-- TASK 3: Multiple JOINs
-- Users + Orders + Payments

DROP TABLE IF EXISTS Payments;
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

CREATE TABLE Payments (
    id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2)
);

-- Users
INSERT INTO Users (id, username) VALUES
(1, 'Harsh'),
(2, 'Rahul'),
(3, 'Priya'),
(4, 'Amit');

-- Orders
INSERT INTO Orders (id, user_id, order_date) VALUES
(101, 1, '2026-09-01'),
(102, 1, '2026-09-03'),
(103, 2, '2026-09-05');

-- Payments
INSERT INTO Payments (id, order_id, amount) VALUES
(1, 101, 2500.00),
(2, 102, 1800.00),
(3, 103, 3200.00);

-- Multiple JOINs
-- LEFT JOIN keeps users even if they have no orders/payments.

SELECT
    u.username,
    o.order_date,
    p.amount AS payment_amount
FROM Users u
LEFT JOIN Orders o
    ON u.id = o.user_id
LEFT JOIN Payments p
    ON o.id = p.order_id;


-- TASK 4: Remove duplicate restaurant rows
-- ============================================

-- Example tables

DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Zomato_Restaurants;

CREATE TABLE Zomato_Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Reviews (
    id INT PRIMARY KEY,
    restaurant_id INT,
    review_text VARCHAR(200)
);

INSERT INTO Zomato_Restaurants (id, name) VALUES
(1, 'Swagat Restaurant'),
(2, 'Spice Hub'),
(3, 'Food Junction');

INSERT INTO Reviews
(id, restaurant_id, review_text)
VALUES
(1, 1, 'Good food'),
(2, 1, 'Excellent service'),
(3, 2, 'Nice restaurant');

-- DISTINCT removes duplicate restaurant names

SELECT DISTINCT
    r.id,
    r.name
FROM Zomato_Restaurants r
INNER JOIN Reviews v
    ON r.id = v.restaurant_id;


-- ============================================
-- TASK 5: Products + Categories
-- Different JOIN conditions
-- ============================================

DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;

CREATE TABLE Categories (
    id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE Products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT
);

INSERT INTO Categories (id, category_name) VALUES
(1, 'Mobiles'),
(2, 'Laptops'),
(3, 'Headphones');

INSERT INTO Products
(id, product_name, category_id)
VALUES
(101, 'iPhone', 1),
(102, 'Samsung Galaxy', 1),
(103, 'HP Laptop', 2),
(104, 'Sony Headphones', 3);


-- JOIN QUERY 1:
-- Normal equality JOIN using primary key and foreign key

SELECT
    p.product_name,
    c.category_name
FROM Products p
INNER JOIN Categories c
    ON p.category_id = c.id;


-- JOIN QUERY 2:
-- Same relationship written using WHERE

SELECT
    p.product_name,
    c.category_name
FROM Products p
CROSS JOIN Categories c
WHERE p.category_id = c.id;