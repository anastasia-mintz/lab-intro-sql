USE sakila;
-- How many copies of the film Hunchback Impossible exist in the inventory system
SELECT COUNT(*) FROM inventory
WHERE film_id IN (
	SELECT film_id FROM (
		SELECT title, film_id FROM film
		WHERE title LIKE 'Hunchback Impossible'
        ) sub1
    );
-- List all films whose length is longer than the average of all the films.

SELECT title, length FROM film
WHERE length > (
  SELECT avg(length)
  FROM film
);

-- Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name FROM actor
WHERE actor_id IN(
	SELECT actor_id from (
		SELECT actor_id, film_id FROM film_actor
		WHERE film_id IN (
			SELECT film_id from (
			SELECT title, film_id FROM film
				WHERE title LIKE 'Alone Trip'
				) sub1
			)
		)sub2
	);
    
-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
SELECT film_id, title FROM film
WHERE film_id IN(
	SELECT film_id FROM film_category
	WHERE category_id IN(
		SELECT category_id FROM category
		WHERE name LIKE 'Family'
		)
	);
    
-- Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, 
-- you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

          -- Using subqueries
SELECT first_name, last_name, email FROM customer
WHERE address_id IN(
	SELECT address_id FROM address
	WHERE city_id IN(
		SELECT city_id FROM city
		WHERE country_id IN(
			SELECT country_id FROM country
			WHERE country LIKE 'Canada')
		)
	);
    
              -- Using joins
SELECT first_name, last_name, email, country FROM country
JOIN city 
USING (country_id)
JOIN address
USING (city_id)
JOIN customer
USING (address_id)
WHERE country LIKE 'Canada';


-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the 
-- most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different 
-- films that he/she starred.

SELECT title FROM film
WHERE film_id IN(
	SELECT film_id FROM film_actor
    WHERE actor_id IN(
		SELECT actor_id FROM(
			SELECT first_name, last_name, actor_id, COUNT(film_id) 
			FROM film_actor
			JOIN actor
			USING (actor_id)
			GROUP BY actor_id
			ORDER BY COUNT(film_id) DESC
			LIMIT 1) sub1
			) 
    );


-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable 
-- customer ie the customer that has made the largest sum of payments

SELECT title, customer_id
FROM inventory
JOIN rental
USING (inventory_id)
JOIN film
USING (film_id)
WHERE customer_id IN(
	SELECT customer_id FROM(
		SELECT customer_id, first_name, last_name, SUM(amount) AS 'Total spent'
		FROM payment
		JOIN customer
		USING (customer_id)
        GROUP BY first_name, last_name
        ORDER BY SUM(amount) DESC
        LIMIT 1
        ) sub1
	);

-- Customers who spent more than the average payments

SELECT first_name, last_name, customer_id, amount AS 'Money Spent'
FROM payment
JOIN customer
USING (customer_id)
GROUP BY first_name, last_name
HAVING amount > (
	SELECT AVG(amount)
	FROM payment 
    );


SELECT first_name, last_name, customer_id
FROM customer
	WHERE customer_id IN (
	SELECT customer_id
        FROM (SELECT sp.customer_id, SUM(amount) AS spent_amount
            FROM sakila.payment sp
            GROUP BY customer_id
            HAVING spent_amount > (SELECT 
								AVG(spent_amount) avg_spent_amount
								FROM (
                                SELECT sp.customer_id, SUM(amount) AS spent_amount
								FROM sakila.payment sp
								GROUP BY customer_id) sub1)
                                )sub2
                                );
