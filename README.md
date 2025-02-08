# University Exam Management System
PL/SQL Scripts for Enhanced Exam Management
## 1. Introduction
1.1 Project Overview
The University Exam Management System enhances exam administration using PL/SQL scripts. The system includes automated processes for:

Grade calculation
Warnings issuance
Audit trails
Performance reports
Exam schedule management
Additionally, it demonstrates transaction handling, deadlock scenarios, and blocker-waiting situations.

## 2. Features
2.1 Grade Calculation Function
A PL/SQL function calculates a student's grade based on their exam score. It updates the ExamResults table and returns the computed grade based on predefined ranges (e.g., 90-100 = A, 80-89 = B, below 60 = Fail).

2.2 Automated Warning Issuance
A PL/SQL procedure automatically issues warnings to students who have failed two or more courses. It:

Checks the ExamResults table.
Logs warnings in the Warnings table.
2.3 Audit Trail for Registration
A BEFORE INSERT and BEFORE DELETE trigger on the Register table logs every registration and deregistration event into the AuditTrail table.

Each log entry includes:

Table name (Register)
Operation type (INSERT/DELETE)
Data changes
Timestamp
2.4 Course Performance Report
A PL/SQL cursor generates a performance report for a specific course by retrieving data from the ExamResults and Register tables.

The report includes:

Student IDs
Grades
Pass/Fail statistics
2.5 Exam Schedule Management
A PL/SQL block retrieves and displays the exam schedule for a course. It queries the Exams table to show:

Course name
Exam date
Exam type (Midterm/Final)
If no exams are scheduled, an appropriate message is displayed.

2.6 Multi-Exam Grade Update with Transactions
A PL/SQL block updates grades for multiple exams in a single transaction.

If any error occurs, all changes are rolled back to maintain data consistency.
2.7 Student Suspension Based on Warnings
A PL/SQL procedure suspends students who have received three or more warnings.

It updates the Students table, setting their academic_status to "Suspended".
The update is logged in the AuditTrail table.
2.8 User Management and Privileges
Manager User: Creates two users.
User 1: Creates the Students and Courses tables.
User 2: Inserts five students and their registered courses.
## 3. Transaction and Deadlock Demonstrations
3.1 Blocker-Waiting Situation
Demonstrates a scenario where:

User 1 locks the Students table while updating a student's academic status.
User 2 attempts to insert a new registration record for the same student in the Register table, causing a waiting situation.
3.2 Identifying Blocker and Waiting Sessions
A query retrieves SID and SERIAL# for both the blocker and waiting sessions.

The script displays details and explains how the situation is resolved.
3.3 Deadlock Demonstration
Simulates a deadlock scenario where:

User 1 updates a record in the Courses table while trying to lock the Register table.
User 2 updates a record in the Register table while trying to lock the Courses table.
The script detects and resolves the deadlock.

## 4. Installation and Setup
4.1 Requirements
Oracle Database
PL/SQL Developer or SQL*Plus
4.2 Execution Steps
Create necessary tables and sequences.
Execute the PL/SQL scripts in order.
Verify the system using test cases.
## 5. Resources
SQL Scripts: Available in the repository.
Documentation: Includes setup instructions and test cases.
