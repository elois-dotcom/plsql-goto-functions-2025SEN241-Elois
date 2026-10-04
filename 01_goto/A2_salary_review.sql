-- A2: Salary Review using GOTO
-- Rule: salary < 300,000 -> 10% raise; 300,000-599,999 -> 5% raise; >= 600,000 -> no raise
SET SERVEROUTPUT ON

DECLARE
  v_emp_id     employees.employee_id%TYPE := 102;   -- try 101, 103, 104
  v_name       VARCHAR2(101);
  v_salary     employees.salary%TYPE;
  v_new_salary NUMBER;
BEGIN
  SELECT first_name || ' ' || last_name, salary
    INTO v_name, v_salary
    FROM employees
   WHERE employee_id = v_emp_id;

  DBMS_OUTPUT.PUT_LINE('Employee: ' || v_name || ' | Current salary: ' || v_salary);

  IF v_salary < 300000 THEN
    GOTO high_raise;
  ELSIF v_salary < 600000 THEN
    GOTO medium_raise;
  ELSE
    GOTO no_raise;
  END IF;

  <<high_raise>>
  v_new_salary := v_salary * 1.10;
  DBMS_OUTPUT.PUT_LINE('Recommendation: 10% raise');
  GOTO finish;

  <<medium_raise>>
  v_new_salary := v_salary * 1.05;
  DBMS_OUTPUT.PUT_LINE('Recommendation: 5% raise');
  GOTO finish;

  <<no_raise>>
  v_new_salary := v_salary;
  DBMS_OUTPUT.PUT_LINE('Recommendation: no raise');

  <<finish>>
  DBMS_OUTPUT.PUT_LINE('Proposed salary: ' || v_new_salary);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_id || ' not found.');
END;
/
