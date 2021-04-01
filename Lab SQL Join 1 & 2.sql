-- LAB SQL JOIN 1:
USE sakila;
-- 1. How many films are there for each of the categories in the category table. 
-- Use appropriate join to write this query.
SELECT c.name, COUNT(f.film_id) AS 'Number of Films'
FROM film_category f
JOIN category c
USING (category_id)
GROUP BY category_id;

-- 2. Display the total amount rung up by each staff member in August of 2005.
SELECT staff_id, SUM(amount) AS 'Total Sales'
FROM payment
WHERE payment_date BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY staff_id;

-- 3. Which actor has appeared in the most films?
SELECT actor_id, COUNT(film_id)
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC
LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films)
SELECT customer_id, COUNT(rental_id)
FROM rental
GROUP BY customer_id
ORDER BY COUNT(rental_id) DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address
FROM staff s
JOIN address a
USING (address_id);

-- 6. List each film and the number of actors who are listed for that film.
SELECT film_id, COUNT(actor_id) AS 'Number of actors in film'
FROM film_actor 
GROUP BY film_id
ORDER BY film_id ASC;

SELECT f.title, COUNT(fa.actor_id) AS 'Number of actors in film'
FROM film_actor fa
JOIN film f
USING (film_id)
GROUP BY f.title
ORDER BY COUNT(fa.actor_id) DESC;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.
SELECT c.first_name, c.last_name, SUM(p.amount)
FROM payment p
JOIN customer c
USING (customer_id)
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name ASC;

-- 8. List number of films per category.
SELECT c.name, COUNT(f.film_id) AS 'Number of Films'
FROM film_category f
JOIN category c
USING (category_id)
GROUP BY category_id;

-- LAB SQL JOIN 2:

-- 1 .For each film, list actor that has acted in more films.             -- UNSOLVED :(
SELECT COUNT(DISTINCT film_id) FROM film;   -- Unique number of films   1000
SELECT COUNT(film_id) FROM film_actor;  -- film Id repeated    5462
SELECT COUNT(DISTINCT actor_id) FROM film_actor; -- distinct actors 200

SELECT actor_id, COUNT(film_id)
FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(film_id) DESC;

SELECT f.title, actor_id OVER (PARTITION BY f.film_id)
FROM film f
JOIN film_actor fa
USING (film_id)
GROUP BY f.title
HAVING fa.actor_id ;

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country 
FROM store a
JOIN address b
USING (address_id)
JOIN city c
USING (city_id)
JOIN country d
USING (country_id);

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT store_id, SUM(amount)
FROM store a
JOIN staff b
USING (store_id)
JOIN payment c
USING (staff_id)
GROUP BY store_id;

SELECT store_id, SUM(amount)
FROM store a
JOIN staff b
USING (store_id)
JOIN payment c
USING (staff_id)
GROUP BY store_id;

SELECT * FROM sales_by_store;
-- 3. Which film categories are longest?
SELECT c.name, AVG(a.length)
FROM film a
JOIN film_category b
USING (film_id)
JOIN category c
USING (category_id)
GROUP BY c.name 
ORDER BY AVG(a.length) DESC;

-- 4. Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(rental_id) as Number_of_rented_times
FROM film f
LEFT JOIN inventory i
USING(film_id)
LEFT JOIN rental r
USING(inventory_id)
GROUP BY f.title
ORDER BY Number_of_rented_times DESC;

-- 5. List the top five genres in gross revenue in descending order.
SELECT c.name as GENRE, SUM(p.amount) as GROSS_REVENUE
FROM category c
LEFT JOIN film_category
USING(category_id)
LEFT JOIN film
USING(film_id)
LEFT JOIN inventory
USING(film_id)
LEFT JOIN rental
USING(inventory_id)
LEFT JOIN payment p
USING(customer_id)
GROUP BY GENRE
ORDER BY GROSS_REVENUE DESC
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?  - No

SELECT inventory_id, title, return_date
FROM film
LEFT JOIN inventory
USING(film_id)
LEFT JOIN rental
USING(inventory_id)
WHERE (title = 'ACADEMY DINOSAUR') AND (store_id =1) AND (return_date IS NULL);

-- 7. Get all pairs of actors that worked together.
SELECT *
FROM actor;
SELECT *
FROM film;
SELECT *
FROM film_actor;
SELECT a.actor_id, b.actor_id
FROM film_actor a
JOIN film_actor b
ON (a.film_id = b.film_id)  AND (a.actor_id <> b.actor_id);
-- 8. Get all pairs of customers that have rented the same film more than 3 times.
SELECT *
FROM customer;
SELECT *
FROM rental;
SELECT *
FROM inventory;
SELECT *
FROM film;
SELECT title, customer_id, COUNT(film_id)
FROM rental a
LEFT JOIN inventory b
USING(inventory_id)
LEFT JOIN film c
USING(film_id)
GROUP BY title, customer_id
HAVING COUNT(film_id) = 3;