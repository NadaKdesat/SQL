create database Test;

-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DepartmentID INT
);

-- Insert Employees Data
INSERT INTO Employees VALUES (1, 'Ahmed', 101);
INSERT INTO Employees VALUES (2, 'Sarah', 102);
INSERT INTO Employees VALUES (3, 'Khalid', NULL); -- Employee without a department
INSERT INTO Employees VALUES (4, 'Laila', 104); -- Department does not exist in the Departments table

-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Insert Departments Data
INSERT INTO Departments VALUES (101, 'Human Resources');
INSERT INTO Departments VALUES (102, 'IT');
INSERT INTO Departments VALUES (103, 'Accounting'); -- A department without employees

-- Create Projects Table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50)
);

-- Insert Projects Data
INSERT INTO Projects VALUES (1, 'Web Application');
INSERT INTO Projects VALUES (2, 'Accounting System');
INSERT INTO Projects VALUES (3, 'Process Automation');

-- Create Enrollments Table (Junction Table for Many-to-Many)
CREATE TABLE Enrollments (
    EmployeeID INT,
    ProjectID INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

-- Insert Enrollments Data
INSERT INTO Enrollments VALUES (1, 1); -- Ahmed works on Web Application
INSERT INTO Enrollments VALUES (1, 2); -- Ahmed works on Accounting System
INSERT INTO Enrollments VALUES (2, 1); -- Sarah works on Web Application
INSERT INTO Enrollments VALUES (3, 3); -- Khalid works on Process Automation

--INNER JOIN
SELECT * from Employees;
SELECT * from Departments;
SELECT e.Name, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;


--LEFT JOIN
SELECT * from Employees;
SELECT * from Departments;
SELECT e.Name, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;


--RIGHT JOIN
SELECT * from Employees;
SELECT * from Departments;
SELECT e.Name, d.DepartmentName
FROM Employees e
RIGHT JOIN Departments d ON e.DepartmentID = d.DepartmentID;


--FULL JOIN
SELECT * from Employees;
SELECT * from Departments;
SELECT e.Name, d.DepartmentName
FROM Employees e
FULL JOIN Departments d ON e.DepartmentID = d.DepartmentID;


--Many to Many
SELECT * from Employees;
SELECT * from Projects;
SELECT e.Name, p.ProjectName
FROM Employees e
INNER JOIN Enrollments en ON e.EmployeeID = en.EmployeeID
INNER JOIN Projects p ON en.ProjectID = p.ProjectID;
