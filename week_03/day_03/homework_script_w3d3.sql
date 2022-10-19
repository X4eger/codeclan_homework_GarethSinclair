
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

/* Find the details of the top ten highest paid employees who have a last_name beginning with ‘A’.*/

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

/* Q6 */

/* Provide a breakdown of the numbers of employees enrolled, 
 * not enrolled, and with unknown enrollment status in the corporation pension scheme.
 */

SELECT
    pension_enrol,
    count(id) AS n_employees
FROM employees 
GROUP BY pension_enrol;

/* Q7 */

/* Obtain the details for the employee with the highest salary in 
 * the ‘Accounting’ department who is not enrolled in the pension scheme?
 */

SELECT *
FROM employees 
WHERE department = 'Accounting'
AND pension_enrol IS FALSE
ORDER BY salary DESC NULLS LAST
LIMIT 1;

/* Q8 */

/* Get a table of country, number of employees in that country, 
 * and the average salary of employees in that country for any 
 * countries in which more than 30 employees are based. 
 * 
 * Order the table by average salary descending.
 */

SELECT 
    country,
    count(id) AS n_employees,
    round(avg(salary), 2) AS avg_salary
FROM employees
GROUP BY country
HAVING count(id) > 30
ORDER BY avg_salary DESC;























