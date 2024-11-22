--여러 사용자가 1개의 글을 수정할 수 있다 가정 후 DB 리뉴얼
--author와 post가 m:n관계가 되어 관계테이블을 별도로 생성

create table author(id bigint auto_increment primary key, email varchar(255) not null unique, name varchar(255), created_time datetime default current_timestamp());

create table post(id bigint auto_increment primary key, title varchar(255) not null, contents varchar(3000),created_time datetime default current_timestamp());

--1:1 관계인 author_address
--1:1 관계를 보장을 확실히 하는 법은 author_id를 unique설정.(즉, foreign key를 unique설정)
create table author_address (id bigint auto_increment primary key, country varchar(255), city varchar(255), street varchar(255), author_id bigint nou null unique, foreign key(author_id) references author(id));


--author_post는 연결테이블로 생성
create table author_post (id bigint auto_increment primary key, author_id bigint not null, post_id bigint not null, foreign key(author_id) refernces author(id),
foreign key(post_id) references post(id));

--복합키로 author_post생성
create table author_post2(author_id bigint not null, post_id bigint not null,
primary key(author_id,post_id),
foreign key(author_id) references author(id),
foreign key(post_id) references post(id));

--내 id로 내가 쓴 글 조회
select * from post p inner join author_post ap on p.id = ap.post_id where ap.author_id = 1;

--글 2번 이상 쓴 사람에 대한 정보 조회
select a.* from author a inner join author_post ap on a.id = ap.author_id group by a.id having count(a.id)>=2 order by author.id