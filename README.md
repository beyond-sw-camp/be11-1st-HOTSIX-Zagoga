# be11-1st-HOTSIX-Zagoga
🐳추가연🐣김진영🐢이준서🐯장기현

# Zagoga
<img height="250" src="https://github.com/user-attachments/assets/56df8380-b5c6-46a5-8cde-231d56a21436"></img>
> **_어디서든 잘 수 있는 숙박 플랫폼_** <br/><br/>
> **개발기간: 2024.11.27 ~ 2024.12.03**
---
 <br/>

# ✨Team HOT SIX

|추가연|김진영|이준서|장기현|
|:-:|:-:|:-:|:-:|
|<img src="https://github.com/user-attachments/assets/f85676a0-86ab-4848-8c2f-47c481aaae80" width=200 height=200>|<img src="https://github.com/user-attachments/assets/7fe3fd8a-1fbf-4a3b-ba53-f4fd39a14ce2" width=200 height=200>|<img src="https://github.com/user-attachments/assets/1ed712cb-330e-4eb4-a06d-2fd3c8a4a706" width=200 height=200>|<img src="https://github.com/user-attachments/assets/c7298255-dbbf-4ac3-9115-aa1926834af5" width=200 height=200>|
|[@gayeon99](https://github.com/gayeon99)|[@jykim1187](https://github.com/jykim1187)|[@LetsSeeTerrapin](https://github.com/LetsSeeterrapin)|[@ki-hyun-Jang](https://github.com/ki-hyun-Jang)|

 
# ⭐️ 프로젝트 소개


---
<br/>

# WBS
![WBS](https://github.com/user-attachments/assets/6b13b529-1aa6-40c4-8a5c-ac30afa9698b)

---
<br/>

# 요구사항 정의서
![요구사항 정의서](https://github.com/user-attachments/assets/0713e05f-7d02-47f4-9234-ab0ddff0010b)

---
<br/>

# ERD
![Zagoga](https://github.com/user-attachments/assets/766de641-41e9-4bcb-b4d3-b9d159dea631)

---
<br/>

# Schema
## 1. 유저
```sql
CREATE TABLE user (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NULL,
	personal_id varchar(255) NOT NULL,
	phone_number varchar(255) NOT NULL,
	email varchar(255) NULL,
	sex enum('남', '여') NULL,	
	level enum('Bronze', 'Silver','Gold','Platinum','Vip') NULL DEFAULT 'Bronze',
	created_time datetime NULL DEFAULT current_timestamp(),
	delete_user tinyint NULL DEFAULT 0
);

```

## 2. 업주
```sql
CREATE TABLE owner (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NULL,
	personal_id varchar(255) NOT NULL,
	phone_number varchar(255) NOT NULL,
	account_number varchar(255) NOT NULL,
	created_time datetime NULL DEFAULT current_timestamp(),
	delete_owner tinyint NULL DEFAULT 0
);
```

## 3. 관리자
```sql
CREATE TABLE admin (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NULL,
	type enum('server_admin','customer_service') NULL,
	created_time datetime NULL DEFAULT current_timestamp()
);
```

## 4. CS 채팅
```sql
CREATE TABLE cs_chat (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	owner_id bigint NULL,
	user_id bigint NULL,
	admin_id bigint NULL,
	contents varchar(3000) NULL,
	created_time datetime NULL DEFAULT current_timestamp(),
	sender enum('user','owner', 'admin') NULL,

	FOREIGN KEY(owner_id) REFERENCES owner(id),
	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(admin_id) REFERENCES admin(id)
);
```

## 5. 쿠폰
```sql
CREATE TABLE coupon (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NOT NULL,
	discount varchar(255) NOT NULL,
	cp_describe varchar(255) NULL,
	update_time datetime NULL DEFAULT current_timestamp()
);
```

## 6. 숙소
```sql
CREATE TABLE accommodation (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	owner_id bigint NOT NULL,
	name varchar(255) NOT NULL,
	type enum('hotel','motel','pension') NOT NULL,
	address varchar(255) NOT NULL,
	latitue decimal(9,6) NOT NULL,
	hardness decimal(9,6) NOT NULL,
	check_in_time varchar(255) NULL,
	check_out_time varchar(255) NULL,
	rent_time varchar(255) NULL,
	business_num varchar(255) NOT NULL,
	update_time datetime NULL DEFAULT current_timestamp(),
	delete_accommodation tinyint NULL DEFAULT 0,

	FOREIGN KEY(owner_id) REFERENCES owner(id)
);
```

## 7. 방
```sql
CREATE TABLE room (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	accommodation_id bigint NOT NULL,
	type varchar(255) NOT NULL,
	people_max int NOT NULL,
	off_peak_season_price int NOT NULL,
	peak_season_price int NOT NULL,
	rent_price int NULL,
	count int NULL,

	FOREIGN KEY(accommodation_id) REFERENCES accommodation(id)
);
```

## 8. 방 편의시설
```sql
CREATE TABLE room_facility (
	id bigint	PRIMARY KEY NOT NULL auto_increment,
	room_id bigint NOT NULL,
	bed_num int NULL DEFAULT 1,
	bed_type enum('Single','Double','Queen') NULL DEFAULT 'Single',
	has_bath tinyint NULL DEFAULT 0,
	has_air_condition tinyint	NULL DEFAULT 0,
	has_tv tinyint NULL DEFAULT 0,
	has_internet tinyint NULL DEFAULT 0,
	has_ott tinyint NULL DEFAULT 0,
	has_amenity tinyint NULL DEFAULT 0,
	has_animal tinyint NULL DEFAULT 0,

	FOREIGN KEY(room_id) REFERENCES room(id)
);
```

## 9. 예약
```sql
CREATE TABLE reservation (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	user_id bigint NOT NULL,
	
	FOREIGN KEY(user_id) REFERENCES user(id)
);
```

## 10. 쿠폰리스트
```sql
CREATE TABLE coupon_list (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	user_id bigint NOT NULL,
	coupon_id bigint NOT NULL,
	created_time datetime NULL DEFAULT current_timestamp(),
	expire_time datetime NULL,
	usable tinyint NULL DEFAULT 0,

	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(coupon_id) REFERENCES coupon(id)
);
```

## 11. 숙소 편의시설
```sql
CREATE TABLE accommodation_facility (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	accommodation_id bigint NOT NULL,
	able_bbq tinyint NULL DEFAULT 0,
	able_parking tinyint NULL DEFAULT 0,
	able_sports tinyint NULL DEFAULT 0,
	able_sauna tinyint NULL DEFAULT 0,
	able_front tinyint NULL DEFAULT 0,
	able_breakfast tinyint NULL DEFAULT 0,
	able_swim tinyint	NULL DEFAULT 0,

	FOREIGN KEY(accommodation_id) REFERENCES accommodation(id)
);
```

## 12. 결제
```sql
CREATE TABLE payment (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	reservation_id bigint NULL,
	total_price int NOT NULL,
	payment_type varchar(255) NOT NULL,
	created_time datetime NOT NULL DEFAULT current_timestamp(),

	FOREIGN KEY(reservation_id) REFERENCES reservation(id)
);
```

## 13. 즐겨찾기
```sql
CREATE TABLE favorite_list (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	user_id bigint NOT NULL,
	accommodation_id bigint NOT NULL,

	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(accommodation_id) REFERENCES accommodation(id)
);
```

## 14. 상세예약
```sql
CREATE TABLE detailed_reservation (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	reservation_id bigint NOT NULL,
	room_id bigint NOT NULL,
	coupon_id bigint NOT NULL,
	check_in_day date NOT NULL,
	check_out_day date NOT NULL,
	num_people int NOT NULL,
	created_time datetime	NULL DEFAULT current_timestamp(),

	FOREIGN KEY(reservation_id) REFERENCES reservation(id),
	FOREIGN KEY(room_id) REFERENCES room(id),
	FOREIGN KEY(coupon_id) REFERENCES coupon(id)
);
```

## 15. 리뷰
```sql
CREATE TABLE review (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	accommodation_id bigint NOT NULL,
	payment_id bigint NOT NULL,
	title varchar(255) NULL,
	content varchar(10000) NULL,
	star int NULL,
	photo varchar(255) NULL,
	created_time datetime NULL DEFAULT current_timestamp(),

	FOREIGN KEY(accommodation_id) REFERENCES accommodation(id),
	FOREIGN KEY(payment_id) REFERENCES payment(id)
);
```

## 16. 결제 상세 예약
```sql
CREATE TABLE payment_detailed_reservation (
    payment_id BIGINT NOT NULL,
    detailed_reservation_id BIGINT NOT NULL,
    PRIMARY KEY (payment_id, detailed_reservation_id),
    FOREIGN KEY (payment_id) REFERENCES payment(id),
    FOREIGN KEY (detailed_reservation_id) REFERENCES detailed_reservation(id)
);
```


---
<br/>

# 프로젝트 시나리오 
**유저 시나리오 남자**  
처음으로 썸녀와 데이트를 한 진영이. 좋은 하루를 보내고 집으로 가려던 길.<br/>
좀 아쉽다.. <br/>
썸녀가 갑자기 어지럽다고 쉬다 가자고 한다.<br/>
근데 그 순간, 00 모텔 간판이 보인다. 찬스다…! <br/>
그러나 통장 잔고가 부족한데… 찬스를 놓칠 수 없다. 서둘러 폰을 꺼내, 몰래 쓰윽 자고가 어플을 킨다.<br/>
내 위치 주변의 최저가 숙박을 검색한다. 마침 할인 이벤트를 하네? 신규 회원 가입 쿠폰을 받고, 조심스럽게 썸녀한테 쓰윽 말을 건낸다. 저기 갈까?  <br/>
<br/>

**유저 시나리오 썸녀**  
썸남이 가리키는 호텔을 확인하고서 휴대폰을 쓰윽 꺼내 자고가 어플에서 조회해본다.<br/>
어라, 흡연 불가능이네?  별점과 리뷰도 좋지 않네? 다시 자신의 위치 주변의 흡연 가능한 숙박을 검색한다.<br/>
숙박 내에 편의점이 있는지 상세 정보를 확인한다. 신설이지만 기가 막힌 곳을 찾았다. 오빠 내가 그냥 예약 할게~ 나 골드 회원이야.   <br/>
<br/>

**업주 시나리오**  
어제 첫 개업을 한 업주. <br/>
마침 첫 손님으로 진영이네 커플이 들어왔다. 다음날 첫 손님의 방을 청소하러 들어간다.<br/>
왜 테이블이 부셔져있지? 와 이새끼들… 고객센터로 들어가 상담원한테 채팅으로 어제 묵었던 유저를 신고해야겠다. 일단 방 예약을 못하게 락을 걸어둬야겠다. <br/>
캘린터를 통해서 다른 유저들이 예약한 내용을 확인하고서 취소 문자를 보내둬야겠다.  <br/>
<br/>

---
<br/>

# 🌟 프로시저 실행결과

> 🔑 1. 회원가입

<img src="" width=30%><img src="" width=30%>
<img src="" width=30%>

> 2. 조회

<img src="" width=30%><img src="" width=30%>
<img src="" width=30%>


