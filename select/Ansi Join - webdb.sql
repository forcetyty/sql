-- 1. 데이터 넣기

select * from employee;
select * from department;

insert into department values(null, '총무팀');
insert into department values(null, '영업팀');
insert into department values(null, '인사팀');
insert into department values(null, '개발팀');

insert into employee values(null, '둘리', 1);
insert into employee values(null, '마이콜', 2);
insert into employee values(null, '또치', 3);
insert into employee values(null, '회장님', null);

truncate department;
truncate employee;
commit;
delete from department where no = 1;

-- inner join
-- 1. 조심 : equi join : cartisian product(m x n)
select * from employee, department;

-- 2. equi join
select * from employee, department
where employee.department_no = department.no;

select * from employee a, department b
where a.department_no = b.no;

select a.no, a.name, b.name from employee a, department b 
where a.department_no = b.no;


-- 3. join on (ANSI SQL 1999)
select a.no, a.name, b.name from employee a join department b 
on a.department_no = b.no;

-- outter join
-- 1. left join
select a.no, a.name,ifnull( b.name, '사장님') from employee a left join department b 
on a.department_no = b.no;

-- 2. right join
select a.no, ifnull(a.name, '채용요망'),b.name from employee a right join department b 
on a.department_no = b.no;

-- 3. full join
-- mysql / mariaDB 지원안함!!!
-- select a.no, a.name,b.name from employee a full join department b 
-- on a.department_no = b.no;











