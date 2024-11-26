--view : 실제 데이터를 참조만 하는 가상의 테이블
--사용목적 1)복잡한 쿼리 대신 2)테이블의 컬럼까지 권한 분리

--view생성
create view author_for_marketing as select name, email from author;

--view조회
select * from author_for_marketing;

--view 권한부여
grant select on board.author_for_marketing to '계정명'@'localhost';


--view 삭제
drop view author_for_marketing;

--프로시저 생성
DELIMITER //
create procedure hello_procedure()
BEGIN
    select 'hello world';
END
// DELIMITER ;

--프로시저 호출
call hello_procedure();

--프로시저 삭제
drop procedure hello_procedure;

--게시글 목록 조회 프로시저 생성
DELIMITER //
create procedure 게시글목록조회()
BEGIN
    select * from post;
END
// DELIMITER ;

call 게시글목록조회();

--게시글 단건 조회

DELIMITER //
create procedure 게시글id단건조회(in postid bigint)
BEGIN
    select * from post where id = postid;
END
// DELIMITER ;

call 게시글id단건조회(1);

--게시글 목록 조회 by email
DELIMITER //
create procedure 게시글목록조회byemail(in inputEmail varchat(255))
BEGIN
    select p.id, p.title, p.contents from post p inner join author_post ap on p.id = ap.post_id inner join author a on a.id = ap.author_id where email=inputEmail;
    END
// DELIMITER ;

--글쓰기
DELIMITER //
create procedure 글쓰기(in inputTitle varchar(255), in inputContents varchar(255) ,in inputEmail varchar(255))
BEGIN
    declare authorId bigint; //변수를 선언한다는 뜻
    declare postID bigint;
   --post테이블에 insert
    insert into post(title, contents) values(inputTitle, inputContents);
    select id into postID from post order by id desc limit 1;
   --author_post테이블 insert: author_id, post_id
    select id into authorId from author where email = inputEmail;
   insert into author_post(author_id, post_id) values(authorId,postId);
    END
// DELIMITER ;

--글삭제
DELIMITER //
create procedure 글삭제(in inputPostId bigint, in inputEmail varchar(255))
BEGIN
    declare authorPostCount bigint;
    declare authorId bigint;
    select count(*) into authorPostCount from authot_post where post_id = inputPostId;
    select id into authorId from author where email = inputEmail;
    if authorPostCount >=2 then

       delete from author_post where post_id = inputPostId and author_id = authorId;
    else
        delete from author_post where post_id = inputPostId and author_id =authorId;
        delete from post where id = inputPostId;
    end if;
END
// DELIMITER ;

--반복문을 통해 post대량생성 :title, 글쓴이email

DELIMITER //
create procedure 글도배(in count int, in inputEmail varchar(255))
BEGIN
    declare countValue int default 0;
    declare authorId bigint; 
    declare postID bigint;
    while countValue<count do
        --post테이블에 insert
         insert into post(title) values('안녕하세요');
         select id into postID from post order by id desc limit 1;
         select id into authorId from author where email = inputEmail;
        
        insert into author_post(author_id, post_id) values(authorId, postId);
        set countValue = countValue+1;
    end while;
END
// DELIMITER ;