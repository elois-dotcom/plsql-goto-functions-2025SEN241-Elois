-- C1: Payroll validator. Returns 'VALID ...' or 'INVALID: <reason>'.
-- Uses fn_dept_name and fn_calculate_tax, so run B3 and B4 first.
CREATE OR REPLACE FUNCTION fn_validate_payroll (p_emp_id IN NUMBER)
  RETURN VARCHAR2
IS
  v_salary    employees.salary%TYPE;
  v_hire_date employees.hire_date%TYPE;
  v_dept_id   employees.department_id%TYPE;
  v_dept_name VARCHAR2(50);
  v_tax       NUMBER;
BEGIN
  SELECT salary, hire_date, department_id
    INTO v_salary, v_hire_date, v_dept_id
    FROM employees
   WHERE employee_id = p_emp_id;

  IF v_salary IS NULL OR v_salary <= 0 THEN
    RETURN 'INVALID: salary must be greater than 0';
  END IF;

  IF v_hire_date IS NULL OR v_hire_date > SYSDATE THEN
    RETURN 'INVALID: hire date is missing or in the future';
  END IF;

  IF v_dept_id IS NULL THEN
    RETURN 'INVALID: no department assigned';
  END IF;

  v_dept_name := fn_dept_name(v_dept_id);
  IF v_dept_name = 'Unknown Department' THEN
    RETURN 'INVALID: department ' || v_dept_id || ' does not exist';
  END IF;

  v_tax := fn_calculate_tax(v_salary);
  RETURN 'VALID: ' || v_dept_name || ', tax ' || v_tax || ', net ' || (v_salary - v_tax);

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'INVALID: employee ' || p_emp_id || ' not found';
  WHEN OTHERS THEN
    RETURN 'ERROR: ' || SQLERRM;
END fn_validate_payroll;
/
SHOW ERRORS
