/* a */
SELECT * from departments;

/* b */
SELECT COUNT(employee_id) FROM employees;

/* c */
SELECT employee_id FROM employees WHERE salary > 15000
AND hire_date between '01-Jan-2002' and '01-Jan-2004'
AND phone_number NOT LIKE '%515%';

/* d */
SELECT employees.first_name || ' ' || employees.last_name 
FROM employees
INNER JOIN departments
ON department_name LIKE 'Finance'
order by last_name;

/* e */
SELECT city, state_province, country_name
FROM locations, countries, regions
WHERE region_name LIKE 'Asia';

/* f */
SELECT city
FROM locations
WHERE state_province IS NULL;


