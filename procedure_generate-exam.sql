use examDB
--------------------------------------------------------------------------------------------------------------------------------------------------
create or alter proc generateExam
	@crsID int,
	--@exam_name nvarchar(50),
	@ExamDurationMinutes int,
	@ExamDescription varchar(50)=NULL,
	@nubOfQues int,
	@numOfTFQues int,
	@numOfMcqQues int 
	WITH ENCRYPTION
as
--1 
	--insert into exam(Crs_Id, exam_duration, Exam_description) values(@crsID, @ExamDurationMinutes, @ExamDescription)
	exec insert_exam
    @ExamDescription,
    @ExamDurationMinutes ,
	@crsID 

	--decalre temp table to questions and itereate on it by the cursor
	DECLARE @quesTable TABLE (questionID int)
--2
	INSERT INTO @quesTable select top (@numOfTFQues) q_id from question where Crs_Id = @crsID AND ques_type='TF'  order by newid() 
	INSERT INTO @quesTable select top (@numOfMcqQues) q_id from question where Crs_Id = @crsID AND ques_type='MCQ'  order by newid() 

	--using cursor to loop over questions
	declare c1 cursor 
	for select * from @quesTable
	for read only

	declare @examID nvarchar(200)
	select @examID = (select TOP 1 exam_id FROM exam order by exam_id desc)

	declare @qID int
	open c1
	fetch c1 into @qID
	while @@FETCH_STATUS=0
		begin
		--3
			exec insert_exam_Q
			@examID ,
			@qID 
			--insert into Exam_q(ex_Id, q_Id) values(@examID, @qID)
			fetch c1 into @qID
		end
		select @examID
	close c1
	deallocate c1
-------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER PROC updateGrade 
		@stdID int, @crsID int, @grade int
		WITH ENCRYPTION
		AS
		UPDATE Std_Crs
		SET [grade %] = @grade
		WHERE Std_Id = @stdID AND Crs_Id = @crsID;
------------------------------------------------------------------------------------------------------------------------------------------
create or alter proc ExamCorrection
	@stdID int,
	@ExamID int 
	WITH ENCRYPTION
as
	DECLARE @answers TABLE (questionID int, studentAns char(1), totalMark int)
	INSERT INTO @answers select question_id, ans_std, marks_worth from std_ans 
													inner join question	 q	
													on  q.q_id = std_ans.question_id
													where std_ans.ex_id = @ExamID AND stud_id = @stdID
	-- gather every question in the exam with its choices  
	DECLARE @choices TABLE (id char(1), correct bit, quesID int)
	INSERT INTO @choices select choice_id, correct_choice, question_Id from choice c 
																inner join  @answers ans	
																on ans.questionID = c.question_id
	DECLARE @totalGrade int
	select @totalGrade = isnull(sum(totalMark), 0)from @choices
							inner join @answers
							on questionID = quesID AND studentAns = id
	DECLARE @Grade int
	select @Grade = isnull((sum(totalMark)*100)/@totalGrade, 0) from @choices
							inner join @answers
							on questionID = quesID AND studentAns = id
								where correct = 1 
	DECLARE @crsID int
		select @crsID = Crs_Id from exam where exam_id = @ExamID

	exec updateGrade @stdID, @crsID, @Grade
	/*UPDATE Std_Crs
		SET grade = @totalGrade
		WHERE Std_Id = @stdID AND Crs_Id = @crsID;*/

		exec ExamCorrection 3,3
---------------------------------------------------------------------------------------------------------------------------------------
CREATE OR ALTER PROC getModelAnswers @examID int
AS
	select q_text as Question, choice_Id as [Choice no], choice_text as Answer from question
				inner join Exam_q	
				on question.q_id = Exam_q.q_Id
				inner join choice
				on question_Id = question.q_id
				where  Exam_q.ex_Id = @examID
				AND correct_choice = 1
------------------------------------------------------------------------------------------------------------------------------------------------

