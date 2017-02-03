SELECT * from departments;

SELECT COUNT(employee_id) FROM employees;

SELECT employee_id FROM employees WHERE salary > 15000
AND hire_date between '01-Jan-2002' and '01-Jan-2004'
AND phone_number NOT LIKE '%515%';

SELECT employees.first_name || ' ' || employees.last_name 
FROM employees
INNER JOIN departments
ON department_name LIKE 'Finance'
order by last_name;

SELECT city, state_province, country_name
FROM locations, countries, regions
WHERE region_name LIKE 'Asia';

SELECT city
FROM locations
WHERE state_province IS NULL;


