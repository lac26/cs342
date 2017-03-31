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