-- 단일행 연산

-- ex)  (현재 Fai Bale이 근무하는 부서)에서 근무하는 (직원의 사번, 전체이름)을 출력해보세요.alter
-- sol 1-1)
select b.emp_no, a.dept_no
from dept_emp a, employees b
where a.emp_no = b.emp_no
and concat(b.first_name,' ',b.last_name) = 'Fai bale';

select b.emp_no, a.dept_no
from dept_emp a, employees b
where a.emp_no = b.emp_no
and to_date = '9999-01-01'
and concat(b.first_name,' ',b.last_name) = 'Fai bale';

-- sol 1-2)
select b.emp_no, concat(b.first_name,' ',b.last_name)
from dept_emp a, employees b
where a. emp_no = b.emp_no
and to_date = '9999-01-01'
and a.dept_no = 'd004';

-- sol1-1)
select    a.dept_no
from   dept_emp a,
      employees b
where    a.emp_no=b.emp_no
   and   to_date='9999-01-01'
    and   concat(b.first_name,' ', b.last_name) = 'Fai Bale';

-- sol1-2)
select    b.emp_no, concat(b.first_name,' ', b.last_name)
from   dept_emp a,
      employees b
where    a.emp_no=b.emp_no
   and   to_date='9999-01-01'
    and   a.dept_no='d004';
-- sol1-3) 서브쿼리 사용
select    a.dept_no
from   dept_emp a,
      employees b
where    a.emp_no=b.emp_no
   and   to_date='9999-01-01'
    and   a.dept_no=    (select a.dept_no
                from   dept_emp a,
                     employees b
               where    a.emp_no=b.emp_no
               and   to_date='9999-01-01'
               and   concat(b.first_name,' ', b.last_name) = 'Fai Bale');

-- 최종 결과
select b.emp_no, concat(b.first_name,' ',b.last_name)
from dept_emp a, employees b
where a. emp_no = b.emp_no
and to_date = '9999-01-01'
and a.dept_no = 'd004'
and concat(b.first_name,' ',b.last_name) = 'Fai bale';

select b.emp_no, concat(b.first_name,' ',b.last_name)
from dept_emp a, employees b
where a. emp_no = b.emp_no
and to_date = '9999-01-01'
and a.dept_no = (select b.emp_no, concat(b.first_name,' ',b.last_name)
from dept_emp a, employees b
where a. emp_no = b.emp_no
and to_date = '9999-01-01'
and a.dept_no = 'd004'
and concat(b.first_name,' ',b.last_name) = 'Fai bale');

-- 서버퀴리는 괄호로 묶여야 함!!!
-- 단일행 연산
-- 서버쿼리 내에 order by 금지
-- group by 절 외에 거의 모든 절에서 사용가능!!!! (특히, from절, where절에 많이 사용)
-- where 절인 경우,

-- 	1) 단일행 연산자 : =, >, <, >=, <=, <>

--  실습문제 1) 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의  이름, 급여를 나타내세요.
select emp.last_name, sal.salary as '평균이하' from employees emp, salaries sal
where sal.salary < (select avg(salary) from salaries)
and sal.to_date = '9999-01-01';

select *
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and salary < (select avg(salary) from salaries);

-- 실습문제2)
-- 현재 가장적은 평균 급여를 받고 있는 직책에해서  평균 급여를 구하세요   
-- 57317.5736
-- Top - K 사용
select b.title, avg(a.salary)
from salaries a, titles b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by b.title 
order by avg(salary) asc
limit 0, 1;

--
select b.title, round(avg(a.salary))
from salaries a, titles b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by b.title
having round(avg(a.salary)) =round(57317.5736);
--

-- from 절 뒤에 있는 서브쿼리에는 Ailas가 있어야 한다.
select a.avg_salary
from (select round(avg(a.salary))
from salaries a, titles b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by b.title) a;

-- 선생님 Code
-- ex) (현재 Fai Bale이 근무하는 부서)에서 근무하는 (직원의 사번, 전체이름)을 출력해보세요.
-- sol 1-1)
select a.dept_no 
  from dept_emp a, employees b
 where a.emp_no = b.emp_no
   and to_date = '9999-01-01'
   and concat(b.first_name, ' ', b.last_name) like 'Fai Bale';
-- sol 1-2)
select b.emp_no, concat(b.first_name, ' ', b.last_name)
  from dept_emp a, employees b
 where a.emp_no = b.emp_no
   and to_date = '9999-01-01'
   and a.dept_no = 'd004';  
   
-- sol subquery를 사용)
select b.emp_no, concat(b.first_name, ' ', b.last_name)
  from dept_emp a, employees b
 where a.emp_no = b.emp_no
   and to_date = '9999-01-01'
   and a.dept_no = (select a.dept_no 
					  from dept_emp a, employees b
					 where a.emp_no = b.emp_no
					   and to_date = '9999-01-01'
					   and concat(b.first_name, ' ', b.last_name) = 'Fai Bale');  

-- 서브쿼리는 괄호로 묶여야 함
-- 서브쿼리 내에 order by 금지
-- group by  절에 외에 거의 모든 절에서 사용가능(특히, from절, where절에 많이 사용)
-- where 절인 경우,
--   1) 단일행 연산자: =, >, <, >=, <=, <>


-- 실습문제1)
-- 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의 이름, 급여를 나타내세요.
select a.first_name, b.salary  
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and salary < ( select avg(salary)
                    from salaries
				   where to_date='9999-01-01');

-- 실습문제2)
-- 현재 가장적은 평균급여를 받고 있는 직책에 대해서 평균급여를 구하세요

-- 방법1: Top-K 를 사용
  select b.title, avg(a.salary)
    from salaries a, titles b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by b.title
  having round(avg(a.salary)) = (  select round(avg(a.salary))
                                     from salaries a, titles b
                                    where a.emp_no = b.emp_no
                                      and a.to_date = '9999-01-01'
                                      and b.to_date = '9999-01-01'
                                 group by b.title
                                 order by avg(a.salary) asc
                                    limit 0, 1);

-- 방법2: from절 서브쿼리 및 집계 min 함수를 사용
  select b.title, avg(a.salary)
    from salaries a, titles b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by b.title
  having round(avg(a.salary)) = (select min(a.avg_salary)
								   from (select round(avg(a.salary)) as avg_salary
                                            from salaries a, titles b
                                           where a.emp_no = b.emp_no
                                             and a.to_date = '9999-01-01'
                                             and b.to_date = '9999-01-01'
                                          group by b.title) a );
                                          

-- 방법 3: Join으로 만 풀기(굳이 서브쿼리 쓸 필요가 없다)
select b.title, round(avg(a.salary))
from salaries a, titles b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by b.title
order by avg(a.salary) asc
limit 0, 1;


-- where 절인 경우,
-- where(title, salary) = (sunquery)
-- 2) 다중(복수)행 연산자 : in, not in, any, all
-- 	2 -1) any 사용법
-- 		1. = any : in 와 완전동일 
-- 		2. > any, >= any  : 최소값
-- 		3. < any, <= any  : 최대값
-- 		4. <> any, != any : != all 와 동일

-- 	2 -2) all 사용법
-- 		1. = all : in 와 완전동일 
-- 		2. > all, >= all  : 최대값
-- 		3. < all, <= all  : 최소값

-- 1) 현재 급여가 50000 이상인 직원 이름 출력
-- 방법 1 : join으로 해결
select a.first_name, b.salary from employees a, salaries b
where  a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and salary >= 50000;

-- 방법 2 : in / Sub Query로 해결
select *
from employees a, salaries b
where a.emp_no = b.emp_no;

select first_name
from employees where emp_no = any(select salary
					from salaries where to_date = '9999-01-01'
					and salary >= 50000);
  
select first_name
from employees where emp_no in (select salary
					from salaries where to_date = '9999-01-01'
					and salary >= 50000);
                    


-- 2) 각 부서별로 최고월급을 받는 직원의 이름과 월급출력
-- dept_no, first_name, max_salary
-- 성공 직원의 이름과 월급 출력, 부서
-- 내 코드
select de.emp_no, de.dept_name, max(sal.salary), de.last_name, de.first_name
from salaries sal,
(select emp.emp_no,emp.first_name, emp.last_name, dept.dept_no, dept.dept_name,dept_e.to_date
from employees emp, dept_emp dept_e, departments dept
where emp.emp_no = dept_e.emp_no 
and dept_e.dept_no = dept.dept_no
and dept_e.to_date = '9999-01-01') de 
where sal.emp_no = de.emp_no
and sal.to_date = '9999-01-01'
group by de.dept_name;

-- 
select c.dept_no, max(b.salary) as max_salary
from employees a, salaries b, dept_emp c
where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and b.to_date='9999-01-01'
	and c.to_date = '9999-01-01'
group by c.dept_no;

-- 방법1 : where 절에 서브쿼리를 사용
select a.first_name, c.dept_no, b.salary
from employees a, salaries b, dept_emp c
where a.emp_no = b.emp_no
	and a.emp_no = c.emp_no
	and b.to_date='9999-01-01'
	and c.to_date = '9999-01-01'
    and (c.dept_no, b.salary) = any (select c.dept_no, max(b.salary) as max_salary
									from employees a, salaries b, dept_emp c
									where a.emp_no = b.emp_no
									and a.emp_no = c.emp_no
									and b.to_date='9999-01-01'
									and c.to_date = '9999-01-01'
									group by c.dept_no);

select *, (select now()) from employees;
-- 방법2 : from절에 subquery 이용!!!


    
























