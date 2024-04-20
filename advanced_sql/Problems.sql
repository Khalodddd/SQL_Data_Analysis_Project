SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    location_category

SELECT 
    
    DISTINCT(company_dim.name),
    job_id,
    job_title_short,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'Egypt' THEN 'Egypt'
        ELSE 'Onsite'
    END AS location_category

FROM job_postings_fact
INNER JOIN company_dim
ON company_dim.company_id = job_postings_fact.company_id
WHERE (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND job_location = 'Egypt'*/
/*SELECT *
FROM(
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;*/
WITH january_jobs AS (
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) 
SELECT *
From january_jobs

/*SELECT name AS company_name,
                company_id
FROM company_dim
WHERE company_id IN (
    SELECT 
            company_id
            
    FROM job_postings_fact
    WHERE job_no_degree_mention = TRUE
    ORDER BY company_id

)
/*WITH 
    company_job_count AS (
SELECT
    company_id,
    COUNT(*) AS total_jobs,

    
FROM
    job_postings_fact
GROUP BY 
    company_id
)
SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs

FROM 
    company_dim
LEFT JOIN 
    company_job_count ON company_job_count.company_id = company_dim.company_id 
ORDER BY total_jobs DESC*/
/*WITH Remote_job_skills AS (
SELECT 
    skill_id,
    COUNT(*) AS skill_count
FROM 
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings 
ON job_postings.job_id = skills_to_job.job_id
WHERE job_postings.job_work_from_home = True
AND job_title_short = 'Data Analyst'
GROUP BY skill_id
)
SELECT 
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM  Remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = Remote_job_skills.skill_id
ORDER BY skill_count DESC
LIMIT 5;*/

SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM (
SELECT * FROM january_jobs
UNION ALL
SELECT * FROM february_jobs
UNION ALL
SELECT * FROM march_jobs
) AS quarter1_job_postings
WHERE 
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC


