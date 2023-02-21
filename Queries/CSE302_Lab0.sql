CREATE TABLE Student ( 
    student_id            VARCHAR2(13),
    student_name     VARCHAR2(20),
    student_gender   CHAR(1),
    student_credits    NUMBER,
    student_cgpa        NUMBER,
    student_dob         DATE,
    student_phone     CHAR(11)
) ;

DROP TABLE Student;

INSERT INTO Student VALUES ('2022-1-60-001', 'Alice' , 'F' , 100, 3.5, '04-03-2002', 
                            '01711908876' ) ;

INSERT INTO Student VALUES ('2022-1-60-002', 'Bob' , 'M' , 90, 3.25, '10-02-2003', 
                            '01899908876' ) ;

INSERT INTO Student VALUES ('2022-1-60-003', 'Carol' , 'F' , 45, 3.95, '01-03-2004', 
                            '01543908876' ) ;

INSERT INTO Student VALUES ('2022-1-60-004', 'Danny' , 'M' , 48, 3.15, '07-30-2004', 
                            '01845908876' ) ;
							
-- For executing in Oracle Local Server

INSERT INTO Student VALUES ('2022-1-60-001', 'Alice' , 'F' , 100, 3.5, '03-Apr-2002', 
                            '01711908876' ) ;

-- displaying all records in a table
SELECT *
FROM Student;

-- deleting rows from a table

DELETE FROM Student
WHERE student_id = '2022-1-60-001';

-- updating a value in a table
UPDATE Student
SET student_credits = 100
WHERE student_id = '2022-1-60-002';

-- Write a SQL Command that updates the CGPA of 2022-1-60-001 to 3.85
UPDATE Student
SET student_cgpa = 3.85
WHERE student_id = '2022-1-60-001';

-- displaying all records in a table in a sorted order based on their student id
SELECT *
FROM Student
ORDER BY student_id;

-- (SELECT queries) Data retrieval based on queries (request for information)

-- Find information of all female students

SELECT *
FROM Student
WHERE student_gender = 'F';

-- Find student id, name and cgpa of all female students
SELECT student_id, student_name, student_cgpa
FROM Student
WHERE student_gender = 'F';

-- Find student id, name and cgpa of female students who have cgpa more than 3.9
SELECT student_id, student_name, student_cgpa
FROM Student
WHERE student_gender = 'F' AND student_cgpa > 3.9;

-- Find students information who have CGPA not more than 3.5
SELECT *
FROM Student
WHERE student_cgpa <= 3.5;

SELECT *
FROM Student
WHERE NOT(student_cgpa > 3.5);

-- displaying all records in a table in a sorted order based on their cgpa
SELECT *
FROM Student
ORDER BY student_cgpa DESC;







