-- B4: Department name lookup with exception handling
CREATE OR REPLACE FUNCTION fn_dept_name (p_dept_id IN NUMBER)
  RETURN VARCHAR2
IS
  v_name departments.department_name%TYPE;
BEGIN
  SELECT department_name
    INTO v_name
    FROM departments
   WHERE department_id = p_dept_id;
  RETURN v_name;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Unknown Department';
END fn_dept_name;
/
SHOW ERRORS
