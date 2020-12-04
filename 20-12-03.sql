	PRACTICE 1
6.
select DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
from DEPARTMENTS

8.
select EMPLOYEE_ID,  LAST_NAME, JOB_ID, HIRE_DATE as STARTDATE
from EMPLOYEES

9.
select distinct JOB_ID from EMPLOYEES

10.
select EMPLOYEE_ID "Emp #", LAST_NAME "Employee", JOB_ID "Job", HIRE_DATE "Hire Date"
from EMPLOYEES

12.
select EMPLOYEE_ID||','||FIRST_NAME||','||LAST_NAME||','||EMAIL||','||PHONE_NUMBER||','||JOB_ID||','||SALARY||','||
       COMMISSION_PCT||','||MANAGER_ID||','||DEPARTMENT_ID as the_output
from EMPLOYEES


	PRACTICE 2
1.
select LAST_NAME, SALARY
from EMPLOYEES
where SALARY >= 12000

2.
select LAST_NAME, DEPARTMENT_ID
from EMPLOYEES
where EMPLOYEE_ID = 176

3.
select LAST_NAME, SALARY
from EMPLOYEES
where SALARY not between 5000 and 12000

4.
select LAST_NAME, JOB_ID, HIRE_DATE
from EMPLOYEES
where HIRE_DATE between '2003-02-20' and '2003-09-01'

5.
select LAST_NAME, DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID between 20 and 50
order by LAST_NAME

6.
select LAST_NAME, salary
from EMPLOYEES
where SALARY between 5000 and 12000
and DEPARTMENT_ID in (20, 50)

8.
select LAST_NAME, JOB_ID
from EMPLOYEES
where MANAGER_ID is NULL

10.
select LAST_NAME
from EMPLOYEES
where LAST_NAME like '__a%'

12.
select LAST_NAMe, JOB_ID, SALARY
from EMPLOYEES
where SALARY not between 2500 and 3500
and salary != 7000


	PRACTICE 3
1.
select sysdate
from DUAL

2.
select EMPLOYEE_ID, LAST_NAME,SALARY, round(SALARY*1.15) "New Salary"
from EMPLOYEES

4.
select EMPLOYEE_ID, LAST_NAME,SALARY, round(SALARY*1.15) "New Salary", round(SALARY*1.15)-SALARY as increase
from EMPLOYEES

6.
select LAST_NAME, round(months_between(sysdate, HIRE_DATE)/30,0) as months_worked
from EMPLOYEES
order by months_worked desc

8.
select LAST_NAME, lpad(salary,15,'$') as salary
from EMPLOYEES

10.
select LAST_NAME, to_char(HIRE_DATE, 'DAY')
from EMPLOYEES

20-12-24 문제풀이
--db: 데이터 영구적으로 사용
--읽기: select
--쓰기: insert, update, delete
--생성: create

--검색
select 컬럼명1, 컬럼명2...
from 테이블명
where 조건

select last_name, salary
from employees
where job_id = 'IT_PROG'
order by salary desc;

select employee_id "Emp #", last_name "Employee", job_id "Job", hire_date "Hire Date"
from employees;


select employee_id||','||first_name||','||last_name "THE_OUTPUT"
from employees;

select last_name
from employees
where last_name like '__a%';

select last_name, job_id, salary
from employees
where job_id in ('ST_CLERK', 'SA_REP')
and salary not in(2500, 3500, 7000);

--d: 요일을 숫자로 표현한 포맷
1(일) / 2(월) / 3(화) / ~ (7)토

0~11

select last_name, hire_date, to_char(hire_date, 'day') day, to_char(hire_date-1, 'd')
from employees
order by to_char(hire_date-1, 'd');


select last_name || ' ' || rpad(' ', salary/1000, '*') aaa
from employees
order by salary desc;
