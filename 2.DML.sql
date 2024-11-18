-- insert into: 테이블에 데이터 삽입 명령어
insert into 테이블명(컬러명1, 컬럼명2, 컬럼명3) values(데이터1, 데이터2, 데이터3);
insert into post(in,)

--문자열은 일반적으로 작은 따옴표' ' 를 사용한다.
insert into author(id, name, email) values(3, 'kim', 'kim@naver.com');
--select : 데이터 조회, * :모든 컬럼을 의미
select * from author; 또는  select name,email from author;

--테이블 제약조건 조회
select * from information_schema.key_column_usage where table_name = 'post';

--insert문을 통해 author데이터 2개 정도 추가, post데이터 2개 정도 추가(1개 익명)

--update : 데이터 수정
--where문을 빠뜨리게 될 경우, 모든 데이터에 update문이 실행됨에 유의. 즉, 그 칼럼의 모든 row에 update문이 되는 거임.
update 테이블명 set 컬럼명 where id =1;
update author set name = '홍길동' where id =1;
update author set name = '홍길동', email='hongkildong@naver.com' where id =1;

--delete : 데이터 삭제
--where문을 빠뜨릭 될 경우, 모든 데이터가 delete됨에 유의
delete from author where id = 5;

--select: 조회
select * from author; -- 어떠한 조건 없이 모든 컬럼 조회
select * from author where id =1; --where 뒤의 조회조건을 통해 조회
select * from author where name = 'honggildong';
select * from author where id>3;
select * from author where id>2 and name = 'kim'; --또는일 경우에는 and대신에 or사용

--중복제거 조회 : distinct
select name from author;
select distinct name from author;

--정렬 : order by + 컬럼명
--아무런 정렬조건 없이 조회할 경우에는  pk기준으로 오름차순 정렬
--acs : 오름파순, desc:내림차순
select * from author order by name--디폴트값이 asc라 오름차순이라면 기입 안 해도 됨. 내림차순이라면 desc기입!

--멀티컬럼 order by : 여러 컬럼으로 정렬, 먼저 쓴 컬럼 우선 정렬하고 중복시 그 다음 정렬옵션 적용
select * from author order by name desc, email asc;

--결과값 개수 제한
select * from author limit 2;
select * from author order by id desc limit 2; -- 가장 최근에 가입한 2 사람을 조회할 수 있음

--별칭(alias)을 이용한 select
select name as '이름', email as '이메일' from author;
select a.name, a.emial from author as a;(테이블 명에 별칭을 주고 앞의 컬럼에 붙여다 쓰면 나중에 다른 테이블에서 조회하는 쿼리에서 섞일 때 깔끔하게 쓸 수 있음)
select a.name, a.emial from author a;(as 생략 가능)

--문제) null 을 조회조건으로 활용
select * from author where password is null;
select * from author where password is not null;


