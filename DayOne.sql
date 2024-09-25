use sys;

CREATE DATABASE BOOTCAMP_2408;
USE BOOTCAMP_2408;

-- comment (double-dash)
-- Database -> tables
	-- One Database may have many tables
    -- One table (similar to Excel worksheet) may have rows
    -- One row contains one or more columns
    
-- Database column definitions: VARCHAR(Similar to Java String), INT/INTEGER(Java int)
-- DECIMAL(13,2) 11 digits for integer, 2 digits for decimal places
-- Boolean (true/false): database normally we use VARCHAR(1) -> Y/N
CREATE TABLE STAFFS (
	ID INTEGER, -- 1,2,3,4.....
    STAFF_NAME VARCHAR(20),
    GENDER VARCHAR(1),
    SALARY DECIMAL(11,2),
    STAFF_EMAIL VARCHAR(50),
    DEPT_CODE VARCHAR(2) -- IT, HR, MK
);

-- DROP TABLE STAFFS;

-- remove data
DELETE FROM STAFFS; -- REMOVE ALL DATA

SELECT * FROM STAFFS;

-- INSERT DATA
-- SYNTAX: INSERT INTO "TABLE_NAME" VALUES
-- table may contain null values
INSERT INTO STAFFS (ID, STAFF_NAME, GENDER, SALARY, STAFF_EMAIL, DEPT_CODE) 
	VALUES (1, 'JOHN WONG', 'M', 20000.5, 'johnwong@gmail.com', 'IT');
    
INSERT INTO STAFFS (ID, STAFF_NAME, GENDER, SALARY, DEPT_CODE) 
	VALUES (3, 'JENNY LAU', 'F', 25000.0, 'HR');
    
INSERT INTO STAFFS (ID, STAFF_NAME, GENDER, SALARY, DEPT_CODE) 
	VALUES (4, 'NICK NURSE', 'M', 140000.0, 'MK');
    
INSERT INTO STAFFS (ID, STAFF_NAME, GENDER, SALARY, DEPT_CODE) 
	VALUES (5, 'STEVE CURR', 'M', 555555.5, 'MK');
    
INSERT INTO STAFFS (ID, STAFF_NAME, GENDER, SALARY, DEPT_CODE) 
	VALUES (6, 'MARY QUEENS', 'F', 9000.0, 'HR');
    
INSERT INTO STAFFS (ID, STAFF_NAME, GENDER, SALARY, DEPT_CODE, STAFF_EMAIL) 
	VALUES (2, 'PETER LAU', 'M', 34222.5, 'HR', NULL);
    
-- SELECT BY CONDITION (WHERE)
SELECT * FROM STAFFS WHERE GENDER = 'M';
-- WHERE DEPT_CODE = 'IT'
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT';
-- AND, OR
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT' OR DEPT_CODE = 'HR';
SELECT * FROM STAFFS WHERE DEPT_CODE IN ('IT','HR'); -- OR
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT' AND DEPT_CODE = 'HR'; -- NO RESULT
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT' AND GENDER = 'M';
-- SUPPORT BRACKETS
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT' OR DEPT_CODE = 'HR' AND GENDER = 'F'; -- AND go first, then OR
SELECT * FROM STAFFS WHERE DEPT_CODE = 'IT' AND (SALARY > 19000 OR GENDER = 'F'); -- OR go first, then AND
-- SELECT SPECIFIC COLUMNS
-- SYNTAX: select "column_name1", "column_name2"..... from "table_name"
-- SELECT (what you want to see in the result set)
-- WHERE (how to retrieve the data) -> ROWS
SELECT STAFF_NAME, DEPT_CODE FROM STAFFS WHERE GENDER = 'M';

-- Change the display column name in the result set(not the physical table)
SELECT STAFF_NAME AS NAME, DEPT_CODE AS DEPARTMENT_CODE FROM STAFFS WHERE GENDER = 'M';

-- Add column in the physical table
ALTER TABLE STAFFS ADD EMPLOYMENT_DATE DATE;

-- After adding the column, the column values become NULL for all rows
SELECT * FROM STAFFS;

-- Update field values
UPDATE STAFFS SET EMPLOYMENT_DATE = STR_TO_DATE('2024-01-01', '%Y-%m-%d') WHERE ID = 1;
UPDATE STAFFS SET EMPLOYMENT_DATE = STR_TO_DATE('2022-11-01', '%Y-%m-%d') WHERE ID = 2;
UPDATE STAFFS SET EMPLOYMENT_DATE = STR_TO_DATE('2023-09-18', '%Y-%m-%d') WHERE ID = 3;

SELECT DATE_ADD(S.EMPLOYMENT_DATE, INTERVAL 3 MONTH) AS PROBATION_END_DATE 
, S.STAFF_NAME
, S.ID
, S.EMPLOYMENT_DATE
, S.EMPLOYMENT_DATE + 33 -- DATE -> INT + OPERATION (MYSQL NOT WORKING)
FROM STAFFS S; -- ALIAS

-- MYSQL (not working)
SELECT S.STAFF_NAME + '!!!!!', CONCAT(S.STAFF_NAME, '!!!!') FROM STAFFS S;

SELECT S.STAFF_NAME + '!!!!!'
, CONCAT(S.STAFF_NAME, '!!!!', '????') 
, CONCAT_WS(' ', S.STAFF_NAME, S.GENDER)
FROM STAFFs S
WHERE S.DEPT_CODE = 'IT'; -- determine the number of rows

-- MATH operation (+,-,*,/,%)
-- 15 fields (3 rows X 5 columns)
SELECT SALARY + 10000, SALARY, 12000 - 200 * 1.1, 1, "HELLO"
FROM STAFFS;

SELECT 1, "HELLO"
FROM STAFFS
WHERE ID IN ('1','2','3');

SELECT 10 % 3, 'HELLO' FROM STAFFS WHERE DEPT_CODE IN ('IT', 'HR');

-- BETWEEN AND
SELECT *
FROM STAFFS
WHERE EMPLOYMENT_DATE BETWEEN STR_TO_DATE('2024-01-01', '%Y-%m-%d') AND STR_TO_DATE('2024-12-31', '%Y-%m-%d');

-- Modify physical column definition
-- from VARCHAR(20) to VARCHAR(30), extend column length
-- if the existing length > new column length, DBMS will reject
ALTER TABLE STAFFS MODIFY STAFF_NAME VARCHAR(30);

SELECT * FROM STAFFS;
-- LIKE
SELECT * 
FROM STAFFS
WHERE DEPT_CODE = 'IT'
AND STAFF_EMAIL LIKE '%@gmail.com';

SELECT * 
FROM STAFFS
WHERE STAFF_EMAIL LIKE 'JOHN%';

SELECT * 
FROM STAFFS
WHERE STAFF_EMAIL LIKE 'JOHN%';

SELECT * 
FROM STAFFS
WHERE STAFF_EMAIL LIKE '%@%' OR STAFF_EMAIL IS NULL;

-- Aggregate functions
SELECT SUM(SALARY) 
FROM STAFFS
WHERE DEPT_CODE = 'MK';

SELECT COUNT(*) AS TWO FROM STAFFS WHERE DEPT_CODE = 'MK';

-- SUM() -> sum up all the value of a column
-- COUNT() -> count the number of rows
-- you cannot put STAFF_NAME here, you should know the reason
-- as long as you have one agg function, the result must be oe single row
SELECT SUM(SALARY), COUNT(1), COUNT(*), COUNT(ID), MAX(SALARY), MIN(SALARY), MAX(ID), AVG(SALARY) -- STAFF_NAME
FROM STAFFS
WHERE DEPT_CODE = 'MK';

-- Aggregate functions + Group By
-- 1. exclude the employee in marketing (where is the action between group by)
-- 2. group by
-- 3. select agg function
SELECT DEPT_CODE, AVG(SALARY) AS DEPT_AVERAGE_SALARY, COUNT(1) AS NUMBER_OF_DEPT_EMPLOYEE
, MAX(SALARY) DEPT_MAX_SALARY
FROM STAFFS
WHERE DEPT_CODE <> 'MK' -- exclude MK
GROUP BY DEPT_CODE;









