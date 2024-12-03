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

<br/>
<br/>

---
# ⭐️ 프로젝트 소개
"모두를 위한 편리한 숙박 플랫폼" <br/>
우리 플랫폼은 일반 유저와 숙박업소 모두에게 최적화된 경험을 제공합니다. <br/>
일반 유저는 다양한 숙박업소를 손쉽게 검색하고 예약할 수 있어 편리함을 누릴 수 있습니다. <br/>
숙박업소는 고객과의 거래를 중개받는 것은 물론, 예약 관리와 매출 확인 등 효율적인 운영을 지원받을 수 있습니다. <br/>

---
<br/>

---
# ⭐️ 프로젝트 배경
숙박플랫폼 데이터베이스는 일반유저, 업주 2가지 유형의 이용자를 가지고 <br/>
숙소라는 상품. 그리고 숙소에 연결되는 객실이라는 세부상품을 다루고 <br/>
예약,결제,관리에 이르는 복합적인 데이터를 다루고있습니다. <br/>
그래서 저희 조는 이러한 데이터들을 다루고 최적화하면서 맞닦뜨리는 문제를 경험하고 <br/>
역량을 쌓기 위해 프로젝트로 숙박플랫폼의db를 선택했습니다. <br/>

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

![Zagoga_erd](https://github.com/user-attachments/assets/49f4fdab-46f5-4de8-97a0-b0d441eee0a8)


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
	coupon_id bigint NULL,
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

# 프로젝트 페르소나
**일반유저**  
처음으로 썸녀와 데이트를 한 진영이. 좋은 하루를 보내고 집으로 가려던 길.<br/>
좀 아쉽다.. <br/>
썸녀가 갑자기 어지럽다고 쉬다 가자고 한다.<br/>
근데 그 순간, 00 모텔 간판이 보인다. 찬스다…! <br/>
그러나 통장 잔고가 부족한데… 찬스를 놓칠 수 없다. 서둘러 폰을 꺼내, 몰래 쓰윽 자고가 어플을 킨다.<br/>
**내 위치 주변의 숙박을 검색**한다. 마침 할인 이벤트를 하네? **신규 회원 가입 쿠폰**을 받고, 조심스럽게 썸녀한테 쓰윽 말을 건낸다. 저기 갈까?  <br/>
<br/>

**일반유저**  
썸남이 가리키는 호텔을 확인하고서 휴대폰을 쓰윽 꺼내 자고가 어플에서 조회해본다.<br/>
어라, 흡연 불가능이네?  **별점과 리뷰**도 좋지 않네? 다시 **자신의 위치 주변의 흡연 가능한 숙박을 검색**한다.<br/>
숙박 내에 편의점이 있는지 상세 정보를 확인한다. 신설이지만 기가 막힌 곳을 찾았다.<br/>
오빠 내가 그냥 예약 할게~ 나 **골드 회원**이야.   <br/>
<br/>

**사업자 유저**  
어제 첫 개업을 한 업주. <br/>
마침 첫 손님으로 진영이네 커플이 들어왔다. 다음날 첫 손님의 방을 청소하러 들어간다.<br/>
왜 테이블이 부셔져있지? 와 이새끼들… 고객센터로 들어가 상담원한테 채팅으로 어제 묵었던 **유저를 신고**해야겠다. 일단 방 예약을 못하게 락을 걸어둬야겠다. <br/>
캘린터를 통해서 다른 유저들이 예약한 내용을 확인하고서 취소 문자를 보내둬야겠다.  <br/>
<br/>

---
<br/>

# 🌟 프로시저 실행결과
<details>
<summary><b>1. 업주 회원 가입</b></summary>
<div markdown="1">

![업주회원가입1](https://github.com/user-attachments/assets/a470c711-7705-473a-93b7-4cb175e59d61)

![업주회원가입2](https://github.com/user-attachments/assets/7fc97bb6-b4be-47e9-819a-d36fd2cc6dab)


</div>
</details>

<details>
<summary><b>2. 업소등록</b></summary>
<div markdown="1">

![숙박업소등록1](https://github.com/user-attachments/assets/092348f1-226f-49b6-8758-fb390c67810f)

![숙박업소등록2](https://github.com/user-attachments/assets/bd52e2c5-e873-43b5-8797-dc82760cdffa)


</div>
</details>

<details>
<summary><b>3. 업소 편의시설 등록</b></summary>
<div markdown="1">

![숙박편의시설등록1](https://github.com/user-attachments/assets/ae11807a-f04a-4c8b-bfc8-6f80b6ce4c31)

![숙박편의시설등록2](https://github.com/user-attachments/assets/41b05ed8-5639-428a-aabf-967ac9e3ff76)


</div>
</details>

<details>
<summary><b>4. 객실 등록</b></summary>
<div markdown="1">

![객실등록1](https://github.com/user-attachments/assets/36d8b258-74d4-4dcc-938f-8604d735c2a4)

![객실등록2](https://github.com/user-attachments/assets/09338bd2-b9fe-43ba-8dc5-0f7775230777)

</div>
</details>

<details>
<summary><b>5. 객실별 편의시설 등록</b></summary>
<div markdown="1">

![객실별편의시설등록](https://github.com/user-attachments/assets/db95b178-b97a-4d26-b8b9-17c82b97258b)

![객실별편의시설등록2](https://github.com/user-attachments/assets/249190d1-f2cb-4e1f-b118-f70c736c68b3)


</div>
</details>

<details>
<summary><b>6. 내 업소 예약확인</b></summary>
<div markdown="1">

![내업소예약확인1](https://github.com/user-attachments/assets/08ed18c7-a28b-4fd2-9290-22c46de5302d)

![내업소예약확인2](https://github.com/user-attachments/assets/0efc73a8-5beb-4e00-8d68-cd84f277637e)



</div>
</details>

<details>
<summary><b>7. 내 업소 월별 매출 확인</b></summary>
<div markdown="1">

![월별매출확인1](https://github.com/user-attachments/assets/71d49f6a-2a06-42da-b80d-2fe41f198d18)

![월별매출확인2](https://github.com/user-attachments/assets/29c1e6c5-56f0-4966-9eee-cfb819b00d9d)



</div>
</details>

<details>
<summary><b>8. 내 업소 기간별 매출 확인</b></summary>
<div markdown="1">

![기간별매출조회1](https://github.com/user-attachments/assets/6e8938ec-e07a-4c82-8cdf-3c54efdab686)

![기간별매출조회2](https://github.com/user-attachments/assets/fe9c3125-0e54-4dc4-acfa-5db91718824f)



</div>
</details>

<details>
<summary><b>9. 내 업소 리뷰 확인하기</b></summary>
<div markdown="1">

![본인숙박업소리뷰조회1](https://github.com/user-attachments/assets/d4e8bc60-2628-4ba2-98d1-18ddc5ccdaff)

![본인숙박업소리뷰조회2](https://github.com/user-attachments/assets/af7ff2e7-a691-4f81-91a9-44b75815c566)


</div>
</details>

<details>
<summary><b>10. 유저 회원가입 + 신규 회원 쿠폰 자동 지급</b></summary>
<div markdown="1">
	
![스크린샷 2024-12-03 122755](https://github.com/user-attachments/assets/47712a9c-5f97-4b49-a796-784fab30f737)

![스크린샷 2024-12-03 122920](https://github.com/user-attachments/assets/73bc129f-73cb-4322-8fd7-20831c840c2d)


</div>
</details>

<details>
<summary><b>11. 결제한 유저에 한 해 리뷰 작성하기</b></summary>
<div markdown="1">
	
![스크린샷 2024-12-03 123542](https://github.com/user-attachments/assets/3ec0cd57-e8ba-4c2a-af2f-f5be14007c87)
	
![스크린샷 2024-12-03 123620](https://github.com/user-attachments/assets/f30a925f-aae8-4d2a-b2d9-94f585d091e8)



	
![스크린샷 2024-12-03 123758](https://github.com/user-attachments/assets/edbfc486-b2d6-4cfd-aaa5-3e68577c9630)




	
![스크린샷 2024-12-03 123815](https://github.com/user-attachments/assets/aeaa8bf6-cf06-400b-9ba3-f35b78f8f8e1)



</div>
</details>

<details>
<summary><b>12. 내가 작성한 리뷰 확인하기</b></summary>
<div markdown="1">
	
![스크린샷 2024-12-03 123837](https://github.com/user-attachments/assets/9c224111-7ed6-4a4e-8bb4-5f3db297960c)
	
![스크린샷 2024-12-03 123851](https://github.com/user-attachments/assets/599b3923-c5a1-4b0c-b390-b37e3168a338)



</div>
</details>

<details>
<summary><b>13. 유저 등급조회 - 나 골드회원이야</b></summary>
<div markdown="1">
	
![스크린샷 2024-12-03 123913](https://github.com/user-attachments/assets/d4181955-54e3-4729-a618-2d756b2e7f0d)

![스크린샷 2024-12-03 123920](https://github.com/user-attachments/assets/daec1941-461b-449f-bcec-f435d0439063)

</div>
</details>


<details>
<summary><b>14. 내가 보유한 쿠폰 확인</b></summary>
<div markdown="1">

 ![스크린샷 2024-12-03 123941](https://github.com/user-attachments/assets/119b6c6f-b1a3-4ea5-8155-9736a34e470e)

![스크린샷 2024-12-03 123947](https://github.com/user-attachments/assets/c0ca932f-98d4-4260-9af8-7630b9921dba)




</div>
</details>

<details>
<summary><b>15. 쿠폰 등록</b></summary>
<div markdown="1">
	
![스크린샷 2024-12-03 124041](https://github.com/user-attachments/assets/f1b0e695-771a-4fed-9f80-0731f99a7ef6)

![스크린샷 2024-12-03 124046](https://github.com/user-attachments/assets/ad592b9a-d336-4c6b-9b93-dbe4383679c7)	


</div>
</details>


<details>
<summary><b>16. (유저) 쿠폰 다운</b></summary>
<div markdown="1">
	
![스크린샷 2024-12-03 124413](https://github.com/user-attachments/assets/5ca583a8-2077-4aa9-b241-da60231ff952)

![스크린샷 2024-12-03 124422](https://github.com/user-attachments/assets/713de863-a89f-4e1e-a368-851fd78da2e1)


</div>
</details>


<details>
<summary><b>17.인원수 선택도시 최저가 순 정렬 조회</b></summary>
<div markdown="1">

![스크린샷 2024-12-03 110801](https://github.com/user-attachments/assets/08646bf9-8472-4373-b70f-3fd431628f55)


![스크린샷 2024-12-03 111200](https://github.com/user-attachments/assets/5467d1ca-d0fb-4a42-a1e6-cc5c8a91a89d)

</div>
</details>

<details>
<summary><b>18. 인원수 선택도시 리뷰 많은 순 정렬 조회</b></summary>
<div markdown="1">

![스크린샷 2024-12-03 111347](https://github.com/user-attachments/assets/477b735b-66d0-43fe-ab8c-3334ff40057e)

![스크린샷 2024-12-03 111503](https://github.com/user-attachments/assets/35360238-afa8-4069-af05-4e2706496e8e)

</div>
</details>

<details>
<summary><b>19. 인원수 선택도시 별점 높은 순 정렬 조회</b></summary>
<div markdown="1">

![스크린샷 2024-12-03 111846](https://github.com/user-attachments/assets/0c6619fb-ffae-45bd-92ff-188ef8dcbd28)

![스크린샷 2024-12-03 111904](https://github.com/user-attachments/assets/f327ed61-c051-4399-8143-032a8131147d)


</div>
</details>

<details>
<summary><b>20. 선택한 숙소 리뷰 전체 조회</b></summary>
<div markdown="1">

![스크린샷 2024-12-03 112000](https://github.com/user-attachments/assets/956cac89-996c-4190-beb4-fd93c4a60285)

![스크린샷 2024-12-03 112054](https://github.com/user-attachments/assets/932064f2-767a-4565-bde7-19c33770d0aa)

</div>
</details>

<details>
<summary><b>21. 숙소 상세정보조회</b></summary>
<div markdown="1">

![스크린샷 2024-12-03 112240](https://github.com/user-attachments/assets/1c57e31b-82fc-4047-aa88-519d0556bfd5)

![스크린샷 2024-12-03 112313](https://github.com/user-attachments/assets/da8ae376-bc95-4e50-b2ac-c595677af303)

</div>
</details>

<details>
<summary><b>22.내근처숙소조회</b></summary>
<div markdown="1">

![스크린샷 2024-12-03 112453](https://github.com/user-attachments/assets/c37aba80-2516-42ee-8788-667c81e7ceb0)

![스크린샷 2024-12-03 112538](https://github.com/user-attachments/assets/1ccd329f-836e-4459-b29b-98c95e2bdf21)


</div>
</details>

<details>
<summary><b>23. 선택한 객실 예약을 위한 정보 입력 </b></summary>
<div markdown="1">

장바구니에 담은 객실들을 한 번에 결제가 가능하게끔 설계하기 위해,
예약_객실 프로시저와 결제 프로시저를 나누었다.

<img width="368" alt="예약_객실_프로시저_1" src="https://github.com/user-attachments/assets/f6dee1c7-37d9-4b4d-aaae-111b8872cadb">


```sql
DELIMITER $$

CREATE PROCEDURE 예약_객실(
    IN p_reservation_id BIGINT,
    IN p_room_id BIGINT,
    IN p_coupon_id BIGINT,
    IN p_check_in_day DATE,
    IN p_check_out_day DATE,
    IN p_num_people INT
)
BEGIN
    -- `detailed_reservation`에 데이터 삽입
    INSERT INTO detailed_reservation (
        reservation_id, 
        room_id, 
        coupon_id, 
        check_in_day, 
        check_out_day, 
        num_people
    )
    VALUES (
        p_reservation_id, 
        p_room_id, 
        p_coupon_id, 
        p_check_in_day, 
        p_check_out_day, 
        p_num_people
    );
END$$

DELIMITER ;
```


</div>
</details>

<details>
<summary><b>24. 가격에 따른 다른 결제 프로시저</b></summary>
<div markdown="1">

결제 금액을 비성수기/성수기/대실 을 나누어 설정해뒀다.
때에 맞는 결제 프로시저를 이용한다.
밑의 사진은 성수기 시즌 가격으로 결제를 진행할 때이다.

<img width="360" alt="결제_성수기_1" src="https://github.com/user-attachments/assets/a2146766-57d7-45ca-8bff-097bd7536564">


</div>
</details>

<details>
<summary><b>25. 여러개 객실 예약 한번에 결제 가능-비성수기 가격</b></summary>
<div markdown="1">
미리 user_id가 8인 사람에게 숙박 장바구니를 넣어두었다.
결제를 진행한 후, created_time 최신순에 따라 결제 내역을 출력하도록 프로시저를 구성했다.
<br/>
<img width="592" alt="결제_단체_예시" src="https://github.com/user-attachments/assets/44cbd022-c454-4071-b970-739a557112fe">
	
```sql
DELIMITER $$
CREATE PROCEDURE 결제_비성수기(
    IN p_user_id BIGINT,          -- 사용자 ID
    IN p_payment_type VARCHAR(255) -- 결제 유형 (예: '신용카드', '현금')
)
BEGIN
    DECLARE total_price INT DEFAULT 0;  -- 총 금액 저장 변수
    DECLARE new_payment_id BIGINT;      -- 새로 생성된 payment ID 저장 변수
    DECLARE representative_reservation_id BIGINT; -- 대표 reservation_id 저장 변수
    -- 해당 user_id의 모든 예약에 대한 비성수기 가격 총합 계산
    SELECT SUM(r.off_peak_season_price) INTO total_price
    FROM detailed_reservation dr
    JOIN reservation res ON dr.reservation_id = res.id
    JOIN room r ON dr.room_id = r.id
    WHERE res.user_id = p_user_id;
    -- 대표 reservation_id를 가져옴 (첫 번째 reservation_id 사용)
    SELECT res.id INTO representative_reservation_id
    FROM reservation res
    WHERE res.user_id = p_user_id
    LIMIT 1;
    -- payment 테이블에 결제 정보 삽입
    INSERT INTO payment (reservation_id, total_price, payment_type)
    VALUES (
        representative_reservation_id,  -- 대표 reservation_id를 설정
        total_price,    -- 계산된 총 금액
        p_payment_type  -- 전달받은 결제 유형
    );
    -- 방금 생성된 payment ID 가져오기
    SET new_payment_id = LAST_INSERT_ID();
    -- payment_detailed_reservation 테이블에 관련 detailed_reservation ID 추가
    INSERT INTO payment_detailed_reservation (payment_id, detailed_reservation_id)
    SELECT new_payment_id, dr.id
    FROM detailed_reservation dr
    JOIN reservation res ON dr.reservation_id = res.id
    WHERE res.user_id = p_user_id;
   -- 결제 내역 출력
   SELECT 
   pdr.payment_id, pdr.detailed_reservation_id, p.created_time
   FROM payment_detailed_reservation pdr
   JOIN payment p ON pdr.payment_id = p.id
   JOIN detailed_reservation dr ON pdr.detailed_reservation_id = dr.id
   JOIN reservation res ON dr.reservation_id = res.id
   WHERE res.user_id = p_user_id
   ORDER BY p.created_time DESC;
END$$
DELIMITER ;
```

</div>
</details>

<details>
<summary><b>26.예약 정보 조회</b></summary>
<div markdown="1">
user_id로 자신이 예약한 정보를 조회하는 프로시저이다. <br/>
<img width="368" alt="결제_정보_조회_프로시저_1" src="https://github.com/user-attachments/assets/6762cf22-16d3-4e8c-975e-f86d417cdeec">
<br/>
아래 이미지는 user_id를 8로 검색했을 때, 나오는 결과이다.<br/>
사실, payment_time 최신순 정렬을 까먹었다.<br/>
<img width="956" alt="결제_정보_조회_프로시저_1_결과" src="https://github.com/user-attachments/assets/a8c443cc-7724-47f2-859e-dab40fbb6e21">
	
```sql
DELIMITER $$
CREATE PROCEDURE 조회_결제_예약_정보(
    IN p_user_id BIGINT -- 조회할 사용자 ID
)
BEGIN
    -- 특정 사용자의 결제 정보와 관련된 예약 상세 정보 조회
    SELECT 
        p.id AS payment_id,
        p.total_price,
        p.payment_type,
        p.created_time AS payment_time,
        dr.room_id AS room_id,
        dr.coupon_id,
        dr.check_in_day,
        dr.check_out_day,
        dr.num_people
    FROM 
        payment p
    JOIN 
        reservation res ON p.reservation_id = res.id
    JOIN 
        detailed_reservation dr ON dr.reservation_id = res.id
    WHERE 
        res.user_id = p_user_id;
END$$
DELIMITER ;
```

</div>
</details>

<details>
<summary><b>27. 채팅 메세지 db 저장</b></summary>
<div markdown="1">
채팅 프로시저에서는 유저-상담원, 오너-상담원, 유저-오너를
input id 값으로 구분하고, sender을 통해 메세지의 수신자를 판단한다.
cs_chat table 에서 user_id, owner_id, admin_id를 모두 fk, null 로 받는다.
아래는 유저-상담원 채팅 프로시저 sql문이다.
	
```sql
DELIMITER $$
CREATE PROCEDURE 채팅_유저_상담원 (
	IN p_user_id BIGINT,
	IN p_admin_id BIGINT,
	IN p_contents VARCHAR(3000),
	IN p_sender ENUM('user', 'admin')
)
BEGIN
	INSERT INTO cs_chat (user_id, admin_id, contents, sender)
	VALUES (p_user_id, p_admin_id, p_contents, p_sender);
END$$
DELIMITER ;
```

아래 사진은 오너-상담원 채팅 프로시저를 사용한 모습이다.<br/>
<img width="379" alt="채팅 프로시져" src="https://github.com/user-attachments/assets/e2edb7b5-116e-41d2-9577-ea004b2a1171">
</div>
</details>

<details>
<summary><b>28. 내가 보낸 채팅 메세지 조회</b></summary>
<div markdown="1">
내가 쓴 채팅을 조회하기 위해, sender를 검색한다.
sender는 user, owner, admin 모두가 될 수 있기 때문에,
자신의 역할군을 밝히고 해당 id 값을 입력받아 채팅 내역을 모두 조회한다.

```sql
DELIMITER $$
CREATE PROCEDURE 채팅_내역_조회 (
	IN p_sender ENUM('user', 'owner', 'admin'), 
	IN p_sender_id BIGINT
)
BEGIN
	IF p_sender = 'user' THEN
		SELECT * FROM cs_chat
		WHERE user_id = p_sender_id AND sender = 'user';
	ELSEIF p_sender = 'owner' THEN
		SELECT * FROM cs_chat
		WHERE owner_id = p_sender_id AND sender = 'owner';
	ELSEIF p_sender = 'admin' THEN
		SELECT * FROM cs_chat
		WHERE admin_id = p_sender_id AND sender = 'admin';
	END IF;
END$$
DELIMITER ;
```

<img width="629" alt="채팅_내역_조회" src="https://github.com/user-attachments/assets/5000e290-27d7-4eee-ac82-671289400bcd">
</div>
</details>

<details>
<summary><b>29. 업주 생성- 프로시저 (10,000개)</b></summary>
<div markdown="1">
	
```sql
DELIMITER $$
CREATE PROCEDURE insert_owners()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 10000 DO
        INSERT INTO owner (name, personal_id, phone_number, account_number, created_time, delete_owner) VALUES
        (CONCAT('업주', i), 
         CONCAT('P', LPAD(i, 6, '0')), 
         CONCAT('010-', FLOOR(RAND() * 1000), '-', FLOOR(RAND() * 10000)), 
         CONCAT('123-456-78901', i), 
         NOW(), 
         0);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;
```

![스크린샷 2024-12-03 112749](https://github.com/user-attachments/assets/d8fe4fc7-6989-4d06-bdfa-f521f0eabcc3)

</div>
</details>

<details>
<summary><b>30. 숙소 생성- 프로시저 (10,000개)</b></summary>
<div markdown="1">

```sql
DELIMITER $$
CREATE PROCEDURE insert_accommodations()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 10000 DO
        INSERT INTO accommodation (owner_id, name, type, address, latitue, hardness, check_in_time, check_out_time, rent_time, business_num, update_time, delete_accommodation) VALUES
        (FLOOR(1 + RAND() * 3), 
         CONCAT('숙소 ', i), 
         ELT(FLOOR(1 + RAND() * 3), 'hotel', 'motel', 'pension'), 
         CONCAT('주소 ', i), 
         ROUND(33 + (RAND() * 5), 6), 
         ROUND(126 + (RAND() * 5), 6), 
         '15:00', 
         '11:00', 
         '4시간', 
         CONCAT(FLOOR(100 + RAND() * 900), '-', FLOOR(100 + RAND() * 900), '-', FLOOR(1000 + RAND() * 9000)), 
         NOW(), 
         0);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;
```

![스크린샷 2024-12-03 112636](https://github.com/user-attachments/assets/e18731b9-c4d2-41a6-b822-2d8e93cee235)
</div>
</details>

# 회고
### 장기현  

**"잘 세운 기초가 좋은 건축을 만든다."** <br/>
무작정 DB ERD설계를 하다보니 <br/>
막상 SELECT 문을 작성할 때 4중 5중 join이 발생하더라고요. <br/>
그래서 테이블 수정작업이 많이 이루어졌는데, <br/>
ERD설계 시 유의할 게 생각보다 많다고 느꼈습니다. <br/>
역시 DB설계 단계부터 좋은 설계를 해야지만 <br/>
좋은 개발이 된다는 것을 깨달았습니다. <br/>
이번 경험을 계기로 앞으로는 더 나은 DB설계를 할 수 있을 것 같습니다.  <br/>
저희 팀원분들 다들 고생많으셨습니다 ! <br/>
<br/>

---
### 김진영
**"결과도 좋았지만 과정이 더 좋았던 프로젝트!"**  <br/>
저희 팀은 시작할 때 부터 우리는 과제라고 생각하지말고 진짜 숙박플랫폼의 데이터베이스를 설계하고 구축한다는 마인드로 먼저 다지고 시작해서 좋았고 그래서 덜 풀어지지 않았나 싶습니다. <br/>
그리고 테이블 관계에 대해 치열하게 토의하고 서로를 설득하고 이해시키는 과정이 멋졌던 팀이었습니다. <br/>
또한, 저도 나중에 생성된 스키마를 바탕으로 sql문을 짜는 과정에서 아 데이터를 설계하는 과정에서  <br/>
빈번하게 조회 될 수 있는 부분을 생각하고 조금은 정규화에 얽메이지 말고 만들어야하지 않았을까 아쉬움을 느꼈고 다음번에 데이터를 설계할 때는 좀 더 앞서서 생각해야겠다고 느낄 수 있었습니다.  <br/>
팀을 리드하고, 각종 툴로 프로젝트를 한껏 업그레이드해주신 가연님  <br/>
우리 팀의 에이스로 덕분에 많은 걸 배울 수 있었던 기현님  <br/>
모두가 미처 생각하지도 못했던 부분이 있을 때 마다 예리하게 알려주셨던 준서님  <br/>
다들 고생 많으셨습니다!  <br/>

---
### 추가연
**" 첫 프로젝트, 그래도 무사히 끝내서 다행이다. "**  <br/>
DB ERD 설계가 무척이나 중요했다는 것을, 깨닫는 순간이다. <br/>
1:N 관계인지, N:N 관계인지 풀어내는 것이 이 프로젝트의 핵심이지 않았나 생각든다. <br/>
NOT NULL이 당연해 보이는 것들도 나중에 프로시저를 생성할 때에, <br/>
규제로 작용하는 경우가 많아 급하게 컬럼을 수정한 기억이 많다.. <br/>
채팅 시스템을 완벽하게 개발하지 못함에 아쉬움이 남는다. <br/>
(그러게 평소에 레퍼런스들 좀 찾아볼걸...) <br/>
지금 설계하나 DB도 문제점이 존재한다. 예약 테이블에서 한번에 결제는 가능하지만, <br/>
생성 조건과 소멸(결제 후) 조건이 아무것도 존재하지 않는다. 이것이 프로그램에서 <br/>
행할 일이라면, 할 말이 없겠다만.. 적어도 created_time을 넣어둘 걸.. 이란 생각이 든다. <br/>
또, 채팅 시스템이 실무에서는 절대 이렇게 진행되지 않을 것 같은데.. 좀만 더 고민해볼걸.. <br/>
생각이 많이 든다. 그래도 이번 프로젝트를 진행하면서 여러가지를 고려하고 DB를 바라보는 <br/>
시각을 많이 키운 것 같다. 재밌었다! <br/>

---
### 이준서
