CREATE TABLE geoplaces2 (
    placeID INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    alcohol VARCHAR(50),
    smoking_area VARCHAR(50),
    price VARCHAR(50)
);
CREATE TABLE rating_final (
    userID VARCHAR(50),
    placeID INT,
    rating INT,
    food_rating INT,
    service_rating INT
);
CREATE TABLE userprofile (
    userID VARCHAR(50),
    transport VARCHAR(50),
    budget VARCHAR(50),
    activity VARCHAR(50)
);
CREATE TABLE chefmozcuisine (
    placeID INT,
    Rcuisine VARCHAR(100)
);



-- 1. Total Restaurants
SELECT COUNT(*) AS Total_Restaurants
FROM geoplaces2;

-- 2. Total Customers
SELECT COUNT(DISTINCT userID) AS Total_Customers
FROM userprofile;

-- 3. Average Rating
SELECT ROUND(AVG(rating),2) AS Average_Rating
FROM rating_final;

-- 4. Top 10 Restaurants
SELECT
    g.name,
    ROUND(AVG(r.rating),2) AS Avg_Rating
FROM geoplaces2 g
JOIN rating_final r
ON g.placeID = r.placeID
GROUP BY g.name
ORDER BY Avg_Rating DESC
LIMIT 10;

-- 5. Top Cities
SELECT
    g.city,
    ROUND(AVG(r.rating),2) AS Avg_Rating
FROM geoplaces2 g
JOIN rating_final r
ON g.placeID = r.placeID
GROUP BY g.city
ORDER BY Avg_Rating DESC;

-- 6. Highest Rated Cuisines
SELECT
    c.Rcuisine,
    ROUND(AVG(r.rating),2) AS Avg_Rating
FROM chefmozcuisine c
JOIN rating_final r
ON c.placeID = r.placeID
GROUP BY c.Rcuisine
ORDER BY Avg_Rating DESC;

-- 7. Most Popular Cuisines
SELECT
    Rcuisine,
    COUNT(*) AS Restaurant_Count
FROM chefmozcuisine
GROUP BY Rcuisine
ORDER BY Restaurant_Count DESC;

-- 8. Price Category vs Rating
SELECT
    g.price,
    ROUND(AVG(r.rating),2) AS Avg_Rating
FROM geoplaces2 g
JOIN rating_final r
ON g.placeID = r.placeID
GROUP BY g.price;

-- 9. Alcohol Service vs Rating
SELECT
    g.alcohol,
    ROUND(AVG(r.rating),2) AS Avg_Rating
FROM geoplaces2 g
JOIN rating_final r
ON g.placeID = r.placeID
GROUP BY g.alcohol;

-- 10. Smoking Area vs Rating
SELECT
    g.smoking_area,
    ROUND(AVG(r.rating),2) AS Avg_Rating
FROM geoplaces2 g
JOIN rating_final r
ON g.placeID = r.placeID
GROUP BY g.smoking_area;

-- 11. Budget Segment Analysis
SELECT
    u.budget,
    ROUND(AVG(r.rating),2) AS Avg_Rating
FROM userprofile u
JOIN rating_final r
ON u.userID = r.userID
GROUP BY u.budget;

-- 12. Transport Preference Analysis
SELECT
    u.transport,
    ROUND(AVG(r.rating),2) AS Avg_Rating
FROM userprofile u
JOIN rating_final r
ON u.userID = r.userID
GROUP BY u.transport;

-- 13. Customer Activity Analysis
SELECT
    u.activity,
    ROUND(AVG(r.rating),2) AS Avg_Rating
FROM userprofile u
JOIN rating_final r
ON u.userID = r.userID
GROUP BY u.activity;

-- 14. Food vs Service Ratings
SELECT
    ROUND(AVG(food_rating),2) AS Avg_Food_Rating,
    ROUND(AVG(service_rating),2) AS Avg_Service_Rating
FROM rating_final;

-- 15. Restaurants Above Average Rating
SELECT
    g.name,
    ROUND(AVG(r.rating),2) AS Avg_Rating
FROM geoplaces2 g
JOIN rating_final r
ON g.placeID = r.placeID
GROUP BY g.name
HAVING AVG(r.rating) >
(
    SELECT AVG(rating)
    FROM rating_final
);

-- 16. Restaurant Success Score
SELECT
    g.name,
    ROUND(
        AVG(
            (r.rating + r.food_rating + r.service_rating)/3.0
        ),2
    ) AS Success_Score
FROM geoplaces2 g
JOIN rating_final r
ON g.placeID = r.placeID
GROUP BY g.name
ORDER BY Success_Score DESC;

-- 17. Top 5 Restaurants Recommendation
SELECT
    g.name,
    ROUND(
        AVG(
            (r.rating + r.food_rating + r.service_rating)/3.0
        ),2
    ) AS Success_Score
FROM geoplaces2 g
JOIN rating_final r
ON g.placeID = r.placeID
GROUP BY g.name
ORDER BY Success_Score DESC
LIMIT 5;

-- 18. Complete Business Summary
SELECT
    g.city,
    c.Rcuisine,
    g.price,
    ROUND(AVG(r.rating),2) AS Avg_Rating
FROM geoplaces2 g
JOIN rating_final r
ON g.placeID = r.placeID
JOIN chefmozcuisine c
ON g.placeID = c.placeID
GROUP BY g.city, c.Rcuisine, g.price
ORDER BY Avg_Rating DESC;