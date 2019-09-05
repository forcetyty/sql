-- 문제1
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(*) as '평균보다 많이 받는 인원'
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and salary > ( select avg(salary)
                    from salaries
				   where to_date='9999-01-01');
                   
-- 문제2
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요.
-- 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select a.first_name, c.dept_no, b.salary as '부서연봉', a.emp_no
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
									group by c.dept_no) order by b.salary desc;

-- 문제3
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select emp.emp_no, emp.last_name, sa.salary
from employees emp, salaries sa, dept_emp dep
where emp.emp_no = sa.emp_no
and dep.emp_no = emp.emp_no
and sa.to_date = '9999-01-01'
and dep.to_date = '9999-01-01'
and sa.salary > any (select avg(sal.salary)
from dept_emp de, salaries sal
where de.emp_no = sal.emp_no
and sal.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
group by dept_no);

-- 문제4
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select em.emp_no as '사원 번호', em.last_name as '사원', se.last_name as '매니저', se.dept_name as '부서번호'
from employees em, dept_emp dept_e,
(select dept_m.emp_no, emp.last_name, dept_m.dept_no, dept.dept_name
from employees emp, dept_manager dept_m, departments dept
where  emp.emp_no = dept_m.emp_no
and dept.dept_no = dept_m.dept_no) se
where em.emp_no = dept_e.emp_no
and se.dept_no = dept_e.dept_no;


-- 문제5
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select avg(sal.salary), ti.title from salaries sal, titles ti
where sal.emp_no = ti.emp_no
and sal.to_date = '9999-01-01'
and ti.to_date = '9999-01-01'
group by ti.title;
--

select emp.emp_no, emp.last_name, ti.title, sal.salary
from employees emp, titles ti, salaries sal, 
(select avg(sal.salary) as 'avsalary', ti.title from salaries sal, titles ti
where sal.emp_no = ti.emp_no
and sal.to_date = '9999-01-01'
and ti.to_date = '9999-01-01' group by ti.title) se
where emp.emp_no = sal.emp_no
and emp.emp_no = ti.emp_no
and se.title = ti.title
order by se.avsalary
limit 1;

-- 문제6
-- 평균 연봉이 가장 높은 부서는? 





                                    