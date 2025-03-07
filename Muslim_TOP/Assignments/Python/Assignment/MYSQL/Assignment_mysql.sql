CREATE DATABASE Assignment;
USE Assignment;

-- 1) Statement to create the Contact table
CREATE TABLE  Contact (
    ContactID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyID INT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10),
    IsMain BOOLEAN,
    Email VARCHAR(45),
    Phone VARCHAR(12)
);

-- Insert data into `Contact` table
INSERT INTO Contact 
VALUES (
    1, 
    1, 
    'Dianne', 
    'Connor', 
    '123 Main St', 
    'Philadelphia', 
    'PA', 
    '19130', 
    TRUE, 
    'dianne.connor@example.com', 
    '2155551001'
);


-- 2) Statement to create the Employee table
CREATE TABLE IF NOT EXISTS Employee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    JobTitle VARCHAR(25),
    Email VARCHAR(45),
    Phone VARCHAR(12)
);

-- Insert data into Employee table
INSERT INTO Employee 
VALUES 
(1, 'Lesley', 'Bland', 75000.00, '2022-05-15', 'Sales Manager', 'lesley.bland@example.com', '2155512341'),
(2, 'Jack', 'Lee', 60000.00, '2023-03-01', 'HR Manager', 'jack.lee@example.com', '3155555678');

-- 3) Statement to create the ContactEmployee table
CREATE TABLE  ContactEmployee (
    ContactEmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,
    Description VARCHAR(100),
    FOREIGN KEY (ContactID) REFERENCES Contact(ContactID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Insert data into ContactEmployee table
INSERT INTO ContactEmployee 
VALUES 
(1, 1, 2, '2024-11-20', 'Meeting with ABC');


-- 4) Update Lesley Bland's phone number in the Employee table
UPDATE Employee
SET Phone = '2155558800'
WHERE FirstName = 'Lesley' AND LastName = 'Bland';

--  Create the Company table
CREATE TABLE IF NOT EXISTS Company (
    CompanyID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10)
);

-- Insert data into `Company` table
INSERT INTO Company 
VALUES 
(1, 'Urban Outfitters, Inc.', '5000 Broad St', 'Philadelphia', 'PA', '19130'),
(2, 'Toll Brothers', '1000 Broad St', 'New York', 'NY', '10001');

-- 5) Update the company name from "Urban Outfitters, Inc." to "Urban Outfitters"
UPDATE Company
SET CompanyName = 'Urban Outfitters'
WHERE CompanyName = 'Urban Outfitters, Inc.';

-- 6) Remove Dianne Connor’s contact event with Jack Lee
DELETE FROM ContactEmployee
WHERE ContactID = (
    SELECT ContactID FROM Contact WHERE FirstName = 'Dianne' AND LastName = 'Connor'
) AND EmployeeID = (
    SELECT EmployeeID FROM Employee WHERE FirstName = 'Jack' AND LastName = 'Lee'
); 

-- 7) Select employees who have contacted "Toll Brothers"
SELECT e.FirstName, e.LastName
FROM Employee e
JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
JOIN Contact c ON ce.ContactID = c.ContactID
JOIN Company co ON c.CompanyID = co.CompanyID
WHERE co.CompanyName = 'Toll Brothers';

-- 8) Explanation of % and _ in LIKE statement
-- %: Represents zero, one, or multiple characters.
-- _: Represents exactly one character.
-- Example queries:
-- SELECT * FROM Employee WHERE FirstName LIKE 'L%'; -- Finds names starting with "L"
-- SELECT * FROM Employee WHERE FirstName LIKE '_e%'; -- Finds names where the second letter is "e"

-- 9) Explanation of normalization:
-- Normalization organizes data to reduce redundancy and improve data integrity by dividing large tables into smaller related ones.

-- 10) What does a JOIN in MySQL:
-- A JOIN combines rows from two or more tables based on a related column.
-- Types:
-- INNER JOIN: Only matching rows are returned.
-- LEFT JOIN: All rows from the left table and matching rows from the right.
-- RIGHT JOIN: All rows from the right table and matching rows from the left.
-- FULL OUTER JOIN: Combines all rows from both tables (not natively supported in MySQL).

-- 11) What do you understand about DDL, DCL, and DML:
-- DDL: Data Definition Language (e.g., CREATE, ALTER, DROP).
-- DCL: Data Control Language (e.g., GRANT, REVOKE).
-- DML: Data Manipulation Language (e.g., SELECT, INSERT, UPDATE, DELETE).

-- 12) What is the role of the MySQL JOIN clause in a query, and what are some common types of joins?
-- Role of the MySQL JOIN Clause:
-- The JOIN clause in MySQL is used to combine rows from two or more tables based on a related column between them. 
-- This allows you to retrieve and analyze data that is spread across multiple tables in a relational database.
-- For example, if you have a Customers table and an Orders table, a JOIN can help retrieve all orders made by each customer.
