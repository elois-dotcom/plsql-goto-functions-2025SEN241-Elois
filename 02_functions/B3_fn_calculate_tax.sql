-- B3: Progressive monthly PAYE tax (Rwanda-style bands; adjust if your instructor gave other rates)
--   0 - 60,000        : 0%
--   60,001 - 100,000  : 10%
--   100,001 - 200,000 : 20%
--   above 200,000     : 30%
CREATE OR REPLACE FUNCTION fn_calculate_tax (p_monthly_salary IN NUMBER)
  RETURN NUMBER
IS
  v_tax NUMBER := 0;
BEGIN
  IF p_monthly_salary IS NULL THEN
    RETURN NULL;
  END IF;
  IF p_monthly_salary < 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'Salary cannot be negative');
  END IF;

  v_tax := GREATEST(LEAST(p_monthly_salary, 100000) - 60000, 0) * 0.10
         + GREATEST(LEAST(p_monthly_salary, 200000) - 100000, 0) * 0.20
         + GREATEST(p_monthly_salary - 200000, 0)               * 0.30;

  RETURN ROUND(v_tax, 2);
END fn_calculate_tax;
/
SHOW ERRORS
