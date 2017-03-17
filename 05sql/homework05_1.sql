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
/* joined */
SELECT DISTINCT country_name
FROM (countries C JOIN locations L ON C.country_id = L.country_id) JOIN Departments D ON D.location_id = L.location_id;

/* nested */
select distinct C.country_name from Countries C where C.country_id IN
  (select L.country_id from Locations L where L.location_id IN
    (select D.location_id from Departments D));
    
/* when dealing with large sets of data, it makes more sense to use to use the JOIN because instead of first getting
all of the say distinct country names and then seeing if a matching location exists and then seeing if a matcing department exists for each country,
it joins the country initially. 
However, I did some reading online that says Oracle simply rewrites the subquery as a join.  If this is the case,
then it would not matter how you wrote it as it would be executed the same anyway.
*/
    


