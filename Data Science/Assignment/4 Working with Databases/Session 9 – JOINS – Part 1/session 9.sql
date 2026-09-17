USE music_streaming_app;

-- TASK 1: Create restaurants table

DROP TABLE IF EXISTS dishes;
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100)
);

-- Create dishes table
CREATE TABLE dishes (
    id INT PRIMARY KEY,
    restaurant_id INT,
    dish_name VARCHAR(100),
    price DECIMAL(10,2)
);

-- Insert restaurants
INSERT INTO restaurants (id, name, city) VALUES
(1, 'Swagat Restaurant', 'Surat'),
(2, 'Spice Hub', 'Ahmedabad'),
(3, 'Food Junction', 'Mumbai'),
(4, 'Royal Dine', 'Vadodara');

-- Insert dishes
INSERT INTO dishes (id, restaurant_id, dish_name, price) VALUES
(1, 1, 'Masala Dosa', 150.00),
(2, 1, 'Paneer Dosa', 180.00),
(3, 2, 'Manchurian', 220.00),
(4, 2, 'Fried Rice', 200.00),
(5, 3, 'Pizza', 300.00),
(6, 3, 'Burger', 180.00);

-- Check both tables
SELECT * FROM restaurants;
SELECT * FROM dishes;


-- TASK 2: INNER JOIN
-- Display each dish with restaurant name and city

SELECT
    dishes.dish_name,
    dishes.price,
    restaurants.name AS restaurant_name,
    restaurants.city
FROM dishes
INNER JOIN restaurants
    ON dishes.restaurant_id = restaurants.id;


-- TASK 3: LEFT JOIN
-- Show ALL restaurants, even if they have no dishes

SELECT
    restaurants.name AS restaurant_name,
    restaurants.city,
    dishes.dish_name,
    dishes.price
FROM restaurants
LEFT JOIN dishes
    ON restaurants.id = dishes.restaurant_id;


-- TASK 4: RIGHT JOIN
-- Show ALL dishes, including an unlinked dish

-- First simulate a data error
INSERT INTO dishes (id, restaurant_id, dish_name, price)
VALUES (7, 99, 'Special Thali', 250.00);

-- RIGHT JOIN
SELECT
    dishes.dish_name,
    dishes.price,
    dishes.restaurant_id,
    restaurants.name AS restaurant_name
FROM restaurants
RIGHT JOIN dishes
    ON restaurants.id = dishes.restaurant_id;


-- TASK 5: Playlists and Songs
-- Show ALL playlists, even empty playlists

-- Create playlists table
DROP TABLE IF EXISTS playlist_songs;
DROP TABLE IF EXISTS playlists;

CREATE TABLE playlists (
    id INT PRIMARY KEY,
    playlist_name VARCHAR(100)
);

CREATE TABLE playlist_songs (
    id INT PRIMARY KEY,
    playlist_id INT,
    song_name VARCHAR(100)
);

-- Insert playlists
INSERT INTO playlists (id, playlist_name) VALUES
(1, 'Bollywood Hits'),
(2, 'Chill Vibes'),
(3, 'Workout Mix');

-- Insert songs
INSERT INTO playlist_songs (id, playlist_id, song_name) VALUES
(1, 1, 'Kesariya'),
(2, 1, 'Tum Hi Ho'),
(3, 3, 'Believer');

-- LEFT JOIN to show ALL playlists
SELECT
    playlists.playlist_name,
    playlist_songs.song_name
FROM playlists
LEFT JOIN playlist_songs
    ON playlists.id = playlist_songs.playlist_id;