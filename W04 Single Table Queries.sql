-- Question 1
INSERT INTO artist (fname, lname, dob, country, dod, local)
VALUES ('Johannes', 'Vermeer', 1632, 'Netherlands', 1674, 'n');

-- Question 2 
SELECT * 
FROM artist 
ORDER BY lname ASC;

-- Question 3
UPDATE artist
SET dod = 1675
WHERE artist_id = 10;

-- Question 4
DELETE FROM artist 
WHERE artist_id = 10;

-- Question 5 
SELECT first_name, last_name, phone
FROM customer
WHERE city = 'Houston';

-- Question 6
SELECT product_name, list_price, list_price - 500 AS 'Discount Price'
FROM product
WHERE list_price >= 5000
ORDER BY list_price DESC;

-- Question 7 
SELECT first_name, last_name, email
FROM staff
WHERE store_id <> 1;

-- Question 8

SELECT product_name, model_year, list_price
FROM product
WHERE product_name LIKE '%spider%';

-- Question 9 
SELECT product_name, list_price 
FROM product
WHERE list_price BETWEEN 500 AND 550
ORDER BY list_price;

-- Question 10 
SELECT first_name, last_name, phone, street, city, state, zip_code
FROM customer
WHERE phone IS NOT NULL AND (city LIKE '%ach%' OR '%och%') OR last_name = 'William'
LIMIT 5;


-- Question 11 
SELECT * FROM product;

SELECT product_id, REGEXP_REPLACE(product_name, '\\-?\\s*-?\\S*\\d{4}\\s*$', '') AS 'Product Name Without Year'
FROM product
ORDER BY product_id
LIMIT 14;

-- Question 12
SELECT * FROM product;

SELECT product_name, CONCAT('$', FORMAT(list_price / 3, 2)) AS 'One of 3 Payments'
FROM product
WHERE model_year = 2019;

-- Question 13
SELECT * FROM magazine;

SELECT magazineName, ROUND(magazinePrice * .97, 2) AS '3% off'
FROM magazine;

-- Question 14
SELECT * FROM subscription;

SELECT subscriberKey,
ROUND(DATEDIFF('2020-12-20', subscriptionStartDate) / 365.25) AS 'Years since subscription';

-- Question 15
SELECT * FROM subscription;

SELECT
  subscriptionStartDate,
  subscriptionLength,
  DATE_FORMAT(DATE_ADD(subscriptionStartDate, INTERVAL subscriptionLength MONTH), '%M %e, %Y') AS 'Subscription End'
FROM subscription;
