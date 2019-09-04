-- ANSI JOIN 1999
-- 1. join on (ANSI SQL 1999)
select a.emp_no, a.first_name, c.dept_name 
from employees a 
join dept_emp b on a.emp_no = b.emp_no
join departments c
on b.dept_no = c.dept_no;

-- 2. natural join
select a.first_name, b.title
from employees a
join titles b
on a.emp_no = b.emp_no;

-- antural join은 추천하지 않는다.
-- 두개의 테이블에서 같은 속성을 찾아서 조인
select a.first_name, b.title
from employees a natural join titles b;

-- 2-1 natural join의 문제점
-- natural join으로 인해서 내가 원하지 않은 결합도 발생하여, 원하는 값을 얻기 어렵다.
-- 해결하기 위해서는 join ~ using을 사용
-- join ~ using은 natural join의 문제점을 해결하기 위해서 사용.
select * from salaries a natural join titles b;

select count(*) from salaries a join titles b using(emp_no);






