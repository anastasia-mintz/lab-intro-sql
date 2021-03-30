USE sakila;
-- Explore tables by selecting all columns from each table
SELECT * FROM actor;
SELECT * FROM address;
SELECT * FROM category;
SELECT * FROM city;
SELECT * FROM film; -- And so on for other tables...
-- Select one column from a table:
-- Select column 'film titles'
SELECT title FROM film;
SELECT title FROM film_text;
-- Select one column from a table and alias it:
-- Get unique list of film languages under the alias 'language'
SELECT name AS Language FROM language;   -- There are 6 languages
-- How many stores and staff does the company have?
SELECT * FROM staff;   -- Two employees 
SELECT * FROM store;   -- Two stores
-- Can you return a list of employee first names only?
SELECT first_name AS 'First Name' FROM staff;
-- How many unique days did customers rent movies in this dataset?
SELECT * FROM rental;
SELECT COUNT(rental_id) FROM rental;


