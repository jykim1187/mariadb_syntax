--author 테이블에 post_count컬럼 추가
alter table author add column post_count int default 0;

--post에 글쓴 후에, author테이블에 post_count값에 +1을 시키는 트랜잭션 테스트

start transaction;
update author set post_count = post_count+1 where id = 3;
insert into post(title, contents, author_id) values('hello java', 'hello java is...',100);
commit; --또는 rollback;

--위 transaction은 실패시 자동으로 rollback 어려움
--stored 프로시저를 활용하여 자동화된 rollback 프로그래밍
DELIMITER //
CREATE PROCEDURE 트랜잭션테스트()
BEGIN
    DECLARE exit handler for SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    start transaction;
    update author set post_count = post_count+1 where id = 3;
    insert into post(title, contents, author_id) values('hello java', 'hello java is...',3);
    commit;
END//
DELIMITER ;

--프로시저 호출
CALL 트랜잭션테스트();

--사용자에게 입력받을 수 있는 프로시저 생성
DELIMITER //
CREATE PROCEDURE 트랜잭션테스트2(in titleInput varchar(255), in contetnsInput varchar(255),in idInput Bigint)
BEGIN
    DECLARE exit handler for SQLEXCEPTION
    BEGIN  
        ROLLBACK;
    END;
    start transaction;
    update author set post_count = post_count+1 where id = 3;
    insert into post(title, contents, author_id) values(titleInput, contetnsInput ,idInput);
    commit;
END//
DELIMITER ;