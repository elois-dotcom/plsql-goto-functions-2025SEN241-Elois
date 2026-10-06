-- Tests for B1-B4. Expected values are in the comments.
SET SERVEROUTPUT ON

SELECT fn_annual_salary(500000) AS annual_500k FROM dual;            -- 6000000
SELECT fn_annual_salary(NULL)   AS annual_null FROM dual;            -- NULL

SELECT fn_calculate_tax(50000)  AS tax_50k  FROM dual;               -- 0
SELECT fn_calculate_tax(100000) AS tax_100k FROM dual;               -- 4000
SELECT fn_calculate_tax(200000) AS tax_200k FROM dual;               -- 24000
SELECT fn_calculate_tax(300000) AS tax_300k FROM dual;               -- 54000

SELECT fn_dept_name(10) AS dept_10, fn_dept_name(99) AS dept_99 FROM dual;  -- Finance / Unknown Department

SELECT fn_years_of_service(ADD_MONTHS(SYSDATE, -60)) AS five_years FROM dual;  -- 5

-- Error cases (should be caught, not crash)
BEGIN
  DBMS_OUTPUT.PUT_LINE(fn_calculate_tax(-100));
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Caught: ' || SQLERRM);          -- ORA-20003
END;
/
BEGIN
  DBMS_OUTPUT.PUT_LINE(fn_years_of_service(SYSDATE + 30));
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('Caught: ' || SQLERRM);          -- ORA-20002
END;
/
