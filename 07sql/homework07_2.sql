--2.
drop view EMPLOYEE_DEPARTMENT;

CREATE materialized VIEW EMPLOYEE_DEPARTMENT for update
AS SELECT E.employee_id, E.first_name, E.last_name, E.email, E.hire_date, D.department_name
FROM employees E, departments D
WHERE E.department_id = D.department_id;

--a
SELECT * FROM (
SELECT first_name, last_name, hire_date
from EMPLOYEE_DEPARTMENT
where department_name = 'Executive'
ORDER BY hire_date DESC
) where ROWNUM = 1;


--cannot do any of the updates because the materialized view is read-only:
--b
UPDATE EMPLOYEE_DEPARTMENT
SET department_name = 'Bean Counting'
WHERE department_name = 'Administration';
--'data manipulation operation not legal on this view'

--c
UPDATE EMPLOYEE_DEPARTMENT
SET first_name = 'Manuel'
WHERE first_name = 'Jose Manuel';
--'data manipulation operation not legal on this view'

--d
INSERT INTO EMPLOYEE_DEPARTMENT VALUES ('207', 'lydia', 'cupery', 'lydiaSuperDuperCuper@gmail.com', '10-AUG-2015', 'Shipping');
--'data manipulation operation not legal on this view'