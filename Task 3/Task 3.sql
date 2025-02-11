CREATE DATABASE SchoolManagement;
USE SchoolManagement;

CREATE TABLE Students (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Address TEXT
);

CREATE TABLE Family_Info (
    ID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT UNIQUE,
    FatherName VARCHAR(255),
    ContactNumber VARCHAR(50),
    FOREIGN KEY (StudentID) REFERENCES Students(ID)
);

CREATE TABLE Courses (
    ID INT PRIMARY KEY IDENTITY(1,1),
    CourseName VARCHAR(255) NOT NULL,
    Description TEXT,
    Resource TEXT
);

CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(ID),
    FOREIGN KEY (CourseID) REFERENCES Courses(ID)
);

CREATE TABLE Classes (
    ID INT PRIMARY KEY IDENTITY(1,1),
	CourseID INT,
    ClassCode VARCHAR(50) NOT NULL,
    RoomNumber VARCHAR(50),
    Schedule TEXT,
	FOREIGN KEY (CourseID) REFERENCES Courses(ID)
);

CREATE TABLE Assignments (
    ID INT PRIMARY KEY IDENTITY(1,1),
	CourseID INT,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    DueDate DATE,
	State VARCHAR(10) CHECK (State IN('Pass', 'Failed')),
	FOREIGN KEY (CourseID) REFERENCES Courses(ID)
);

CREATE TABLE Attendance (
    ID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT,
    AttendanceDate DATE NOT NULL,
    AbsenceType VARCHAR(10) CHECK (AbsenceType IN ('Leaving', 'Absence', 'Late')),
    Reason TEXT,
    FOREIGN KEY (StudentID) REFERENCES Students(ID)
);



-- 1- Select students in a specific birth date ?
SELECT * FROM Students WHERE DateOfBirth = '2002-12-21';

-- 2- Select details of a course by its name ? 
SELECT * FROM Courses WHERE CourseName = 'Mathematics';

-- 3- Add a new column 'Email' to the Students table ?
ALTER TABLE Students ADD Email VARCHAR(255) UNIQUE;

-- 4- Insert a new student record ?
INSERT INTO Students (Name, DateOfBirth, Address, Email) 
VALUES ('John Doe', '2002-12-21', '123 Main St', 'johndoe@example.com');

-- 5- Select students who have relatives listed in the system ? 
SELECT * FROM Students
JOIN Family_Info ON Students.ID = Family_Info.StudentID;

-- 6- Select students who are enrolled in a specific course (e.g : Math) ? 
SELECT Students.ID, Students.Name, Courses.CourseName
FROM Students
JOIN Enrollments ON Students.ID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.ID
WHERE Courses.CourseName = 'Math';

-- 7- Select students who have submitted and passed a specific assignment (e.g : sql  Assignment ) ? 
SELECT Students.ID, Students.Name, Assignments.Name, Assignments.State
FROM Students
JOIN Assignments ON Assignments.CourseID IN (
    SELECT CourseID FROM Courses WHERE CourseName = 'SQL'
)
WHERE Assignments.State = 'Pass';

--8- i need the student who took an leaving between last sunday and the Thursday ? (e.g: between this date : 1/1/2024 - 5/1/2024 )
SELECT Students.ID, Students.Name, attendance.AttendanceDate, attendance.AbsenceType
FROM Students
JOIN attendance  ON Students.ID = attendance.StudentID
WHERE attendance.AbsenceType = 'Leaving'
AND attendance.AttendanceDate BETWEEN '2024-01-01' AND '2024-01-05';


INSERT INTO Students (Name, DateOfBirth, Address, Email) VALUES
('Ali Ahmad', '2003-05-10', 'Amman, Jordan', 'ali.ahmad@example.com'),
('Sara Khalid', '2002-12-21', 'Irbid, Jordan', 'sara.khalid@example.com'),
('Omar Nasser', '2004-07-15', 'Zarqa, Jordan', 'omar.nasser@example.com'),
('Lina Samir', '2001-09-05', 'Aqaba, Jordan', 'lina.samir@example.com'),
('Hassan Tamer', '2003-03-18', 'Madaba, Jordan', 'hassan.tamer@example.com');

INSERT INTO Family_Info (StudentID, FatherName, ContactNumber) VALUES
(1, 'Ahmad Saeed', '0791234567'),
(2, 'Khalid Mustafa', '0792345678'),
(3, 'Nasser Fadel', '0793456789'),
(4, 'Samir Ibrahim', '0794567890'),
(5, 'Tamer Youssef', '0795678901');

INSERT INTO Courses (CourseName, Description, Resource) VALUES
('Mathematics', 'Advanced mathematics course', 'math_resources.pdf'),
('Physics', 'Basic physics principles', 'physics_resources.pdf'),
('SQL', 'Database management and queries', 'sql_resources.pdf'),
('Computer Science', 'Fundamentals of computing', 'cs_resources.pdf'),
('English', 'Language and literature studies', 'english_resources.pdf'),
('Math', 'Advanced math course', 'math_resources.pdf');

INSERT INTO Enrollments (StudentID, CourseID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5),
(1, 3), (2, 4), (3, 5), (4, 1), (5, 2);

INSERT INTO Classes (CourseID, ClassCode, RoomNumber, Schedule) VALUES
(1, 'MATH101', 'Room A1', 'Sunday-Tuesday 10:00 AM'),
(2, 'PHYS101', 'Room B1', 'Monday-Wednesday 11:00 AM'),
(3, 'SQL201', 'Room C1', 'Tuesday-Thursday 12:00 PM'),
(4, 'CS301', 'Room D1', 'Wednesday-Friday 01:00 PM'),
(5, 'ENG101', 'Room E1', 'Thursday-Saturday 02:00 PM');

INSERT INTO Assignments (CourseID, Name, Description, DueDate, State) VALUES
(1, 'Math Homework 1', 'Algebra problems', '2024-02-10', 'Pass'),
(2, 'Physics Lab Report', 'Newton’s laws experiment', '2024-02-15', 'Failed'),
(3, 'SQL Assignment', 'Write complex queries', '2024-02-20', 'Pass'),
(4, 'CS Project', 'Build a simple website', '2024-02-25', 'Failed'),
(5, 'English Essay', 'Analyze a poem', '2024-03-01', 'Pass');

INSERT INTO Attendance (StudentID, AttendanceDate, AbsenceType, Reason) VALUES
(1, '2024-01-01', 'Leaving', 'Family emergency'),
(2, '2024-01-02', 'Late', 'Traffic jam'),
(3, '2024-01-03', 'Absence', 'Sick leave'),
(4, '2024-01-04', 'Leaving', 'Doctor appointment'),
(5, '2024-01-05', 'Leaving', 'Personal reasons');
