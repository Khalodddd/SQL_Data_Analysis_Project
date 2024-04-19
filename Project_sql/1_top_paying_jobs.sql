/*
Question: What are top_paying data analyst jobs?
_ Identify the top 10 highest_paying Data Analyst roles that are avalible remotely.
_ Focus on job postings with specfied salaries (remove nulls).
_ Why?  Highlight the top_paying opportunities for Data Analysts, offering insights into employee */

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
