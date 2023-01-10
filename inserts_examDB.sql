--Department
INSERT INTO department (name)
VALUES ('Computer Science'), ('Mechanical Engineering'), ('Electrical Engineering');

--Student
INSERT INTO student (dept_id, first_name, last_name, email, phone_number)
VALUES (1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'), 
       (2, 'Jane', 'Smith', 'janesmith@example.com', '555-555-5556'), 
       (3, 'Bob', 'Johnson', 'bobjohnson@example.com', '555-555-5557');


--Instuctor
INSERT INTO instructor (dept_id, first_name, last_name, email, phone_number)
VALUES (1, 'Alice', 'Brown', 'alicebrown@example.com', '555-555-5558'),
       (2, 'Charlie', 'Williams', 'charlie@example.com', '555-555-5559'),
       (3, 'David', 'Jones', 'davidjones@example.com', '555-555-5560');

--Course
INSERT INTO course (name, description)
VALUES ('Introduction to Computer Science', 'An introduction to the basic concepts of computer science'),
       ('Mechanics of Materials', 'An introduction to the mechanics of solid materials'),
       ('Electricity and Magnetism', 'An introduction to the basic principles of electricity and magnetism');

--std_crs
INSERT INTO Std_Crs (Std_Id, Crs_Id, enrollment_date, grade)
VALUES (1, 1, '2020-01-01', 85),
       (2, 2, '2020-01-02', 90),
       (3, 3, '2020-01-03', 80);

--topic
INSERT INTO topic (crs_id, topic_name)
VALUES (1, 'Algorithms'),
       (2, 'Structures'),
       (3, 'Circuits');

--ins_crs
INSERT INTO Ins_Crs (Ins_Id, Crs_Id)
VALUES (1, 1),
       (2, 2),
       (3, 3);

--exam
INSERT INTO exam (exam_description, exam_duration, Crs_Id)
VALUES ('Midterm 1', 120, 1),
       ('Midterm 2', 120, 2),
       ('Final Exam', 150, 3);

--question
INSERT INTO question (q_text, ques_type, difficulty_level, marks_worth, Crs_Id)
VALUES ('What is an algorithm?', 'MCQ', 2, 2, 1),
       ('What is the equation of the deflection curve?', 'MCQ', 3, 3, 2),
       ('What is Ohm’s law?', 'MCQ', 1, 1, 3);

INSERT INTO question VALUES ('Is the earth flat', 'TF', 1, 1, 3);

--Choices
INSERT INTO choice (choice_Id, choice_text, correct_choice, question_Id)
VALUES ('A', 'A set of instructions to be followed', 1, 1),
       ('B', 'A set of instructions to not be followed', 0, 1),
	   ('C', 'A set of values to be put', 0, 1),
	   ('D', 'A set of variables to be set', 0, 1),
       ('A', 'y = ax^3 + bx^2 + cx + d', 1, 2),
	   ('B', 'y = ax^3 + bx^3 + cx + d', 0, 2),
	   ('C', 'y = ax^2 + bx^2 + cx + d', 0, 2),
	   ('D', 'y = ax + bx^2 + d', 0, 2),
       ('A', 'V = IR', 1, 3),
	   ('B', 'E= IR', 0, 3),
	   ('C', 'I= VR', 0, 3),
	   ('D', 'R= VI', 0, 3),
	   ('A', 'TRUE', 1, 4),
	   ('B', 'FALSE', 0, 4);
       

--Exam_q
INSERT INTO Exam_q (ex_Id, q_Id)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (3, 4);

--std_ans
INSERT INTO std_ans (stud_Id, ex_id, question_id, ans_std)
VALUES (1, 1, 1, 'A'),
       (1, 1, 2, 'B'),
       (2, 2, 3, 'C'),
       (3, 3, 4, 'A');
