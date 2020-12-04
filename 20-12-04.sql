create table job_grades(
    gra char(1) primary key ,
    l_sal number(6),
    h_sal number(6)
)

insert into job_grades values ('A', 1000, 2999);
insert into job_grades values ('B', 3000, 3999);
insert into job_grades values ('C', 6000, 5000);
insert into job_grades values ('D', 10000, 10000);
insert into job_grades values ('E', 15000, 15000);
insert into job_grades values ('F', 25000, 19000);

SELECT * FROM JOB_GRADES

update job_grades set L_sal = '7000' where gra = 'C';
delete job_grades;

select * From JOB_GRADES;

select employee_id, last_name, salary, gra
from employees e, job_grades j
where e.salary between j.l_sal and j.h_sal;

select EMPLOYEE_ID, LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_ID, DEPARTMENT_NAME
from EMPLOYEES e, DEPARTMENTS d
where e.DEPARTMENT_ID(+) = d.DEPARTMENT_ID

select worker.LAST_NAME || ' works under ' || manager.LAST_NAME
from EMPLOYEES worker, EMPLOYEES manager
where worker.MANAGER_ID = manager.EMPLOYEE_ID

select DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID, CITY
from DEPARTMENTS
natural join locations;

select LAST_NAME, SALARY
from EMPLOYEES
where salary > (select SALARY from EMPLOYEES where LAST_NAME = 'Abel');

select LAST_NAME, SALARY
from EMPLOYEES
where salary > (select avg(SALARY) from EMPLOYEES)
order by SALARY desc

--practice 4
--1
select LAST_NAME, e.DEPARTMENT_ID, DEPARTMENT_NAME
from EMPLOYEES e, DEPARTMENTS d
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
order by DEPARTMENT_ID;

--2
select distinct JOB_ID, LOCATION_ID
from EMPLOYEES e, DEPARTMENTS d
where d.DEPARTMENT_ID = 80
and e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--3
select LAST_NAME, DEPARTMENT_NAME, d.LOCATION_ID, CITY
from DEPARTMENTS d, EMPLOYEES e, LOCATIONS l
where d.LOCATION_ID = l.LOCATION_ID
and e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--4
select LAST_NAME, DEPARTMENT_NAME
from EMPLOYEES e, DEPARTMENTS d
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
and e.LAST_NAME like '%a%';

--5
select LAST_NAME, JOB_ID, e.DEPARTMENT_ID, DEPARTMENT_NAME
from EMPLOYEES e, DEPARTMENTS d, LOCATIONS l
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
and d.LOCATION_ID = l.LOCATION_ID
and city = 'Toronto';

--6
select e.LAST_NAME "Employee", e.EMPLOYEE_ID "emp#", m.LAST_NAME "Manager", m.EMPLOYEE_ID "Mgr#"
from EMPLOYEES e, EMPLOYEES m
where e.MANAGER_ID = m.EMPLOYEE_ID
order by "Mgr#";

--7
select e.LAST_NAME "Employee", e.EMPLOYEE_ID "emp#", m.LAST_NAME "Manager", m.EMPLOYEE_ID "Mgr#"
from EMPLOYEES e, EMPLOYEES m
where e.MANAGER_ID = m.EMPLOYEE_ID(+)
order by e.EMPLOYEE_ID;

--8
select e.DEPARTMENT_ID, e.LAST_NAME, c.LAST_NAME, c.DEPARTMENT_ID
from EMPLOYEES e, EMPLOYEES c
where e.DEPARTMENT_ID = c.DEPARTMENT_ID(+)
and e.LAST_NAME != c.LAST_NAME
order by e.LAST_NAME;

--10
select LAST_NAME, HIRE_DATE
from EMPLOYEES
where HIRE_DATE > (select HIRE_DATE from EMPLOYEES where LAST_NAME = 'Davies');

--11
select e.LAST_NAME, e.HIRE_DATE, m.LAST_NAME, m.HIRE_DATE
from EMPLOYEES e, EMPLOYEES m
where e.MANAGER_ID = m.EMPLOYEE_ID
and e.HIRE_DATE < m.HIRE_DATE;

--practice 5
--4
select max(SALARY), min(SALARY), sum(SALARY), round(avg(SALARY)) average
from EMPLOYEES;

--5
select JOB_ID, max(SALARY), min(SALARY), sum(SALARY), round(avg(SALARY)) average
from EMPLOYEES
group by JOB_ID
order by JOB_ID;

--6
select JOB_ID, count(*)
from EMPLOYEES
group by JOB_ID;

--7
select count(distinct MANAGER_ID) "Number of Managers"
from EMPLOYEES;

--8
select max(SALARY)-min(SALARY) as difference
from EMPLOYEES;

--9
select MANAGER_ID, min(SALARY)
from EMPLOYEES
where MANAGER_ID is not null
group by MANAGER_ID
having min(SALARY) > 6000
order by min(SALARY) desc;

--10
select d.DEPARTMENT_NAME as name, d.LOCATION_ID as location, count(*) "Number of People", round(avg(salary), 2) as salary
from DEPARTMENTS d, EMPLOYEES e
where e.DEPARTMENT_ID = d.DEPARTMENT_ID
group by d.DEPARTMENT_NAME, d.LOCATION_ID;

--11
--12

--practice 6
--1
select LAST_NAME, HIRE_DATE
from EMPLOYEES
where DEPARTMENT_ID = (select DEPARTMENT_ID from EMPLOYEES where LAST_NAME = 'Zlotkey')
and LAST_NAME != 'Zlotkey';

--2
select EMPLOYEE_ID, LAST_NAME, SALARY
from EMPLOYEES
where salary > (select avg(salary) from EMPLOYEES)
order by SALARY;

--3(?)
select EMPLOYEE_ID, LAST_NAME
from EMPLOYEES
where DEPARTMENT_ID in (select DEPARTMENT_ID from EMPLOYEES where LAST_NAME like '%u%');

--4
select LAST_NAME, DEPARTMENT_ID, JOB_ID
from EMPLOYEES
where DEPARTMENT_ID in (select DEPARTMENT_ID from DEPARTMENTS where LOCATION_ID = 1700);

--5
select LAST_NAME, SALARY
from EMPLOYEES
where MANAGER_ID in (select EMPLOYEE_ID from EMPLOYEES where LAST_NAME = 'King');

--6
select DEPARTMENT_ID, LAST_NAME, JOB_ID
from EMPLOYEES
where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENTS where DEPARTMENT_NAME = 'Executive');

--7
select EMPLOYEE_ID, LAST_NAME, SALARY
from EMPLOYEES
where SALARY >= (select avg(SALARY) from EMPLOYEES)
and DEPARTMENT_ID in (select DEPARTMENT_ID from EMPLOYEES where LAST_NAME like '%u%');
