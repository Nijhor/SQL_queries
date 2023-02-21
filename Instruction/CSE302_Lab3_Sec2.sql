-- Nested Subqueries
-- What is a nested subquery?
-- A query within another query is known as a nested subquery.
-- Example
-- SELECT ........
-- FROM ..........
-- WHERE ......... (SELECT .......
                    FROM .........
                    WHERE ........);
-- The SELECT .... FROM .... WHERE .... appears outside the bracket
-- is known as OUTER query.

-- The SELECT .... FROM .... WHERE .... appears inside the bracket
-- is known as INNER query or nested subquery.

-- Nested subqueries can be broadly classified into three types.
-- 1. Nested Subquery within WHERE clause
-- 2. Nested Subquery within FROM clause
-- 3. Nested Subquery within SELECT clause

-- 1. Nested subquery within WHERE clause
-- SELECT ........
-- FROM ..........
-- WHERE ......... (SELECT .......
                    FROM .........
                    WHERE ........);

-- IN/NOT IN, ALL/SOME, EXISTS/NOT EXISTS

-- Usage of IN/NOT IN
-- They are used to identify the set membership.
-- IN keyword returns True if the value in the outer relation is also 
-- present in the set of values of the inner relation/relation returned
-- by the subquery.

-- Alice IN {Bob, Charlie, David} --> FALSE
-- Bob IN {Bob, Charlie, David} --> TRUE

-- NOT IN is completely opposite of IN

-- Find course ids that were offered in both Fall 2009 and in Spring 2010.
SELECT course_id
FROM SECTION
WHERE semester = 'Fall' and year = 2009
INTERSECT
SELECT course_id
FROM SECTION
WHERE semester = 'Spring' and year = 2010;

-- using IN
SELECT course_id 
FROM SECTION
WHERE semester = 'Fall' and year = 2009
      and course_id IN (SELECT course_id
                        FROM SECTION
                        where semester = 'Spring' and year = 2010);


FALL 2009
--------
CS-101 
CS-347 
PHY-101 

SPRING 2010
--------
CS-101 -->
CS-315
CS-319
CS-319
FIN-201
HIS-351
MU-199

-- -- Find course ids that were offered in Fall 2009 but not in Spring 2010.
SELECT course_id 
FROM SECTION
WHERE semester = 'Fall' and year = 2009
      and course_id NOT IN (SELECT course_id
                        FROM SECTION
                        where semester = 'Spring' and year = 2010);


-- Find instructor name who taught courses offered in Fall 2009 and also 
-- in Spring 2010.
SELECT DISTINCT name
FROM INSTRUCTOR NATURAL JOIN TEACHES
WHERE semester = 'Fall' and year = 2009
      and id IN (SELECT id 
                 FROM TEACHES
                 WHERE semester = 'Spring' and year = 2010);

-- Find instructor name who taught courses offered in Fall 2009 but not 
-- in Spring 2010.
SELECT DISTINCT name
FROM INSTRUCTOR NATURAL JOIN TEACHES
WHERE semester = 'Fall' and year = 2009
      and id NOT IN (SELECT id 
                 FROM TEACHES
                 WHERE semester = 'Spring' and year = 2010);

-- Usage of ALL/SOME
-- these keywords are used to compare a value against a set of values.
-- 10 >ALL (9, 10, 11) --> FALSE
-- 10 >SOME (9, 10, 11) --> TRUE

-- Find instructor name and salary who gets more than the salary of all 
-- instructors of History department. 

SELECT name, salary
FROM instructor
WHERE salary >ALL (SELECT salary
                   FROM instructor
                   WHERE dept_name = 'History');

-- Find instructor name and salary who gets more than the salary of some 
-- instructors of Physics department. 

SELECT name, salary
FROM instructor
WHERE salary > SOME(SELECT salary
                   FROM instructor
                   WHERE dept_name = 'Physics');

-- Find the instructor name who gets the highest salary.

SELECT name, salary
FROM instructor
WHERE salary >=ALL (SELECT salary 
                   FROM instructor); 

SELECT name, salary
FROM instructor
WHERE salary = (SELECT max(salary) FROM instructor);

SELECT name, salary
FROM (SELECT max(salary) as MAX_SAL FROM instructor) temp, instructor
WHERE instructor.salary = temp.MAX_SAL;

-- Find instructor name and salary who gets more than the average salary
-- of all instructors.
SELECT name, salary
FROM (SELECT avg(salary) as AVG_SAL FROM instructor) temp, instructor
WHERE instructor.salary > temp.AVG_SAL;


SELECT name, salary
FROM instructor
WHERE salary > (SELECT avg(salary) FROM instructor);

--EXISTS/NOT EXISTS

-- These keywords are used for the set cardinality (number of tuples).
-- EXISTS returns TRUE if the inner relation/relation returned by the 
-- subquery is non-empty.

-- NOT EXISTS returns TRUE if the inner relation/relation returned by the 
-- subquery is empty.

-- Correlation condition: this is a condition that relates a tuple from 
-- outer relation with the tuple of inner relation

-- Find course ids which were offered in Fall 2009 and in Spring 2010.
-- INTERSECT, IN, EXISTS

SELECT course_id
FROM Section r
WHERE semester = 'Fall' and year = 2009 
      and EXISTS (SELECT course_id
                  FROM Section s
                  WHERE semester = 'Spring' and year = 2010
                  and r.course_id = s.course_id);

FALL 2009
--------
CS-101 <-- r
CS-347 
PHY-101 

SPRING 2010
--------
CS-101 --> s
CS-315
CS-319
CS-319
FIN-201
HIS-351
MU-199

-- Find course ids which were offered in Fall 2009 but not in Spring 2010.

SELECT course_id
FROM Section r
WHERE semester = 'Fall' and year = 2009 
      and NOT EXISTS (SELECT course_id
                  FROM Section s
                  WHERE semester = 'Spring' and year = 2010
                  and r.course_id = s.course_id);

-- MINUS, NOT IN, NOT EXISTS

-- Subqueries within FROM clause

-- Find the department name and number of instructors 
-- with at least two instructors.

SELECT *
FROM (SELECT dept_name, count(*) as NUM_OF_INST
      FROM instructor
      GROUP BY dept_name) temp
WHERE NUM_OF_INST >= 2;

-- HAVING Clause

SELECT dept_name, count(*) as NUM_OF_INST
FROM instructor
GROUP BY dept_name
HAVING count(*) >= 2;

-- Find department names and avg.salary of instructors for those 
-- departments which have avg. salary of more than 50000.

SELECT dept_name, avg(salary) as Avg_Salary
FROM instructor
group by dept_name
HAVING avg(salary) > 50000;

SELECT dept_name, Avg_Salary
FROM (SELECT dept_name, avg(salary) as Avg_Salary
	FROM instructor
	group by dept_name) temp
WHERE Avg_Salary > 50000;

















