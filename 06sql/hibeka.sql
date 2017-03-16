SELECT * FROM (
SELECT M.employee_id, M.first_name, M.last_name, COUNT(*)
FROM employees M, employees E
WHERE E.manager_id = M.employee_id 
GROUP BY M.employee_id, M.first_name, M.last_name
ORDER BY COUNT(*) DESC)
where ROWNUM <= 10;