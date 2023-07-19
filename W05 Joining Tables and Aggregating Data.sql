
-- Question 1
SELECT artfile 
FROM artwork
WHERE period = 'Impressionism';

-- Question 2 
SELECT artfile 
FROM artwork a  
	JOIN artwork_keyword ak
    ON a.artwork_id = ak.artwork_id
    JOIN keyword k
    ON ak.keyword_id = k.keyword_id
WHERE keyword LIKE '%flower%';

-- Question 3
SELECT fname, lname, title 
FROM artist
	LEFT JOIN artwork 
    ON artist.artist_ID = artwork.artist_id;
    
-- Question 4
SELECT magazineName, subscriberLastName, subscriberFirstName
FROM magazine m
	JOIN subscription s
    ON m.magazineKey = s.magazineKey
    JOIN subscriber sber 
    ON sber.subscriberKey = s.subscriberKey
ORDER BY magazineName;

-- Question 5
SELECT magazineName
FROM magazine m
	JOIN subscription s
    ON m.magazineKey = s.magazineKey
    JOIN subscriber sber 
    ON sber.subscriberKey = s.subscriberKey
WHERE subscriberFirstName = 'Samantha'
ORDER BY magazineName;

-- Question 6
SELECT first_name, last_name
FROM departments d
	JOIN dept_emp de
    ON d.dept_no = de.dept_no
    JOIN employees e 
    ON de.emp_no = e.emp_no
WHERE dept_name = 'Customer Service'
ORDER BY last_name
LIMIT 5;

-- Question 7 
SELECT first_name, last_name, dept_name, salary, s.from_date
FROM salaries s 
	JOIN employees e 
    ON s.emp_no = e.emp_no
    JOIN dept_emp de
    ON de.emp_no = e.emp_no
    JOIN departments d
    ON d.dept_no = de.dept_no
WHERE first_name = 'Berni' AND last_name = 'Genin'
ORDER BY from_date DESC
LIMIT 1;

-- Question 8 
SELECT ROUND(AVG(quantity)) AS 'Stock Average'
FROM stock;

-- Question 9 
SELECT DISTINCT product_name 
FROM product p 
	JOIN stock s 
    ON p.product_id = s.product_id
WHERE s.quantity = 0
GROUP BY product_name
ORDER BY product_name;


-- Question 10 
SELECT category_name, SUM(quantity) AS 'instock'
FROM category c 
	JOIN product p 
    ON c.category_id = p.category_id
    JOIN stock s 
    ON s.product_id = p.product_id
    JOIN store 
    ON s.store_id = store.store_id
WHERE store_name = "Baldwin Bikes"
GROUP BY category_name
ORDER BY instock;

-- Question 11
SELECT COUNT(emp_no) AS 'Number of Employees'
FROM employees;

-- Question 12
SELECT dept_name, FORMAT(AVG(salary), 2) AS average_salary
FROM salaries s 
	JOIN employees e 
    ON e.emp_no = s.emp_no
    JOIN dept_emp de
    ON de.emp_no = e.emp_no
    JOIN departments d 
    ON d.dept_no = de.dept_no
GROUP BY dept_name
HAVING AVG(salary) < 60000;

-- Question 13
SELECT dept_name, COUNT(gender) as 'Number of Females'
FROM departments d
	JOIN dept_emp de 
    ON d.dept_no = de.dept_no 
    JOIN employees e 
    ON e.emp_no = de.emp_no 
WHERE gender = 'F'
GROUP by dept_name;