# redis설치
sudo apt-get install redis-server

# redis접속
redis-cli

# redis는 0~15번 까지의 database로 구성(default는 0번 db)
# 데이터베이스 선택
select db번호

# 데이터베이스내 모든 키 조회
keys *

# 일반적인 String 자료 구조
set key명 value값
# set을 통해 key:value 세팅. 맵에서 set은 이미 존재하는 value에 덮어쓰기를 한다.
set user:email:1 hong1@naver.com
# nx : 이미 존재하면 pass,없으면 set
set user:email:1 hong1@naver.com nx
# ex : 만료시간(초 단위) - ttl(time to live)
set user:email:1 hong1@naver.com ex 10

# get을 통해 value값 얻기
get user:email:1

# 특정 key 삭제
del user:email:1

# 현재 db내 모든 key삭제
flushdb

# redis활용예시 : 동시성 이슈
# 1.좋아요 기능 구현
set likes:posting:1 0
# 좋아요 눌렀을 경우
incr likes:posting:1 #특정 key값의 value를 1만큼 증가
decr likes:posting:1 #특정 key값의 value를 1만큼 감소
get likes:posting:1

# 2.재고관리
set stocks:product:1 100
decr stocks:product:1
get stocks:product:1

# bash쉘을 활용하여 재고감소 프로그램 작성(15번 파일 참고)

# redis활용예시 : 캐싱기능 구현
# 1번 author 회원 정보 조회
# select name,emial,age from author where id=1;(rdb에서 조회)
# 위 데이터의 결과값을 redis로 캐싱 -> json형식으로 저장 {"name":"hong", "email:hong@daum.net", "age:30"}
set author:info:1 "{\"name\":\"hong\", \"email:hong@daum.net\", \"age\":30}" ex 20

# list자료구조
# redis의 list는 java의 deque와 같은 자료구조, 즉 double-ended  queue구조

# lpush : 데이터를 왼쪽에 삽입
# rpush : 데이터를 오른쪽에 삽입
# lpop : 데이터를 왼쪽에서 꺼내기
# rpop : 데이터를 오른쪽에서 꺼내기

lpush hogildongs hong1
lpush hogildongs hong2
lpush hogildongs hong3
rpop hongildongs

# list조회
-1은 리스트의 끝자리를 의미. -2는 끝에서 두 번째를 의미.
lrange hongildongs 0 0  # 첫번째 값
lrange hongildongs -1 -1 # 마지막 값
lrange hongildongs 0 -1 # 처음부터 마지막 값
lrange hongildongs -3 -1 
lrange hongildongs 0 2

# 데이터 개수 조회
llen hogildongs
# ttl 적용
expire hongildongs 20
# ttl 조회
ttl hongildongs
# pop과 push를 동시에 
# A리스트에서 pop하여 B리스트로 push도 가능하다.
rpoplpush A리스트 B리스트

# 최근 방문한 페이지
# 5개 정도 데이터 push하고 최근방문한 페이지 3개만 보여주는
rpush mypages www.naver.com 
rpush mypages www.google.com 
rpush mypages www.daum.net 
rpush mypages www.chatgpt.com 
rpush mypages www.playdata.com 
lrange mypages -3 -1

# set자료구조 : 중복없음. 순서없음.
sadd memberlist member1
sadd memberlist member2
sadd memberlist member1

# set 조회
smembers memberlist

# set멤버 개수 조회
scard memberlist

# set에서 멤버 삭제
srem memberlist member2
# 특정 멤버가 set안에 있는지 존재여부 확인
sismember memberlist member1

# 좋아요 구현
sadd likes:posting:1 member1
sadd likes:posting:1 member2
sadd likes:posting:1 member1
scard likes:posting:1 
sismember memberlist member1

# zset :sorted set
# 사이에 숫자는 score라고 불리고, score를 기준으로 정렬이 가능
zadd memberlist 3 member1
zadd memberlist 4 member2
zadd memberlist 1 member3
zadd memberlist 2 member4

# 조회방법
# score기준 오름차순 정렬
zrange memberlist 0 -1
# score기준 내림차순 정렬
zrevrenage memberlist 0 -1
# zset 삭제
zrem memberlist meber4

# zrank : 특정 멤버가 몇번째(index기준임) 순서인지 출력
zrank memberlist member4

# 최근 본 상품 목록 =>zset을 활용해서 최근시간 순으로 정렬
# zset도 set이므로 같은 상품을 add할 경우에 시간만 업데이트되고 중복이 제거
# 같은 상품을 더할 경우 시간만 마지막에 넣은 값으로 업데이트 (즉 중복 제거)
zadd recent:products 151930 pineapple
zadd recent:products 152030 banana
zadd recent:products 152130 orange
zadd recent:products 152230 apple
zadd recent:products 152330 apple

#최근 본 상품목록 3개 조회
zrevrange recent:products 0 2 withscores

# hashes : map형태의 자료구조(key:value, key:value...형태의 자료구조)
hset author:info1 name hong email hong@naver.com age 30
# 특정값 조회
hget author:info:1 age
# 모든 개체값 조회
hgetall author:info:1
#  특정 요소값 수정
hset author:info:1 name kim