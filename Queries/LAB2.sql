--STUDENT ID : 2019-2-60-072
--LAB NO: 02

--QUESTION 1--

--i--

CREATE TABLE ACCOUNT(
	ACCOUNT_NO CHAR(5),
	BALANCE NUMBER NOT NULL,
	CONSTRAINT ACCOUNT_NO_PK PRIMARY KEY (ACCOUNT_NO),
	CONSTRAINT BALANCE_CHECK CHECK(BALANCE>=0)
);

--ii--

CREATE TABLE CUSTOMER(
	CUSTOMER_NO CHAR(5),
	CUSTOMER_NAME VARCHAR2(20) NOT NULL,
	CUSTOMER_CITY VARCHAR2(10),
	CONSTRAINT CUSTOMER_NO_PK PRIMARY KEY(CUSTOMER_NO)
);

--iii--

CREATE TABLE DEPOSITOR(
	ACCOUNT_NO CHAR(5),
	CUSTOMER_NO CHAR(5),
	CONSTRAINT CUS_AC_PK PRIMARY KEY(ACCOUNT_NO,CUSTOMER_NO)
);

--QUESTION 2--

--i--

ALTER TABLE CUSTOMER ADD DATE_OF_BIRTH DATE;

--ii--

ALTER TABLE CUSTOMER DROP COLUMN DATE_OF_BIRTH;

--iii--

ALTER TABLE DEPOSITOR RENAME COLUMN ACCOUNT_NO TO A_NO;
ALTER TABLE DEPOSITOR RENAME COLUMN CUSTOMER_NO TO C_NO;

--iv--

ALTER TABLE DEPOSITOR ADD CONSTRAINT DEPOSITOR_FK1 foreign KEY (A_NO) REFERENCES ACCOUNT(ACCOUNT_NO);
ALTER TABLE DEPOSITOR ADD CONSTRAINT DEPOSITOR_FK2 foreign KEY (C_NO) REFERENCES CUSTOMER(CUSTOMER_NO);

--QUESTION 3--

INSERT INTO ACCOUNT VALUES ('A-101',12000);
INSERT INTO ACCOUNT VALUES ('A-102',6000);
INSERT INTO ACCOUNT VALUES ('A-103',2500);

INSERT INTO CUSTOMER VALUES ('C-101','Alice','Dhaka');
INSERT INTO CUSTOMER VALUES ('C-102','Annie','Dhaka');
INSERT INTO CUSTOMER VALUES ('C-103','Bob','Chittagong');
INSERT INTO CUSTOMER VALUES ('C-104','Charlie','Khulna');

INSERT INTO DEPOSITOR VALUES ('A-101','C-101');
INSERT INTO DEPOSITOR VALUES ('A-103','C-102');
INSERT INTO DEPOSITOR VALUES ('A-103','C-104');
INSERT INTO DEPOSITOR VALUES ('A-102','C-103');

--QUESTION 4--

--i--

SELECT CUSTOMER_NAME,CUSTOMER_CITY;
FROM CUSTOMER;

--ii--

SELECT DISTINCT CUSTOMER_CITY
FROM CUSTOMER;

--iii--

SELECT ACCOUNT_NO 
FROM ACCOUNT
WHERE BALANCE>7000;

--iv--

SELECT CUSTOMER_NO,CUSTOMER_NAME
FROM CUSTOMER
WHERE CUSTOMER_CITY='Khulna';

--v--

SELECT CUSTOMER_NAME,CUSTOMER_NO
FROM CUSTOMER
WHERE NOT(CUSTOMER_CITY='Dhaka');

--vi--

SELECT CUSTOMER_NAME,CUSTOMER_CITY
FROM ACCOUNT, CUSTOMER, DEPOSITOR
WHERE ACCOUNT.ACCOUNT_NO=DEPOSITOR.A_NO AND CUSTOMER.CUSTOMER_NO=DEPOSITOR.C_NO AND BALANCE>7000;

--vii--

SELECT CUSTOMER_NAME,CUSTOMER_CITY
FROM ACCOUNT, CUSTOMER, DEPOSITOR
WHERE ACCOUNT.ACCOUNT_NO=DEPOSITOR.A_NO AND CUSTOMER.CUSTOMER_NO=DEPOSITOR.C_NO AND BALANCE>7000 AND CUSTOMER_CITY!='Khulna';

--viii--

SELECT ACCOUNT_NO,BALANCE
FROM ACCOUNT,DEPOSITOR
WHERE ACCOUNT.ACCOUNT_NO=DEPOSITOR.A_NO AND C_NO='C-102';

--ix--

SELECT ACCOUNT_NO,BALANCE
FROM ACCOUNT, CUSTOMER, DEPOSITOR
WHERE ACCOUNT.ACCOUNT_NO=DEPOSITOR.A_NO AND CUSTOMER.CUSTOMER_NO=DEPOSITOR.C_NO AND CUSTOMER_CITY!='Chittagong' ;


--x--

SELECT CUSTOMER_NAME
FROM ACCOUNT, CUSTOMER, DEPOSITOR
WHERE ACCOUNT.ACCOUNT_NO=DEPOSITOR.A_NO AND CUSTOMER.CUSTOMER_NO=DEPOSITOR.C_NO AND A_NO=C_NO;





