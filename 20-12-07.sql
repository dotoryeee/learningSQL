--테이블 복사해서 생성
create table emp_cp as select * from employees;
create table dept_cp as select * from departments;
select * from emp_cp;
select * from dept_cp;
insert into dept_cp(department_id, department_name) values(280, 'aaa');
insert into dept_cp values(290, 'bbb', null, null);
insert into emp_cp values(208, 'aaa', 'bbb', 'aaa@email.com', '010-1111-2222', sysdate, 'AC_ACCOUNT', 6900,null, 205, 100);
insert into emp_cp values(209, 'ccc', 'ddd', 'ccc@email.com', '010-333-4444',
to_date('05 05 2007', 'dd mm yyyy'), 'AC_ACCOUNT', 6900,null, 205, 100);

--테이블 구조만 복사해서 만듬.
create table emp_dept20 as select * from employees where 1=2;
select * from emp_dept20;
insert into emp_dept20 (select * from employees where department_id=20);

--직무가 it_prog 사람들의 사번 이름(first_name, last_name), job_id, salary, department_id, manager_id
--를 복사하여 테이블 emp_ITProg
create table emp_itprog as
select employee_id emp_id, first_name||' '||last_name name, job_id, salary, manager_id, department_id
from employees
where job_id='IT_PROG';
select * from emp_itprog;

update emp_itprog set name='aaa bbb', salary=10000 where emp_id=107

create table test(
    num number primary key,
    name varchar2(20) not null,
    loc varchar2(20) default '서울'
);

insert into test(num, name, loc) values (1, 'aaa','서울');
insert into test values (2,'bbb', default);
insert into test values (3, 'ccc', default);

select * from test;

create table emp_cp2 as select * from EMPLOYEES;

select * from emp_cp;
select * from emp_cp2;

update emp_cp set PHONE_NUMBER = '000.000.0000'
where EMPLOYEE_ID = 206;

merge into emp_cp2 c2 using emp_cp c1
ON (c2.employee_id = c1.EMPLOYEE_ID)
when MATCHED THEN
update set c2.PHONE_NUMBER = c1.PHONE_NUMBER;

commit;

--practice 8
--1
create table MY_EMPLOYEE(
    ID number(4) not null,
    LAST_NAME varchar2(25),
    FIRST_NAME varchar2(25),
    USERID varchar2(8),
    SALARY number(9, 2)
);
--2
select * from MY_EMPLOYEE;
--3, 4
insert into MY_EMPLOYEE(ID, LAST_NAME, FIRST_NAME, USERID, SALARY) values (1, 'Patel', 'Ralph', 'rpatel', 895);
insert into MY_EMPLOYEE values (2, 'Dancs', 'Bettyp', 'bdancs', 860);
insert into MY_EMPLOYEE values (3, 'Biri', 'Ben', 'bbiri', 1100);
insert into MY_EMPLOYEE values (4, 'Noewman', 'Chad', 'cnewman', 750);
insert into MY_EMPLOYEE values (5, 'Ropeburn', 'Audrey', 'aropebur', 1550);
--5
select * from MY_EMPLOYEE;
--10
update MY_EMPLOYEE set LAST_NAME = 'Drexler' where id = 3;
--11
update MY_EMPLOYEE set SALARY = 1000 where ID in (
    select ID
    from MY_EMPLOYEE
    where SALARY < 900
    );
--12
select * from MY_EMPLOYEE;
--13
delete from MY_EMPLOYEE where LAST_NAME = 'Dancs';
--14
select * from MY_EMPLOYEE;
--15
commit
--17
select * from MY_EMPLOYEE;
--18
savepoint a
--19
delete from MY_EMPLOYEE
--20
select * from MY_EMPLOYEE;
--21
rollback to savepoint a
--22
select * from MY_EMPLOYEE;
--23
commit

--practice 9
--1
create table DEPT(
    ID number(7),
    NAME varchar2(25)
);
--2
insert into dept (select department_id, DEPARTMENT_NAME from DEPARTMENTS);
--3
create table EMP(
    ID number(7),
    LAST_NAME varchar2(25),
    FIRST_NAME varchar2(25),
    DEPT_ID number(7)
);
--4
alter table EMP
modify (LAST_NAME varchar2(50));
--6
create table EMPLOYEES2 as
    select EMPLOYEE_ID ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID DEPT_ID from EMPLOYEES;
--7
drop table EMP;
--8
RENAME employees2 to EMP;
--10
alter table EMP drop column FIRST_NAME;
--11
alter table emp
set unused (dept_ID);
--12
alter table EMP
drop unused columns;

select * from EMP