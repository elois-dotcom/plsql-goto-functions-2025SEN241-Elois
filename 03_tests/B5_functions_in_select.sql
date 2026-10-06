-- B5: Using the functions inside SQL
SET LINESIZE 200
SET PAGESIZE 50
COLUMN full_name FORMAT A22
COLUMN department FORMAT A18

-- Future-dated hire (107) is excluded because fn_years_of_service raises an error for it.
SELECT e.employee_id,
       e.first_name || ' ' || e.last_name        AS full_name,
       fn_dept_name(e.department_id)             AS department,
       e.salary                                  AS monthly_salary,
       fn_annual_salary(e.salary)                AS annual_salary,
       fn_calculate_tax(e.salary)                AS monthly_tax,
       fn_years_of_service(e.hire_date)          AS years_service
  FROM employees e
 WHERE e.hire_date <= SYSDATE
 ORDER BY fn_calculate_tax(e.salary) DESC;      -- function used in ORDER BY too

-- Function used in WHERE
SELECT employee_id, first_name, salary
  FROM employees
 WHERE hire_date <= SYSDATE AND fn_years_of_service(hire_date) >= 5;
