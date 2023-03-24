-- 1. creating  new schema as alumni 
CREATE DATABASE alumni;

-- 2. Importing all csv files into MySQL 
--  All csv files are imported into alumni datbase

-- Table profiling :
   -- 1. college_a_hs ~ Alumni higher studies data of college A
   -- 2. college_a_se ~ Alumni self employment record of college A
   -- 3. college_a_sj ~ Service or job record of college A
   -- 4. college_b_hs ~ Higher studies data of college B
   -- 5. college_b_se ~ Self employment status of college B
   -- 6. college_b_sj ~ Service or job status of college B
   
   USE alumni;
 
-- 3: Describing the  structure of tabels

DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj;

-- Data cleaning and store the clean tables in to  views

-- 6. Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. 

CREATE  VIEW college_a_hs_v AS
    SELECT 
        *
    FROM
        college_a_hs
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND NAME IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL;

-- 7 . Perform data cleaning on table College_A_HS and store cleaned data in view College_A_SE_V, Remove null values. 

CREATE VIEW college_a_se_v AS
    SELECT 
        *
    FROM
        college_a_se
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND NAME IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Location IS NOT NULL;



-- 8. Perform data cleaning on table College_A_HS and store cleaned data in view College_A_SJ_V, Remove null values. 

CREATE  VIEW college_a_sj_v AS
    SELECT 
        *
    FROM
        college_a_sj
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND NAME IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL;

-- 9. Perform data cleaning on table College_A_HS and store cleaned data in view College_B_HS_V, Remove null values. 

CREATE  VIEW college_b_hs_v AS
    SELECT 
        *
    FROM
        college_b_hs
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND NAME IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
             AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND HSDegree IS NOT NULL
            AND EntranceExam IS NOT NULL
            AND Institute IS NOT NULL
            AND Location IS NOT NULL;
            
-- 10. Perform data cleaning on table College_A_HS and store cleaned data in view College_B_SE_V, Remove null values. 

CREATE  VIEW college_b_se_v AS
    SELECT 
        *
    FROM
        college_b_se
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND NAME IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
             AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
            AND Organization IS NOT NULL
            AND Location IS NOT NULL;
            
-- 11. Perform data cleaning on table College_A_HS and store cleaned data in view College_B_SJ_V, Remove null values. 

CREATE  VIEW college_b_sj_v AS
    SELECT 
        *
    FROM
        college_b_sj
    WHERE
        RollNo IS NOT NULL
            AND LastUpdate IS NOT NULL
            AND NAME IS NOT NULL
            AND FatherName IS NOT NULL
            AND MotherName IS NOT NULL
            AND Branch IS NOT NULL
             AND Batch IS NOT NULL
            AND Degree IS NOT NULL
            AND PresentStatus IS NOT NULL
             AND Organization IS NOT NULL
            AND Designation IS NOT NULL
            AND Location IS NOT NULL;

/* 12. Make procedure to use string function/s for converting record of Name, 
       FatherName, MotherName into lower case for views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, 
      College_B_SE_V, College_B_SJ_V) */


-- College_A_HS_V

DELIMITER |
CREATE PROCEDURE hs_a()
BEGIN 
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_a_hs_v;
END |
DELIMITER ;

CALL hs_a();

-- College_A_SE_V

DELIMITER |
CREATE PROCEDURE se_a()
BEGIN 
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_a_se_v;
END |
DELIMITER ;

CALL se_a();

-- College_A_SJ_V:

DELIMITER |
CREATE PROCEDURE sj_a()
BEGIN 
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_a_sj_v;
END |
DELIMITER ;

CALL sj_a()

-- College_B_HS_V:

DELIMITER |
CREATE PROCEDURE hs_b()
BEGIN 
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_b_hs_v;
END |
DELIMITER ;

CALL hs_b();

-- College_B_SE_V:

DELIMITER |
CREATE PROCEDURE se_b()
BEGIN 
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_b_se_v;
END |
DELIMITER ;

CALL se_b();

-- COLLEGE_B_SJ_V:

DELIMITER |
CREATE PROCEDURE sj_b()
BEGIN 
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_b_sj_v;
END |
DELIMITER ;

CALL sj_b();

 /*
14. Write a query to create procedure get_name_collegeA using the cursor to 
fetch names of all students from college A.
*/

DELIMITER |
CREATE PROCEDURE get_name_collegeA(INOUT student_name LONGTEXT)
BEGIN
DECLARE finished INT DEFAULT 0;
DECLARE student_info TEXT;
DECLARE studentdetail
CURSOR FOR 
SELECT Name FROM college_a_hs
UNION ALL
SELECT Name FROM college_a_se
UNION ALL
SELECT Name FROM college_a_sj;
DECLARE CONTINUE 
	HANDLER FOR NOT FOUND SET finished = 1;
OPEN studentdetail;
firstname:
LOOP
FETCH studentdetail INTO student_info;
IF finished=1 THEN LEAVE firstname;
END IF;
SET student_name=CONCAT(student_info,' , ',student_name);
END LOOP;
SELECT student_name;
CLOSE studentdetail;
END |
DELIMITER ;

SET @student_college_a ='';
CALL get_name_collegeA(@student_college_a);

/*
15. Write a query to create procedure get_name_collegeB 
using the cursor to fetch names of all students from college B.
*/

DELIMITER |
CREATE PROCEDURE get_name_collegeB(INOUT student_name1 LONGTEXT)
BEGIN
DECLARE finished INTEGER DEFAULT 0;
DECLARE student_info TEXT;
DECLARE studentdetail 
CURSOR FOR 
SELECT Name FROM college_b_hs
UNION ALL
SELECT Name FROM college_b_se
UNION ALL
SELECT Name FROM college_b_sj;
DECLARE CONTINUE 
	HANDLER FOR NOT FOUND SET finished = 1;
OPEN studentdetail;
firstname:
LOOP
FETCH studentdetail INTO student_info;
IF finished=1 THEN LEAVE firstname;
END IF;
SET student_name1=CONCAT(student_info,' , ',student_name1);
END LOOP;
SELECT student_name1;
CLOSE studentdetail;
END |
DELIMITER ;

SET @student_college_b ='';
CALL get_name_collegeB(@student_college_b);

/*
16. Calculate the percentage of career choice of College A and College B Alumni
 (w.r.t Higher Studies, Self Employed and Service/Job)
Note: Approximate percentages are considered for career choices.
*/

SELECT((SELECT COUNT(*) FROM college_a_hs)+(SELECT COUNT(*) FROM college_a_se)+(SELECT COUNT(*) FROM college_a_sj)) TOTALA;
-- 5887

SELECT((SELECT COUNT(*) FROM college_b_hs)+(SELECT COUNT(*) FROM college_b_se)+(SELECT COUNT(*) FROM college_b_sj)) TOTALB;
-- 2259

SELECT 'Higher_Studies',(SELECT COUNT(*) / 5887 * 100 FROM college_a_hs)'College A Percentage',
(SELECT COUNT(*) / 2259 * 100 FROM college_b_hs) 'College B Percentage'
UNION
SELECT 'Self_Employed',(SELECT COUNT(*) / 5887 * 100 FROM college_a_se)'College A Percentage',
(SELECT COUNT(*) / 2259 * 100 FROM college_b_se) 'College B Percentage'
UNION
SELECT 'Service_Job',(SELECT COUNT(*) / 5887 * 100 FROM college_a_sj)'College A Percentage',
(SELECT COUNT(*) / 2259 * 100 FROM college_b_sj) 'College B Percentage';

