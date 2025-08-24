/*
=====================================================
   SQL Portfolio - RAGHAV
   Description: Collection of SQL queries & projects
   Notes: Each section demonstrates a key SQL skill
=====================================================
*/

-- =====================
-- 1. Database Setup
-- =====================
-- Example schema creation
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

INSERT INTO Employees (EmpID, Name, Department, Salary, HireDate) VALUES
(1, 'Alice', 'HR', 55000, '2020-01-15'),
(2, 'Bob', 'IT', 70000, '2019-03-20'),
(3, 'Charlie', 'Finance', 80000, '2021-07-10'),
(4, 'David', 'IT', 90000, '2018-11-01'),
(5, 'Eva', 'HR', 60000, '2022-05-12');

-- =====================
-- 2. Basic Queries
-- =====================
-- Select all employees
SELECT * FROM Employees;

-- Find employees in IT department
SELECT * FROM Employees WHERE Department = 'IT';

-- =====================
-- 3. Aggregations
-- =====================
-- Average salary by department
SELECT Department, AVG(Salary) AS Avg_Salary
FROM Employees
GROUP BY Department;

-- =====================
-- 4. Subqueries
-- =====================
-- Find employees earning above the average salary
SELECT Name, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- =====================
-- 5. Joins
-- =====================
-- Example: Employee projects
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    EmpID INT
);

INSERT INTO Projects VALUES
(101, 'ERP Migration', 2),
(102, 'Tax Audit', 3),
(103, 'Cloud Setup', 4);

-- Join employees with projects
SELECT e.Name, p.ProjectName
FROM Employees e
JOIN Projects p ON e.EmpID = p.EmpID;

-- =====================
-- 6. Window Functions
-- =====================
-- Rank employees by salary within each department
SELECT Name, Department, Salary,
       RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

-- =====================
-- 7. Real-World Scenario
-- =====================
-- Find top 2 highest paid employees in each department
SELECT Name, Department, Salary
FROM (
    SELECT Name, Department, Salary,
           DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS rnk
    FROM Employees
) t
WHERE rnk <= 2;
