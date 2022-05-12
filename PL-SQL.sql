declare
fname varchar(35);
lname varchar(35);
snum number :=&in;
begin 
select first_name, last_name
into fname,lname
from student 

where student_id=snum;

DBMS_OUTPUT.PUT_LINE('MY NAME IS : '|| fname||' '||lname);

end ;
/


BEGIN
   DBMS_OUTPUT.PUT_LINE ('Today is '||'&&sv_day');
   DBMS_OUTPUT.PUT_LINE ('Tomorrow will be '||'&sv_day');
END; 
/



DECLARE
   v_date DATE := SYSDATE;
BEGIN
   DBMS_OUTPUT.PUT_LINE (''||to_char(v_date,'YYYY-DD')||'');
END;
/  


<<s1>>
declare
var number :=1;
begin 
DBMS_output.put_line('s1: '||var);
<<s2>>
declare
var number :=2;
begin 
DBMS_output.put_line('s2: '||var||' s1: '||s1.var);
end s2;
end s1;
/


BEGIN
   SELECT MAX(student_id)
     INTO v_max_id
     FROM student;
   INSERT into student
      (student_id, last_name, zip,
       created_by, created_date,
       modified_by, modified_date,
       registration_date
      )
     VALUES (v_max_id + 1, 'Rosenzweig',
             11238, 'BROSENZ ', '01-JAN-2014',
             'BROSENZ', '10-JAN-2014', '15-FEB-2014'
            );
END; 




-- For Example ch05_3b.sql
DECLARE
   v_final_grade  NUMBER := &sv_final_grade;
   v_letter_grade CHAR(1); 
BEGIN
   CASE v_final_grade
      WHEN 90 
      THEN 
         v_letter_grade := 'A';
      WHEN 80 
      THEN 
         v_letter_grade := 'B';
      WHEN 70 
      THEN 
         v_letter_grade := 'C';
      WHEN 60 
      THEN 
         v_letter_grade := 'D';
      ELSE 
         v_letter_grade := 'F';
   END CASE;
   -- control resumes here
   DBMS_OUTPUT.PUT_LINE ('Final grade is: '||v_final_grade);
   DBMS_OUTPUT.PUT_LINE ('Letter grade is: '||v_letter_grade);
END;
/



-- For Example ch04_5a.sql
DECLARE
   v_letter CHAR(1) := '&sv_letter';
BEGIN
   IF (v_letter >= 'A' AND v_letter <= 'Z') OR 
      (v_letter >= 'a' AND v_letter <= 'z') 
   THEN 
      DBMS_OUTPUT.PUT_LINE ('This is a letter');
   
   ELSIF (v_letter >= '0' AND v_letter <= '9')
   THEN
      DBMS_OUTPUT.PUT_LINE ('This is a number --ELSIF');
   ELSE 

      IF v_letter NOT BETWEEN '0' and '9' 
      THEN
         DBMS_OUTPUT.PUT_LINE ('This is a number');
      ELSE
         DBMS_OUTPUT.PUT_LINE ('This is not a number');
      END IF;
   END IF;
END;
/




-- For Example ch06_1a.sql
DECLARE
   v_counter BINARY_INTEGER := 0; 
BEGIN
   LOOP
      -- increment loop counter by one
      v_counter := v_counter + 1;
      DBMS_OUTPUT.PUT_LINE ('v_counter = '||v_counter); 

      -- if exit condition yields TRUE exit the loop
      IF v_counter = 5 
      THEN 
         EXIT;
      END IF;
       
   END LOOP;
   -- control resumes here
   DBMS_OUTPUT.PUT_LINE ('Done…');
END;


DECLARE
   v_counter BINARY_INTEGER := 0; 
BEGIN
   LOOP
      -- increment loop counter by one
      v_counter := v_counter + 1;
      DBMS_OUTPUT.PUT_LINE ('v_counter = '||v_counter); 

      -- if exit condition yields TRUE exit the loop
      EXIT WHEN v_counter = 5;
   END LOOP;
   -- control resumes here
   DBMS_OUTPUT.PUT_LINE ('Done…');
END;


-- For Example ch06_2c.sql
DECLARE
   v_counter NUMBER := 1;
BEGIN
   WHILE v_counter < 5 
   LOOP
      DBMS_OUTPUT.PUT_LINE ('v_counter = '||v_counter);
      
      -- increment the value of v_counter by one
      v_counter := v_counter + 1;
  END LOOP;
END;

-- For Example ch06_4a.sql
BEGIN
   FOR v_counter IN 1..5 
   LOOP
      DBMS_OUTPUT.PUT_LINE ('v_counter = '||v_counter);
   END LOOP;
END;



-- For Example ch06_5a.sql
BEGIN
   FOR v_counter IN REVERSE 1..5 
   LOOP
      DBMS_OUTPUT.PUT_LINE ('v_counter = '||v_counter);
   END LOOP;
END;

BEGIN
   FOR v_counter IN 1..5 
   LOOP
      DBMS_OUTPUT.PUT_LINE ('v_counter = '||v_counter);
      EXIT WHEN v_counter = 3;
   END LOOP;
END;



-- For Example ch06_8b.sql
DECLARE
   v_counter BINARY_INTEGER := 0; 
BEGIN
   LOOP
      -- increment loop counter by two
      v_counter := v_counter + 1;

      -- determine whether v_counter is even or odd
      CASE
         WHEN MOD(v_counter, 2) = 0
         THEN
            DBMS_OUTPUT.PUT_LINE (v_counter||' is even');
         ELSE
            DBMS_OUTPUT.PUT_LINE (v_counter||' is odd');
         END CASE;

      -- if EXIT WHEN condition yields TRUE exit the loop
      EXIT WHEN v_counter = 10;
   END LOOP;
   
   -- control resumes here
   DBMS_OUTPUT.PUT_LINE ('Done…');
END;
/




-- For Example ch08_3a.sql
DECLARE
   v_student_id NUMBER      := &sv_student_id;
   v_enrolled   VARCHAR2(3) := 'NO';
BEGIN
   DBMS_OUTPUT.PUT_LINE ('Check if the student is enrolled');
   SELECT 'YES'
     INTO v_enrolled
     FROM enrollment
    WHERE student_id = v_student_id;
   
    DBMS_OUTPUT.PUT_LINE ('The student is enrolled into one course'); 
EXCEPTION
   WHEN NO_DATA_FOUND 
   THEN
      DBMS_OUTPUT.PUT_LINE ('The student is not enrolled');

   WHEN TOO_MANY_ROWS 
   THEN
       DBMS_OUTPUT.PUT_LINE ('The student is enrolled in multiple courses');

   WHEN VALUE_ERROR OR INVALID_NUMBER 
   THEN
      DBMS_OUTPUT.PUT_LINE ('An error has occurred');
END;

NO_DATA_FOUND / TOO_MANY_ROWS / ZERO_DIVIDE / OTHERS / PROGRAM_ERROR / VALUE_ERROR / DUP_VALUE_ON_INDEX

INVALID_NUMBER

-- 
DECLARE
exception_name EXCEPTION;
BEGIN
…
IF CONDITION
THEN
RAISE exception_name;
END IF;
…
EXCEPTION
WHEN exception_name
THEN
ERROR-PROCESSING STATEMENTS;
END;


<<outer_block>>
DECLARE
e_exception1 EXCEPTION;
e_exception2 EXCEPTION;
BEGIN
<<inner_block>>
BEGIN
RAISE e_exception1;
EXCEPTION
WHEN e_exception1
THEN
RAISE e_exception2;
WHEN e_exception2
THEN
DBMS_OUTPUT.PUT_LINE (‘An error has occurred in the inner block’);
END;
EXCEPTION
WHEN e_exception2
THEN
DBMS_OUTPUT.PUT_LINE (‘An error has occurred in the program’);
END;



DECLARE
e_exception1 EXCEPTION;
BEGIN
RAISE e_exception1;
END;
ORA-06510: PL/SQL: unhandled user-defined exception
ORA-06512: at line 4



<<outer_block>>
DECLARE
e_exception EXCEPTION;
BEGIN
<<inner_block>>
BEGIN
RAISE e_exception;
EXCEPTION
WHEN e_exception
THEN
RAISE;
END;
EXCEPTION
WHEN e_exception
THEN
DBMS_OUTPUT.PUT_LINE (‘An error has occurred’);
END;

----------------------
SET SERVEROUTPUT ON
BEGIN
UPDATE student
SET first_name = ‘B’
WHERE first_name LIKE ‘B%’;
DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
END;


----
SET SERVEROUTPUT ON
DECLARE
   v_city zipcode.city%TYPE;
BEGIN
   SELECT 'COLUMBUS'
     INTO v_city
     FROM dual;
   UPDATE zipcode
      SET city = v_city
    WHERE ZIP = 43224;
END; 
-----

<record_name> <table_name or cursor_name>%ROWTYPE
------

SET SERVEROUTPUT ON
DECLARE
   vr_student student%ROWTYPE;
BEGIN
   SELECT *
     INTO vr_student
     FROM student
    WHERE student_id = 156;
   DBMS_OUTPUT.PUT_LINE (vr_student.first_name||' '
      ||vr_student.last_name||' has an ID of 156');
EXCEPTION
   WHEN no_data_found
      THEN
           RAISE_APPLICATION_ERROR(-2001,'The Student '||
            'is not in the database');
END; 



-------------
DECLARE
CURSOR c_student_name IS
SELECT first_name, last_name
FROM student;
vr_student_name c_student_name%ROWTYPE;

------------



DECLARE
   CURSOR c_student_name IS
      SELECT first_name, last_name
        FROM student
       WHERE rownum <= 5;
   vr_student_name c_student_name%ROWTYPE;
BEGIN
   OPEN c_student_name;
   LOOP
      FETCH c_student_name INTO vr_student_name;
      EXIT WHEN c_student_name%NOTFOUND;
   DBMS_OUTPUT.PUT_LINE('Student name: '||
      vr_student_name.first_name||' ' 
      ||vr_student_name.last_name);

   END LOOP;
   CLOSE c_student_name;
   DBMS_OUTPUT.PUT_LINE('Student name: '||
      vr_student_name.first_name||' ' 
      ||vr_student_name.last_name);
END;
/



-------------------
cursorname%NOTFOUND / cursorname%FOUND / cursorname%ROWCOUNT / Cursorname%ISOPEN
-----------

--For Example?ch11_7.sql
DECLARE
   CURSOR c_student IS
      SELECT student_id, last_name, first_name
        FROM student
       WHERE student_id < 110;
BEGIN
   FOR r_student IN c_student
   LOOP
      INSERT INTO table_log
         VALUES(r_student.last_name);
   END LOOP;
END;


--------------
-- For Example ch11_9.sql
SET SERVEROUTPUT ON
    DECLARE
       v_zip zipcode.zip%TYPE;
       v_student_flag CHAR;
       CURSOR c_zip IS
          SELECT zip, city, state
            FROM zipcode
           WHERE state = 'CT';
       CURSOR c_student IS
          SELECT first_name, last_name
            FROM student
           WHERE zip = v_zip;
    BEGIN
       FOR r_zip IN c_zip
       LOOP
          v_student_flag := 'N';
          v_zip := r_zip.zip;
          DBMS_OUTPUT.PUT_LINE(CHR(10));
          DBMS_OUTPUT.PUT_LINE('Students living in '||
             r_zip.city);
          FOR r_student in c_student
          LOOP
             DBMS_OUTPUT.PUT_LINE(
                r_student.first_name||
                ' '||r_student.last_name);
             v_student_flag := 'Y';
          END LOOP;
          IF v_student_flag = 'N'
             THEN
             DBMS_OUTPUT.PUT_LINE
            ('No Students for this zipcode');
          END IF;
       END LOOP;
  END; 

------------------


CREATE [OR REPLACE] [EDITIONABLE|NONEDITIONABLE] TRIGGER trigger_name
{BEFORE|AFTER} triggering_event ON table_name
[FOR EACH ROW]
[FOLLOWS|PRECEDES another_trigger]
[ENABLE/DISABLE]
[WHEN condition]
DECLARE
Declaration statements
BEGIN
Executable statements
EXCEPTION
Exception-handling statements
END;


ALTER TRIGGER trigger_name DISABLE;





-------


-- For Example ch13_1a.sql
CREATE OR REPLACE TRIGGER student_bi
BEFORE INSERT ON STUDENT
FOR EACH ROW
BEGIN
   :NEW.student_id    := STUDENT_ID_SEQ.NEXTVAL;
   :NEW.created_by    := USER;
   :NEW.created_date  := SYSDATE;
   :NEW.modified_by   := USER;
   :NEW.modified_date := SYSDATE;
END;


-- For Example ch13_2b.sql
CREATE OR REPLACE TRIGGER instructor_aud
AFTER UPDATE OR DELETE ON INSTRUCTOR
DECLARE
   v_trans_type VARCHAR2(10); 
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   v_trans_type := CASE
                      WHEN UPDATING THEN 'UPDATE'
                      WHEN DELETING THEN 'DELETE'
                    END;
   
   INSERT INTO audit_trail 
      (TABLE_NAME, TRANSACTION_NAME, TRANSACTION_USER, TRANSACTION_DATE)
   VALUES 
      ('INSTRUCTOR', v_trans_type, USER, SYSDATE);
   COMMIT;
END; 

-----------------


-- For Example ch13_4a.sql
CREATE VIEW course_cost 
AS
   SELECT course_no, description, cost
     FROM course;

-- For Example ch13_5a.sql
UPDATE course_cost
   SET cost = 2000
 WHERE course_no = 450;


 ------------------

 -- For Example ch13_6a.sql
CREATE VIEW instructor_summary_view 
AS
   SELECT i.instructor_id, COUNT(s.section_id) total_courses
     FROM instructor i
     LEFT OUTER JOIN section s 
       ON (i.instructor_id = s.instructor_id)
   GROUP BY i.instructor_id;

-- For Example ch13_7b.sql
CREATE OR REPLACE TRIGGER instructor_summary_del
INSTEAD OF DELETE ON instructor_summary_view
FOR EACH ROW
BEGIN
   DELETE FROM section
    WHERE instructor_id = :OLD.INSTRUCTOR_ID;
   DELETE FROM instructor
    WHERE instructor_id = :OLD.INSTRUCTOR_ID;
END;









