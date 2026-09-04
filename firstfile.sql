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

INSERT INTO Student
(StudentID, StudentName, Email, Phone, DateOfBirth, Gender, DepartmentID, CGPA, GraduationYear, ResumeURL)
VALUES
(1, 'Aarav Patel', 'aarav.patel@email.com', '9876543210', '2004-05-12', 'Male', 1, 8.75, 2026, 'resume/aarav.pdf'),
(2, 'Diya Shah', 'diya.shah@email.com', '9876543211', '2004-08-21', 'Female', 2, 9.10, 2026, 'resume/diya.pdf'),
(3, 'Rohan Mehta', 'rohan.mehta@email.com', '9876543212', '2003-11-15', 'Male', 3, 7.85, 2026, 'resume/rohan.pdf'),
(4, 'Ananya Desai', 'ananya.desai@email.com', '9876543213', '2004-02-18', 'Female', 4, 8.60, 2026, 'resume/ananya.pdf'),
(5, 'Kunal Joshi', 'kunal.joshi@email.com', '9876543214', '2003-09-30', 'Male', 5, 7.45, 2026, 'resume/kunal.pdf'),
(6, 'Isha Mehta', 'isha.mehta@email.com', '9876543215', '2004-06-10', 'Female', 6, 8.95, 2026, 'resume/isha.pdf'),
(7, 'Vivek Trivedi', 'vivek.trivedi@email.com', '9876543216', '2003-12-05', 'Male', 7, 7.70, 2026, 'resume/vivek.pdf'),
(8, 'Meera Patel', 'meera.patel@email.com', '9876543217', '2004-03-25', 'Female', 8, 9.25, 2026, 'resume/meera.pdf'),
(9, 'Rahul Shah', 'rahul.shah@email.com', '9876543218', '2003-07-19', 'Male', 9, 8.20, 2026, 'resume/rahul.pdf'),
(10, 'Neha Joshi', 'neha.joshi@email.com', '9876543219', '2004-10-11', 'Female', 10, 8.40, 2026, 'resume/neha.pdf');


INSERT INTO Skill (SkillID, SkillName) VALUES
(1, 'Java'),
(2, 'Python'),
(3, 'C++'),
(4, 'SQL'),
(5, 'HTML/CSS'),
(6, 'JavaScript'),
(7, 'React'),
(8, 'Machine Learning'),
(9, 'Data Structures'),
(10, 'Communication');

INSERT INTO Student_Skill (StudentID, SkillID, Proficiency) VALUES
(1, 1, 'Advanced'),
(2, 2, 'Advanced'),
(3, 3, 'Intermediate'),
(4, 5, 'Advanced'),
(5, 4, 'Intermediate'),
(6, 8, 'Advanced'),
(7, 10, 'Advanced'),
(8, 7, 'Advanced'),
(9, 6, 'Intermediate'),
(10, 9, 'Advanced');

INSERT INTO Company
(CompanyID, CompanyName, Email, Phone, Location, Website, Industry)
VALUES
(1, 'Tata Consultancy Services', 'hr@tcs.com', '18002093111', 'Mumbai', 'https://www.tcs.com', 'IT Services'),
(2, 'Infosys', 'careers@infosys.com', '18004195500', 'Bengaluru', 'https://www.infosys.com', 'IT Services'),
(3, 'Wipro', 'careers@wipro.com', '18004250425', 'Bengaluru', 'https://www.wipro.com', 'IT Services'),
(4, 'Accenture', 'careers@accenture.com', '18001234567', 'Pune', 'https://www.accenture.com', 'Consulting'),
(5, 'Tech Mahindra', 'careers@techmahindra.com', '18003000444', 'Pune', 'https://www.techmahindra.com', 'IT Services'),
(6, 'IBM', 'careers@ibm.com', '18001234567', 'Bengaluru', 'https://www.ibm.com', 'Technology'),
(7, 'Deloitte', 'careers@deloitte.com', '18002345678', 'Hyderabad', 'https://www.deloitte.com', 'Consulting'),
(8, 'Capgemini', 'careers@capgemini.com', '18003456789', 'Mumbai', 'https://www.capgemini.com', 'IT Services'),
(9, 'Cognizant', 'careers@cognizant.com', '18004567890', 'Chennai', 'https://www.cognizant.com', 'IT Services'),
(10, 'HCLTech', 'careers@hcltech.com', '18005678901', 'Noida', 'https://www.hcltech.com', 'Technology');

INSERT INTO Job
(JobID, CompanyID, JobTitle, JobDescription, JobType, MinimumCGPA, Salary, GraduationYear, ApplicationDeadline, JobStatus)
VALUES
(1, 1, 'Software Developer', 'Develop software applications.', 'Full-Time', 7.50, 650000, 2026, '2026-09-20', 'Open'),
(2, 2, 'Systems Engineer', 'Develop and maintain enterprise systems.', 'Full-Time', 7.00, 600000, 2026, '2026-09-21', 'Open'),
(3, 3, 'Project Engineer', 'Work on software development projects.', 'Full-Time', 7.00, 550000, 2026, '2026-09-22', 'Open'),
(4, 4, 'Software Engineer', 'Develop modern software solutions.', 'Full-Time', 8.00, 700000, 2026, '2026-09-23', 'Open'),
(5, 5, 'Web Developer', 'Build responsive web applications.', 'Full-Time', 7.50, 580000, 2026, '2026-09-24', 'Open'),
(6, 6, 'Data Analyst', 'Analyze business data and generate reports.', 'Full-Time', 8.00, 620000, 2026, '2026-09-25', 'Open'),
(7, 7, 'Business Analyst', 'Analyze business processes and requirements.', 'Full-Time', 7.50, 680000, 2026, '2026-09-26', 'Open'),
(8, 8, 'Frontend Developer', 'Develop user-friendly web interfaces.', 'Full-Time', 7.00, 590000, 2026, '2026-09-27', 'Open'),
(9, 9, 'Programmer Analyst', 'Design and develop software applications.', 'Full-Time', 7.50, 610000, 2026, '2026-09-28', 'Open'),
(10, 10, 'Cloud Engineer', 'Manage and develop cloud-based solutions.', 'Full-Time', 8.00, 750000, 2026, '2026-09-29', 'Open');

INSERT INTO Job_Skill (JobID, SkillID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 9),
(5, 5),
(6, 8),
(7, 10),
(8, 7),
(9, 4),
(10, 6);

INSERT INTO Application
(ApplicationID, StudentID, JobID, ApplicationDate, ApplicationStatus)
VALUES
(1, 1, 1, '2026-09-05', 'Shortlisted'),
(2, 2, 2, '2026-09-05', 'Shortlisted'),
(3, 3, 3, '2026-09-06', 'Applied'),
(4, 4, 4, '2026-09-06', 'Shortlisted'),
(5, 5, 5, '2026-09-07', 'Rejected'),
(6, 6, 6, '2026-09-07', 'Shortlisted'),
(7, 7, 7, '2026-09-08', 'Applied'),
(8, 8, 8, '2026-09-08', 'Selected'),
(9, 9, 9, '2026-09-09', 'Shortlisted'),
(10, 10, 10, '2026-09-10', 'Selected');


INSERT INTO Interview
(InterviewID, ApplicationID, InterviewDate, InterviewType, InterviewRound, InterviewStatus, InterviewLocation)
VALUES
(1, 1, '2026-09-12 10:00:00', 'Technical', 1, 'Completed', 'Online'),
(2, 2, '2026-09-12 11:00:00', 'Technical', 1, 'Completed', 'Online'),
(3, 3, '2026-09-13 10:00:00', 'Technical', 1, 'Scheduled', 'College Lab 1'),
(4, 4, '2026-09-13 11:00:00', 'Technical', 1, 'Completed', 'Online'),
(5, 5, '2026-09-14 10:00:00', 'Technical', 1, 'Completed', 'Online'),
(6, 6, '2026-09-14 11:00:00', 'Technical', 1, 'Completed', 'College Lab 2'),
(7, 7, '2026-09-15 10:00:00', 'Technical', 1, 'Scheduled', 'Online'),
(8, 8, '2026-09-15 11:00:00', 'HR', 2, 'Completed', 'Online'),
(9, 9, '2026-09-16 10:00:00', 'Technical', 1, 'Scheduled', 'College Lab 1'),
(10, 10, '2026-09-16 11:00:00', 'HR', 2, 'Completed', 'Online');


INSERT INTO Selection
(SelectionID, ApplicationID, SelectionStatus, Package, JoiningDate, SelectionDate)
VALUES
(1, 1, 'Selected', 650000, '2027-01-04', '2026-09-16'),
(2, 2, 'Selected', 600000, '2027-01-05', '2026-09-16'),
(3, 3, 'Not Selected', NULL, NULL, '2026-09-17'),
(4, 4, 'Selected', 700000, '2027-01-11', '2026-09-17'),
(5, 5, 'Not Selected', NULL, NULL, '2026-09-17'),
(6, 6, 'Selected', 620000, '2027-01-06', '2026-09-18'),
(7, 7, 'Not Selected', NULL, NULL, '2026-09-18'),
(8, 8, 'Selected', 590000, '2027-01-08', '2026-09-18'),
(9, 9, 'Selected', 610000, '2027-01-10', '2026-09-19'),
(10, 10, 'Selected', 750000, '2027-01-12', '2026-09-19');


INSERT INTO PlacementOfficer
(OfficerID, OfficerName, Email, Phone)
VALUES
(1, 'Dr. Rajesh Kumar', 'rajesh.kumar@college.edu', '9876500001'),
(2, 'Prof. Sneha Patel', 'sneha.patel@college.edu', '9876500002'),
(3, 'Mr. Amit Shah', 'amit.shah@college.edu', '9876500003'),
(4, 'Dr. Priya Mehta', 'priya.mehta@college.edu', '9876500004'),
(5, 'Prof. Rahul Desai', 'rahul.desai@college.edu', '9876500005'),
(6, 'Ms. Neha Joshi', 'neha.joshi@college.edu', '9876500006'),
(7, 'Mr. Karan Trivedi', 'karan.trivedi@college.edu', '9876500007'),
(8, 'Dr. Pooja Shah', 'pooja.shah@college.edu', '9876500008'),
(9, 'Prof. Vivek Patel', 'vivek.patel@college.edu', '9876500009'),
(10, 'Ms. Rina Mehta', 'rina.mehta@college.edu', '9876500010');


INSERT INTO UserAccount
(UserID, Username, PasswordHash, Role, StudentID, CompanyID, OfficerID)
VALUES
(1, 'aarav.patel', '$2b$12$example_hash_aarav', 'Student', 1, NULL, NULL),
(2, 'diya.shah', '$2b$12$example_hash_diya', 'Student', 2, NULL, NULL),
(3, 'rohan.mehta', '$2b$12$example_hash_rohan', 'Student', 3, NULL, NULL),
(4, 'ananya.desai', '$2b$12$example_hash_ananya', 'Student', 4, NULL, NULL),
(5, 'tcs.hr', '$2b$12$example_hash_tcs', 'Company', NULL, 1, NULL),
(6, 'infosys.hr', '$2b$12$example_hash_infosys', 'Company', NULL, 2, NULL),
(7, 'wipro.hr', '$2b$12$example_hash_wipro', 'Company', NULL, 3, NULL),
(8, 'rajesh.kumar', '$2b$12$example_hash_rajesh', 'Officer', NULL, NULL, 1),
(9, 'sneha.patel', '$2b$12$example_hash_sneha', 'Officer', NULL, NULL, 2),
(10, 'amit.shah', '$2b$12$example_hash_amit', 'Officer', NULL, NULL, 3);