#Create table queries

#Below are the create table queries from the CSV files.

CREATE TABLE crew_basic_info
(
    nconst character(15) NOT NULL,
    primaryname character varying(200)  NOT NULL,
    birthyear integer,
    deathyear integer,
    primaryprofession character varying(100) ,
    knownfortitles character varying(100) ,
    PRIMARY KEY (nconst)
);

CREATE TABLE title_basics
(
    tconst character(20)  NOT NULL,
    titletype character varying(1000) ,
    primarytitle character varying(3000) ,
    originaltitle character varying(3000) ,
    isadult boolean,
    startyear integer,
    endyear integer,
    runtimeminutes integer,
    genres character varying(5000),
    PRIMARY KEY (tconst)
);

CREATE TABLE title_crew
(
    tconst character(20)  NOT NULL,
    directors character varying(20000) ,
    writers character varying(20000) ,
    PRIMARY KEY (tconst)
);


CREATE TABLE title_episode
(
    tconst character(20)  NOT NULL,
    parenttconst character(20),
    seasonnumber integer,
    episodenumber integer,
    PRIMARY KEY (tconst)
);


CREATE TABLE title_info
(
    
    titleid character varying(10) COLLATE pg_catalog."default" NOT NULL,
    ordering integer NOT NULL,
    title character varying(5000) COLLATE pg_catalog."default",
    region character varying(50) COLLATE pg_catalog."default",
    language character varying(50) COLLATE pg_catalog."default",
    types character varying(50) COLLATE pg_catalog."default",
    attributes character varying COLLATE pg_catalog."default",
    isoriginaltitle boolean,
    PRIMARY KEY (titleid, ordering)

);



CREATE TABLE title_principal_crew
(
    tconst character(20)  NOT NULL,
    ordering integer NOT NULL,
    nconst character(20)  NOT NULL,
    category character varying(5000) ,
    job character varying(5000) ,
    characters character varying(5000) ,
   	PRIMARY KEY (tconst, ordering)
   	
);



CREATE TABLE title_rating
(
    tconst character(20)  NOT NULL,
    averagerating numeric(5,2),
    numvotes integer,
    PRIMARY KEY (tconst)
);


#Further tables are created so that the data can be normalized.

create table title_basic_main(
tconst character(20) ,
titletype character varying(1000) ,
primarytitle character varying(3000) ,
originaltitle character varying(3000),
isadult boolean,
startyear integer,
endyear integer,
runtimeminutes integer,
PRIMARY key (tconst)
);



Create table genre_title(
tconst character(20),
genres character varying(5000),
PRIMARY KEY (tconst,genres)
);


create table details_type(
tconst character varying(10),
ordering integer NOT NULL,
types character varying(50),
PRIMARY KEY (tconst,ordering)
);

create table details_attribute(
tconst character varying(10),
ordering integer NOT NULL,
attribute character varying,
PRIMARY KEY (tconst,ordering)
);


create table rating (
tconst character(20) ,
averagerating numeric(5,2),
numvotes integer,
PRIMARY KEY(tconst)
);

create table roles(
tconst character(20) ,   
nconst character(20) ,
characters character varying(5000),
PRIMARY KEY (tconst, nconst, characters)
);

create table director_info(
tconst character(20) ,
directors character varying(20000),
PRIMARY KEY (tconst, directors)
 );

create table writes_info(
tconst character(20) ,
writers character varying(20000),
PRIMARY KEY (tconst)
);


create table principal_info(
tconst character(20)  NOT NULL,
ordering integer NOT NULL,
nconst character(20) NOT NULL,
category character varying(5000) ,
job character varying(5000) ,
PRIMARY key (tconst,ordering)
);

create table crew_info(
nconst character(15)  NOT NULL,
primaryname character varying(200) NOT NULL,
birthyear integer,
deathyear integer,
PRIMARY KEY (nconst)
);


   
create table professional_info(
nconst character(15) NOT NULL,
primaryprofession character varying(100) ,
PRIMARY KEY (nconst,primaryprofession)
);

create table episode_info(
tconst character(20)  NOT NULL,
parenttconst character(20) ,
seasonnumber integer,
episodenumber integer,
PRIMARY KEY (tconst)
);

create table title_details(
tconst character(20)  NOT NULL,
ordering integer NOT NULL,
title character varying(5000) ,
region character varying(50) COLLATE pg_catalog."default",
language character varying(50) COLLATE pg_catalog."default",
isoriginaltitle boolean,
PRIMARY KEY (tconst, ordering)

);


#Adding Foriegn key constrainst 

ALTER TABLE ONLY public.writes_info
    ADD CONSTRAINT fk FOREIGN KEY (tconst) REFERENCES public.title_basic_main(tconst) NOT VALID;


ALTER TABLE ONLY public.writes_info
    ADD CONSTRAINT fk1 FOREIGN KEY (writers) REFERENCES public.crew_info(nconst) NOT VALID;

ALTER TABLE ONLY public.professional_info
    ADD CONSTRAINT "nconstFK" FOREIGN KEY (nconst) REFERENCES public.crew_info(nconst) NOT VALID;


ALTER TABLE ONLY public.director_info
    ADD CONSTRAINT nconst_director FOREIGN KEY (directors) REFERENCES public.crew_info(nconst) NOT VALID;


ALTER TABLE ONLY public.principal_info
    ADD CONSTRAINT nconst_nconst_crew_info FOREIGN KEY (nconst) REFERENCES public.crew_info(nconst) NOT VALID;


ALTER TABLE ONLY public.episode_info
    ADD CONSTRAINT parenttconst_tconst_main FOREIGN KEY (parenttconst) REFERENCES public.title_basic_main(tconst) NOT VALID;


ALTER TABLE ONLY public.genre_title
    ADD CONSTRAINT tconst FOREIGN KEY (tconst) REFERENCES public.title_basic_main(tconst) NOT VALID;


ALTER TABLE ONLY public.title_details
    ADD CONSTRAINT tconst FOREIGN KEY (tconst) REFERENCES public.title_basic_main(tconst) NOT VALID;


ALTER TABLE ONLY public.details_attribute
    ADD CONSTRAINT tconst FOREIGN KEY (tconst) REFERENCES public.title_basic_main(tconst) NOT VALID;


ALTER TABLE ONLY public.rating
    ADD CONSTRAINT tconst_rating_main FOREIGN KEY (tconst) REFERENCES public.title_basic_main(tconst) NOT VALID;


ALTER TABLE ONLY public.director_info
    ADD CONSTRAINT "tconst_tconstDIRFK" FOREIGN KEY (tconst) REFERENCES public.title_basic_main(tconst) NOT VALID;


ALTER TABLE ONLY public.episode_info
    ADD CONSTRAINT tconst_tconst_main FOREIGN KEY (tconst) REFERENCES public.title_basic_main(tconst) NOT VALID;


ALTER TABLE ONLY public.principal_info
    ADD CONSTRAINT tconst_tconst_principal FOREIGN KEY (tconst) REFERENCES public.title_basic_main(tconst) NOT VALID;


ALTER TABLE ONLY public.roles
    ADD CONSTRAINT tconst_tconst_roles FOREIGN KEY (tconst) REFERENCES public.title_basic_main(tconst) NOT VALID;


ALTER TABLE ONLY public.details_type
    ADD CONSTRAINT tconst_types_main FOREIGN KEY (tconst) REFERENCES public.title_basic_main(tconst) NOT VALID;


