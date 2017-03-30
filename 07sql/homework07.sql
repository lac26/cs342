--1

drop view EMPLOYEE_DEPARTMENT;
CREATE VIEW EMPLOYEE_DEPARTMENT
AS SELECT E.employee_id, E.first_name, E.last_name, E.email, E.hire_date, D.department_name
FROM Employees E, Departments D
WHERE E.department_id = D.department_id;

--a
-- newest employee would have the largest hire date
SELECT * FROM (
SELECT first_name, last_name, hire_date
from EMPLOYEE_DEPARTMENT
where department_name = 'Executive'
ORDER BY hire_date DESC
) where ROWNUM = 1;

--b
UPDATE EMPLOYEE_DEPARTMENT
SET department_name = 'Bean Counting'
WHERE department_name = 'Administration';