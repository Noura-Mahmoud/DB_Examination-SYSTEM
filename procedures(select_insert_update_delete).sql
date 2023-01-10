--select from any table by passing table name
CREATE PROCEDURE select_all_data (@table_name VARCHAR(50))
AS
BEGIN
    DECLARE @query NVARCHAR(MAX) = 'SELECT * FROM ' + @table_name;
    EXEC sp_executesql @query;
END
GO
----------------------------------------------------------------
---------------------Insert-------------------------------------
--1)insert into department
CREATE PROCEDURE insert_department(
 @name VARCHAR(50)
)
AS
BEGIN
	INSERT INTO department VALUES(@name)
END
GO
--2) insert into student
CREATE PROCEDURE insert_student
(
  @dept_id INT,
  @first_name VARCHAR(50),
  @last_name VARCHAR(50),
  @email VARCHAR(50),
  @phone_number VARCHAR(50)
)
AS
BEGIN
	INSERT INTO student VALUES(@dept_id,@first_name,@last_name,@email,@phone_number)
END
GO
--3) insert into instructor
CREATE PROCEDURE insert_instructor
(
    @dept_id INT ,
    @first_name VARCHAR(50),
	@last_name VARCHAR(50),
	@email VARCHAR(50),
	@phone_number VARCHAR(50)
)
AS
BEGIN
	INSERT INTO instructor VALUES(@dept_id,@first_name,@last_name,@email,@phone_number)
END
GO
--4)insert exam
CREATE PROCEDURE insert_exam
(
    @exam_description VARCHAR(50),
    @exam_duration INT,
	@Crs_Id INTEGER
)
AS
BEGIN
	INSERT INTO exam VALUES(@exam_description,@exam_duration,@Crs_Id)
END
GO
--5)insert course
CREATE PROCEDURE insert_course
(
    @name VARCHAR(50),
	@description VARCHAR(50)
)
AS
BEGIN
	INSERT INTO course VALUES(@name,@description)
END
GO
--6)insert question
CREATE PROCEDURE insert_question
(
	@q_text varchar(50),
	@correct_ans_id char(1),
	@ques_type varchar(20),
	@difficulty_level INT,
    @marks_worth INT,
	@Crs_Id INTEGER
)
AS
BEGIN
	INSERT INTO question values(@q_text,@correct_ans_id,@ques_type,@difficulty_level,@marks_worth,@Crs_Id)
END
GO
--7)insert topic
CREATE PROCEDURE insert_choice
(
	@choice_Id char(1),
	@choice_text varchar(200),
	@correct_choice BIT,
	@question_Id INTEGER
)
AS
BEGIN
	INSERT INTO choice values(@choice_Id,@choice_text,@correct_choice,@question_Id)
END
GO
--8)insert topic
CREATE PROCEDURE insert_topic
(
	@crs_id INT
)
AS
BEGIN
	INSERT INTO topic values(@crs_id)
END
GO


