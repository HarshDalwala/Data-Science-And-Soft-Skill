-- Select database
USE music_streaming_app;


-- Task 1: Create Restaurants table
CREATE TABLE Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    rating DECIMAL(2,1),
    city VARCHAR(50)
);


-- Insert 5 sample restaurants
INSERT INTO Restaurants (id, name, cuisine, rating, city)
VALUES
(1, 'Swagat Restaurant', 'South Indian', 4.5, 'Surat'),
(2, 'Swadisht Kitchen', 'Chinese', 4.2, 'Ahmedabad'),
(3, 'Pizza Palace', 'Italian', 4.6, 'Surat'),
(4, 'Royal Chinese', 'Chinese', 3.8, 'Mumbai'),
(5, 'South Spice', 'South Indian', 3.5, 'Ahmedabad');


-- Task 1: Display all restaurants
SELECT * FROM Restaurants;


-- Task 2: Rating greater than 4.0
-- and city is Ahmedabad or Surat
SELECT *
FROM Restaurants
WHERE rating > 4.0
AND city IN ('Ahmedabad', 'Surat');


-- Task 3: Restaurant names starting with Swa
SELECT *
FROM Restaurants
WHERE name LIKE 'Swa%';


-- Task 4: Rating between 3.5 and 4.5
SELECT *
FROM Restaurants
WHERE rating BETWEEN 3.5 AND 4.5;


-- Task 5: Cuisine is Chinese, Italian or South Indian
SELECT *
FROM Restaurants
WHERE cuisine IN ('Chinese', 'Italian', 'South Indian');