-- Select database
USE music_streaming_app;


-- Task 1: Create MusicPlaylist table
CREATE TABLE MusicPlaylist (
    id INT PRIMARY KEY,
    song_name VARCHAR(100),
    artist VARCHAR(100),
    genre VARCHAR(50),
    duration INT
);


-- Insert 5 songs
INSERT INTO MusicPlaylist (id, song_name, artist, genre, duration)
VALUES
(1, 'Excuses', 'AP Dhillon', 'Punjabi', 150),
(2, 'Brown Munde', 'AP Dhillon', 'Punjabi', 145),
(3, 'Heeriye', 'Jasleen Royal', 'Pop', 190),
(4, 'Tum Hi Ho', 'Arijit Singh', 'Bollywood', 262),
(5, 'Kesariya', 'Arijit Singh', 'Bollywood', 268);


-- Task 1: Display all columns
SELECT * FROM MusicPlaylist;


-- Task 2: Display song name and artist, first 3 records
SELECT song_name, artist
FROM MusicPlaylist
LIMIT 3;


-- Task 3: Create FoodOrders table
CREATE TABLE FoodOrders (
    id INT PRIMARY KEY,
    restaurant VARCHAR(100),
    food_item VARCHAR(100),
    order_date DATE
);


-- Insert sample orders
INSERT INTO FoodOrders (id, restaurant, food_item, order_date)
VALUES
(1, 'Dominos', 'Pizza', '2026-09-10'),
(2, 'Zomato Cafe', 'Burger', '2026-09-11'),
(3, 'Dominos', 'Garlic Bread', '2026-09-12'),
(4, 'La Pinoz', 'Pizza', '2026-09-13'),
(5, 'Zomato Cafe', 'Sandwich', '2026-09-14');


-- Task 3: Display unique restaurants
SELECT DISTINCT restaurant
FROM FoodOrders;


-- Task 4: Display columns using aliases
SELECT food_item AS Dish,
       order_date AS `Date Ordered`
FROM FoodOrders;


-- Task 5: DISTINCT with LIMIT
SELECT DISTINCT food_item, restaurant
FROM FoodOrders
LIMIT 2;