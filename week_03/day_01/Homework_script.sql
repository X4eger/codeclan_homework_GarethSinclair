/* MVP */

/* Q1 */ 

-- Find all the employees who work in the ‘Human Resources’ department.

SELECT *
FROM employees 
WHERE department = 'Human Resources';


/* Q2 */

-- Get the first_name, last_name, 
-- and country of the employees who 
-- work in the ‘Legal’ department

SELECT first_name,
       last_name,
       country,
       department
FROM employees 
WHERE department = 'Legal';

/* Q3 */

-- Count the number of employees based in Portugal.

SELECT count(*)
FROM employees 
WHERE country = 'Portugal';

/* Q4 */
      
-- Count the number of employees based in either Portugal or Spain.

SELECT count(*)
FROM employees 
WHERE country = 'Portugal' OR 
      country = 'Spain';
      
/* Q5 */

-- Count the number of pay_details records lacking a local_account_no.

SELECT count(*) 
FROM pay_details 
WHERE local_account_no IS NULL; 
      
/* Q6 */

-- Are there any pay_details records lacking both 
-- a local_account_no and iban number?

SELECT count(*)
FROM pay_details 
WHERE local_account_no IS NULL
AND iban IS NULL;    


/* Q7 */

-- Get a table with employees first_name and last_name 
-- ordered alphabetically by last_name (put any NULLs last).

SELECT id,
       first_name,
       last_name
FROM employees 
ORDER BY last_name ASC NULLS LAST;
      
/* Q8 */

-- Get a table of employees first_name, last_name and country, 
-- ordered alphabetically first by country and then by last_name 
-- (put any NULLs last).
      
SELECT first_name,
       last_name,
       country
FROM employees 
ORDER BY country ASC NULLS LAST,
         last_name ASC NULLS LAST;
      
/* Q9 */
     
-- Find the details of the top ten highest paid employees in the corporation.
     
SELECT *
FROM employees 
ORDER BY salary DESC NULLS LAST 
LIMIT 10;


     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
      
      
      
      
      
      
