-- ManagerUSER 
alter session set "_oracle_script"=true;
CREATE USER ManagerUser IDENTIFIED BY 123  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER USER_1 QUOTA UNLIMITED ON "USERS";

-- SYSTEM PRIVILEGES
GRANT CREATE SESSION TO ManagerUser WITH ADMIN OPTION;
GRANT CREATE TABLE TO ManagerUser;
GRANT CREATE USER TO ManagerUser WITH ADMIN OPTION;
GRANT DROP USER TO ManagerUser WITH ADMIN OPTION;
GRANT ALTER USER TO ManagerUser WITH ADMIN OPTION;
GRANT CREATE ANY TABLE TO ManagerUser;
GRANT CREATE SESSION, CREATE TABLE, GRANT ANY PRIVILEGE TO ManagerUser;


GRANT REFERENCES ON USER_1.STUDENTS TO ManagerUser;
GRANT REFERENCES ON USER_1.COURCES TO ManagerUser;

GRANT SELECT ANY TABLE TO ManagerUser;
GRANT INSERT ANY TABLE TO ManagerUser;
GRANT UPDATE ANY TABLE TO ManagerUser;
GRANT DELETE ANY TABLE TO ManagerUser;
GRANT CREATE PROCEDURE TO ManagerUser;
GRANT EXECUTE ON exam_schedule TO ManagerUser;
GRANT INSERT , DELETE , UPDATE ,SELECT ON USER_1.COURCES  TO ManagerUser;
GRANT CREATE TRIGGER TO ManagerUser;

-- ManagerUser 


alter session set "_oracle_script"=true;
DROP USER USER_2 CASCADE ;


--9. User Management and Privileges 
--Create User_1
alter session set "_oracle_script"=true;
CREATE USER USER_1 IDENTIFIED BY 123;
GRANT CREATE SESSION, CREATE TABLE TO USER_1;
GRANT REFERENCES (id) ON ManagerUser.PROFFERSSORS  TO USER_1;
GRANT INSERT , DELETE , UPDATE ,SELECT ON ManagerUser.REGISTERATION  TO User_1;
ALTER USER ManagerUser QUOTA UNLIMITED ON USERS;

--Create User_2
alter session set "_oracle_script"=true;
CREATE USER User__2 IDENTIFIED BY 222;
GRANT CREATE SESSION, CREATE TABLE TO User__2;

GRANT INSERT ON User_1.STUDENTS TO User__2;
GRANT INSERT ON User_1.COURCES TO User__2;
GRANT INSERT , DELETE , UPDATE , SELECT ON ManagerUser.REGISTERATION  TO User__2;
GRANT INSERT , DELETE , UPDATE , SELECT ON USER_1.COURCES  TO User__2;
GRANT INSERT , DELETE , UPDATE , SELECT ON USER_1.STUDENTS  TO User__2;


// CREATE THE TABLES                  
CREATE TABLE ManagerUser.PROFFERSSORS (ID  NUMBER PRIMARY KEY
                            , PROFF_NAME VARCHAR(50) NOT NULL 
                            , DEPARTMENT NVARCHAR2(50));
                            
CREATE TABLE ManagerUser.AuditTrail (ID NUMBER PRIMARY KEY,
                        NAME VARCHAR(50) NOT NULL 
                        , OPERATION NVARCHAR2(50) 
                        , OLD_DATA NVARCHAR2(50) 
                        ,NEW_DATA NVARCHAR2(50) 
                        , timestamp DATE DEFAULT SYSDATE);

CREATE TABLE ManagerUser.WARNINGS (ID  NUMBER PRIMARY KEY,
                        SID INT ,
                        WARNING_RESSON NVARCHAR2(150),
                        WARNING_DATE DATE ,
                        FOREIGN KEY (SID) REFERENCES  USER_1.STUDENTS (ID) );
                        
                      
CREATE TABLE ManagerUser.REGISTERATION (ID  NUMBER PRIMARY KEY,
                        SID INT ,
                        COURSEID INT ,
                        FOREIGN KEY (SID) REFERENCES  USER_1.STUDENTS (ID) ,
                        FOREIGN KEY (COURSEID) REFERENCES  USER_1.COURCES (ID));


CREATE TABLE ManagerUser.EXAMES (ID NUMBER PRIMARY KEY,
                     COURCEID INT ,
                     EXAME_TYPE NVARCHAR2(50),
                     EXAME_DATE DATE ,
                    FOREIGN KEY (COURCEID) REFERENCES  USER_1.COURCES(ID));
                    
CREATE TABLE ManagerUser.EXAMERESULT (ID NUMBER PRIMARY KEY,
                          REG_ID INT ,
                          GRADE NVARCHAR2(50) ,
                          STATUS NVARCHAR2(50) CHECK (STATUS IN ('PASS' , 'FAIL')),
                          FOREIGN KEY (REG_ID) REFERENCES ManagerUser.REGISTERATION (ID) );
                          




-- User_1 Tables 

CREATE TABLE STUDENTS (ID NUMBER PRIMARY KEY,
                        NAME VARCHAR2(50) NOT NULL,
                        ACADEMIC_STATUS NVARCHAR2(50),
                         TOTAL_CREDITS INT);
                         
CREATE TABLE COURCES (ID  NUMBER PRIMARY KEY,
                        NAME VARCHAR(50) NOT NULL ,
                        PROFF_ID INT ,
                        CREDIT_HOURSE INT ,
                        prerequisite_course_id INT ,
                        FOREIGN KEY (PROFF_ID) REFERENCES ManagerUser.PROFFERSSORS(ID)) ; 
                        
                        
-- USER 2 :insertions   
-- insert into student 

INSERT INTO USER_1.STUDENTS (ID, NAME, ACADEMIC_STATUS, TOTAL_CREDITS)
VALUES (1, 'esraa', 'Active', 30);

INSERT INTO USER_1.STUDENTS (ID, NAME, ACADEMIC_STATUS, TOTAL_CREDITS)
VALUES (2, 'malak', 'Inactive', 20);

INSERT INTO USER_1.STUDENTS (ID, NAME, ACADEMIC_STATUS, TOTAL_CREDITS)
VALUES (3, 'sondos', 'Active', 25);

INSERT INTO USER_1.STUDENTS (ID, NAME, ACADEMIC_STATUS, TOTAL_CREDITS)
VALUES (4, 'rehab', 'Inactive', 15);

INSERT INTO USER_1.STUDENTS (ID, NAME, ACADEMIC_STATUS, TOTAL_CREDITS)
VALUES (5, 'malak', 'Active', 22);

INSERT INTO USER_1.STUDENTS (ID, NAME, ACADEMIC_STATUS, TOTAL_CREDITS)
VALUES ((SELECT MAX(ID) FROM USER_1.STUDENTS)+1, 'AHMED', 'Active', 30);

-- insert into courses

INSERT INTO USER_1.COURCES (ID, NAME, PROFF_ID, CREDIT_HOURSE, prerequisite_course_id)
VALUES (1, 'Database Systems', 1, 3, NULL);

INSERT INTO USER_1.COURCES (ID, NAME, PROFF_ID, CREDIT_HOURSE, prerequisite_course_id)
VALUES (2, 'Mathematics', 2, 4, 1);

INSERT INTO USER_1.COURCES (ID, NAME, PROFF_ID, CREDIT_HOURSE, prerequisite_course_id)
VALUES (3, 'Physics', 3, 3,1);

INSERT INTO USER_1.COURCES (ID, NAME, PROFF_ID, CREDIT_HOURSE, prerequisite_course_id)
VALUES (4, 'Biology', 4, 5, 2);

INSERT INTO USER_1.COURCES (ID, NAME, PROFF_ID, CREDIT_HOURSE, prerequisite_course_id)
VALUES (5, 'Chemistry', 5, 4, 1);

INSERT INTO USER_1.COURCES (ID, NAME, PROFF_ID, CREDIT_HOURSE, prerequisite_course_id)
VALUES ((SELECT MAX(ID) FROM USER_1.COURCES)+1, 'DB_2', 5, 4, 1);

INSERT INTO USER_1.COURCES (ID, NAME, PROFF_ID, CREDIT_HOURSE, prerequisite_course_id)
VALUES ((SELECT MAX(ID) FROM USER_1.COURCES)+1, 'AI', 5, 10, 1);

-- ManagerUser insertion
-- insert into PROFFERSSORS table
INSERT INTO ManagerUser.PROFFERSSORS (ID, PROFF_NAME, DEPARTMENT)
VALUES (1, 'esraa samir', 'Computer Science');

INSERT INTO ManagerUser.PROFFERSSORS (ID, PROFF_NAME, DEPARTMENT)
VALUES (2, 'malak sayed', 'Physics');

INSERT INTO ManagerUser.PROFFERSSORS (ID, PROFF_NAME, DEPARTMENT)
VALUES (3, 'sondos baker', 'Mathematics');

INSERT INTO ManagerUser.PROFFERSSORS (ID, PROFF_NAME, DEPARTMENT)
VALUES (4, 'rehab hamdy', 'Biology');

INSERT INTO ManagerUser.PROFFERSSORS (ID, PROFF_NAME, DEPARTMENT)
VALUES (5, 'salma nour eldeen', 'Chemistry');


-- insert into AuditTrail
INSERT INTO ManagerUser.AuditTrail (ID, NAME, OPERATION, OLD_DATA, NEW_DATA)
VALUES (1, 'Admin', 'INSERT', NULL, 'Initial data for Admin');

INSERT INTO ManagerUser.AuditTrail (ID, NAME, OPERATION, OLD_DATA, NEW_DATA)
VALUES (2, 'User_1', 'UPDATE', 'Old information', 'Updated information');

INSERT INTO ManagerUser.AuditTrail (ID, NAME, OPERATION, OLD_DATA, NEW_DATA)
VALUES (3, 'User_2', 'DELETE', 'Some data', 'Deleted data');

INSERT INTO ManagerUser.AuditTrail (ID, NAME, OPERATION, OLD_DATA, NEW_DATA)
VALUES (4, 'ManagerUser', 'INSERT', NULL, 'Initial setup data');

INSERT INTO ManagerUser.AuditTrail (ID, NAME, OPERATION, OLD_DATA, NEW_DATA)
VALUES (5, 'System', 'MODIFY', 'Old status', 'Changed status');



-- insert into warning 
INSERT INTO ManagerUser.WARNINGS (ID, SID, WARNING_RESSON, WARNING_DATE)
VALUES (1, 1, 'Late submission', TO_DATE('2024-12-15', 'YYYY-MM-DD'));

INSERT INTO ManagerUser.WARNINGS (ID, SID, WARNING_RESSON, WARNING_DATE)
VALUES (2, 2, 'Poor grades', TO_DATE('2024-12-16', 'YYYY-MM-DD'));

INSERT INTO ManagerUser.WARNINGS (ID, SID, WARNING_RESSON, WARNING_DATE)
VALUES (3, 3, 'Absence without leave', TO_DATE('2024-12-17', 'YYYY-MM-DD'));

INSERT INTO ManagerUser.WARNINGS (ID, SID, WARNING_RESSON, WARNING_DATE)
VALUES (4, 4, 'Late registration', TO_DATE('2024-12-18', 'YYYY-MM-DD'));

INSERT INTO ManagerUser.WARNINGS (ID, SID, WARNING_RESSON, WARNING_DATE)
VALUES (5, 5, 'Incomplete course work', TO_DATE('2024-12-19', 'YYYY-MM-DD'));



-- insert into REGISTERATION
INSERT INTO ManagerUser.REGISTERATION (ID, SID, COURSEID)
VALUES (1, 1, 1);

INSERT INTO ManagerUser.REGISTERATION (ID, SID, COURSEID)
VALUES (2, 2, 2);

INSERT INTO ManagerUser.REGISTERATION (ID, SID, COURSEID)
VALUES (3, 3, 3);

INSERT INTO ManagerUser.REGISTERATION (ID, SID, COURSEID)
VALUES (4, 4, 4);

INSERT INTO ManagerUser.REGISTERATION (ID, SID, COURSEID)
VALUES (5, 5, 5);

INSERT INTO ManagerUser.REGISTERATION (ID, SID, COURSEID)
VALUES ((SELECT MAX(ID) FROM ManagerUser.REGISTERATION)+1, 6, 6);

INSERT INTO ManagerUser.REGISTERATION (ID, SID, COURSEID)
VALUES ((SELECT MAX(ID) FROM ManagerUser.REGISTERATION)+1, 6, 7);

SELECT * FROM ManagerUser.REGISTERATION;
-- insert EXAMERESULT
INSERT INTO ManagerUser.EXAMERESULT (ID, REG_ID, GRADE, STATUS)
VALUES (1, 1, '85', 'PASS');

INSERT INTO ManagerUser.EXAMERESULT (ID, REG_ID, GRADE, STATUS)
VALUES (2, 2, '90', 'PASS');

INSERT INTO ManagerUser.EXAMERESULT (ID, REG_ID, GRADE, STATUS)
VALUES (3, 3, '75', 'FAIL');

INSERT INTO ManagerUser.EXAMERESULT (ID, REG_ID, GRADE, STATUS)
VALUES (4, 4, '88', 'FAIL');

INSERT INTO ManagerUser.EXAMERESULT (ID, REG_ID, GRADE, STATUS)
VALUES (5, 5, '92', 'PASS');

INSERT INTO ManagerUser.EXAMERESULT (ID, REG_ID, GRADE, STATUS)
VALUES ((SELECT MAX(ID) FROM ManagerUser.EXAMERESULT)+1, 11, 20, 'FAIL');

INSERT INTO ManagerUser.EXAMERESULT (ID, REG_ID, GRADE, STATUS)
VALUES ((SELECT MAX(ID) FROM ManagerUser.EXAMERESULT)+1, 12, 30, 'FAIL');


-- insert into EXAMES

INSERT INTO ManagerUser.EXAMES (ID, COURCEID, EXAME_TYPE, EXAME_DATE)
VALUES (1, 2, 'Final Exam', TO_DATE('2024-12-20', 'YYYY-MM-DD'));

INSERT INTO ManagerUser.EXAMES (ID, COURCEID, EXAME_TYPE, EXAME_DATE)
VALUES (2, 3, 'Midterm', TO_DATE('2024-12-21', 'YYYY-MM-DD'));

INSERT INTO ManagerUser.EXAMES (ID, COURCEID, EXAME_TYPE, EXAME_DATE)
VALUES (3, 1, 'Final Exam', TO_DATE('2024-12-22', 'YYYY-MM-DD'));

INSERT INTO ManagerUser.EXAMES (ID, COURCEID, EXAME_TYPE, EXAME_DATE)
VALUES (4, 1, 'Midterm', TO_DATE('2024-12-23', 'YYYY-MM-DD'));

INSERT INTO ManagerUser.EXAMES (ID, COURCEID, EXAME_TYPE, EXAME_DATE)
VALUES (5, 2, 'Final Exam', TO_DATE('2024-12-24', 'YYYY-MM-DD'));




--10. Blocker-Waiting Situation 
--USER1
--lock table     
--USER_1.STUDENTS IN EXCLUSIVE MODE;
UPDATE  USER_1.STUDENTS SET ACADEMIC_STATUS= 'INACTIVE ' WHERE ID =2;

--USER2
INSERT INTO ManagerUser.REGISTERATION (ID,SID,COURSEID ) VALUES (9,2, 5);
COMMIT;

--11. Identifying Blocker and Waiting Sessions 
-- SELECT v$lock
SELECT
    s1.username AS blocker,
    s1.sid AS blocker_sid,
    s1.serial# AS blocker_serial,
    s2.username AS waiter,
    s2.sid AS waiter_sid,
    s2.serial# AS waiter_serial
FROM
    v$lock l1
    JOIN v$session s1 ON l1.sid = s1.sid
    JOIN v$lock l2 ON l1.id1 = l2.id1 AND l1.id2 = l2.id2
    JOIN v$session s2 ON l2.sid = s2.sid
WHERE
    l1.block = 1 AND l2.request > 0


-- SELECT SESSION ID OF BLOCK WAITING
--SELECT
--    SYS_CONTEXT('USERENV', 'SID') AS session_id
--FROM
--    dual;


--12. Deadlock Demonstration
-- USER1

-- SESSION1_BLOCK1
set serveroutput on;
BEGIN
    -- Update a record in the Courses table
    UPDATE USER_1.COURCES SET NAME = 'Advanced Mathematics' WHERE ID = 2;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in User 1 Transaction 1: ' || SQLERRM);
        ROLLBACK;
END;


-- SESSION1_BLOCK2
set serveroutput on;
BEGIN
    -- Update a record in the Register table
    UPDATE ManagerUser.REGISTERATION SET SID = 4 WHERE ID = 2;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in User 1 Transaction 2: ' || SQLERRM);
        ROLLBACK;
      END;  
        
   
 -- USER2
 
 
 -- SESSION2_BLOCK1
 set serveroutput on;
BEGIN
    -- Update a record in the Register table
    UPDATE ManagerUser.REGISTERATION SET SID = 4 WHERE ID = 2;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in User 2 Transaction 1: ' || SQLERRM);
        ROLLBACK;
END;


-- SESSION2_BLOCK2
set serveroutput on;
BEGIN
    -- Update a record in the Courses table
    UPDATE USER_1.COURCES SET NAME = 'Advanced =' WHERE ID = 2;
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in User 2 Transaction 2: ' || SQLERRM);
        ROLLBACK;
END;

-- SELECT * FROM V$LOCK;




-- 6- Exam Schedule Management 
SET SERVEROUTPUT ON;

-- Create or Replace Procedure
CREATE OR REPLACE PROCEDURE exam_schedule (course_id IN NUMBER)
IS
    course_name VARCHAR2(50);
    exam_count INTEGER;
BEGIN
    -- Fetch course name
    SELECT NAME INTO course_name FROM USER_1.COURCES WHERE ID = course_id;

    -- Count exams for the course
    SELECT COUNT(*) INTO exam_count FROM ManagerUser.EXAMES WHERE COURCEID = course_id;

    -- Check exam count and display details
    IF exam_count = 0 THEN 
        dbms_output.put_line('No Exams For Course: ' || course_name); 
    ELSE
        dbms_output.put_line('Schedule of Course: ' || course_name);

        -- Iterate through exams
        FOR exam IN (SELECT EXAME_TYPE, EXAME_DATE FROM ManagerUser.EXAMES WHERE COURCEID = course_id) LOOP
            dbms_output.put_line('Exam Type: ' || exam.EXAME_TYPE);
            dbms_output.put_line('Exam Date: ' || TO_CHAR(exam.EXAME_DATE, 'YYYY-MM-DD'));
        END LOOP;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        dbms_output.put_line('Course Not Found.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error: ' || SQLERRM);
END;

--Show result
EXEC exam_schedule(1)


-- Audit Trail for Registration

CREATE OR REPLACE TRIGGER Audit_Trail_for_Registration
BEFORE INSERT OR DELETE
ON ManagerUser.REGISTERATION
FOR EACH ROW
DECLARE
    beforeInsert VARCHAR2(50);
    beforeDeleting VARCHAR2(50);
BEGIN
    IF INSERTING THEN
        beforeInsert := 'Id ' || :NEW.ID || ' SID ' || :NEW.SID || ' COURSEID ' || :NEW.COURSEID;
        INSERT INTO ManagerUser.AuditTrail (ID,NAME, OPERATION, OLD_DATA, NEW_DATA)
        VALUES ((SELECT MAX(ID)+ 1 FROM ManagerUser.AuditTrail),'REGISTERATION', 'INSERT', NULL, beforeInsert);
    ELSIF DELETING THEN
        beforeDeleting := 'Id ' || :OLD.ID || ' SID ' || :OLD.SID || ' COURSEID ' || :OLD.COURSEID;
        INSERT INTO ManagerUser.AuditTrail (ID,NAME, OPERATION, OLD_DATA, NEW_DATA)
        VALUES ((SELECT MAX(ID)+ 1 FROM ManagerUser.AuditTrail),'DEREGISTERATION', 'DELETE', beforeDeleting, NULL);
    END IF;
END;



INSERT INTO ManagerUser.REGISTERATION (ID,SID,COURSEID ) VALUES (11,3,1);
DELETE FROM ManagerUser.REGISTERATION WHERE ID =11
COMMIT;

SELECT * FROM ManagerUser.EXAMERESULT
SELECT * FROM ManagerUser.REGISTERATION
SELECT * FROM ManagerUser.AuditTrail


SET SERVEROUTPUT ON;
--  5-Course Performance Report 
DECLARE 
    STATUS NVARCHAR2(50);
    COURSEID INT := 1;
    PASS_COUNT INT := 0;
    FAIL_COUNT INT := 0;
    GRADE INT;
    SID INT;

    CURSOR c_course_performance IS
        SELECT E.STATUS, R.SID, E.GRADE
        FROM ManagerUser.EXAMERESULT E
        JOIN ManagerUser.REGISTERATION R ON E.REG_ID = R.ID
        WHERE  R.COURSEID=5;

BEGIN
    OPEN c_course_performance;

    LOOP
        FETCH c_course_performance INTO STATUS, SID, GRADE;
        
        EXIT WHEN c_course_performance%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Student ID: ' || SID || ' - Grade: ' || GRADE || ' - Status: ' || STATUS);
        
        IF STATUS = 'PASS' THEN
            PASS_COUNT := PASS_COUNT + 1;
        ELSIF STATUS = 'FAIL' THEN
            FAIL_COUNT := FAIL_COUNT + 1;
        END IF;
    END LOOP;

    CLOSE c_course_performance;

    DBMS_OUTPUT.PUT_LINE('Performance Report for Course ID: ' || COURSEID);
    DBMS_OUTPUT.PUT_LINE('Number of Students Passed: ' || PASS_COUNT);
    DBMS_OUTPUT.PUT_LINE('Number of Students Failed: ' || FAIL_COUNT);

END;


INSERT INTO ManagerUser.EXAMERESULT (ID, REG_ID, GRADE, STATUS)
VALUES (6, 5, 49, 'FAIL');
INSERT INTO ManagerUser.EXAMERESULT (ID, REG_ID, GRADE, STATUS)
VALUES (7, 5, 47, 'FAIL');
INSERT INTO ManagerUser.EXAMERESULT (ID, REG_ID, GRADE, STATUS)
VALUES (8, 5, 100, 'PASS');
INSERT INTO ManagerUser.EXAMERESULT (ID, REG_ID, GRADE, STATUS)
VALUES (9, 5, 80, 'PASS')
SELECT * FROM ManagerUser.EXAMERESULT;


-- Automated Warning Issuance 


-- [OR replace]: when you run the code more than one time the prosedure will create in the first time only 

CREATE OR REPLACE PROCEDURE IssueWarnings 
IS
BEGIN
    -- Loop for each student with two or more failing grades
    FOR student IN (
        SELECT r.SID, COUNT(*) AS fail_count
        FROM ManagerUser.EXAMERESULT er
        JOIN ManagerUser.REGISTERATION r ON er.REG_ID = r.ID
        WHERE er.STATUS = 'FAIL'
        GROUP BY r.SID
        HAVING COUNT(*) >= 2
    ) LOOP
        -- Insert a warning into the Warnings table
        INSERT INTO ManagerUser.WARNINGS (ID, SID, WARNING_RESSON, WARNING_DATE)
        VALUES (
            (SELECT NVL(MAX(ID), 0) + 1 FROM ManagerUser.WARNINGS), 
            student.SID,
            'Student has received failing grades in two or more courses.',
            SYSDATE  -- Use current date for the warning date
        );
    END LOOP;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;



SET SERVEROUTPUT ON;
EXEC IssueWarnings
SELECT * FROM ManagerUser.WARNINGS


-- 8- Student Suspension Based on Warnings 

CREATE OR REPLACE PROCEDURE SuspendStudentsBasedOnWarnings IS
BEGIN
    -- This for loop for each student who has 3 or more warnings
    FOR student IN (
        SELECT SID
        FROM ManagerUser.WARNINGS
        GROUP BY SID
        HAVING COUNT(*) >= 3
    ) LOOP

        DECLARE
            current_status VARCHAR(15);
        BEGIN
            SELECT 
            ACADEMIC_STATUS INTO current_status
            FROM USER_1.STUDENTS
            WHERE id = student.SID;
        
           
            UPDATE USER_1.STUDENTS
            SET ACADEMIC_STATUS = 'Suspended'
            WHERE id = student.SID;

            -- Log this update into the AuditTrail table
            INSERT INTO ManagerUser.AuditTrail (ID , name, operation, old_data, new_data, timestamp)
            VALUES (
                (SELECT MAX(id)+ 1 FROM AuditTrail), 
                'Students',  
                'UPDATE',   
                'academic_status = ''' || current_status || '''',  
                'academic_status = ''Suspended''', 
                SYSDATE      
            );
        END;
    END LOOP;

     
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;

EXEC SuspendStudentsBasedOnWarnings

SELECT * FROM ManagerUser.WARNINGS


INSERT INTO ManagerUser.WARNINGS (ID, SID, WARNING_RESSON, WARNING_DATE)
VALUES (9, 1, 'Late registration', TO_DATE('2024-12-18', 'YYYY-MM-DD'));

INSERT INTO ManagerUser.WARNINGS (ID, SID, WARNING_RESSON, WARNING_DATE)
VALUES (10, 1, 'Incomplete course work', TO_DATE('2024-12-19', 'YYYY-MM-DD'));
INSERT INTO ManagerUser.WARNINGS (ID, SID, WARNING_RESSON, WARNING_DATE)
VALUES (11, 1, 'Late registration', TO_DATE('2024-12-18', 'YYYY-MM-DD'));
SELECT * FROM USER_1.STUDENTS

UPDATE USER_1.STUDENTS SET USER_1.ACADEMIC_STATUS ='FAIL' WHAERE ID=1;


SELECT * FROM ManagerUser.REGISTERATION;
--7. Multi-Exam Grade Update with Transactions

DECLARE
    TYPE GradeUpdateRec IS RECORD (
        registration_id NUMBER,
        new_grade NVARCHAR2(10)
    );
    
    TYPE GradeUpdateRecs IS TABLE OF GradeUpdateRec; -- Corrected type definition
    
    rollback_exc EXCEPTION;
    old_grade NVARCHAR2(10);
    grade_updates GradeUpdateRecs := GradeUpdateRecs(
        GradeUpdateRec(3, '50'),
        GradeUpdateRec(4,'70' )
    );
        
BEGIN
    SAVEPOINT before_update;
    
    FOR I IN 1 .. grade_updates.COUNT LOOP
        BEGIN 
            SELECT GRADE INTO old_grade FROM ManagerUser.EXAMERESULT WHERE REG_ID = grade_updates(I).registration_id;      
            UPDATE ManagerUser.EXAMERESULT 
            SET GRADE = grade_updates(I).new_grade 
            WHERE REG_ID = grade_updates(I).registration_id;
            
            INSERT INTO ManagerUser.AuditTrail (ID, NAME, OPERATION, OLD_DATA, NEW_DATA, timestamp) 
            VALUES (
                (SELECT MAX(ID) + 1 FROM ManagerUser.AuditTrail),
                'ExamResults', 
                'UPDATE', 
                'OLD: ' || old_grade, 
                'NEW: ' || grade_updates(I).new_grade, 
                SYSTIMESTAMP
            );
            
--        EXCEPTION 
--            WHEN OTHERS THEN 
--                RAISE rollback_exc;
       END;
    END LOOP;
    
    COMMIT; -- If all updates succeed, commit the transaction

--EXCEPTION 
--    WHEN rollback_exc THEN 
--        ROLLBACK TO before_update;
--        DBMS_OUTPUT.PUT_LINE('Transaction rolled back');
--    WHEN OTHERS THEN
--        ROLLBACK;
--        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;



SELECT * FROM ManagerUser.EXAMERESULT 
SELECT * FROM ManagerUser.REGISTERATION 






-- 2-Grade Calculation Function 
CREATE OR REPLACE FUNCTION GRADE_CALCULATION (EXAM_RESULT_ID NUMBER)
RETURN VARCHAR2
IS
    GRADE NUMBER;                
    NEW_GRADE VARCHAR2(2);
BEGIN
    BEGIN
        SELECT TO_NUMBER(GRADE) 
        INTO GRADE 
        FROM ManagerUser.EXAMERESULT 
        WHERE ID = EXAM_RESULT_ID;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001, 'Invalid grade format in EXAMERESULT table.');
    END;

    IF GRADE < 60 THEN
        NEW_GRADE := 'F';
    ELSIF GRADE < 70 THEN
        NEW_GRADE := 'D';
    ELSIF GRADE < 80 THEN
        NEW_GRADE := 'C';
    ELSIF GRADE < 90 THEN
        NEW_GRADE := 'B';
    ELSE
        NEW_GRADE := 'A';
    END IF;

    UPDATE ManagerUser.EXAMERESULT 
    SET GRADE = NEW_GRADE 
    WHERE ID = EXAM_RESULT_ID;

    RETURN NEW_GRADE;
END;



BEGIN
    DBMS_OUTPUT.PUT_LINE(GRADE_CALCULATION(3));
END;



BEGIN
    DBMS_OUTPUT.PUT_LINE(GRADE_CALCULATION(1));
END;



SELECT * FROM ManagerUser.EXAMERESULT;



