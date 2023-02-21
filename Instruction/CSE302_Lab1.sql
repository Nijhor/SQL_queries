
CREATE TABLE AUTHOR(
	author_id NUMBER,
	name varchar2(10),
	dob date NOT NULL,
	nationality VARCHAR2(10),
	constraint AUTHOR_PK primary key(author_id)
);

CREATE TABLE BOOK(
	ISBN char(13),
	book_title varchar2(20),
	price NUMBER,
	pubYear DATE,
	author_id NUMBER,
	constraint BOOK_PK PRIMARY KEY (ISBN),
	constraint BOOK_PRICE CHECK (price >= 0),
	constraint BOOK_FK FOREIGN KEY (author_id) REFERENCES AUTHOR
);

-- adding a new attribute 'AUTHOR_ID' in BOOK relation
ALTER TABLE BOOK ADD author_id NUMBER;

-- dropping an existing attribute 'AUTHOR' from BOOK relation
ALTER TABLE BOOK DROP COLUMN author;

-- modifying an existing attribute 
ALTER TABLE BOOK MODIFY pubYear DATE;

-- renaming an existing attribute
ALTER TABLE BOOK RENAME COLUMN TITLE TO BOOK_TITLE;

-- adding a new constraint in an existing table
ALTER TABLE BOOK ADD CONSTRAINT BOOK_FK FOREIGN KEY(AUTHOR_ID) REFERENCES AUTHOR;

-- Find book title and their price.
SELECT BOOK_TITLE, PRICE
FROM BOOK;

-- Find book title, author id and price of those books which have price higher than 500.
SELECT BOOK_TITLE, AUTHOR_ID, PRICE
FROM BOOK
WHERE PRICE > 500;

-- Find book title, author id and price of those books which have price in between 500 and 1000.
-- Both bounds are inclusive.
SELECT BOOK_TITLE, AUTHOR_ID, PRICE
FROM BOOK
WHERE PRICE >= 500 AND PRICE <= 1000;

SELECT BOOK_TITLE, AUTHOR_ID, PRICE
FROM BOOK
WHERE PRICE BETWEEN 500 AND 1000;

-- CARTESIAN PRODUCT Without JOIN CONDITION
SELECT *
FROM BOOK, AUTHOR;

-- CARTESIAN PRODUCT With JOIN CONDITION
SELECT *
FROM BOOK, AUTHOR
WHERE BOOK.AUTHOR_ID = AUTHOR.AUTHOR_ID;

-- TABLE NAME ALIASING
SELECT *
FROM BOOK B, AUTHOR A
WHERE B.AUTHOR_ID = A.AUTHOR_ID;

-- Multi-Table Queries
-- Find book title, author name and their price.
SELECT BOOK_TITLE, NAME, PRICE
FROM BOOK B, AUTHOR A
WHERE B.AUTHOR_ID = A.AUTHOR_ID;

-- Find book title, author id, author name and price of those books which have price 
-- higher than 500.
SELECT BOOK_TITLE, A.AUTHOR_ID, NAME, PRICE
FROM BOOK B, AUTHOR A
WHERE B.AUTHOR_ID = A.AUTHOR_ID AND PRICE > 500;

-- Find book title, author id, author name and price of those books which have price 
-- in between 500 and 1000


-- Find book title, author id, author name and price of those books written by Indian authors.


-- NATURAL JOIN OPERATOR (No table Aliasing)
-- Join Condition is IMPLICIT (No need to write)
SELECT *
FROM BOOK NATURAL JOIN AUTHOR;

SELECT *
FROM BOOK B, AUTHOR A
WHERE B.AUTHOR_ID = A.AUTHOR_ID;

-- Find book title, author id, author name and price of those books which have price 
-- in between 500 and 1000
SELECT BOOK_TITLE, A.AUTHOR_ID, NAME, PRICE
FROM BOOK B, AUTHOR A
WHERE B.AUTHOR_ID = A.AUTHOR_ID AND PRICE BETWEEN 500 AND 1000;

SELECT BOOK_TITLE, AUTHOR_ID, NAME, PRICE
FROM BOOK  NATURAL JOIN AUTHOR 
WHERE PRICE BETWEEN 500 AND 1000;



DROP TABLE BOOK CASCADE CONSTRAINTS;
DROP TABLE AUTHOR CASCADE CONSTRAINTS;












