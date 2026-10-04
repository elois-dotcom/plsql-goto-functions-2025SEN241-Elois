-- A3: Illegal GOTO and the fix
SET SERVEROUTPUT ON

-- PART 1: ILLEGAL. GOTO cannot jump INTO an IF / LOOP / CASE block from outside.
-- Expected compile error: PLS-00375: illegal GOTO statement; this label is inside an IF statement
-- (Take your screenshot of this error.)
DECLARE
  v_x NUMBER := 5;
BEGIN
  GOTO inside_if;                 -- jumps into the IF block: NOT allowed
  IF v_x > 0 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Inside the IF block');
  END IF;
END;
/

-- PART 2: FIX. Put the label at the same block level (not inside the IF),
-- and use the IF only to decide whether to jump.
DECLARE
  v_x NUMBER := 5;
BEGIN
  IF v_x > 0 THEN
    GOTO show_message;            -- jumping OUT of an IF to a label in the enclosing block is legal
  END IF;
  DBMS_OUTPUT.PUT_LINE('x is not positive - skipped');
  GOTO done;

  <<show_message>>
  DBMS_OUTPUT.PUT_LINE('x is positive - message shown');

  <<done>>
  NULL;   -- a label must be followed by an executable statement
END;
/
