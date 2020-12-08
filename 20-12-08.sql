create table member(
    id varchar2(20) primary key,
    pwd varchar2(20)not NULL,
    name varchar2(10) not null ,
    email varchar2(50) not null
);

create sequence seq_board_num;

create table board(
    num number primary key,
    writer varchar2(20) references member(id) on delete SET NULL ,
    w_date date,
    title varchar2(50) not null ,
    content varchar2(100) not null
);

insert into member values ('aaa', 'aaa', 'Lee AAA', 'aaa@aaa.aaa');
insert into member values ('bbb', 'bbb', 'KIM BBB', 'bbb@bbb.bbb');
insert into member values ('ccc', 'ccc', 'YOON ccc', 'ccc@ccc.ccc');

insert into board values (1, 'aaa', sysdate, 'ㅋㅋㅋㅋㅋ', 'ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ');
insert into board values (2, 'bbb', sysdate, 'ㄷㄷㄷㄷㄷㄷㄷㄷ', 'ㄷㄷㄷㄷㄷㄷㄷㄷㄷㄷㄷ');
insert into board values (3, 'aaa', sysdate, 'ㅈㅈㅈㅈ', 'ㅈㅈㅈㅈ');

delete from member where id = 'bbb';

select * from member;
select * from board;
drop table board;

commit;

drop table test;
create table test(
    num number primary key ,
    name varchar2(20)not null ,
    price number not null ,
    disc varchar2(50)
);
create sequence seq_test;

select * from test;
