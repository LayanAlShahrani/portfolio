-- SORTED PROCEDURE

-- انشاء بروسيجر عادي وثلبت لا يستقبل متغيرات

create procedure stu_info
as
begin
  select s_f_name ,s_phone ,d_name
  from students s
  join departments d
   on d.d_id = s.stduydept_id ;
end;

-- الاستدعاء 
exec stu_info ;

-- انشاء بروسجير مع متغيرات 

-- اريد بروسجير يعرض اعضاء هيئة التدريس الي رواتبهم تتجاوز حد معين
create procedure member_salary_above(@max_salary as int )
as
begin
select member_id , member_f_name + member_l_name as 'Full Name'
from facultymembers
where salary > @max_salary;
end;

alter procedure member_salary_above(@max_salary as int )
as
begin
select member_id , member_f_name+' ' + member_l_name as 'Full Name'
from facultymembers
where salary > @max_salary;
end;

-- كذا اناديه
exec member_salary_above
@max_salary=16000;

-- طيب الجين بسوي بروسجير يستقبل باراميتر ويطلع قيمة
create procedure No_member_salary_above(@max_salary as int , @member_count as int output )
as
begin
select member_id , member_f_name + member_l_name as 'Full Name'
from facultymembers
where salary > @max_salary;

-- برجع المتغير الي بيرجع بقيمة
select @member_count  = @@ROWCOUNT;
-- rowcount هذه بترجع عدد الصفوف الناتجة عن الاستعلام  
end;

-- لازم قبل استعدي اسوي متغير عشان اخزن فيخ القيمة الي بتجي
-- ولازم احدد سطر الانشاء معاهم اذا جيت اسوي رن
declare @count as int;

exec No_member_salary_above 
@max_salary = 16000 ,
@member_count = @count output ;
-- كذا بالسطور العلوية ما راح يعرض لي الاوتبت فقط بيعرض حق الاستعلام الي كان داخل البروسجير 
-- عشان يعرض الاوتبت لازم اشغل ذا السطر معاهم
select @count as 'number of member with salary above ';



-- مثال اخر
-- كم عدد اعضاء هيئة التدريس الذين يعملون في قسم مع بيااناتهم
alter procedure member_of_dept(@dept_id as varchar(2) , @no_of_member as int output)
as
begin 
select member_id , member_f_name + member_l_name as 'Full Name'
from facultymembers
where deptwork_id = @dept_id ;

select @no_of_member = @@ROWCOUNT;

end;

declare @counter as int ;

exec member_of_dept
@dept_id ='CS',
@no_of_member = @counter output;

select @counter as 'Number of member in dept ' ;





--هذا ليه سويته ؟ لاني زمان كنت غبية سويت ال
--Varchar 
-- كذا سادرة بدون احدد حجم فكان ما ياخذ الا اول حرف من الاي دي تبع القسم وبالعقل يطلع لي مافيه داتا تطابق 
-- لذلك سويت جملة طباعه داخل عشان اشوف ايش القيمة الي كانت تسند ل
--@dept_id
-- ومن هنا اكتشتفت الغلط وسلامتي
ALTER PROCEDURE member_of_dep(@dept_id AS VARCHAR(2) = 'CS')
AS
BEGIN
    PRINT 'Department ID: ' + @dept_id; -- Add this line for debugging
    SELECT member_id, member_f_name + member_l_name AS 'Full Name'
    FROM facultymembers
    WHERE deptwork_id = @dept_id;
END;

exec member_of_dep  ;

drop procedure member_of_dep;

