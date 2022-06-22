#Queries 

--1)	List the distinct types of professions in the database and the count of each type of profession?
select  a.category from principal_info as a
group by a.category
order by a.category ASC



--2) What are the different type of  genres? How many movies are there in each genre?
SELECT G.genres, COUNT(G.genres) AS Count
FROM genre_title AS G, title_basic_main AS T
WHERE T.tconst = G.tconst
AND T.titletype = 'movie'
GROUP BY genres
ORDER BY Count DESC;


--3) What is the count of movies, short made in each year from 1980 to 2005?

SELECT a.startYear, COUNT(*) AS  total_content
FROM title_basic_main AS a
WHERE a.titleType IN ('movie','short')
GROUP BY a.startYear
HAVING a.startYear BETWEEN 1980 AND 2005
ORDER BY a.startYear ASC;




--4)List the content(any type) whose duration is longer than 2 hours?

SELECT tconst , runtimeMinutes, titleType, primaryTitle
FROM Title_Basic_main WHERE runtimeMinutes > (2*60)
ORDER BY runtimeMinutes DESC, titleType ASC;



--5) List the distinct types of titles present in the database.
SELECT T.titletype, COUNT(*)
FROM title_basic_main AS T
GROUP BY T.titletype
ORDER BY T.titletype ASC;



--6)	What is the mean rating of the title “Brother Rat”
SELECT t.primaryTitle, R.averageRating
FROM title_basic_main AS t, rating AS R
WHERE  t.tconst  = R.tconst
AND t.titleType = 'movie' AND
t.primaryTitle like 'Brother Rat';

--7)  Which actor played the role of 'Isabelle' in a 'short' titletype ?  How many times have they played that role?
#Using view.

CREATE OR REPLACE VIEW Q1(nconst,primaryname,number_of_films)
AS SELECT N.nconst, N.primaryname, COUNT(*) AS number_of_films
FROM crew_info AS N, roles AS H, title_basic_main AS T
WHERE H.characters LIKE 'Isabelle'
AND T.titletype LIKE 'short'
AND T.tconst = H.tconst
AND N.nconst = H.nconst
GROUP BY N.nconst;
SELECT * FROM Q1;


--8) How many Thriller of titletype (movies, short) are made in even years?
#Using Views
CREATE OR REPLACE VIEW Q2(StartYear,Num_of_Thriller_movies)
AS SELECT T.startyear, COUNT(DISTINCT T.tconst) AS Num_of_Thriller_movies
FROM title_basic_main AS T, genre_title AS G
WHERE T.tconst = G.tconst
AND G.genres = 'Thriller'
AND T.titletype IN ('movie','short')
AND (T.startyear % 2) = 0
GROUP BY T.startyear
ORDER BY T.startyear DESC;

SELECT * FROM Q2;



--9) Creating a function below that List the distinct types of titles present in the database.
CREATE OR REPLACE FUNCTION distinct_title()  
RETURNS table(
	titletype character varying(1000),
	count bigint
)  
AS $$
BEGIN  
   RETURN QUERY SELECT T.titletype, COUNT(*)
	FROM title_basic_main AS T
	GROUP BY T.titletype
	ORDER BY T.titletype ASC;  
	END;  $$ 
LANGUAGE plpgsql;

#Calling the function
select * from  distinct_title()


--10) Below will create a new table avg_rating_percentage, create a trigger which will insert
-- new values of the average rating into the avg_rating table. 

create table avg_rating_percentage(
percentage numeric(5,5)
); 


CREATE OR REPLACE FUNCTION insert_avg_rating_percentage()
  RETURNS trigger AS
$$
BEGIN
         INSERT INTO avg_rating_percentage(percentage)
         VALUES(NEW.percentage);
 
    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';


CREATE TRIGGER percentage_trigger
  AFTER INSERT
  ON avg_rating_percentage
  FOR EACH ROW
  EXECUTE PROCEDURE insert_avg_rating_percentage();


--11) Below will create an index on the title_basic_main table and before creating an index

--  we will use "explain" keyword on the same query to show the difference
-- and the power of indexing 
#Before indexing 
explain select * from title_basic_main 
where primarytitle ='100 Years of Love'; 


#Creating an index
CREATE INDEX primary_title_index 
ON title_basic_main(primarytitle);

#After indexing 
explain select * from title_basic_main 
where primarytitle ='100 Years of Love'; 














