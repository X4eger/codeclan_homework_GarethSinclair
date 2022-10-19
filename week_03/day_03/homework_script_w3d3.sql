
/* MVP */

/* Q1 */
/* How many employee records are lacking both a grade and salary? */


SELECT count(id)
FROM employees 
WHERE grade  IS NULL 
AND salary IS NULL;

/* Q2 */

/* Produce a table with the two following fields (columns):
 *
 *   the department
 *   the employees full name (first and last name)
 *
 * Order your resulting table alphabetically by department, and then by last name
 */

SELECT department,
        concat(first_name,' ',last_name) AS full_name
FROM employees 
ORDER BY department, last_name;

/* Q3 */

/*
 * Find the details of the top ten highest paid employees who have a last_name beginning with ‘A’.
 */

SELECT *
FROM employees 
WHERE last_name LIKE 'A%'
ORDER BY salary DESC NULLS LAST
LIMIT 10;

/* Q4 */

/* Obtain a count by department of the employees who started work with the corporation in 2003 */

SELECT 
    department,    
    count(id) AS n_employees
FROM employees 
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department;

/* Q5 */

/* Obtain a table showing department, fte_hours and the number of employees 
 * in each department who work each fte_hours pattern. Order the table 
 * alphabetically by department, and then in ascending order of fte_hours. 
 */

SELECT 
    department,
    fte_hours,
    count(id) AS n_employees
FROM employees 
GROUP BY department, fte_hours
ORDER BY department, fte_hours;
































