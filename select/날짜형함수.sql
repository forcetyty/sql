-- curdate(), current_date 
select curdate(), current_date;

-- curtime(), current_date => hh, mm, ss
select curtime(), current_date;

-- now(), sysdate(), current_timestamp() => yyyy, MM, dd, hh, mm, ss
select now(), sysdate(), current_date;

-- *********************중요**********************
-- now() vs sysdate()
-- now() -> Query가 시작할때 시간 -> 그렇기에 now 시작할때의 시간이기 때문에 고정된 시간이라고 볼 수 있다. / Query가 실행하기 전에!!!
-- sysdate() -> 출력될때의 시간 -> 그렇기에 (2)에서 sysdate은 2초 정도 지연된 시간이 출력된다. / Query가 실행되면서!!!
select now(), sleep(2), now(); -- (1)
select now(), sleep(2), sysdate(); -- (2)

-- date_format
-- '%Y년 %m월 %d일 %h시 %i분 %s초' -> m은 2자리 월 출력
-- '%Y년 %c월 %d일 %h시 %i분 %s초' -> c은 1자리 월 출력
select date_format(now(), '%Y년 %m월 %d일 %h시 %i분 %s초');
select date_format(sysdate(), '%Y-%m-%d %h:%i:%s');
select date_format(sysdate(), '%Y-%c-%e %h:%i:%s:%f');

-- period_diff(p1, p2)
-- : YYMM, YYYYMM으로 표기되는 P1과 P2의 차이의 개월을 반환한다.
-- ex) 직원들의 근무 개월 수 구하기
select concat(first_name, ' ', last_name) as name,
period_diff(date_format(curdate(), '%Y%m'),
date_format(hire_date, '%Y%m'))
 from employees;
 
 
 -- date_add, adddate
 -- date_sub, subdate
 -- (date, INTERVAL expr type)
 -- : 날짜 date에 type 형식(year, month, day)으로 지정한 expr값을 더하거나 뺀다.
 -- ex) 각 직원들의 6개월 후 근무 평가일
 select concat(first_name, ' ', last_name) as name,
 hire_date,
 date_add(hire_date, INTERVAL 6 month) from employees;
 
 -- cast
 select now(), cast(now() as date), cast(now() as datetime);
 
 select 1-2, cast(1-2 as unsigned);
 
 select cast(cast(1-2 as unsigned) as signed);
 
 
 
 
 


