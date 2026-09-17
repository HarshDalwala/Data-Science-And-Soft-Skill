-- SESSION 17: SQL PROJECT - HR ANALYSIS

USE music_streaming_app;


-- TASK 1
-- Create Restaurant table

DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Restaurant;

CREATE TABLE Restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    location VARCHAR(100),
    average_rating DECIMAL(2,1)
);


-- Insert 5 sample restaurants
INSERT INTO Restaurant
(id, name, cuisine, location, average_rating)
VALUES
(1, 'Swagat Restaurant', 'South Indian', 'Surat', 4.5),
(2, 'Pizza Palace', 'Italian', 'Surat', 4.2),
(3, 'Royal Chinese', 'Chinese', 'Ahmedabad', 4.0),
(4, 'Spice Garden', 'North Indian', 'Surat', 4.6),
(5, 'Dragon House', 'Chinese', 'Ahmedabad', 4.3);


-- Check Restaurant table
SELECT * FROM Restaurant;


-- TASK 2
-- Number of restaurants for each cuisine

SELECT
    cuisine,
    COUNT(*) AS restaurant_count
FROM Restaurant
GROUP BY cuisine
ORDER BY restaurant_count DESC;


-- TASK 3
-- Create Review table

CREATE TABLE Review (
    id INT PRIMARY KEY,
    restaurant_id INT,
    user_name VARCHAR(100),
    rating DECIMAL(2,1),
    review_date DATE,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(id)
);


-- Insert 10 sample reviews
INSERT INTO Review
(id, restaurant_id, user_name, rating, review_date)
VALUES
(1, 1, 'Harsh', 5.0, '2026-09-01'),
(2, 1, 'Rahul', 4.5, '2026-09-02'),
(3, 2, 'Priya', 4.0, '2026-09-03'),
(4, 2, 'Amit', 4.5, '2026-09-04'),
(5, 3, 'Neha', 3.5, '2026-09-05'),
(6, 3, 'Karan', 4.0, '2026-09-06'),
(7, 4, 'Harsh', 5.0, '2026-09-07'),
(8, 4, 'Priya', 4.5, '2026-09-08'),
(9, 5, 'Rahul', 4.0, '2026-09-09'),
(10, 5, 'Amit', 4.5, '2026-09-10');


-- Check Review table
SELECT * FROM Review;


-- TASK 4
-- Average review rating for each restaurant

SELECT
    r.name,
    r.cuisine,
    ROUND(AVG(rv.rating), 2) AS average_review_rating
FROM Restaurant r
JOIN Review rv
    ON r.id = rv.restaurant_id
GROUP BY
    r.id,
    r.name,
    r.cuisine
ORDER BY average_review_rating DESC;


-- TASK 5
-- Rank restaurants by average review rating
-- within each cuisine

WITH RestaurantRatings AS (
    SELECT
        r.id,
        r.name,
        r.cuisine,
        ROUND(AVG(rv.rating), 2) AS average_rating
    FROM Restaurant r
    JOIN Review rv
        ON r.id = rv.restaurant_id
    GROUP BY
        r.id,
        r.name,
        r.cuisine
)

SELECT
    name AS restaurant_name,
    cuisine,
    average_rating,
    RANK() OVER (
        PARTITION BY cuisine
        ORDER BY average_rating DESC
    ) AS cuisine_rank
FROM RestaurantRatings
ORDER BY cuisine, cuisine_rank;