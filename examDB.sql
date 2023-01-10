CREATE DATABASE examDB;
-- DROP DATABASE examDB

USE examDB;

CREATE TABLE department (
  dept_id INT PRIMARY KEY IDENTITY,
  name VARCHAR(50)
);


CREATE TABLE student (
  stud_id INT PRIMARY KEY IDENTITY,
  dept_id INT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(50),
  phone_number VARCHAR(50),
  FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE instructor (
    ins_id INT PRIMARY KEY IDENTITY,
    dept_id INT NOT NULL,
    first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	phone_number VARCHAR(50),
  FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);


CREATE TABLE course (
  course_id INT PRIMARY KEY IDENTITY,
  name VARCHAR(50),
  description VARCHAR(50),
);


CREATE TABLE Std_Crs (
    Std_Id INTEGER REFERENCES student(stud_id) NOT NULL,
    Crs_Id INTEGER REFERENCES course(course_id) NOT NULL,
	enrollment_date DATE,
	grade INT,
    PRIMARY KEY (Std_Id, Crs_Id)
);


CREATE TABLE topic (
  topic_id INT PRIMARY KEY IDENTITY,  
  crs_id INT,
  FOREIGN KEY (crs_id) REFERENCES course(course_id)
);


CREATE TABLE Ins_Crs (
    Ins_Id INTEGER REFERENCES instructor(ins_id) NOT NULL,
    Crs_Id INTEGER REFERENCES course(course_id) NOT NULL,
    PRIMARY KEY (Ins_Id, Crs_Id)
);


CREATE TABLE exam(
    exam_id INT PRIMARY KEY IDENTITY,
	exam_description VARCHAR(50),
    exam_duration INT,
	Crs_Id INTEGER REFERENCES course(course_id) NOT NULL,
);


CREATE TABLE question(
    q_id INT PRIMARY KEY IDENTITY,
	q_text varchar(50) NOT NULL,
	correct_ans_id char(1) NOT NULL,
	ques_type varchar(20), /*0 for t&f, 1 for mcq*/
	difficulty_level INT,
    marks_worth INT,
	Crs_Id INTEGER REFERENCES course(course_id)NOT NULL,
);


CREATE TABLE choice(
	choice_Id char(1), -- A, B, C OR d
	choice_text varchar(200) NOT NULL,
	correct_choice BIT,
	question_Id INTEGER REFERENCES question(q_id) NOT NULL,
	PRIMARY KEY (choice_Id, question_Id)
);



CREATE TABLE Exam_q(
    ex_Id INTEGER REFERENCES exam(exam_id) NOT NULL,
    q_Id INTEGER REFERENCES question(q_id) NOT NULL,
    PRIMARY KEY (ex_id, q_id)
);


CREATE TABLE std_ans(
    stud_Id INTEGER REFERENCES student(stud_id) NOT NULL,
    ex_id INTEGER REFERENCES exam(exam_id)NOT NULL,
	question_id INTEGER REFERENCES question(q_id) NOT NULL,
	ans_std char(1),
    PRIMARY KEY (stud_id,ex_id,question_id)
);









