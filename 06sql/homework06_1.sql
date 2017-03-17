--a
SELECT * FROM (
SELECT M.employee_id, M.first_name, M.last_name, COUNT(*)
FROM employees M, employees E
WHERE E.manager_id = M.employee_id 
GROUP BY M.employee_id, M.first_name, M.last_name
ORDER BY COUNT(*) DESC)
where ROWNUM <= 10;



--b 
SELECT D.department_name, COUNT(*) AS Number_Employees, SUM(E.salary) AS Salary_Sum
FROM departments D, employees E, locations L, countries C
WHERE E.department_id = D.department_id 
AND D.location_id = L.location_id 
AND L.country_id = C.country_id
AND C.country_name <> 'United States of America'
GROUP BY D.department_name
HAVING COUNT(*) < 100;


--c
SELECT D.department_name AS dept_name, M.first_name AS firstName, M.last_name AS lastName, J.job_title
FROM departments D LEFT OUTER JOIN 
(employees M JOIN jobs J
ON M.job_id = J.job_id ) 
ON D.manager_id = M.employee_id;

--d 
SELECT D.department_name, AVG(E.salary)
FROM departments D LEFT OUTER JOIN employees E 
ON D.department_id = E.department_id
GROUP BY D.department_name
ORDER BY AVG(E.salary) DESC;