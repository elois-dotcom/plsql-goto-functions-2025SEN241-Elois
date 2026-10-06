-- Tests for C1: validate every employee
SET LINESIZE 200
COLUMN result FORMAT A80

SELECT employee_id, fn_validate_payroll(employee_id) AS result
  FROM employees
 ORDER BY employee_id;

-- Non-existent employee
SELECT fn_validate_payroll(999) AS result FROM dual;
-- Expected: 101-105 VALID; 106 zero salary; 107 future hire date; 108 dept missing; 109 no dept; 999 not found
