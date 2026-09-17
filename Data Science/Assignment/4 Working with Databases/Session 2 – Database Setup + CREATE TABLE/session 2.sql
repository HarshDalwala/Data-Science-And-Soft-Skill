-- Task 1: Verify MySQL
SELECT VERSION();


-- Task 2: Create database
CREATE DATABASE foodie_app;

USE foodie_app;


-- Task 3: Create restaurants table
CREATE TABLE restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    rating DECIMAL(2,1),
    location VARCHAR(100)
);

-- Check restaurants table
SHOW TABLES;

DESC restaurants;


-- Task 4: Create users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100),
    email VARCHAR(150) UNIQUE,
    phone_number VARCHAR(15),
    created_at DATETIME
);


-- Check users table
SHOW TABLES;

DESC users;


-- Task 5: Incorrect query for practice
CREATE TABLE test_restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100)
    cuisine VARCHAR(50),
    rating DECIMAL(2,1)
);


-- Corrected query
CREATE TABLE test_restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    rating DECIMAL(2,1)
);