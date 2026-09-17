-- Select database
USE music_streaming_app;

CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO products (id, name, price) VALUES
(1, 'Laptop', 55000),
(2, 'Mobile Phone', 25000),
(3, 'Headphones', 2500),
(4, 'Keyboard', 1500),
(5, 'Mouse', 800),
(6, 'Monitor', 12000),
(7, 'Tablet', 30000),
(8, 'Smart Watch', 5000),
(9, 'Speaker', 3500),
(10, 'Camera', 45000);

SELECT * FROM products;


-- TASK 1: Display all products sorted by price
-- Lowest price to highest price

SELECT *
FROM products
ORDER BY price ASC;


-- TASK 2: Display top 5 most expensive products
-- Highest price to lowest price

SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;


-- TASK 3: Display movies
-- Latest release year first
-- If same year, highest rating first

CREATE TABLE movies (
    id INT PRIMARY KEY,
    title VARCHAR(100),
    release_year INT,
    rating DECIMAL(3,1)
);

INSERT INTO movies (id, title, release_year, rating) VALUES
(1, '3 Idiots', 2009, 8.4),
(2, 'Dangal', 2016, 8.3),
(3, 'Jawan', 2023, 6.9),
(4, 'Pathaan', 2023, 5.8),
(5, '12th Fail', 2023, 8.8),
(6, 'Animal', 2023, 6.1),
(7, 'Drishyam 2', 2022, 8.2),
(8, 'KGF Chapter 2', 2022, 8.3);

SELECT *
FROM movies
ORDER BY release_year DESC,
         rating DESC;


-- TASK 4: Display first 10 restaurants
-- Sort alphabetically by restaurant name

SELECT *
FROM restaurants
ORDER BY name ASC
LIMIT 10;


-- TASK 5: Display top 3 trending songs
-- Highest play count first
-- If same play count, newest song first

CREATE TABLE songs (
    id INT PRIMARY KEY,
    song_name VARCHAR(100),
    artist VARCHAR(100),
    play_count INT,
    added_date DATE
);

INSERT INTO songs (id, song_name, artist, play_count, added_date) VALUES
(1, 'Excuses', 'AP Dhillon', 950000, '2026-01-10'),
(2, 'With You', 'AP Dhillon', 850000, '2026-02-15'),
(3, 'Heeriye', 'Jasleen Royal', 1200000, '2025-12-20'),
(4, 'Aaj Ki Raat', 'Madhubanti Bagchi', 1100000, '2026-03-05'),
(5, 'Tauba Tauba', 'Karan Aujla', 1500000, '2026-04-12'),
(6, 'Millionaire', 'Yo Yo Honey Singh', 1300000, '2026-05-18'),
(7, 'Softly', 'Karan Aujla', 900000, '2026-06-01');

SELECT *
FROM songs
ORDER BY play_count DESC,
         added_date DESC
LIMIT 3;