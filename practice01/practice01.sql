-- 1번문제
-- 사번이 10944인 사원의 이름은(전체 이름)
select concat(first_name,' ',last_name), gender, hire_date from employees;

-- 2번문제
-- 전체직원의 다음 정보를 조회하세요.
-- 가장 선임부터 출력이 되도록 하세요. 
-- 출력은 이름, 성별,  입사일 순서이고 “이름”, “성별”, “입사일로 컬럼 이름을 대체해 보세요.
select concat(first_name,' ',last_name) as '이름', gender as '성별',
hire_date as '입사일' from employees order by hire_date asc;

-- 3번문제
-- 여직원과 남직원은 각 각 몇 명이나 있나요?
-- 신기하다. Oracle은 무조건 From 뒤에 문자을 적어줘야 하는데, 이건 그렇지 않다
select (select count(gender) as man from employees
where gender = 'M') as man, (select count(gender) as woman from employees
where gender = 'F') as woman;

-- 4번문제
-- 현재 근무하고 있는 직원 수는 몇 명입니까? (salaries 테이블을 사용합니다.)
--- Oracle에서는 가능한데 이건 안된다!!!
--- select  count(emp_no)  from (select distinct emp_no from salaries);
select count(distinct emp_no) from salaries; -- 정답

select * from salaries;
select count(*) from employees;

-- 5번문제
-- 부서는 총 몇 개가 있나요?
select count(dept_name) as '총 부서수' from departments;

-- 6번문제
-- 현재 부서 매니저는 몇 명이나 있나요?(역임 매너저는 제외)
select * from dept_manager;

-- 추가 각 부서별 매니저는 몇명인지 구하라
select count(dept_no) from dept_manager;
select dept_no from dept_manager
group by emp_no having count(emp_no);

-- 7번문제
-- 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세요.
select char_length(dept_name) as 'len', dept_name from departments
order by len desc;

-- 8번문제
-- 현재 급여가 120,000이상 받는 사원은 몇 명이나 있습니까?
select count(*) from salaries where salary >= 120000;

-- 9번문제
-- 어떤 직책들이 있나요? 중복 없이 이름이 긴 순서대로 출력해 보세요.
select distinct(char_length(title))as ti, title from titles
order by ti desc;

-- 아래에서는 이건 왜 안되는거지???
select char_length(ti), title from 
(select distinct(title) as 'ti' from titles)
order by ti desc;


-- 10번
-- 현재 Enginner 직책의 사원은 총 몇 명입니까?
select count(*) from titles
where title like 'engineer';

-- 11번
-- 사번이 13250(Zeydy)인 직원이 직책 변경 상황을 시간순으로 출력해보세요.
select * from titles where emp_no = 13250
order by from_date;










