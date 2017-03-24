--a
/*
The IDs and full names of managers and the number of employees
 each of them manages. Order the results by decreasing number 
 of employees and return only the top ten results.
*/
SELECT * FROM (
SELECT M.employee_id, M.first_name, M.last_name, COUNT(*)
FROM employees M, employees E
WHERE E.manager_id = M.employee_id 
GROUP BY M.employee_id, M.first_name, M.last_name
ORDER BY COUNT(*) DESC)
where ROWNUM <= 10;



/*
The name, number of employees and total salary for each department outside of the US with less than 100 employees.
 The total salary is the sum of the salaries of each of the department's employees.
*/
SELECT D.department_name, COUNT(*) AS Number_Employees, SUM(E.salary) AS Salary_Sum
FROM departments D, employees E, locations L, countries C
WHERE E.department_id = D.department_id 
AND D.location_id = L.location_id 
AND L.country_id = C.country_id
AND C.country_name <> 'United States of America'
GROUP BY D.department_name
HAVING COUNT(*) < 100;


/*
The department name, department manager name and manager job title for all departments. 
If the department has no manager, include it in the output with NULL values for the manager and title.
*/
SELECT D.department_name AS dept_name, M.first_name AS firstName, M.last_name AS lastName, J.job_title
FROM departments D LEFT OUTER JOIN 
(employees M JOIN jobs J
ON M.job_id = J.job_id ) 
ON D.manager_id = M.employee_id;

/* The name of each department along with the average salary of the employees of that department. 
If a department has no employees, include it in the list with no salary value. Order your results by decreasing salary. 
You may order the NULL-valued salaries however you’d like.
*/
SELECT D.department_name, AVG(E.salary)
FROM departments D LEFT OUTER JOIN employees E 
ON D.department_id = E.department_id
GROUP BY D.department_name
ORDER BY AVG(E.salary) DESC;
/* 27 */