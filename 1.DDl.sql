--mariadb 서버에 접속
maiadb -u root -p

--스키마(=데이터베이스) 목록 조회
show databases;

--스키마(=데이터베이스) 생성 // DB SQL문은 대문자가 정석이나 소문자로 적어도 컴퓨터는 알아 먹는다 :중요
CREATE DATABASE board;

--스키마 삭제
DROP DATABASE board;

--데이터베이스 선택 : 중요
use board;

--테이블 목록 조회 : 중요
show tables;

--문자 인코딩 조회
show variables like 'character_set_server';

--문자 인코딩 변경
alter databese board default character set = utf8mb4;

--테이블 생성
create table author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));// 괄호안은 컬럼명 타입 길이

--테이블 컬럼 조회 : 중요 ->describe 테이블명을 붙여야한다
describe autuor;

--테이블 컬럼 상세 조회
show full columns from author;

--테이블 생성명령문 조회
show create table author;

-- post 테이블 신규 생성(id, title, content, author_id) : 중요
create table post(id int primary key, title varchar(255), content varchar(255), author_id int not null, foreign key(author_id) references author(id));
                                                                                           not null을 없애면 id라는 foreign key에 null값이 들어갈 수 있다.

-- 테이블 index(성능향상 옵션) 조회
show index from author;

-- alter문 : 테이블 구조를 변경
--테이블의 이름 변경
alter table post rename posts;

--테이블 컬럼 추가 : 중요
alter table author add column age int;

--테이블 컬럼 삭제
alter table author drop column age;

--테이블 컬럼명 변경
alter table post change column content contents varchar(255);

--테이블 컬럼 타입과 제약조건 변경(foriegn key나 not null같은 제약을 건다는 것) => 덮어쓰기 됨에 유의
alter table author modify column email varchar(100) not null;

--실습: author 테이블에 address칼럼 추가. varchar(255)
alter table author add column address varchar(255);

--실습: post 테이블에 title은 not tull로 변경, contents로 3000자로 변경
alter table post modify column title varchar(255) not null, modify column contents varchar(3000); -->한 번에 하는 법 웬만하면 그냥 따로 해라

--테이블 삭제
drop table post;