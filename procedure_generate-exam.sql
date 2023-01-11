use examDB

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
	--select TOP 1 exam_id FROM exam order by exam_id desc

	--set @id = @examID

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


exec generateExam