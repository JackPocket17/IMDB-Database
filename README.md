# IMDB-Database

There were 7 files downloaded into our system and it was in .tsv.gz format.
We converted them into csv format.
The above data files are in the data_csv_project directory.

In the SQL_files we have the below mentioned files:

1.create.sql : this file contains the queries to create initial
 7 tables and then queries we ran to create 13 tables for normalization.

2.load.sql : this file contains the command that loads the data into 7 initial tables
And several other queries used for normalization and inserting data into the normalized database.

3.Queries_IMDB.sql which contains several queries for analyzing the database.

4.Data_csv_project: This subdirectory contains all the data files in cdv format.

The UI_app.py file runs with the following command 'streamlit run UI_app.py
We need to have streamlit library into our python eco space.
Use the following command to run the same '93pip install streamlit"
