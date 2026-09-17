USE music_streaming_app;


-- TASK 1: Create Playlists table

DROP TABLE IF EXISTS Playlists;

CREATE TABLE Playlists (
    id INT PRIMARY KEY,
    user_id INT,
    playlist_name VARCHAR(100),
    total_likes INT
);

-- Insert 8 sample playlists
-- Some users have multiple playlists

INSERT INTO Playlists
(id, user_id, playlist_name, total_likes)
VALUES
(1, 101, 'Bollywood Hits', 950),
(2, 101, 'Chill Vibes', 700),
(3, 101, 'Workout Mix', 500),
(4, 102, 'Party Songs', 1200),
(5, 102, 'Romantic Songs', 800),
(6, 103, 'Travel Music', 650),
(7, 103, 'Morning Vibes', 650),
(8, 104, 'Trending Hits', 1500);

-- Check the data
SELECT * FROM Playlists;


-- TASK 2: ROW_NUMBER()
-- Unique row number for every playlist
-- Ordered by total_likes DESC

SELECT
    playlist_name,
    user_id,
    total_likes,
    ROW_NUMBER() OVER (
        ORDER BY total_likes DESC
    ) AS row_num
FROM Playlists;


-- TASK 3: RANK()
-- Rank all playlists by total_likes

SELECT
    playlist_name,
    user_id,
    total_likes,
    RANK() OVER (
        ORDER BY total_likes DESC
    ) AS playlist_rank
FROM Playlists;


-- TASK 4: DENSE_RANK()
-- Rank playlists within each user's account

SELECT
    playlist_name,
    user_id,
    total_likes,
    DENSE_RANK() OVER (
        PARTITION BY user_id
        ORDER BY total_likes DESC
    ) AS dense_rank_no
FROM Playlists;


-- TASK 5: TOP 2 PLAYLISTS PER USER

WITH RankedPlaylists AS (
    SELECT
        playlist_name,
        user_id,
        total_likes,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY total_likes DESC
        ) AS row_num
    FROM Playlists
)

SELECT
    playlist_name,
    user_id,
    total_likes
FROM RankedPlaylists
WHERE row_num <= 2
ORDER BY user_id, total_likes DESC;