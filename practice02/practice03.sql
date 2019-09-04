-- 문제 1
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
select emp.emp_no, emp.last_name, sal.salary
from employees emp join  salaries sal on emp.emp_no = sal.emp_no
order by sal.salary desc;

-- 문제 2
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
select emp.emp_no, emp.last_name, ti.title
from employees emp left join titles ti on emp.emp_no = ti.emp_no
order by emp.last_name;

-- 문제3
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요.
select emp.emp_no, concat(emp.first_name,' ',emp.last_name) as 'name', dept.dept_name
from employees emp 
left join dept_manager dept_m on emp.emp_no = dept_m.emp_no 
left join  departments dept on dept.dept_no = dept_m.dept_no
order by name;

-- 문제4
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
-- employees / salaries / titles / departments / dept_manager
select emp.emp_no as '사번', emp.last_name as '이름', avg(sal.salary) as '연봉',
ti.title as '직책', dept.dept_name as '부서', count(*)
from employees emp 
left join salaries sal on emp.emp_no = sal.emp_no
left join titles ti on emp.emp_no = ti.emp_no
left join dept_manager detp_m on emp.emp_no = detp_m.emp_no
left join departments dept on detp_m.dept_no = dept.dept_no
group by emp.emp_no;

-- 문제5
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. 
-- (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.)
-- 이름은 first_name과 last_name을 합쳐 출력 합니다.
select emp.emp_no as '사번', concat(emp.first_name,' ',emp.last_name) as '이름'
from employees emp, titles ti
where ti.title = 'Technique Leader' and ti.to_date != '9999-01-01';

-- 문제6
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
select emp.last_name as '이름', ti.title as '직책', dept.dept_name as '부서'
from employees emp 
left join titles ti on emp.emp_no = ti.emp_no
left join dept_emp dept_e on dept_e.emp_no = emp.emp_no
left join departments dept on dept.dept_no = dept_e.dept_no
where ti.to_date = '9999-01-01' and emp.last_name like "S%";


-- 문제7
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
select concat(emp.first_name,' ',emp.last_name) as 'name', ti.title, sal.salary
from employees emp, titles ti, salaries sal
where emp.emp_no = ti.emp_no 
and emp.emp_no = sal.emp_no
and ti.title ='Engineer'
and sal.salary >= 40000
order by salary;

-- 문제8
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
select ti.title, sal.salary
from salaries sal left join titles ti on
sal.emp_no = ti.emp_no
where sal.salary > 50000
group by ti.title
order by sal.salary desc; 

-- 문제9
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
select  dept.dept_name, avg(sal.salary) as 'sala'
from salaries sal, dept_emp dept_e, departments dept
where sal.emp_no = dept_e.emp_no 
and dept_e.dept_no = dept.dept_no
and sal.to_date='9999-01-01'
group by dept_e.dept_no
order by sala desc;

-- 문제10
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
select ti.title, avg(sal.salary) as 'salary'
from salaries sal, titles ti
where sal.emp_no = ti.emp_no
group by ti.title
order by salary desc;



















