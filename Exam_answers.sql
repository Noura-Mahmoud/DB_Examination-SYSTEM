use examDB;

create proc save_answers @stdID int , @examID int , @answers nvarchar(max)
with encryption 
as

--delete the exam info if existed
delete from std_ans where stud_id = @stdID and ex_id = @examID

--convert the @answers input to XML
declare @xml xml
declare @temp varchar(500)
set @temp = replace(@answers,',','</id><ans>') 
set @xml = N'<root><ques><id>' + replace(@temp,'|','</ans></ques><ques><id>') + '</ans></ques></root>'

--insert data after conversion to XML into std_ans table
Insert into std_ans (stud_id,ex_id,question_id,ans_std)
select 
@stdID , @examID , a.t.query('id').value('.','varchar(max)') , a.t.query('ans').value('.','varchar(max)')
from @xml.nodes('//root/ques') as a(t)

--test proc answers => 'questionID,studentAnswer|questionID,studentAnswer...'
save_answers 3,2,'1,D|2,D'
