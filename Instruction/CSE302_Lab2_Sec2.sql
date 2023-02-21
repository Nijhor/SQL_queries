-- CSE302, Lab 02, Section 02

-- LIKE for String Matching

-- Pattern Creation

-- For creating a pattern, we have two special characters. (wildcards)
-- % (percent) : This symbol can be matched to any number of characters from 0 to n
-- Example: 'Z%' --> any value that starts with Z and then have any number of characters
-- 'Zoo', 'Zebra'
-- _ (Underscore) : This symbol can be matched to exactly one characters
-- Example: '__e' --> any value that has three characters and the last character will be 'e'
-- 'one', 'see'

-- Value starts with 'A' --> 'A%'
-- Value ends with 'Khan' --> '%Khan'
-- Value that has a substring 'Computer' --> '%Computer%'
-- Value that has exactly five characters and starts with 'E' --> 'E____'
-- Value that has exactly four characters and ends with 'E' --> '___E'

-- Value that has '%' as substring --> '%\%%' ESCAPE '\'
-- Example: '100%', '50%', '%10000'
-- Value that has 'A_B' as substring --> '%A\_B%' ESCAPE '\'

-- Value that starts with '%' --> '\%%' ESCAPE '\'

-- Student (id, name, addr, dept_name, ....)
-- Find student id and their name for those students who have 'A' as their first character.
SELECT id, name
FROM Student
WHERE name LIKE 'A%';

-- Find student id and their name for those students who have 'Rampura' in their address 
-- as a substring.

SELECT id, name
FROM Student
WHERE addr LIKE '%Rampura%';

-- Find customer information of those whose name starts with 'M'.
SELECT *
FROM Customer
WHERE customer_name LIKE 'M%';

-- Find customer information of those whose city ends with 'e'.
SELECT *
FROM Customer
WHERE customer_city LIKE '%e';

-- Find those customers who have names of exactly five characters.
SELECT *
FROM Customer
WHERE customer_name LIKE '_____';

SELECT *
FROM Customer
WHERE LENGTH(customer_name) = 5;

-- Find those customers who have names starts with a Vowel.

SELECT *
FROM Customer
WHERE customer_name LIKE 'A%' or customer_name LIKE 'E%' or customer_name LIKE 'I%'
      or customer_name LIKE 'O%' or customer_name LIKE 'U%';

-- DISTINCT operator

-- used to remove the duplicate values

-- Find unique customer name who have accounts.

SELECT DISTINCT customer_name
FROM Depositor;

-- Prepare a report that shows the account number, balance and 15% bonus of the current balance
-- as bonus amount.

SELECT account_number, balance, 0.15*balance as "Bonus Amount"
FROM Account;

-- Prepare a report that shows the account number, customer name, balance and updated balance 
-- after providing 20% bonus.

SELECT A.account_number, customer_name, balance, 1.2*balance as "Updated Balance"
FROM Account A, Depositor D
WHERE A.account_number = D.Account_number;

SELECT A.account_number, customer_name, balance, 1.2*balance as "Updated Balance"
FROM Account A JOIN Depositor D ON A.account_number = D.Account_number;


SELECT account_number, customer_name, balance, 1.2*balance as "Updated Balance"
FROM Account NATURAL JOIN Depositor;

SELECT account_number, customer_name, balance, 1.2*balance as "Updated Balance"
FROM Account JOIN Depositor USING (account_number);

-- ORDER BY Clause

-- Sort the account information in the ascending order of account balance.
SELECT * 
FROM Account
ORDER BY balance;

-- Sort the account information in the descending order of account balance.

SELECT * 
FROM Account
ORDER BY balance desc;

-- Sort the account information in the descending order of account balance.
-- If multiple accounts have the same balance then sort them based on the descending order of
-- their account number.

SELECT * 
FROM Account
ORDER BY balance desc, account_number desc;


-- SET Operations

-- Find the branch names and their city which have accounts or loans or both. (UNION)

SELECT branch_name, branch_city
FROM Account NATURAL JOIN Branch
UNION
SELECT branch_name, branch_city
FROM Loan NATURAL JOIN Branch;

-- Find the branch names and their city which have both accounts and loan.
SELECT branch_name, branch_city
FROM Account NATURAL JOIN Branch
INTERSECT
SELECT branch_name, branch_city
FROM Loan NATURAL JOIN Branch;
 
-- Find the branch names and their city which have loans but no accounts.
SELECT branch_name, branch_city
FROM Loan NATURAL JOIN Branch
MINUS
SELECT branch_name, branch_city
FROM Account NATURAL JOIN Branch;

-- Find the branch names and their city which have accounts but no loans.
SELECT branch_name, branch_city
FROM Account NATURAL JOIN Branch
MINUS
SELECT branch_name, branch_city
FROM Loan NATURAL JOIN Branch;

-- Find the branch names and their city which have no accounts and no loans.

SELECT branch_name, branch_city
FROM Branch
MINUS
SELECT branch_name, branch_city
FROM Account NATURAL JOIN Branch
MINUS
SELECT branch_name, branch_city
FROM Loan NATURAL JOIN Branch;


SELECT branch_name, branch_city
FROM Branch
MINUS
(SELECT branch_name, branch_city
FROM Account NATURAL JOIN Branch
UNION
SELECT branch_name, branch_city
FROM Loan NATURAL JOIN Branch);

-- Aggregate Queries

-- Aggregate Function: SUM, AVG, MIN, MAX, COUNT

-- Find the total balance of all accounts.

SELECT SUM(balance) as "Total Balance"
FROM Account;

-- Find the total balance and average balance of all accounts
SELECT SUM(balance) as "Total Balance", AVG(balance) as "Avg. Balance", COUNT(balance) as "Number of Accounts"
FROM Account;

-- What is the sum and average loan amount of loans which have opened in 'Downtown' or 
-- 'Perryridge' branch.

SELECT SUM(amount) as "Total Amount", AVG(amount) as "Avg. Amount"
FROM Loan
WHERE branch_name = 'Downtown' or branch_name = 'Perryridge';

-- GROUP BY clause

-- Find avg. loan amount for each branch.

SELECT branch_name, AVG(amount)
FROM Loan
GROUP BY branch_name;

















