USE sakila;

-- Drop column picture from staff
ALTER TABLE staff
DROP COLUMN picture;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.                                                                                                  
SELECT * 
FROM customer
WHERE first_name = 'TAMMY' AND last_name = 'SANDERS';

INSERT INTO staff
VALUES (4,'TAMMY', 'SANDERS', 79, 'TAMMY.SANDERS@sakilacustomer.org', 2, 1, 'username', password, '2006-02-15 04:57:20' );
 
SELECT * FROM sakila.staff;

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.

SELECT * FROM sakila.film
WHERE title = 'Academy Dinosaur';                -- film_id = 1

SELECT * FROM sakila.inventory
WHERE FILM_id = 1 ;                              -- inventory_id = 1

SELECT customer_id FROM sakila.customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';     -- customer_id = 130

SELECT * FROM sakila.staff
WHERE first_name = 'Mike' AND last_name = 'Hillyer';         -- staff_id = 1

SELECT * FROM sakila.rental;

INSERT INTO rental
VALUES (16061,'2021-04-05 23:33:42',1, 130, '2005-06-02 23:33:42', 1, '2006-06-02 23:33:42');

SELECT MAX(rental_id) from rental;


