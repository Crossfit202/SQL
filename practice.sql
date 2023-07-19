USE v_art;

SELECT * FROM artwork;

SELECT title, period, artyear 
FROM artwork
WHERE artyear > 1800 OR title = 'last supper';

SELECT tite, artyear
FROM artwork
WHERE artyear BETWEEN 1800 AND 1900;

SELECT title, period
FROM artwork
WHERE period IN ('Modern', 'Baroque', 'impressionism');

SELECT title, period
FROM artwork
WHERE period LIKE '%impression%';

SELECT title, period
FROM artwork
WHERE title REGEXP 'the|in|on';

SELECT * from artist;

SELECT fname AS Artist_First_Name, mname AS Middle, lname AS Artist_First_Name
FROM artist
WHERE mname IS NULL
ORDER BY Middle;

USE bike;

SELECT * from product;

SELECT product_name, model_year, list_price + 100 AS 'marked_up', list_price
FROM product
WHERE list_price + 100 > 1000
ORDER BY marked_up;

SELECT product_name, model_year 
FROM product
WHERE (product_name LIKE 'Trek%' OR product_name LIKE 'Surly%') AND model_year <> 2016;









