-- Setup: DEPARTMENTS and EMPLOYEES tables with sample data (salaries are MONTHLY, in RWF)
-- Constraints are deliberately light so we can insert "bad" rows to test the payroll validator.

BEGIN EXECUTE IMMEDIATE 'DROP TABLE employees PURGE';   EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE departments PURGE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE departments (
  department_id   NUMBER PRIMARY KEY,
  department_name VARCHAR2(50) NOT NULL
);

CREATE TABLE employees (
  employee_id   NUMBER PRIMARY KEY,
  first_name    VARCHAR2(50) NOT NULL,
  last_name     VARCHAR2(50) NOT NULL,
  salary        NUMBER(12,2),
  hire_date     DATE,
  department_id NUMBER
);

INSERT INTO departments VALUES (10, 'Finance');
INSERT INTO departments VALUES (20, 'IT');
INSERT INTO departments VALUES (30, 'Human Resources');
INSERT INTO departments VALUES (40, 'Marketing');

-- Valid employees
INSERT INTO employees VALUES (101, 'Alice',   'Uwase',      850000, DATE '2018-03-15', 10);
INSERT INTO employees VALUES (102, 'Jean',    'Habimana',   450000, DATE '2020-07-01', 20);
INSERT INTO employees VALUES (103, 'Grace',   'Mukamana',   180000, DATE '2023-01-10', 30);
INSERT INTO employees VALUES (104, 'Eric',    'Niyonzima',   55000, DATE '2024-05-20', 20);
INSERT INTO employees VALUES (105, 'Diane',   'Ingabire',   320000, DATE '2019-11-05', 10);
-- Deliberately invalid employees (for C1 testing)
INSERT INTO employees VALUES (106, 'Patrick', 'Nsabimana',       0, DATE '2022-02-02', 10);   -- zero salary
INSERT INTO employees VALUES (107, 'Claire',  'Uwimana',    400000, SYSDATE + 180,       20);   -- future hire date
INSERT INTO employees VALUES (108, 'Samuel',  'Mugisha',    275000, DATE '2021-09-09', 99);   -- dept does not exist
INSERT INTO employees VALUES (109, 'Aline',   'Kayitesi',   500000, DATE '2021-04-12', NULL); -- no dept

COMMIT;
