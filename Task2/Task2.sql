--SQL day 3 Task : 
--As a SQL developer in my Company  "Ayman for Teck solutions 😎"  you are responsible for building the database for the new project, where the project is School 
--System contains the following tables : ( Teachers, TeacherDetails, Courses, Students ). So you have to start with Database schema first to understand the
--structure of the database then you have to create these tables with the appropriate fields in each one of them and create the correct relationship between
--them to be logically and functionally Right ,and after that insert at least Five records in each table .

Create database School;
Go
use School;
Go
Create Schema SchoolSchema;
Go

Create Table SchoolSchema.Teachers
(
ID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(50) UNIQUE NOT NULL,
);

Create Table SchoolSchema.TeacherDetails
(
ID INT PRIMARY KEY,
Teacher_ID INT UNIQUE,
Salary DECIMAL(10,2),
Address VARCHAR(255),
DateOfBirth DATE,
FOREIGN KEY (Teacher_ID) REFERENCES SchoolSchema.Teachers(ID) ON DELETE CASCADE
);

Create Table SchoolSchema.Courses
(
ID INT PRIMARY KEY,
Teacher_ID INT,
CourseName VARCHAR(100) NOT NULL,
FOREIGN KEY (Teacher_ID) REFERENCES SchoolSchema.Teachers(ID) ON DELETE CASCADE
);

Create Table SchoolSchema.Students
(
ID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(50) UNIQUE NOT NULL,
);


Create Table SchoolSchema.Student_Courses
(
Student_ID INT,
Course_ID INT,
PRIMARY KEY (Student_ID, Course_ID),
FOREIGN KEY (Student_ID) REFERENCES SchoolSchema.Students(ID),
FOREIGN KEY (Course_ID) REFERENCES SchoolSchema.Courses(ID)
);

Create Table SchoolSchema.Student_Teachers
(
Student_ID INT,
Teacher_ID INT,
PRIMARY KEY (Student_ID, Teacher_ID),
FOREIGN KEY (Student_ID) REFERENCES SchoolSchema.Students(ID),
FOREIGN KEY (Teacher_ID) REFERENCES SchoolSchema.Teachers(ID)
);

INSERT INTO SchoolSchema.Teachers (ID, FirstName, LastName, Email) VALUES
(1, 'John', 'Doe', 'john.doe@example.com'),
(2, 'Jane', 'Smith', 'jane.smith@example.com'),
(3, 'Robert', 'Brown', 'robert.brown@example.com'),
(4, 'Emily', 'Davis', 'emily.davis@example.com'),
(5, 'Michael', 'Wilson', 'michael.wilson@example.com');

INSERT INTO SchoolSchema.TeacherDetails (ID, Teacher_ID, Salary, Address, DateOfBirth) VALUES
(1, 1, 50000.00, '123 Main St', '1980-05-15'),
(2, 2, 55000.00, '456 Oak St', '1975-09-22'),
(3, 3, 48000.00, '789 Pine St', '1982-11-10'),
(4, 4, 60000.00, '101 Maple St', '1978-07-08'),
(5, 5, 53000.00, '202 Elm St', '1985-03-18');

INSERT INTO SchoolSchema.Courses (ID, Teacher_ID, CourseName) VALUES
(1, 1, 'Mathematics'),
(2, 2, 'Physics'),
(3, 3, 'Chemistry'),
(4, 4, 'Biology'),
(5, 5, 'Computer Science');

INSERT INTO SchoolSchema.Students (ID, FirstName, LastName, Email) VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@example.com'),
(2, 'Bob', 'Miller', 'bob.miller@example.com'),
(3, 'Charlie', 'Anderson', 'charlie.anderson@example.com'),
(4, 'David', 'Thomas', 'david.thomas@example.com'),
(5, 'Eve', 'Martinez', 'eve.martinez@example.com');

INSERT INTO SchoolSchema.Student_Courses (Student_ID, Course_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO SchoolSchema.Student_Teachers (Student_ID, Teacher_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

select * from SchoolSchema.Teachers;
select * from SchoolSchema.TeacherDetails;
select * from SchoolSchema.Courses;
select * from SchoolSchema.Students;
select * from SchoolSchema.Student_Courses;
select * from SchoolSchema.Student_Teachers;
