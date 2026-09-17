-- Select database
USE music_streaming_app;


-- Task 1: Create Playlist table
CREATE TABLE Playlist (
    id INT PRIMARY KEY,
    song_name VARCHAR(100),
    artist VARCHAR(100),
    duration INT
);


-- Insert favorite song
INSERT INTO Playlist (id, song_name, artist, duration)
VALUES (1, 'Excuses', 'AP Dhillon', 150);


-- Task 2: Insert 3 songs
INSERT INTO Playlist (id, song_name, artist, duration)
VALUES
(2, 'Brown Munde', 'AP Dhillon', 145),
(3, 'Heeriye', 'Jasleen Royal', 190),
(4, 'Tum Hi Ho', 'Arijit Singh', 262);


-- Display all songs
SELECT * FROM Playlist;


-- Task 3: Fix artist name
UPDATE Playlist
SET artist = 'Arijit Singh'
WHERE id = 4;


-- Check updated data
SELECT * FROM Playlist;


-- Task 4: Add a short song for DELETE demonstration
INSERT INTO Playlist (id, song_name, artist, duration)
VALUES (5, 'Short Song', 'Test Artist', 100);


-- Delete specific song less than 120 seconds
DELETE FROM Playlist
WHERE id = 5 AND duration < 120;


-- Task 5: Add AP Dhillon song longer than 180 seconds
INSERT INTO Playlist (id, song_name, artist, duration)
VALUES (6, 'Summer High', 'AP Dhillon', 210);


-- Add (Remix) to AP Dhillon songs longer than 180 seconds
UPDATE Playlist
SET song_name = CONCAT(song_name, ' (Remix)')
WHERE artist = 'AP Dhillon'
AND duration > 180;

SELECT * FROM Playlist
WHERE id = 6;

-- Final result
SELECT * FROM Playlist;
