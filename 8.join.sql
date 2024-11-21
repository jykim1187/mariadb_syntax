--inner join
--두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
select * from author inner join post on author.id = post.aurhor_id;
select * from author a inner join post b on a.id = p.aurhor_id;--별칭조건 준 것
-- 출력순서만 달라질 뿐 조회결과는 동일.
select * from post inner join author on a.id = p.aurhor_id;
--글쓴이가 있는 글 목록과 글쓴이의 이메일만을 출력하시오
--post의 글쓴이가 없는 데이터는 포함 안되고 글쓴이 중에 글을 한번도 안쓴 사람은 포함이 안 됨.
select  p.*, a.email from post p inner join author a on a.id = p.author_id;
--글쓴이가 있는 글의 제목 내용, 그리고 글쓴이의 이메일만을 출력하시오
select  p.title, p.contents, a.email from post p inner join author a on a.id = p.author_id;

--모든 글목록을 출력하고, 만약에 글쓴이가 있다면 이메일 정보를 출력.
--left outter join->left join으로 생략가능
--글을 한 번도 안쓴 글쓴이 정보는 포함x
select p.*, a.email from post p left join author a on a.id =p.author_id; 

--글쓴이를 기준으로 left join 할 경우, 글쓴이가 n개의 글을 쓸 수 있으므로 같은 글쓴이가 여러번 출력될 수 있음
--author와 post가 1:n 관계이므로.
--글쓴이가 없는 글은 포함x
select * from author a left join post p on a.id = p.author_id;

--실습) 글쓴이가 있는 글 중에서 글의 title과 저자의 email만을 출력하되, 저자의 나이가 30세 이상인 글만 출력
select p.title, a.email from  post p inner join author a on a. id = p.author_id where a.age >= 30;

--글의 내용과 글의 저자의 이름이 있는, 글 목록을 출력하되 2024-06 이후에 만들어진 글만 출력.
select p.* from post p left join author a on p.author_id = a.id where p.contents is not null and a.name is not null and p.created_time like '2024-06%'

--union : 두 테이블의 select결과를 아래로 결합(기본적으로 distinct가 적용이 된다)
--컬럼의 개수와 컬럼의 타입이 같아야함에 유의
--union all :중복까지 모두 포함
select name, email from author union select title, contents from post;

--서브쿼리 : select문 안에 또 다른 select문을 서브쿼리라 한다.
--where절 안에 서브쿼리
--한 번이라도 글을 쓴 author 목록 조회
select distinct a.* from author a inner join post p on a.id = p.author_id;  
select * from author where id in (select author_id from post);

--from절 안에 서브쿼리
select a.name from (select * from author) as a; 

--select절 안에 서브쿼리
--author의 email과 author별로 본인이 쓴 글의 개수를 출력
-select a.email,(select count(*) from post where author_id = a.id) from author a;

--없어진 기록 찾기(프로그래머스 한 번 더 해보기)
SELECT animal_id, name from animal_outs  where animal_id not in (select animal_id from animal_ins);


--집계함수
select count(*) from author; -- null값은 카운터에서 제외된다.
select sum(price) from post;
select avg(price) from post;
--소수점 2번째 자리까지 나오게 반올림(0쓰면 정수만 나오게 반올림)
select round(avg(price),2) from post;

--group by : 그룹화된 데이터를 하나의 행(row)처럼 취급.
--(author_id로 그룹핑 하였으면, 그외의 칼럼을 조회하는 것은 적절하지 않다.)
select author_id from post group by author_id
--group by와 집계함수
--아래 쿼리에서 *은 그룹화된 데이터내에서의 개수
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price) from post group by author_id;

--author의 email과 author별로 본인이 쓴 글의 개수를 출력
select a.email,(select count(*) from post where author_id = a.id) from author a;
--join과 group by 집계함수 활용한 글의 개수 출력 글쓴이는 다 나와야함

select a.email, count(p.author_id) from author a left join post p on a.id = p.author_id group by a.id;

--where 와 group by
--연도별로 post글의 개수 출력, 연도가 null인 값인 제외
select date_format(created_time,'%Y') as year, count(*) from post where created_time is not null group by year;

--having : group by를 통해 나온 집계값에 대한 조건
--글을 2개 이상 쓴 사람에 대한 정보조회
select author_id from post group by author_id having count(*)>=2;
select author_id, count(*) as count from post group by author_id having count>=2

--다중열 group by
--post에서 작성자 별로 만든 제목의 개수를 출력하시오-->그룹을 2개로 나눈 것
select author_id, title, count(*) from post group by author_id, title;

--재구매가 일어난 상품과 회원 리스트 구하기
SELECT user_id, product_id from online_sale group by user_id, product_id having count(*)>=2 order by user_id, product_id desc;