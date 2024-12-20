--case문
select 컬럼1, 컬럼2, 컬럼3,
--if (컬럼4 ==비교값1){결과값1출력}else if(컬럼4==비교값2){결과값2출력}else{결과값3출력}
case 컬럼4
  when 비교값1 then 결과값1
  when 비교값2 then 결과값2
  else 결과값3
  from 테이블명 ;

  select id, email,
  case 
    when name is null then '익명사용자'
    else name
end
  from author;

  --ifnull(a, b) : 만약에 a가 null이면 b반환, null아니면 a반환
  select id, email, ifnull(name,'익명사용자') as'사용자명' from author;

 --경기도에 위치한 식품창고 목록 출력하기 
  select warehouse_id,warehouse_name,address, ifnull(freezer_yn, 'N') as FREEZER_YN from food_warehouse where address like '경기%' order by warehouse_id

--if(a, b, c): a조건이 참이면 b반환, a조건이 거짓이면 c반환
select id, email, if(name is null ,'익명사용자', name) as'사용자명' from author;


--조건에 부합하느