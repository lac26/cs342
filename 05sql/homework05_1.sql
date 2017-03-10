/* 1 */

/* a */
Select E.first_name, E.last_name
FROM EMPLOYEES E JOIN JOB_HISTORY JH ON JH.employee_id = E.employee_id
WHERE end_date IS NOT NULL;


/* b */

Select E.employee_id, E.first_name, E.last_name, M.first_name, M.last_name, M.employee_id, E.hire_date, M.hire_date, E.manager_id
FROM (EMPLOYEES E JOIN EMPLOYEES M ON E.manager_id = M.employee_id) 
WHERE E.hire_date < M.hire_date AND
									 EXISTS (
												SELECT * 
												FROM JOB_HISTORY JH 
												WHERE E.employee_id = JH.employee_id AND JH.department_id = M.department_id
												);


/* c */
/* join */
SELECT DISTINCT country_name
FROM (countries C JOIN locations L ON C.country_id = L.country_id) JOIN Departments D ON D.location_id = L.location_id;

/* nested */

SELECT DISTINCT country_name
FROM Country C
WHERE  
AND EXISTS ( SELECT * 
				FROM Departments D, Locations L
				WHERE D.location_id = L.location_id AND C.country_id = L.country_id

);

