
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

/* Q9 */

/*  Return a table containing each employees first_name, 
 *  last_name, full-time equivalent hours (fte_hours), 
 *  salary, and a new column effective_yearly_salary 
 *  which should contain fte_hours multiplied by salary. 
 *  Return only rows where effective_yearly_salary is more than 30000.
 */

SELECT 
    first_name,
    last_name,
    fte_hours,
    salary,
    (fte_hours * salary) AS effective_yearly_salary
FROM employees
WHERE ((fte_hours * salary) > 30000);

/* Q10 */

/* Find the details of all employees in either Data Team 1 or Data Team 2 */

SELECT *
FROM employees AS e
LEFT JOIN teams AS t
ON e.team_id = t.id
WHERE t."name" = 'Data Team 1' OR 
      t."name" = 'Data Team 2';

  -- Without a Join -- 
SELECT *
FROM employees 
WHERE team_id = '7' OR
      team_id = '8';
      
/* Q11 */
      
/* Find the first name and last name of all employees who lack a local_tax_code. */

SELECT 
    e.first_name,
    e.last_name
FROM employees AS e
LEFT JOIN pay_details AS pd 
ON e.pay_detail_id = pd.id
WHERE pd.local_tax_code IS NULL;

/* Q12 */

/*  The expected_profit of an employee is defined as (48 * 35 * charge_cost - salary) * fte_hours, 
 *  where charge_cost depends upon the team to which the employee belongs. 
 *  Get a table showing expected_profit for each employee.
 */

SELECT
    concat(e.first_name, ' ', e.last_name) AS full_name,
    t."name",
    t.charge_cost,
    e.fte_hours,
    ((48 * 35 * CAST(t.charge_cost AS int) - e.salary) * e.fte_hours) AS expected_profit
FROM employees AS e
LEFT JOIN teams AS t
ON e.team_id = t.id;

/* Q13 */

/* Find the first_name, last_name and salary of the lowest paid employee in 
 * Japan who works the least common full-time equivalent hours across the corporation.”
 */

SELECT
    first_name,
    last_name,
    salary
FROM employees 
WHERE country = 'Japan'
AND fte_hours = (
            SELECT 
                fte_hours 
                FROM employees 
                GROUP BY fte_hours
                ORDER BY count(id)
                LIMIT 1
)
ORDER BY salary ASC NULLS LAST
LIMIT 1;

/* Q14 */

/* Obtain a table showing any departments in which there are two or more 
 * employees lacking a stored first name. Order the table in descending order 
 * of the number of employees lacking a first name, 
 * and then in alphabetical order by department.
 */

SELECT 
    count(id) AS nameless_employees,
    department
FROM employees 
WHERE first_name IS NULL
GROUP BY department
HAVING count(id) > 1
ORDER BY nameless_employees DESC, department ASC;

/* Q15 */

/* Return a table of those employee first_names shared by more than one employee, 
 * together with a count of the number of times each first_name occurs. 
 * Omit employees without a stored first_name from the table. 
 * Order the table descending by count, and then alphabetically by first_name.
 */

SELECT 
    first_name,
    count(id) AS n_employees
FROM employees 
WHERE first_name IS NOT NULL
GROUP BY first_name
HAVING count(id) > 1
ORDER BY n_employees DESC, first_name ASC


/* Q16 */

/* Find the proportion of employees in each department who are grade 1. 
 */

SELECT
    department,
    grade,
    count(grade),
    sum()
FROM employees
GROUP BY department, grade











