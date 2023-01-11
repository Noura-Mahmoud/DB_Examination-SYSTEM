--•	Report that returns the students information according to Department No parameter.

create proc Dept_students @deptID int 
with encryption 
as 
select s.first_name + ' ' + s.last_name 'full name',s.email,s.phone_number 'phone number'
from student s 
where s.dept_id = @deptID

--•	Report that takes the student ID and returns the grades of the student in all courses. %
create proc student_grades @stdID int 
with encryption 
as 
select s.first_name +' '+ s.last_name 'full name',c.name 'course',isnull(sc.grade,0) 'grade'
from student s 
join Std_Crs sc
on s.stud_id=sc.Std_Id and s.stud_id=@stdID
join course c
on c.course_id=sc.Crs_Id

--•	Report that takes the instructor ID and returns the name of the courses that he teaches and the number of student per course.

create proc instructor_courses @insID int 
with encryption 
as 
select i.first_name +' ' + i.last_name 'full name',c.name 'course' ,COUNT(*) 'number of students'
from instructor i 
join Ins_Crs ic
on i.ins_id = ic.Ins_Id and i.ins_id=@insID
join course c 
on ic.Crs_Id = c.course_id
join Std_Crs sc 
on c.course_id = sc.Crs_Id
group by c.name,i.first_name,i.last_name

--•	Report that takes course ID and returns its topics  

create proc course_topics @crsID int 
with encryption 
as 
select c.name , t.topic_name 
from course c
join topic t 
on c.course_id = t.crs_id and c.course_id=@crsID

--•	Report that takes exam number and returns the Questions in it and chocies

create proc get_exam @examID int
with encryption 
as
select q.q_text 'question' , c.choice_Id 'ID' , c.choice_text 'choice'
from exam e
join Exam_q eq
on e.exam_id = eq.ex_Id and e.exam_id = @examID
join question q
on eq.q_Id = q.q_id
join choice c 
on q.q_id = c.question_Id
order by q.q_id,c.choice_Id

--•	Report that takes exam number and the student ID then returns the Questions in this exam with the student answers.
create proc student_answers @examID int, @stdID int
with encryption 
as 
select q.q_text 'question' , sa.ans_std 'ID' , c.choice_text 'answer'
from std_ans sa
join question q 
on sa.question_id = q.q_id and sa.ex_id = @examID and sa.stud_Id = @stdID
join choice c
on q.q_id = c.question_Id and sa.ans_std = c.choice_Id
order by q.q_id

