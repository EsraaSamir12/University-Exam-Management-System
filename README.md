# University-Exam-Management-System
PL/SQL scripts to enhance a university exam system with automated grade calculation, warnings, audit trails, performance reports, and schedule management. Includes triggers, procedures, functions, cursors, transaction handling, and demonstrations of deadlock and blocker-waiting scenarios.


Tables & Relationships

Courses: (id, name, professor_id, credit_hours, prerequisite_course_id) Tracks course details, assigned professors,
and the prerequisite course that must be completed before registering for this course.
----------------------------------------------------------------------------------------------
Professors: (id, name, department) Stores information about university professors.
----------------------------------------------------------------------------------------------
Students: (id, name, academic_status, total_credits) contains details of students and their academic status (e.g.,
active, suspended).
----------------------------------------------------------------------------------------------
Register: (id, student_id, course_id) Tracks students who are registered for courses.
----------------------------------------------------------------------------------------------
Exams: (id, course_id, exam_date, exam_type) Logs exam schedules for courses (e.g., midterm, final).
----------------------------------------------------------------------------------------------
ExamResults: (id, registration_id, grade, status) Stores grade and pass/fail status for students after exams.
----------------------------------------------------------------------------------------------
AuditTrail: (id, table_name, operation, old_data, new_data, timestamp) Logs updates or deletions to keep track of
changes in any table.
----------------------------------------------------------------------------------------------
Warnings: (id, student_id, warning_reason, warning_date) Stores warnings issued to students based on low
performance or violations.
----------------------------------------------------------------------------------------------





Features to be covered
1.Grade Calculation Function
- Create a PL/SQL function that calculates the grade for a student based on their exam
performance. The function should take the ExamResults ID as input and compute the grade
based on predefined ranges (e.g., 90-100 = A, 80-89 = B). The function updates the grade
column in the ExamResults table and returns the grade as output.
-------------------------------------------------------------------------------------------
2. Automated Warning Issuance
- Develop a PL/SQL procedure to issue warnings automatically for students who have received a
failing grade (status = 'Fail') in two or more courses. The procedure should check
the ExamResults table and log warnings in the Warnings table with details.
----------------------------------------------------------------------------------------------
3. Audit Trail for Registration
- Create a BEFORE INSERT and BEFORE DELETE trigger for the Register table. The trigger
logs every registration or deregistration event into the AuditTrail table. Each log entry should
include the table name (Register), operation type (INSERT/DELETE), and relevant data
changes, along with a timestamp.
----------------------------------------------------------------------------------------------
4. Course Performance Report
- Write a PL/SQL cursor that generates a performance report for a specific course. The cursor
should retrieve information from the ExamResults and Register tables, including student IDs,
grades, and overall pass/fail statistics for the course. The report should summarize the number
of students who passed and failed the course.
----------------------------------------------------------------------------------------------
5. Exam Schedule Management
- Create a PL/SQL block to retrieve and display the schedule of exams for a specific course. The
block should query the Exams table and display the course name, exam date, and type (e.g.,
midterm or final). If no exams are scheduled, the block should display an appropriate message.
----------------------------------------------------------------------------------------------
6. Multi-Exam Grade Update with Transactions
- Develop a PL/SQL block that processes grade updates for multiple exams in a single
transaction. The block should update the ExamResults table for a list of registration_ids with
new grades. If any error occurs, the block should rollback all changes to ensure data
consistency.
----------------------------------------------------------------------------------------------
7. Student Suspension Based on Warnings
- Create a PL/SQL procedure to suspend students who have received three or more warnings. The
procedure should query the Warnings table to identify affected students and update
their academic_status in the Students table to "Suspended." Ensure the procedure logs these
updates into the AuditTrail table.
----------------------------------------------------------------------------------------------
8. User Management and Privileges
- Create a Manager User and grant them the role to create two users. Let User 1 create the
Students and Courses tables. Let User 2 insert 5 rows of students and their respective registered
courses data.
----------------------------------------------------------------------------------------------
9. Blocker-Waiting Situation
- Demonstrate generating a blocker-waiting situation using two transactions by User 1 and User
2. User 1 locks the students table while updating the academic status of a student, and User 2
tries to simultaneously insert a new registration record for the same student in the Register table.
----------------------------------------------------------------------------------------------
10. Identifying Blocker and Waiting Sessions
- Identify the sessions in the blocker-waiting situation created in Question 10 using SID and
SERIAL# for both the blocker and waiting sessions. Display the details of these sessions and
how they are resolved.
----------------------------------------------------------------------------------------------
11. Deadlock Demonstration
- Demonstrate a deadlock scenario by having User 1 and User 2 perform simultaneous
transactions. User 1 updates a record in the Courses table while trying to lock the Register table,
and User 2 updates a record in the Register table while trying to lock the Courses table. and
show how you handle the deadlock.
