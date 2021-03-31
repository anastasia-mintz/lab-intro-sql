USE sakila;
-- Select all the actors with the first name ‘Scarlett’.
SELECT * FROM ACTOR;
SELECT * FROM actor WHERE first_name = 'Scarlett';

-- How many films (movies) are available for rent and how many films have been rented?
SELECT * FROM rental;
-- Way 1:
SELECT COUNT(rental_id) AS 'Available films'
FROM rental
WHERE return_date is null;

SELECT COUNT(rental_id) AS 'Unvailable films'
FROM rental
WHERE return_date is not null;
-- Way 2:
SELECT * FROM rental;
SELECT COUNT(rental_date)-COUNT(return_date) AS rented FROM rental;

-- What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) as min_duration   -- Length (column name) = duration of film
FROM film;

-- What's the average movie duration expressed in format (hours, minutes)?
SELECT FLOOR(AVG(length)/60)  AS hour, (AVG(length) % 60) AS minutes
FROM film;

-- How many distinct (different) actors' last names are there?
SELECT * FROM actor;
SELECT COUNT(DISTINCT last_name) FROM actor;

-- Since how many days has the company been operating (check DATEDIFF() function)?
SELECT MIN(rental_date) FROM rental;
SELECT DATEDIFF( MIN(rental_date), MAX(return_date) AS DateDiff) FROM rental;
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) AS Days_Operating
FROM rental;

-- Show rental info with additional columns month and weekday. Get 20 results.
SELECT *, month(rental_date) AS 'Month',
CASE
WHEN weekday(rental_date) = 0 then 'Monday'
WHEN weekday(rental_date) = 1 then 'Tuesday'
WHEN weekday(rental_date) = 2 then 'Wednesday'
WHEN weekday(rental_date) = 3 then 'Thursday'
WHEN weekday(rental_date) = 4 then 'Friday'
WHEN weekday(rental_date) = 5 then 'Saturday'
ELSE 'Sunday'
END AS 'Weekday'
FROM rental
LIMIT 20;

-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *, month(rental_date) AS 'Month',
CASE
WHEN weekday(rental_date) < 6 then 'Weekday'
ELSE 'Weekend'
END AS 'Weekday'
FROM rental
LIMIT 20;

-- Get release years.
SELECT release_year FROM film;
SELECT DISTINCT release_year FROM film;

-- Get all films with ARMAGEDDON in the title.
SELECT title 
FROM film
WHERE title LIKE '%ARMAGEDDON%';

-- Get all films which title ends with APOLLO.
SELECT title
FROM film
WHERE title LIKE '%APOLLO';

-- Get 10 the longest films.
SELECT title
FROM film
ORDER BY length DESC
LIMIT 10;

-- How many films include Behind the Scenes content?
SELECT COUNT(title)
FROM film
WHERE special_features LIKE '%Behind the Scenes%';

-- In the table actor, which are the actors whose last names are not repeated? For example if you would sort the data in the 
-- table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
-- These three actors have the same last name. So we do not want to include this last name in our output. 
-- Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;

-- Which last names appear more than once? We would use the same logic as in the previous question but this time we 
-- want to include the last names of the actors where the last name was present more than once
SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- Using the rental table, find out how many rentals were processed by each employee.
SELECT staff_id, COUNT(staff_id)
FROM rental
GROUP BY staff_id;

-- Using the film table, find out how many films were released each year.
SELECT release_year, COUNT(release_year) FROM film
GROUP BY release_year;

-- Using the film table, find out for each rating how many films were there.
SELECT rating, COUNT( rating) FROM film
GROUP BY rating;

-- What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT rating as Rating, round(AVG(length),2) as Average_duration
FROM film
GROUP BY rating;

-- Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, AVG(length) as 'Average_duration'
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.
SELECT title, length,
CASE
WHEN length <= 60 then 'duration low'
WHEN length <= 120 then 'duration medium'
ELSE 'duration high'
END AS 'Ranking duration'
FROM film
WHERE length is not null
AND length <> 0;
