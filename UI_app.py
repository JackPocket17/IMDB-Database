
#Make sure you run "pip install streamlit" before running the application.

# Core Pkgs
import streamlit as st 
import pandas as pd


import psycopg2
conn = psycopg2.connect(database = "IMDB", user = "postgres", password = "1234", host = "127.0.0.1", port = "5432")

c = conn.cursor()


# Fxn Make Execution
def sql_executor(raw_code):
    c.execute(raw_code)
    cols = [desc[0] for desc in c.description]
    data = c.fetchall()
    return data, cols


def main():
    st.title("IMDB Sql Executor")


    st.subheader("HomePage")

    # Columns/Layout
    col1,col2 = st.columns(2)


    with st.form(key='query_form'):
        raw_code = st.text_area("SQL Code Here")
        submit_code = st.form_submit_button("Execute")
            
    # Results Layouts

        if submit_code:
            st.info("Query Submitted")
            st.code(raw_code)

            # Results 
            query_results, cols = sql_executor(raw_code)

            with st.expander("Pretty Table"):
                query_df = pd.DataFrame(query_results, columns = cols)
                st.dataframe(query_df)


            with st.expander("Results"):
                st.write(query_results)

            

if __name__ == '__main__':
    main()