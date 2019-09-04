-- 집계함수
-- 단일행 함수!!!
-- 집계함수를 사용하면 단일행만을 출력한다.
-- 만약, 집계함수를 사용했는 select avg(salary), 
-- sum(salary), emp_no from salaries; <- 이거와 같은 경우 원칙상 안되는것이 맞지만, MySql에서는 가능 - 안좋은것
-- 위와 같은 Query는 Oracle에서는 불가능하다.

-- 4. select sum(salary) 
-- 1. from employees
-- 2. where gender = 'M'
-- 3. group by no;

select avg(salary), sum(salary)
from salaries
where emp_no='10060';

-- and avg(salary) > 40000
select avg(salary), sum(salary) 
from salaries
where to_date='9999-01-01' 
group by emp_no;

select emp_no, avg(salary) as avg_salary, sum(salary) 
from salaries
where to_date='9999-01-01' 
group by emp_no
having avg(salary) > 40000
order by avg_salary asc; -- avg(salary), avg_salary, salary


-- ex1) 각 사원별로 평균연봉 출력
select * from salaries;

select avg(salary), emp_no from salaries
group by emp_no
order by avg(salary) desc;

select * from titles
where emp_no = 109334;

select * from employees
where emp_no = 109334;

-- [과제]
-- ex2) 각 현재 Manager 직책 사원에 대한 평균 연봉은?
-- join 필요

select * from dept_manager
group by emp_no;

select * from salaries;
select avg(salary), emp_no from salaries group by emp_no;

select salary, emp_no
from salaries as sal right join dept_manager as dept
on  sal.emp_no = dept.dept_no;

select *
from salaries a, titles b
where a.emp_no = b.emp_no;

select b.title, a.salary
from salaries a, titles b
where a.emp_no = b.emp_no    -- 조인조건
and a.to_date = '9999-01-01' -- row 선택조건1
and b.to_date = '9999-01-01' -- row 선택조건2
and b.title = 'Manager';      -- row 선택조건3

-- 최종
select avg(a.salary)
from salaries a, titles b
where a.emp_no = b.emp_no     -- 조인조건
and a.to_date = '9999-01-01'  -- row 선택조건1
and b.to_date = '9999-01-01'  -- row 선택조건2
and b.title = 'Manager';      -- row 선택조건3

-- ex2-1) 각 현재 직책별 평균 연봉은?
select b.title, avg(a.salary)
from salaries a, titles b
where a.emp_no = b.emp_no     -- 조인조건
	and a.to_date = '9999-01-01'  -- row 선택조건1
	and b.to_date = '9999-01-01'  -- row 선택조건2
	group by b.title
    order by avg(a.salary) desc;




-- 사원별 몇 번의 직책변경이 있었는지 조회

select emp_no, count(*) from titles
group by emp_no
order by count(*) desc;

select * from titles where emp_no='204120';

-- ex4 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
select emp_no, avg(salary)
from salaries
group by emp_no
having avg(salary) > 50000
order by avg(salary) asc;

-- [과제]
-- ex5) 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요 
-- 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에 대해서 내림차순(DESC)로 정렬하세요.
select a.title, sum(b.salary)
from titles a, salaries b
where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
    and a.title != 'Engineer'
group by a.title 
having sum(b.salary) > 2000000000
order by sum(b.salary) desc;

-- [과제]
-- ex6) 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.=>join

-- [과제] 
-- ex7) 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.


-- limit
-- 게시판 만들때 주로 사용
select * from employees limit 0, 10;
select * from employees limit 10, 10;
select * from employees limit 20, 20;






