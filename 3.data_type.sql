--tinyint는 128~127까지 표현(1byte할당)
--author테이블에 age컬럼 추라
alter table author add column age tinyint;
--data insert테스트 : 200살 insert
insert into author(id,age) values(6,200);
alter table author modify column age tinyint unsigned; --음의 표현을 하지 않겠다-->따라서 표현할 수 있는 양수의 범위가 넓어짐

--decimal 실습
--decimal(총 자릿수, 소수부 자릿수)
alter table post add column price decimal(10,3);

--decimal 소수점 초과 후 값 짤림 현상
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

select * from author where id in(select author_id from post);로도 활용 가능 /글쓴 사람 아이디를 조회하는 방법

--like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%h'; --h로 끝나는 타이틀 검색
select * from post where title like 'h%'; --h로 시작하는 타이틀 검색
select * from post where title like '%h%'; --단어의 중간에 h라는 키워드가 있는 경우 검색

-- regexp : 정규표현식을 활용한 조회
-- not regexp도 활용가능
select * from post where title regexp '[a-z]'; -- 하나라도 알파벳 (소문자)가 들어있으면 // sql에서는 대문자까지 인식한다는 것 참고
select * from post where titlt regexp '[가-힣]'; --하나라도 한글이 포함되어 있으면

--날짜 변환: cast, convert : 숫자->날짜 // 문자-->날짜 
select cast(20231119 as date);
select cast('20231119' as date);
select convert(20231119, date);
select convert('20231119', date);

-- 문자 -->숫자 변환 //(unsigned대신 int를 쓰기도 함)
select cast('12' as unsigned); 
select convert('12', unsigned);

--날짜조회 방법
--1.like 패턴, 2.부등호 활용, 3.date_format
select * from post where created_time like '2024-11%'; --문자열 처럼 조회하는 방법
select * from post where created_time >= '2024-01-01' and created_time < '2025-01-01';
--date_format 활용
select date_format(created_time,'%y-%m-%d') from post; //년=%Y , 월 = %m, 일 = %d
select date_format(created_time,'%H:%i:%s') from post; //시,분,초
select * from post where date_format(created_time, '%Y') = '2024';
select * from post where cast(date_format(created_time, %Y) = '2024' as unsigned) =2024

--현재 날짜 시간
select now();