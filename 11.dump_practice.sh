# 덤프파일 생성 : dumpfile.sql이라는 이름의 덤프파일 생성
mysqldump -u root -p board > dumpfile.sql

# 한글 깨질 때
mysqldump -u root -p -r board dumpfile.sql

# 덤프파일 적용(복원)
# <가 예약어로 인식되어, window에서는 적용이 안될 경우, git bash 터미널 창을 활용한다.
mysql -u root -p board < dumpfile.sql

# 덤프파일을 github에 업로드

# 리눅스에서 mariadb설치
sudo apt-get install mariadb-server

# mariadb 서버 실행
sudo systemctl start mariadb

# mariaDB 접속 :1234
sudo mariadb -u root -p
create database board;

# git 설치
sudo apt install git

# git에서 repository clone
git clone 레포지토리 주소

#dump파일 복원