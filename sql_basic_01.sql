###테이블 생성, 삭제, 수정
###데이터베이스 사용자 생성, 조건에 따라 사용자 만들기, 생성, 삭제, 수정, 조회 비밀번호설정, 권한 부여, 삭제,테이블 컬럼 생성, 삭제, 수정



#mysql 데이터베이스에 
#user 테이블.
desc mysql.user;
describe mysql.user;

show full columns from mysql.user;

select Host, User 
	from mysql.user;

select * 
	from mysql.user;
#create user '아이디'@'접근가능한주소' identified by '비밀번호'
create user 'test'@'localhost' identified by '1234';
select Host,user,password from mysql.user;

create user 'anywhere'@'%' identified by '1234';
select User, Host from mysql.user;

#데이터베이스 사용자만들기
#특정ip대역 에서만 접속 가능한 사용자를 만듬
#사용자이름은 test2이고 비밀번호는 1234인 사용자를 만듬.
CREATE USER 'test2'@'192.168.0.%' IDENTIFIED BY '1234';
select User,Host from mysql.user;

#데이터베이스 조건에 따라 사용자 만들기
#이미 존재하는 사용자이름으로 사용자를만들려고 하면 에러가 발생함.
#OR REPLACE라는 조건을 붙이면, 이미 존재하는 사용자 이름인 경우 기존 사용자를 삭제하고 다시만듬.
create or replace user 'test'@'localhost' identified by '1234';
select User, Host from mysql.user;

#데이터베이스 조건에 따라 사용자 만들기
#이와는 달리 if not exists 조건을 붙이면, 같은 이름의 사용자가 없을 떄만 사용자를 추가한다.
create user if not exists 'test'@'localhost' identified by '1234';
select User,Host from mysql.user;

#데이터베이스 사용자 이름 변경하기
#'test2'@'192.168.0.%'를 'test3'@'%'으로 변경하고싶다면 아래와같이 명령어를 입력하면됨
rename user 'test2'@'192.168.0.%' to 'test3'@'%';
select user, host from mysql.user;

#데이터베이스 사용자 비밀번호 변경하기
#'test3'@'%'의 비밀번호를 12345로 변경하기
set password for 'test3'@'%' = password('12345');
select User,Host,Password from mysql.user;

#데이터베이스 사용자 삭제하기
#'test3'@'%' 사용자를 삭제
drop user'test3'@'%';
select User,Host from mysql.user;

#데이터베이스 사용자 조건에 따라 삭제하기
#'anywhere'@'%'을 삭제하는대, 존재할 경우에만 삭제
drop user if exists 'anywhere'@'%';
select User,Host from mysql.user;

#데이터베이스 목록 조회
show databases;
#데이터베이스 test라는 이름으로 생성
create database test;

#데이터베이스 권한 부여하기
#사용자 'test'@'localhost'에 대해서 test데이터베이스의 모든 테이블에 대해 모든 권한을 부여
show grants for 'test'@'localhost'; # 기존 권한 확인
grant all privileges on test.* to 'test'@'localhost';
flush privileges;

#데이터베이스 권한확인하기
#사용자 'test'@'localhost'가 가진 권한을 조회
show grants for 'test'@'localhost';

#사용자 'test'@'localhost'가 test데이터베이스에 가진 모든 권한을 제거.
revoke all on test.* from 'test'@'localhost';
flush privileges;
show grants for 'test'@'localhost';

#모든 데이터 베이스에 대해서 목록 조회
show databases;

#데이터베이스 test 라는 이름으로 생성
create database test;

#이미존재하는 데이터베이스와 같은이름의 데이터베이스를 만드려고하면 에러발생, 같은이름의 데이터베이스가 존재하지 않을때만 만들고 싶다면 if not exists를 추가
create database if not exists test;

#데이터베이스 특수한 이름 명명하기
#특수문자가 명명시에 포함되는 경우 에러가 발생. 키보드 esc키 아래 있는 억음 부호 호는 grave라고 불리는 키(')로 이름을 감싸면 에러가나지 않음
create database `test.test`;
show databases;

#test.test 데이터 베이스 삭제
drop database `test.test`;
show databases;

#테이블 만들기 준비
#테이블을 만들 python이란 명칭의 데이터베이스를 새롭게 생성
#그리고 그 데이터 베이스를 사용하기 위한 명령어 입력
create database python;
use python;

#테이블 만들기
#table1이란 명칭의 데이블을 만듬
#column이 하나도없으면 테이블이 만들어지지 않으므로 적어도 하나이상의 column을 만듬
create table table1 (column1 varchar(100));

#테이블 목록 조회하기
#앞서 만든 테이블이 잘 생성되었는지 확인
select database(); #현재 사용중인 데이터 베이스를 확인하는 명령어
show tables; #테이블 목록조회

#테이블 이름 변경하기
#테이블 이름을 table1에서 table2로 변경
rename table table1 to table2;
show tables; #테이블 목록조회

#테이블삭제하기
#앞서 이름을 변경한 table2를 삭제
drop table table2;
show tables;

#테이블생성하기
#열(column)추가,삭제 등을 해볼 테스트용 test_table을 생성
#만든 후에는 방금 만든 테이블의 구조를 살펴봐라.
create table test_table(
test_column1 int,
test_column2 int,
test_column3 int
);
desc test_table;

#테이블에 column 추가하기
#test_table에 test_column4 column을 추가
#추가된 column은 젤뒤에 추가됨
alter table test_table
add test_column4 int;
desc test_table;

#데이블 여러개 한번에 추가하기
alter table test_table
add(
test_column5 int,
test_column6 int,
test_column7 int);
desc test_table;

#테이블에 column 삭제하기
#test_table에서 test_column1을 삭제
alter table test_table
drop test_column1;
desc test_table;

#테이블에 column 순서 변경하기
#test_column7을 맨앞로 이동한다. 데이터 타입도 같이적어야함
alter table test_table
modify test_column7 int
first;
desc test_table;

#특정열 뒤로 이동하고 싶다면 after명령어를 함께 사용
alter table test_table
modify test_column7 int
after test_column6;
desc test_table;

#테이블 column 이름 변경하기
#test_column2를 test_column0으로 이름을 변경
alter table test_table
change test_column2 test_column0 int;
desc test_table

#테이블 데이터 타입 변경하기
#test_column0 테이터타입을 varchar(10)으로 변경함.
alter table test_table
change test_column0 test_column0 varchar(10);
desc test_table

#테이블 컴럼 이름과 데이터 타입 동시에 변경하기
#컬럼 이름과 데이터 타입을 동시에 변경하수 있음
alter table test_table
change test_column0 test_column2 int

desc test_table;

#--------------------------------------------------------------#
#--------------------------sql 2일차----------------------------#
#--------------------------------------------------------------#

# 데이블에는 데이터(ROW)를 특정할수있는 고유값(primary key)이 있는게 좋음
# 수동으로 넣어줄수도 있지만 auto_increment를 사용해서 생성할 수 있다.

#자동으로 증가하는 컬럼 만들기
#컬럼 이름은 id 데이터타입은 정수int로 만듬
#데이터 타입뒤에 auto_increment primary key를 붙힘
create table test(
	id int auto_increment primary key
); #primary key를 붙이지 않으면 에러가 남.
desc test;
show databases;

#auto_increment 컬럼에 데이터 추가하기
#auto_increment가 지정된 컬럼은 데이터를 추가할 때 값을 지정하지 않아도 됨. 1부터 값이 자동으로 생성되어 저장.
insert into test values();
select * from test;
select id from test;
select id.name from test;

#AUTO_INCREMENT가 지정된 Column에 값을 정하여 데이터를 추가할 수도 있음.
insert into test values(100);
# 이후 값이 없는 데이터를 추가하면 id는 100보다 하나 큰 101가 됩니다.
INSERT INTO test VALUES ();
select id from test;

#AUTO_INCREMENT Column 생성 값 살펴보기
#id Column에 101 값을 갖는 행을 지우고 데이터를 추가하면 102이 값이 됨. 즉, 삭제한 값을 다시 사용하지 않습니다.
delete from test where id = 101;
select * from test;

insert into test values();
select * from test;

#AUTO_INCREMENT Column 생성 값 살펴보기
#test 테이블의 모든 데이터를 삭제함. 그리고 새로 데이터를 추가해보면 
#AUTO_INCREMENT 값이 이전에 사용한 값보다 큰 값부터 이어서 시작됨.

#mysql workbench를 재시작 했다면 아래 명령어 실행 필요.
#use python;
delete from test;
select * from test;
insert into test values();
select * from test;

#auto_increment 값 초기화 하기
#AUTO_INCREMENT에 대해 초기화 또는 시작하는 번호를 정하고 싶다면 다음과 같이.  
show table status; #1부터 시작하라는 뜻.
show table status where name = 'test';

# 테이블에 데이터가 1개도 없어야 한다.
# 만약 테이블의 데이터가 있다면 걔 중 가장 큰 AUTO_INCREMENT보다 크게만 지정할 수 있음.
alter table test auto_increment =1;
select * from test;

#AUTO_INCREMENT 값 수정하기
#데이터 삭제와 업데이트 등과 같은 이유로 AUTO_INCREMENT로 설정된 컬럼의 숫자가 난잡하게 될 수 있음. 
#이때 보기 좋게 1부터 순서대로 정렬할 수 있습니다.
set @count=0;
update test set id=@count:=@count+1;

#테이블에 데이터 추가, INSERT
#table1 테이블을 만듬.
create table table1(
column1 varchar(100),
column2 varchar(100),
column3 varchar(100)
);
desc table1;

#데이터를 추가하는 명령어는 INSERT입니다. 모든 컬럼에 값을 넣을 때는 다음과 같이 쿼리를 작성.
insert into table1(column1,column2,column3) values('a','aa','aaa');
select * from table1;

#모든 컬럼에 값을 넣을 때는 다음과 같이 컬럼을 나열하지 않아도 됨
insert into table1 values('a','aa','aaa');
select * from table1;

#컬럼에 값을 부분적으로 넣을 때는 다음과 같이 쿼리를 작성.
insert into table1(column1,column2) values('a,','aa');
select * from table1;

#테이블에 데이터 수정, UPDATE
#데이터를 수정하는 명령어는 UPDATE. 모든 데이터의 특정 컬럼 값을 변경하고 싶다면 다음과 같이 합니다.
update table1 set column1 = 'z';
select * from table1;

#특정 행의 값을 변경하고 싶다면 WHERE를 사용.
update table1 set column1 ='x' where column2 ='aa';

#여러 개의 컬럼 값을 변경하고 싶다면 쉼표로 구분해서 여러 개의 컬럼별 값을 지정.
update table1 
	set column1 ='y',
    column2='yy'
    where column3='aaa';
    
select * from table1;

#데이터를 삭제하는 명령어는 DELETE입니다. 특정 데이터를 삭제하려면 WHERE를 사용.
delete from table1 where column1 ='y';
select * from table1;

#WHERE가 없이 DELETE를 사용하면 모든 데이터를 삭제
delete from table1;
select * from table1;

#테스트용 테이블 생성
# 기존테이블 삭제(테이블 존재시)
drop table if exists day_visitor_realtime;
# 테이블생성
create table if not exists day_visitor_realtime(
 ipaddress varchar(16),
 iptime_first datetime,
 before_url varchar(250),
 device_info varchar(40),
 os_info varchar(40),
 session_id varchar(80));
# 데이터 타입의 길이에 맞게 데이터를 삽입할 때 테이블 명세를 보고 데이터 타입의 길이를 넘치지 않게 데이터를 넣어봐라.
 insert into day_visitor_realtime(
	ipaddress, iptime_first, before_url, device_info
)values 
#('12345678901234567', '2023-02-23 11:35:28', 'localhost', 'pc'), ipaddress varchar(16)에 17자리 값을 넣어서 에러 발생
('192.168.0.1', '2023-02-23 11:35:28', 'localhost', 'pc')
, ('192.168.0.2', '2023-02-23 11:36:28', 'localhost', 'iphone');
select * from day_visitor_realtime;
desc day_visitor_realtime;

#데이터 타입의 길이를 초과해서 데이터를 삽입할때
 insert into day_visitor_realtime(
	ipaddress, iptime_first, before_url, device_info
)values 
('12345678901234567', '2023-02-23 11:35:28', 'localhost', 'pc');
select * from day_visitor_realtime; # Error Code: 1406. Data too long for column 'ipaddress' at row 1 오류 발생

#데이터 삽입하기
#데이터 삽입
insert into `python`.`day_visitor_realtime` (`session_id`) values('1234567890');
insert into `python`.`day_visitor_realtime` (`session_id`) values('1234.567890');
insert into `python`.`day_visitor_realtime` (`session_id`) values('123');
insert into `python`.`day_visitor_realtime` (`session_id`) values('1234');
insert into `python`.`day_visitor_realtime` (`session_id`) values('12345');
select * from day_visitor_realtime;
select count(*) from day_visitor_realtime;

delete from `python`.`day_visitor_realtime` where session_id = '12345';
update `python`.`day_visitor_realtime` set session_id = '12345';
select * from day_visitor_realtime;

#NOT NULL
#테이블 컬럼에 데이터 타입을 NOT NULL을 추가해서 해당 컬럼의 값에 NULL이 오지 못하도록 강제함 NULL은 python의 None과 같다.
 drop table if exists day_visitor_realtime;
# 테이블생성
create table if not exists day_visitor_realtime(
 ipaddress varchar(16) not null,
 iptime_first datetime,
 before_url varchar(250),
 device_info varchar(40),
 os_info varchar(40),
 session_id varchar(80));
 
 #NULL
 #INSERT시 값을 넣지 않게되면 NULL로서 표시됨. 즉 데이터가 존재하지 않다는 것.
 insert into day_visitor_realtime (
 ipaddress, iptime_first, before_url, device_info, os_info
 /*session_id*/
)
VALUES (
 'asdf', NOW(), 'aa', 'asdf', 'aa'
);
SELECT * FROM day_visitor_realtime;

#not null
#not null 컬럼 값에 값을 넣지 않으면 오류 발생
 insert into day_visitor_realtime (
 /*ipaddress,*/
 iptime_first, before_url, device_info, os_info
 /*session_id*/
)
VALUES (
 NOW(), 'aa', 'asdf', 'aa'
);
# Error Code: 1364. Field 'ipaddress' doesn't have a default value 오류 발생
SELECT * FROM day_visitor_realtime;

#primary key
#기본키는 하나의 테이블에 있는 데이터들을 고유하게 식별하는 제약조건입니다.
#기본키는 한개의 테이블에 하나만 생성가능.
#기본키로 설정된 열에 중복된 값을 가질수 없으며 null값 또한 가질수 없음.
#형식은 primary key(컬럼명1,컬럼명2,컬럼명3...)와 같이 작성할 수 있음.

drop table if exists day_visitor_realtime;
create table day_visitor_realtime (
 id int,
 ipaddress varchar(16),
 iptime_first datetime,
 before_url varchar(250),
 device_info varchar(40),
 os_info varchar(40),
 session_id varchar(80),
 primary key(id)
);
select *
from day_visitor_realtime;

# PRIMARY KEY에 같은 값을 두번 넣으면 오류가 발생.
insert into day_visitor_realtime(
id,ipaddress,iptime_first,before_url,device_info,os_info/*,session_id*/) 
 values (1, 'asdf', NOW(), 'aa', 'asdf', 'aa')
 , (1, 'asdf2', NOW(), 'aa2', 'asdf2', 'aa2');
# Error Code: 1062. Duplicate entry '1' for key 'PRIMARY' 오류 발생

#외래키(foreign key)는 참조하는 테이블의 컬럼에 존재하는 값만 사용하는 제약조건.
#참조할수 있는 컬럼은 참조하는 테이블의 기본키이거나 unique한 컬럼만 가능. 
# 참조할 테이블
create table orders (
  order_id int,
  customer_id int,
  order_date datetime,
  primary key(order_id)
); 

insert into orders values(1,1,now());
insert into orders values(2,1,now());
insert into orders values(3,1,now());
select *
from orders;

create table order_detail (
  order_id int,
  product_id int,
  product_name varchar(200),
  order_date datetime,
  constraint fk_orders_orderid foreign key(order_id) references orders(order_id),
  primary key(order_id, product_id)
);

 insert into order_detail(order_id, product_id,product_name) 
 values(1, 100, 'iphone'),
	   (1, 101, 'ipad');

select *from order_detail;

insert into order_detail(order_id, product_id,product_name) 
 values(4, 100, 'iphone'),
	   (4, 101, 'ipad');

use employees;
select *
from departments;

select *
from titles;

select distinct title
from titles;

select *
from salaries
where salary > 150000;

select *
from dept_manager
where emp_no = 111133;

select *
from dept_manager
where emp_no between 111133 and 111939;

select *
from employees
where first_name like 'Geo%';

select *
from employees
where first_name like '_e%;';


select *
from titles
where title = 'Senior Engineer' and from_date > '2002-06-01';

select *
from titles
order by emp_no;

select max(emp_no)
from titles;

select min(emp_no)
from titles;

select count(emp_no)
from titles;

select *
from employees as emp left join salaries as sal
on emp.emp_no = sal.emp_no;

select *
from employees as emp right join salaries as sal
on emp.emp_no = sal.emp_no;

select title, count(*)
from titles
where to_date = '9999-01-01' 
group by title
;

select * from titles;

select title, count(*)
from titles
where to_date = '9999-01-01'
group by title
having count(*) < 10
;

use python;
CREATE TABLE `users` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `email` varchar(255) COLLATE utf8_bin NOT NULL,
    `password` varchar(255) COLLATE utf8_bin NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin
AUTO_INCREMENT=1 ;

select*
from users;