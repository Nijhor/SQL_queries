-- CSE302, Section 02
-- Lab 04

-- WITH CLAUSE
-- An alternative of the subqueries within FROM clause

-- Find the name and dept name of instructors who gets less than the overall average salary
-- of instructors

SELECT name, dept_name, salary
FROM instructor, (SELECT avg(salary) as avg_sal FROM instructor) TEMP
WHERE instructor.salary < TEMP.avg_sal;

WITH TEMP(avg_sal) AS 
   (SELECT avg(salary) FROM instructor)
SELECT name, dept_name, salary 
FROM instructor i, temp t
WHERE i.salary < t.avg_sal;

-- Find the instructors who have taught at least two sections and have salary more than
-- 60000.

WITH TEMP (id, num_of_section) AS
   (SELECT id, count(*) 
    FROM teaches
    GROUP BY id)
SELECT instructor.id, name 
FROM instructor, temp
WHERE instructor.id = temp.id AND num_of_section >=2 AND salary >60000;

SELECT instructor.id, name 
FROM instructor, (SELECT id, count(*) as num_of_section
    FROM teaches
    GROUP BY id) temp
WHERE instructor.id = temp.id AND num_of_section >=2 AND salary >60000;

insert into department values ('LAW', 'Painter', 90000);
select * from Department;
-- FInd the number of instructors for each department.
SELECT dept_name, count(*) as NUM_OF_INST
FROM instructor
GROUP BY dept_name;

-- Subqueries within SELECT clause

SELECT dept_name, (SELECT COUNT(*) 
                   FROM instructor i 
                   WHERE i.dept_name = d.dept_name) as NUM_OF_INST
FROM department d;

-- Using OUTER JOINS
SELECT dept_name, count(id) as NUM_of_INST
FROM department natural left join instructor
group by dept_name;


-- Oracle Functions
-- Find the name of the instructors who has more than 6 characters in their name.
SELECT lower(name)
FROM instructor
WHERE LENGTH(name) > 6;

-- Show the instructor id and name in a single column. 
SELECT id || '-' || name as INSTRUCTOR_INFO
FROM instructor;

SELECT 'DATABASE ' || 'SYSTEMS'
FROM DUAL;

SELECT 2+2 FROM DUAL;

SELECT FLOOR(AVG(SALARY)) AS AVG_SAL, MEDIAN(SALARY) AS MEDIAN_SAL FROM INSTRUCTOR;

CREATE TABLE DUMMY_PERSON(id number, name varchar2(10), dob date); 

insert into DUMMY_PERSON VALUES (1, 'Alice', '01-JAN-2003');

insert into DUMMY_PERSON VALUES (2, 'Bob', '21-FEB-2004');


insert into DUMMY_PERSON VALUES (3, 'Charlie', '31-JUL-2008');

SELECT * FROM DUMMY_PERSON;

-- Show the name and birth year.

SELECT NAME, EXTRACT (day from dob) as BIRTH_YEAR
FROM DUMMY_PERSON;

-- Find the difference in age (in days) in between Bob and charlie.

SELECT ROUND(((SELECT dob from DUMMY_PERSON where name = 'Charlie') - (SELECT dob from DUMMY_PERSON where name = 'Bob'))/365,2)
FROM DUAL;

SELECT ADD_MONTHS((SELECT dob from DUMMY_PERSON where name = 'Charlie'), 6)
FROM DUAL;


