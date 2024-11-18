--tinyint는 128~127까지 표현(1byte할당)
--author테이블에 age컬럼 추라
alter table author add column age tinyint;
--data insert테스트 : 200살 insert
insert into author(id,age) values(6,200);
alter table author modify column age tinyint unsigned; --음의 표현을 하지 않겠다-->따라서 표현할 수 있는 양수의 범위가 넓어짐

--decimal 실습
--decimal(총 자릿수, 소수부 자릿수)
alter table post add column price decimal(10,3);

--decimal 소수저 초과 후 값 짤림 현상
insert into post(id,title,price) values(5, ' java programming', 10.33412);

--문자열 실습
alter table author add column self_introduction text;
insert into author(id,self_introduction) values(7,'안녕하세요.김진영입니다');

--blob(바이너리 데이터) 타입 실습
alter table author add column profile_image longblob;
insert into author(id,profile_image) values(8, LOAD_FILE('C:\\my_image.jpg'))

--enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
--role 컬럼 추가
alter table author add column role enum('user','admin') not null default 'user';
--user값 세팅 후 insert
insert into author(id,role) values(9,'user');
--users값 세팅 후 insert(잘못된 값)
insert into author(id,role) vaulues (10,'users');
--아무것도 안 넣고 insert(default값)

--date: 날짜, datetime:날짜 및 시분초(microseconds)
--datetime은 입력,수정,조회시에 문자열 형식을 사용
alter table post add column created_time datetime default current_timestamp(); 
update post set created_time = '2024-11-18 19:12:16' where id=3;

--조회시 비교연산자
select * from author where id >=c 2 and id <= 4;
select * from author where id between 2 and 4; --> 위와 같은 구문
select * from author where id not(id < 2 or id > 4);
select * from author where id in(2,3,4); 
select * from author where id not in(1,5); -->전체 데이터가 1~5까지 밖에 없다고 가정했을 때

select * from author where id in(select author_id from post);로도 활용 가능 /글쓴 사람 아디를 조회하는 방법