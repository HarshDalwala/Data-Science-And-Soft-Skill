-- SESSION 18: INTERVIEW QUESTIONS + FINAL REVISION

USE music_streaming_app;


-- TASK 1
-- Songs uploaded by each artist
-- Show artists with more than 3 songs

DROP TABLE IF EXISTS songs;

CREATE TABLE songs (
    song_id INT PRIMARY KEY,
    artist_name VARCHAR(100),
    title VARCHAR(150)
);

INSERT INTO songs
(song_id, artist_name, title)
VALUES
(1, 'AP Dhillon', 'Excuses'),
(2, 'AP Dhillon', 'With You'),
(3, 'AP Dhillon', 'Summer High'),
(4, 'AP Dhillon', 'Insane'),
(5, 'Karan Aujla', 'Tauba Tauba'),
(6, 'Karan Aujla', 'Softly'),
(7, 'Karan Aujla', 'Winning Speech'),
(8, 'Arijit Singh', 'Tum Hi Ho'),
(9, 'Arijit Singh', 'Channa Mereya'),
(10, 'Arijit Singh', 'Kesariya'),
(11, 'Arijit Singh', 'Agar Tum Saath Ho'),
(12, 'Arijit Singh', 'Ve Kamleya');

SELECT
    artist_name,
    COUNT(song_id) AS total_songs
FROM songs
GROUP BY artist_name
HAVING COUNT(song_id) > 3;


-- TASK 2
-- Username with total order amount

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2)
);

INSERT INTO users
(user_id, username)
VALUES
(101, 'Harsh'),
(102, 'Rahul'),
(103, 'Priya'),
(104, 'Amit');

INSERT INTO orders
(order_id, user_id, amount)
VALUES
(1, 101, 500.00),
(2, 101, 750.00),
(3, 102, 400.00),
(4, 102, 600.00),
(5, 103, 900.00),
(6, 104, 300.00),
(7, 104, 450.00);

SELECT
    u.username,
    SUM(o.amount) AS total_order_amount
FROM users u
JOIN orders o
    ON u.user_id = o.user_id
GROUP BY
    u.user_id,
    u.username;


-- TASK 3
-- Restaurants above average rating

DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    rating DECIMAL(2,1)
);

INSERT INTO restaurants
(id, name, rating)
VALUES
(1, 'Swagat Restaurant', 4.5),
(2, 'Pizza Palace', 4.2),
(3, 'Royal Chinese', 3.8),
(4, 'Spice Garden', 4.7),
(5, 'Dragon House', 4.0);

SELECT
    name,
    rating
FROM restaurants
WHERE rating > (
    SELECT AVG(rating)
    FROM restaurants
);


-- TASK 4
-- Transaction running total for each user

DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2),
    transaction_date DATE
);

INSERT INTO transactions
(id, user_id, amount, transaction_date)
VALUES
(1, 101, 500.00, '2026-09-01'),
(2, 101, 300.00, '2026-09-03'),
(3, 101, 700.00, '2026-09-05'),
(4, 102, 400.00, '2026-09-02'),
(5, 102, 600.00, '2026-09-04'),
(6, 103, 250.00, '2026-09-01'),
(7, 103, 450.00, '2026-09-06');

SELECT
    id,
    user_id,
    amount,
    transaction_date,
    SUM(amount) OVER (
        PARTITION BY user_id
        ORDER BY transaction_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM transactions
ORDER BY user_id, transaction_date;


-- TASK 5
-- Query optimization

-- Example table
DROP TABLE IF EXISTS FlipkartProducts;

CREATE TABLE FlipkartProducts (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    price DECIMAL(10,2)
);

-- Index on category and price
CREATE INDEX idx_category_price
ON FlipkartProducts(category, price);


-- Example optimized query
SELECT
    product_id,
    product_name,
    category,
    price
FROM FlipkartProducts
WHERE category = 'Electronics'
  AND price BETWEEN 1000 AND 50000;