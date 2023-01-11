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
select s.first_name +' '+ s.last_name 'full name',c.name 'course',isnull(sc.grade,0) 
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
