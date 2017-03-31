CREATE VIEW EMPLOYEE_DEPARTMENT AS
SELECT E.employee_id, E.first_name, E.last_name, E.hire_date, D.department_name
FROM Employees E, Departments D
WHERE E.department_id = D.department_id;

--a (did in other file, add here)

--b
UPDATE EMPLOYEE_DEPARTMENT
SET department_name = 'Bean Counting'
WHERE department_name = 'Administration';
--Error: cannot modify a column which maps to a non key-preserved table.  I.e. the table did not have its key column preserved in the join to make the view so cannot update the department name.
--assuming that department_id is the primary key, it would make sense that the table is not key-preserved because did not select department_id when creating the view

--c
UPDATE EMPLOYEE_DEPARTMENT
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel';
--this works, updates first name of employee from Jose Manuel to Manuel

--d
INSERT INTO EMPLOYEE_DEPARTMENT VALUES (x);

