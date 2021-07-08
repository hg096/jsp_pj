create database jsp_pj;
use  jsp_pj;

-- 상품
drop table product;
CREATE TABLE IF NOT EXISTS product(
	
	p_id int NOT NULL auto_increment, -- 코드 
	name VARCHAR(20) not null, -- 이름 
	description TEXT not null, -- 상세설명 
	unitPrice int not null, -- 가격 
	fileName  VARCHAR(20),	-- 이미지
		PRIMARY KEY (p_id)
)default CHARSET=utf8;

desc product;

INSERT INTO product VALUES( 1, '긴팔티셔츠', '긴팔티셔츠 입니다.', 1000, 'p1.jpg');
INSERT INTO product VALUES( 2, '겨울 패딩', '겨울 패딩 입니다.', 2000, 'p2.jpg');
INSERT INTO product VALUES( 3, '이너웨어', '이너웨어 입니다.', 3000, 'p3.jpg');

INSERT INTO product VALUES( 4, '반팔티셔츠', '반팔티셔츠 입니다.', 1000, 'p4.jpg');
INSERT INTO product VALUES( 5, '니트/스웨터', '니트/스웨터 입니다.', 2000, 'p5.jpg');
INSERT INTO product VALUES( 6, '자켓', '자켓 입니다.', 3000, 'p6.jpg');

INSERT INTO product VALUES (7, '반팔티셔츠', '반팔티셔츠 입니다.', 1000, 'p7.jpg');
INSERT INTO product VALUES( 8, '자켓', '자켓 입니다.', 2000, 'p8.jpg');
INSERT INTO product VALUES( 9, '데님팬츠', '데님팬츠 입니다.', 3000, 'p9.jpg');

INSERT INTO product VALUES( 10, '슬리퍼', '슬리퍼 입니다.', 1000, 'p10.jpg');
INSERT INTO product VALUES(11, '데님팬츠', '데님팬츠 입니다.', 2000, 'p11.jpg');
INSERT INTO product VALUES( 12, '데님팬츠', '코튼팬츠 입니다.', 3000, 'p12.jpg');

INSERT INTO product VALUES( 13, '모자', '모자 입니다.', 1000, 'p13.jpg');
INSERT INTO product VALUES( 14, '니트/스웨터', '니트/스웨터 입니다.', 2000, 'p14.jpg');
INSERT INTO product VALUES( 15, '셔츠', '셔츠 입니다.', 3000, 'p15.jpg');


select * from product;



-- 주문 
drop table orders;
CREATE TABLE IF NOT EXISTS orders (
	o_num int not null auto_increment, -- 주문번호 자동으로 숫자 증가 
	p_name varchar(40) not null, -- 상품이름
	amount int not null, -- 수량
    m_name varchar(40) not null, -- 주문자 이름   
	regist_day varchar(30) not null,	 --  날짜
    t_Price int not null, -- 총 가격    
	conditions varchar(30) not null,	-- 상태
    postcode varchar(20) not null, -- 우편 번호
	address varchar(90) not null,	-- 주소
		PRIMARY KEY (o_num)
)default CHARSET=utf8;

INSERT INTO orders VALUES(1, '상품이름1', 1, '주문자이름1', '2020/01/01', 1001, '주문완료', 1001, '주소1');
INSERT INTO orders VALUES(2, '상품이름2', 2, '주문자이름2', '2020/01/02', 4000, '배송준비중', 1002, '주소2');
INSERT INTO orders VALUES(3, '상품이름3', 3, '주문자이름3', '2020/01/03', 6000, '배송중', 1003, '주소3');
INSERT INTO orders VALUES(4, '상품이름1', 3, '주문자이름3', '2020/01/04', 8000, '배송완료', 1003, '주소4');
INSERT INTO orders VALUES(5, '상품이름2', 3, '주문자이름3', '2020/01/05', 10000, '배송완료', 1003, '주소5');
INSERT INTO orders VALUES(6, '상품이름3', 3, '주문자이름3', '2020/01/06', 12000, '배송완료', 1003, '주소6');

select * from orders;
desc orders;



-- 공지사항
drop table notice;
CREATE TABLE IF NOT EXISTS notice (
       n_num int not null auto_increment, -- 번호
       name varchar(10) not null,	-- 작성이름
       subject varchar(100) not null,	-- 제목
       content text not null,	-- 내용
       regist_day varchar(30) not null,	-- 날짜
       hit int not null,	-- 조회수
       ip varchar(20) not null,	-- 아이피
			PRIMARY KEY (n_num)
)default CHARSET=utf8;

select * from notice;
desc notice;



-- 유저
drop table member;
create table IF NOT EXISTS member ( 
    m_id varchar(20) not null, -- 유저아이디 
    password varchar(20) not null, -- 비밀번호
    name varchar(10) not null,	-- 이름
    gender varchar(4) not null,	-- 성별
    birth  varchar(10) not null,	-- 생일
    mail  varchar(30) not null,	-- 이메일
    phone varchar(10) not null,	-- 전화번호
    address varchar(90) not null,	-- 주소
    regist_day varchar(50) not null,	-- 가입시간
		primary key(m_id) 
) default CHARSET=utf8;

INSERT INTO member VALUES('aaa', '1234', '이름', '남성', '2020/01/01', 'aaa@aaa.com', '01012341234', '주소1', '2020/01/01');
select * from member;


-- 문의사항
drop table commu;
CREATE TABLE IF NOT EXISTS commu (
       c_num int not null auto_increment, -- 번호
	   m_id varchar(10) not null, -- 유저아이디 
       subject varchar(100) not null,	-- 제목
       content text not null,	-- 내용
       hit int not null,	-- 조회수
		date Timestamp not null,	-- 날짜
        
			PRIMARY KEY (c_num)
)default CHARSET=utf8;
INSERT INTO commu VALUES(1, 'aaa', '예시1', '예시1', 0,'2020/01/02');
select * from commu;



-- 답글
drop table comment;
create table comment(
	c_num int,
	m_id varchar(50), 
	content text,
	date Timestamp
);
INSERT INTO comment VALUES(1, 'aaa', '예시1', '2020/01/02');
INSERT INTO comment VALUES(1, 'aaa', '예시2', '2020/01/02');
select * from comment;
-- 관계 추가
ALTER TABLE comment
    ADD CONSTRAINT FK_comment_c_num_commu_c_num FOREIGN KEY (c_num)
        REFERENCES commu (c_num) ON DELETE CASCADE ON UPDATE RESTRICT;
         



