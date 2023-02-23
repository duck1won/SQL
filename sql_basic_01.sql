###테이블 생성, 삭제, 수정
###데이터베이스 생성, 삭제, 수정



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