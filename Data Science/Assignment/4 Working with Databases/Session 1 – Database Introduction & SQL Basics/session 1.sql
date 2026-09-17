
-- Task 1: Create the Database
CREATE DATABASE music_streaming_app;
USE music_streaming_app;
SHOW DATABASES;


-- Task 2: Create the playlists Table
CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(100),
    created_by VARCHAR(100)
);

SHOW TABLES;
DESC playlists;


-- Task 3: Insert Three Sample Rows
INSERT INTO playlists (playlist_id, name, created_by)
VALUES
(1, 'Bollywood Hits', 'Amit'),
(2, 'Chill Vibes', 'Rahul'),
(3, 'Workout Mix', 'Priya');

SELECT * FROM playlists;


-- Task 4: Display Playlists Created by Amit
SELECT *
FROM playlists
WHERE created_by = 'Amit';

-- Task 5: Table, Row and Column Explanation
/*
In SQL, a table is used to store data in an organized format. A table contains rows and columns.

For example, consider a food delivery application like Zomato. We can create a table called `orders` to store customer order information.

Table:
The `orders` table stores all the order information of customers. It can contain details such as order ID, customer name, restaurant name, food item, and price.

Column:
A column represents one type of information in a table. For example, `order_id`, `customer_name`, `restaurant_name`, `food_item`, and `price` are columns of the `orders` table. Each column stores a specific type of data.

Row:
A row represents one complete record in a table. For example, one row can contain information about one customer's order, such as Order ID 101, customer name Amit, restaurant ABC Restaurant, food item Pizza, and price 250.

Example:

| order_id | customer_name | restaurant_name | food_item | price |
| -------- | ------------- | --------------- | --------- | ----: |
| 101      | Amit          | ABC Restaurant  | Pizza     |   250 |
| 102      | Rahul         | XYZ Restaurant  | Burger    |   180 |
| 103      | Priya         | Food Corner     | Biryani   |   220 |

Here, `orders` is the table. `order_id`, `customer_name`, `restaurant_name`, `food_item`, and `price` are columns. Each horizontal record, such as the record for Amit, is a row.

In simple words, a table is like a complete Excel sheet, a column represents a particular type of information, and a row represents one complete record.
 
*/
