/* MVP */

/* Q1 */

/*    (a). Find the first name, last name and team name of employees who are members of teams.
 *
 *  Hint
 *  We only want employees who are also in the teams table. So which type of join should we use?
 *
 *  (b). Find the first name, last name and team name of employees who are members of teams and are enrolled in the pension scheme.
 *
 *  (c). Find the first name, last name and team name of employees who are members of teams, 
 *       where their team has a charge cost greater than 80. 
 */

/* a */
SELECT e.first_name,
       e.last_name,
       t."name" 
FROM employees AS e 
INNER JOIN teams AS t 
ON t.id = e.team_id;

/* b */
SELECT e.first_name,
       e.last_name,
       t."name" 
FROM employees AS e 
INNER JOIN teams AS t 
ON t.id = e.team_id
WHERE e.pension_enrol IS TRUE;

/* c */
SELECT e.first_name,
       e.last_name,
       t."name",
       t.charge_cost
FROM employees AS e 
INNER JOIN teams AS t 
ON t.id = e.team_id
WHERE CAST(t.charge_cost AS int) > 80;

/* Q2 */

/* (a). Get a table of all employees details, together with their local_account_no and local_sort_code, if they have them.
 *
 * Hints
 * and are fields in , and employee details are held in , so this query requires a . 
 * What sort of is needed if we want details of employees, even if they don’t have stored and ?
 *
 * (b). Amend your query above to also return the name of the team that each employee belongs to.
 */

/* a */
SELECT e.*,
       p_d.local_account_no,
       p_d.local_sort_code
FROM employees AS e
LEFT JOIN pay_details AS p_d
ON p_d.id = e.id;

/* b */

SELECT e.*,
       p_d.local_account_no,
       p_d.local_sort_code,
       t."name"
FROM employees AS e
LEFT JOIN teams AS t
ON t.id = e.team_id
LEFT JOIN pay_details AS p_d
ON p_d.id = e.id;

/* Q3 */

/* (a). Make a table, which has each employee id along with the team that employee belongs to.
 *
 * (b). Breakdown the number of employees in each of the teams.
 *
 * Hint
 * You will need to add a group by to the table you created above.
 *
 * (c). Order the table above by so that the teams with the least employees come first. 
 */

/* a */

SELECT e.id,
       t."name"
FROM employees AS e
INNER JOIN teams AS t 
ON t.id =  e.team_id;

/* b */

SELECT t."name",
       count(e.id)
FROM employees AS e
INNER JOIN teams AS t 
ON t.id =  e.team_id
GROUP BY t."name";

/* c */

SELECT t."name",
       count(e.id)
FROM employees AS e
INNER JOIN teams AS t 
ON t.id =  e.team_id
GROUP BY t."name"
ORDER BY count(e.id);

/* Q4 */

/*
 * (a). Create a table with the team id, team name and the count of the number of employees in each team.
 *
 * Hint
 * If you , because it’s the primary key, you can any other column of that you want 
 * (this is an exception to the rule that normally you can only a column that you ).
 *
 * (b). The total_day_charge of a team is defined as the charge_cost of the team multiplied by the number of employees in the team. 
 *      Calculate the total_day_charge for each team.
 *
 * (c). How would you amend your query from above to show only those teams with a total_day_charge greater than 5000? 
 */

/* a */

SELECT t.id,
       t."name",
       count(e.id) AS n_team_members
FROM teams AS t
LEFT JOIN employees AS e 
ON e.team_id = t.id
GROUP BY t.id

/* b */

SELECT t.id,
       t."name",
       count(e.id) AS n_team_members,
       CAST(t.charge_cost AS int) * count(e.id) AS total_day_charge
FROM teams AS t
LEFT JOIN employees AS e 
ON e.team_id = t.id
GROUP BY t.id;

/* c */

SELECT t.id,
       t."name",
       count(e.id) AS n_team_members,
       CAST(t.charge_cost AS int) * count(e.id) AS total_day_charge
FROM teams AS t
LEFT JOIN employees AS e 
ON e.team_id = t.id
GROUP BY t.id
HAVING CAST(t.charge_cost AS int) * count(e.id) > 5000;

/* Extension */

/* Q5 */

/*
 * How many of the employees serve on one or more committees?
 */

SELECT COUNT(DISTINCT employee_id)
FROM employees_committees

/* Q6 */

/*
 * How many of the employees do not serve on a committee?
 */

SELECT count(e.id)
FROM employees AS e
LEFT JOIN employees_committees AS e_c
ON e_c.employee_id = e.id
WHERE e_c.committee_id IS NULL









