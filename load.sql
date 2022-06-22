
#Loading the data into the SQL database 
copy crew_basic_info FROM '/Users/aryansaini/Documents/EAS Semester 2/Data Models and Query Language/Project/DMQL_FINAL_PROJECT/Data_csv_project/name_basic_info.csv' with csv header;
copy title_basics FROM '/Users/aryansaini/Documents/EAS Semester 2/Data Models and Query Language/Project/DMQL_FINAL_PROJECT/Data_csv_project/title_basics.csv' with csv header;
copy title_crew FROM '/Users/aryansaini/Documents/EAS Semester 2/Data Models and Query Language/Project/DMQL_FINAL_PROJECT/Data_csv_project/title_crew.csv' with csv header;
copy title_episode FROM '/Users/aryansaini/Documents/EAS Semester 2/Data Models and Query Language/Project/DMQL_FINAL_PROJECT/Data_csv_project/title_episode.csv' with csv header;
copy title_info FROM '/Users/aryansaini/Documents/EAS Semester 2/Data Models and Query Language/Project/DMQL_FINAL_PROJECT/Data_csv_project/title_info.csv' with csv header;
copy title_principal_crew FROM '/Users/aryansaini/Documents/EAS Semester 2/Data Models and Query Language/Project/DMQL_FINAL_PROJECT/Data_csv_project/title_principal_crew.csv' with csv header;
copy title_ratings FROM '/Users/aryansaini/Documents/EAS Semester 2/Data Models and Query Language/Project/DMQL_FINAL_PROJECT/Data_csv_project/title_ratings.csv' with csv header;



#We used the below queries to convert genre, directors column into 1 NF

select tconst,
       regexp_split_to_table(genres, ',') as genre
from title_basics

select tconst,
       regexp_split_to_table(directors, ',') as director
from title_crew


#We then store the above values in a dummy tables to add the data to genre_title and director_info.
create table dummy1 as 
select tconst,
       regexp_split_to_table(genres, ',') as genre
from title_basics

insert into genre_title
select tconst, genre from dummy1


create table dummy2 as 
select tconst,
       regexp_split_to_table(directors, ',') as director
from title_crew

insert into director_info
select tconst, director from dummy2





#After Normalization of the tables we insert data into these tables using the below queries.

insert into title_basic_main
select tconst, titletype, primarytitle, originaltitle, isadult, startyear, endyear, runtimeminutes
from title_basics;


insert into title_details
select titleid, ordering, title, region, language, isoriginaltitle 
from title_info;

insert into details_type
select titleid, ordering, types from title_info;

insert into details_attribute
select 
titleid, ordering, attributes  from title_info;

insert into rating
select tconst, averagerating, numvotes from title_ratings;

insert into roles
select 
tconst, nconst, characters from title_principal_crew;


insert into writes_info
select tconst, writers
from title_crew;

insert into principal_info
select 
tconst, ordering , nconst, category, job from title_principal_crew;



insert into crew_info
select 
nconst, primaryname, birthyear, deathyear from crew_basic_info;


insert into professional_info
select nconst, primaryprofession from crew_basic_info;


insert into episode_info
select 
tconst, parenttconst, seasonnumber, episodenumber from title_episode;

