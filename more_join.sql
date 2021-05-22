-- List the films where the yr is 1962 [Show id, title]
SELECT id, title FROM movie WHERE yr=1962;
-- Give year of 'Citizen Kane'.
SELECT yr FROM movie WHERE title = 'Citizen Kane';
-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr from movie WHERE title LIKE '%Star Trek%':
-- What id number does the actor 'Glenn Close' have?
SELECT id FROM actor WHERE name = 'Glenn Close';
-- What is the id of the film 'Casablanca'
SELECT id FROM movie WHERE title = 'Casablanca';
-- Obtain the cast list for 'Casablanca'.
SELECT name FROM actor JOIN casting ON actorid = id WHERE movieid = (SELECT id FROM movie WHERE title = 'Casablanca');
-- Obtain the cast list for the film 'Alien'
SELECT name FROM actor JOIN casting ON actorid = id WHERE movieid = (SELECT id FROM movie WHERE title = 'ALien');
-- List the films in which 'Harrison Ford' has appeared
SELECT title FROM movie WHERE id IN (SELECT movieid FROM casting JOIN actor ON actorid = id WHERE name = 'Harrison Ford');
-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT title FROM movie WHERE id IN (SELECT movieid FROM casting JOIN actor ON actorid = id WHERE name = 'Harrison Ford' AND ord <> 1);
-- List the films together with the leading star for all 1962 films.
SELECT title, name FROM movie m JOIN casting ON m.id = movieid JOIN actor a ON a.id = actorid WHERE ord = 1 AND yr = 1962;
-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr, COUNT(yr) FROM movie WHERE id IN (SELECT movieid FROM casting WHERE actorid = (SELECT id FROM actor WHERE name = 'Rock Hudson')) GROUP BY yr HAVING COUNT(yr) > 2
-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
 SELECT title, name FROM movie m JOIN casting ON m.id = movieid JOIN actor a ON a.id= actorid WHERE movieid IN (SELECT movieid FROM casting WHERE actorid = (SELECT id FROM actor WHERE name = 'Julie Andrews')) AND ord = 1 GROUP BY m.id, title, name
-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.                          
SELECT name FROM casting JOIN actor ON actorid = id WHERE ord = 1 GROUP BY actorid, name HAVING COUNT(actorid) > 14 ORDER BY name;