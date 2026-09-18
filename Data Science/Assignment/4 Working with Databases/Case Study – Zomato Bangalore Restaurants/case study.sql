/* ============================================================
   ZOMATO BANGALORE RESTAURANTS - SQL CASE STUDY
   Database: zomato_db
   Table: zomato
   ============================================================ */


/* ============================================================
   STEP 1: SELECT DATABASE
   ============================================================ */

CREATE DATABASE IF NOT EXISTS zomato_db;

USE zomato_db;


/* ============================================================
   STEP 2: CHECK TABLE
   ============================================================ */

SELECT COUNT(*) AS total_rows
FROM zomato;


/* ============================================================
   STEP 3: CHECK SAMPLE DATA
   ============================================================ */

SELECT *
FROM zomato
LIMIT 10;


/* ============================================================
   STEP 4: CREATE CLEAN NUMERIC COLUMNS
   ------------------------------------------------------------
   rate example: 4.1/5
   cost example: 800 or 1,200
   ============================================================ */

ALTER TABLE zomato
ADD COLUMN rating_num DECIMAL(3,1),
ADD COLUMN cost_for_two_num DECIMAL(10,2);


/* ============================================================
   STEP 5: CONVERT RATE AND COST INTO NUMERIC VALUES
   ============================================================ */

UPDATE zomato
SET
    rating_num =
        CASE
            WHEN TRIM(rate) REGEXP '^[0-9]+(\\.[0-9]+)?/5$'
            THEN CAST(SUBSTRING_INDEX(TRIM(rate), '/', 1) AS DECIMAL(3,1))
            ELSE NULL
        END,

    cost_for_two_num =
        CASE
            WHEN REPLACE(TRIM(approx_cost_for_two_people), ',', '')
                 REGEXP '^[0-9]+(\\.[0-9]+)?$'
            THEN CAST(
                REPLACE(TRIM(approx_cost_for_two_people), ',', '')
                AS DECIMAL(10,2)
            )
            ELSE NULL
        END;


/* ============================================================
   STEP 6: CHECK CLEANED VALUES
   ============================================================ */

SELECT
    name,
    rate,
    rating_num,
    approx_cost_for_two_people,
    cost_for_two_num
FROM zomato
LIMIT 20;


/* ============================================================
   TASK 1
   ------------------------------------------------------------
   Find TOP 5 highest-rated restaurants in Koramangala
   that serve North Indian cuisine.
   ============================================================ */

SELECT
    name AS restaurant_name,
    location,
    cuisines,
    rating_num AS rating
FROM zomato
WHERE LOWER(location) LIKE '%koramangala%'
  AND LOWER(cuisines) LIKE '%north indian%'
  AND rating_num IS NOT NULL
GROUP BY
    name,
    location,
    cuisines,
    rating_num
ORDER BY rating_num DESC, name ASC
LIMIT 5;


/* ============================================================
   TASK 1 - SIMPLE VERSION
   ------------------------------------------------------------
   If your faculty expects a basic GROUP BY query:
   ============================================================ */

SELECT
    name,
    location,
    cuisines,
    MAX(rating_num) AS rating
FROM zomato
WHERE LOWER(location) LIKE '%koramangala%'
  AND LOWER(cuisines) LIKE '%north indian%'
  AND rating_num IS NOT NULL
GROUP BY name, location, cuisines
ORDER BY rating DESC
LIMIT 5;


/* ============================================================
   TASK 2
   ------------------------------------------------------------
   Calculate average cost for two people for each cuisine.
   Then show the 3 most expensive cuisine categories.
   
   NOTE:
   The dataset stores cuisines such as:
   "North Indian, Chinese"
   Therefore this query groups cuisine combinations.
   ============================================================ */

SELECT
    cuisines,
    ROUND(AVG(cost_for_two_num), 2) AS average_cost_for_two
FROM zomato
WHERE cuisines IS NOT NULL
  AND TRIM(cuisines) <> ''
  AND cost_for_two_num IS NOT NULL
GROUP BY cuisines
ORDER BY average_cost_for_two DESC
LIMIT 3;


/* ============================================================
   TASK 2 - SEE ALL CUISINES
   ============================================================ */

SELECT
    cuisines,
    ROUND(AVG(cost_for_two_num), 2) AS average_cost_for_two
FROM zomato
WHERE cuisines IS NOT NULL
  AND TRIM(cuisines) <> ''
  AND cost_for_two_num IS NOT NULL
GROUP BY cuisines
ORDER BY average_cost_for_two DESC;


/* ============================================================
   TASK 3
   ------------------------------------------------------------
   Find restaurants that:
   1. Offer online delivery
   2. Have rating below 3.0
   ============================================================ */

SELECT
    name AS restaurant_name,
    location,
    cuisines,
    rating_num AS rating,
    cost_for_two_num AS cost_for_two
FROM zomato
WHERE LOWER(TRIM(online_order)) = 'yes'
  AND rating_num < 3.0
ORDER BY rating_num ASC;


/* ============================================================
   TASK 3 - FIND PATTERNS BY LOCATION
   ------------------------------------------------------------
   This helps us understand where low-rated restaurants
   with online delivery are concentrated.
   ============================================================ */

SELECT
    location,
    COUNT(*) AS low_rated_restaurants,
    ROUND(AVG(rating_num), 2) AS average_rating,
    ROUND(AVG(cost_for_two_num), 2) AS average_cost
FROM zomato
WHERE LOWER(TRIM(online_order)) = 'yes'
  AND rating_num < 3.0
GROUP BY location
ORDER BY low_rated_restaurants DESC;


/* ============================================================
   TASK 3 - FIND PATTERNS BY CUISINE
   ============================================================ */

SELECT
    cuisines,
    COUNT(*) AS low_rated_restaurants,
    ROUND(AVG(rating_num), 2) AS average_rating,
    ROUND(AVG(cost_for_two_num), 2) AS average_cost
FROM zomato
WHERE LOWER(TRIM(online_order)) = 'yes'
  AND rating_num < 3.0
  AND cuisines IS NOT NULL
  AND TRIM(cuisines) <> ''
GROUP BY cuisines
ORDER BY low_rated_restaurants DESC;


/* ============================================================
   TASK 3 - FIND PATTERNS BY PRICE RANGE
   ============================================================ */

SELECT
    CASE
        WHEN cost_for_two_num < 400 THEN 'Budget'
        WHEN cost_for_two_num BETWEEN 400 AND 800 THEN 'Mid-range'
        WHEN cost_for_two_num > 800 THEN 'Premium'
        ELSE 'Unknown'
    END AS price_segment,

    COUNT(*) AS low_rated_restaurants,

    ROUND(AVG(rating_num), 2) AS average_rating

FROM zomato

WHERE LOWER(TRIM(online_order)) = 'yes'
  AND rating_num < 3.0

GROUP BY price_segment
ORDER BY low_rated_restaurants DESC;


/* ============================================================
   TASK 3 - MARKETING STRATEGY
   ------------------------------------------------------------
   Use the actual patterns from the above queries.
   
   Example strategy:
   
   - Identify locations having many low-rated restaurants.
   - Focus on improving customer experience in those areas.
   - Promote restaurants with improved ratings.
   - Use customer reviews to identify common complaints.
   - Offer limited-time discounts or loyalty offers.
   - Improve food quality, delivery time and packaging.
   
   Do NOT blindly claim a location/cuisine is the problem.
   Base the final explanation on your SQL results.
   ============================================================ */


/* ============================================================
   TASK 4
   ------------------------------------------------------------
   MARKET SEGMENTATION:
   
   Budget    = below 400
   Mid-range = 400 to 800
   Premium   = above 800
   
   Count restaurants in each segment.
   ============================================================ */

SELECT
    CASE
        WHEN cost_for_two_num < 400 THEN 'Budget'
        WHEN cost_for_two_num BETWEEN 400 AND 800 THEN 'Mid-range'
        WHEN cost_for_two_num > 800 THEN 'Premium'
        ELSE 'Unknown'
    END AS market_segment,

    COUNT(*) AS restaurant_count

FROM zomato

WHERE cost_for_two_num IS NOT NULL

GROUP BY market_segment

ORDER BY
    CASE market_segment
        WHEN 'Budget' THEN 1
        WHEN 'Mid-range' THEN 2
        WHEN 'Premium' THEN 3
        ELSE 4
    END;


/* ============================================================
   TASK 4 - ALTERNATIVE
   ------------------------------------------------------------
   If faculty asks only for valid 3 segments:
   ============================================================ */

SELECT
    CASE
        WHEN cost_for_two_num < 400 THEN 'Budget'
        WHEN cost_for_two_num BETWEEN 400 AND 800 THEN 'Mid-range'
        WHEN cost_for_two_num > 800 THEN 'Premium'
    END AS market_segment,

    COUNT(*) AS restaurant_count

FROM zomato

WHERE cost_for_two_num IS NOT NULL
  AND cost_for_two_num > 0

GROUP BY market_segment;


/* ============================================================
   TASK 5
   ------------------------------------------------------------
   TOP 10 MOST POPULAR RESTAURANT CHAINS
   BY NUMBER OF OUTLETS
   
   COUNT(DISTINCT address) is used because the same restaurant
   may appear multiple times in the dataset.
   ============================================================ */

SELECT
    name AS restaurant_chain,
    COUNT(DISTINCT address) AS number_of_outlets
FROM zomato
WHERE name IS NOT NULL
  AND TRIM(name) <> ''
GROUP BY name
ORDER BY number_of_outlets DESC, name ASC
LIMIT 10;


/* ============================================================
   TASK 5 - BASIC VERSION
   ------------------------------------------------------------
   If faculty specifically wants GROUP BY + COUNT example:
   ============================================================ */

SELECT
    name AS restaurant_chain,
    COUNT(*) AS number_of_outlets
FROM zomato
WHERE name IS NOT NULL
  AND TRIM(name) <> ''
GROUP BY name
ORDER BY number_of_outlets DESC
LIMIT 10;


/* ============================================================
   FINAL VALIDATION
   ============================================================ */

SELECT COUNT(*) AS total_restaurant_records
FROM zomato;

SELECT
    COUNT(*) AS records_with_rating
FROM zomato
WHERE rating_num IS NOT NULL;

SELECT
    COUNT(*) AS records_with_cost
FROM zomato
WHERE cost_for_two_num IS NOT NULL;


/* ============================================================
   END OF ZOMATO SQL CASE STUDY
   ============================================================ */