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
select c.title as 직책,avg(a.salary) as 평균연봉,count(b.emp_no) as 인원수
from salaries a, employees b,titles c
where a.emp_no = b.emp_no
   and b.emp_no = c.emp_no
    and c.to_date = '9999-01-01'
group by c.title
having count(b.emp_no) >= 100
order by count(b.emp_no) desc;

-- [과제] 
-- ex7) 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.
select avg(c.salary) as 평균급여, d.dept_name as 부서
from titles a, dept_emp b,salaries c, departments d
where a.emp_no = b.emp_no
   and b.emp_no = c.emp_no
    and d.dept_no = b.dept_no
    and a.to_date='9999-01-01'
    and b.to_date='9999-01-01'
    and a.title = 'Engineer'
group by d.dept_name
order by avg(c.salary) desc;
