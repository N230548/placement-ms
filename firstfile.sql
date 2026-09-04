create DATABASE placementmanagementsystem;
use placementmanagementsystem;
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Student (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    DepartmentID INT,
    CGPA DECIMAL(3,2),
    GraduationYear YEAR,
    ResumeURL VARCHAR(255),

    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);
CREATE TABLE Skill (
    SkillID INT PRIMARY KEY AUTO_INCREMENT,
    SkillName VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Student_Skill (
    StudentID INT,
    SkillID INT,
    Proficiency VARCHAR(30),

    PRIMARY KEY (StudentID, SkillID),

    FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID)
        ON DELETE CASCADE,

    FOREIGN KEY (SkillID)
        REFERENCES Skill(SkillID)
        ON DELETE CASCADE
);
CREATE TABLE Company (
    CompanyID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(150) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Location VARCHAR(150),
    Website VARCHAR(255),
    Industry VARCHAR(100)
);
CREATE TABLE Job (
    JobID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyID INT NOT NULL,
    JobTitle VARCHAR(100) NOT NULL,
    JobDescription TEXT,
    JobType VARCHAR(50),
    MinimumCGPA DECIMAL(3,2),
    Salary DECIMAL(12,2),
    GraduationYear YEAR,
    ApplicationDeadline DATE,
    JobStatus VARCHAR(30) DEFAULT 'Open',

    FOREIGN KEY (CompanyID)
        REFERENCES Company(CompanyID)
);
CREATE TABLE Job_Skill (
    JobID INT,
    SkillID INT,

    PRIMARY KEY (JobID, SkillID),

    FOREIGN KEY (JobID)
        REFERENCES Job(JobID)
        ON DELETE CASCADE,

    FOREIGN KEY (SkillID)
        REFERENCES Skill(SkillID)
        ON DELETE CASCADE
);
CREATE TABLE Application (
    ApplicationID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    JobID INT NOT NULL,
    ApplicationDate DATE DEFAULT (CURRENT_DATE),
    ApplicationStatus VARCHAR(30) DEFAULT 'Applied',

    FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),

    FOREIGN KEY (JobID)
        REFERENCES Job(JobID),

    UNIQUE (StudentID, JobID)
);
CREATE TABLE Interview (
    InterviewID INT PRIMARY KEY AUTO_INCREMENT,
    ApplicationID INT NOT NULL,
    InterviewDate DATETIME,
    InterviewType VARCHAR(50),
    InterviewRound INT,
    InterviewStatus VARCHAR(30) DEFAULT 'Scheduled',
    InterviewLocation VARCHAR(255),

    FOREIGN KEY (ApplicationID)
        REFERENCES Application(ApplicationID)
        ON DELETE CASCADE
);
CREATE TABLE Selection (
    SelectionID INT PRIMARY KEY AUTO_INCREMENT,
    ApplicationID INT NOT NULL UNIQUE,
    SelectionStatus VARCHAR(30),
    Package DECIMAL(12,2),
    JoiningDate DATE,
    SelectionDate DATE,

    FOREIGN KEY (ApplicationID)
        REFERENCES Application(ApplicationID)
);
CREATE TABLE PlacementOfficer (
    OfficerID INT PRIMARY KEY AUTO_INCREMENT,
    OfficerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15)
);
CREATE TABLE UserAccount (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(30) NOT NULL,
    StudentID INT,
    CompanyID INT,
    OfficerID INT,

    FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),

    FOREIGN KEY (CompanyID)
        REFERENCES Company(CompanyID),

    FOREIGN KEY (OfficerID)
        REFERENCES PlacementOfficer(OfficerID)
);

INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science and Engineering'),
(2, 'Information Technology'),
(3, 'Electronics and Communication Engineering'),
(4, 'Mechanical Engineering'),
(5, 'Civil Engineering'),
(6, 'Electrical Engineering'),
(7, 'Artificial Intelligence and Data Science'),
(8, 'Information Science'),
(9, 'Chemical Engineering'),
(10, 'Biotechnology');