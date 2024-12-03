--업주 회원가입 프로시저

DELIMITER //
CREATE PROCEDURE 업주회원가입(in 업주이름 varchar(255), in 주민등록번호 varchar(255), in 전화번호 varchar(255), in 계좌번호 varchar(255))
BEGIN
  insert into owner (name, personal_id, phone_number, account_number) values(업주이름, 주민등록번호, 전화번호, 계좌번호);
    END ;
END//
DELIMITER ;


--숙박업소 등록 프로시저

DELIMITER //
CREATE PROCEDURE 업소등록
(in 사업자고유번호 bigint, in 숙박업소명 varchar(255), in 업소타입 varchar(255)
, in 주소 varchar(255), in 위도 decimal, in 경도 decimal,in 사업자번호 varchar(255))

BEGIN
  insert into accommodation (owner_id, name, type, address, latitue, hardness, business_num) values(사업자고유번호, 숙박업소명, 업소타입, 주소, 위도, 경도, 사업자번호);
END//
DELIMITER ;

--숙박편의시설 등록 프로시저

DELIMITER //
CREATE PROCEDURE 숙박편의시설등록
(in 숙박업소고유번호 bigint, in BBQ tinyint, in 주차여부 tinyint, in 스포츠시설 tinyint, in 사우나 tinyint,
in 24시간프론트 tinyint, in 조식 tinyint, in 수영장 tinyint)

BEGIN
  insert into accommodation_facility ( accommodation_id, able_bbp, able_parking, able_sport, able_sauna, able_front, able_breakfast, able_swim) 
  values(숙박업소고유번호, BBQ, 주차여부, 스포츠시설, 사우나, 24시간프론트, 조식, 수영장);
END//
DELIMITER ;

--객실 등록 프로시저

DELIMITER //
CREATE PROCEDURE 객실등록
(in 숙박업소ID bigint, in 객실유형 varchar(255), in 최대수용인원 int, 
in 비수기가격 int, in 성수기가격 int, in 대실료 int, 객실수 int)

BEGIN
  insert into room(accommodation_id, type, people_max , 
off_peak_season_price , peak_season_price ,rent_price, count) 
  values(숙박업소ID , 객실유형 , 최대수용인원 , 
비수기가격, 성수기가격 , 대실료, 객실수);
END//
DELIMITER ;

--객실별 편의시설 등록 프로시저

DELIMITER //
CREATE PROCEDURE 객실별편의시설등록
(in 객실id bigint, in 침대개수 int, in 침대타입 varchar(255), 
in 욕조 tinyint, in 에어컨 tinyint, in TV tinyint, 인터넷 tinyint
,in OTT tinyint, in 어메니티제공 tinyint, in 반려동물동반가능 tinyint)

BEGIN
  insert into room_facility(room_id, bed_num, bed_type, 
has_bath, has_air_condition, has_tv, has_internet,has_ott, has_amenity, has_animal) 
  values(객실id, 침대개수, 침대타입, 
욕조 , 에어컨, TV , 인터넷, OTT, 어메니티제공, 반려동물동반가능);
END //
DELIMITER ;

--내 업소 예약확인

DELIMITER //
CREATE PROCEDURE 내업소예약확인
(in 사업주id bigint)

BEGIN
 select o.name as 업주명, ac.name as 숙박업소명, r.id as 객실, dr.check_in_day as 체크인날짜, dr.check_out_day as 체크아웃날짜 from detailed_reservation dr inner join room r on dr.room_id = r.id inner join accommodation ac on r.accommodation_id = ac.id
inner join owner o on ac.owner_id = o.id where o.id = 사업주id;
END //
DELIMITER ;

--월별매출확인

DELIMITER //
CREATE PROCEDURE 월별매출확인
(in 사업자ID bigint, in 년도월 varchar(20))

BEGIN
 select ac.id as 숙박업소id, ac.name as 숙박업소명,date_format(p.created_time,'%Y-%m') as 년도월,sum(p.total_price) as 매출액 from payment p inner join reservation res on p.reservation_id = res.id inner join detailed_reservation dr on res.id = dr.reservation_id
inner join room r on dr.room_id = r.id inner join accommodation ac on r.accommodation_id = ac.id where ac.id =사업자ID and date_format(p.created_time,'%Y-%m') = 년도월 group by ac.id ;
END //
DELIMITER ;


--기간별 매출확인

DELIMITER //
CREATE PROCEDURE 기간별매출확인
(in 사업자ID bigint, in 조회시작날짜 varchar(20), in 조회종료날짜 varchar(20))

BEGIN
 declare start_date varchar(20);
 declare end_date varchar(20);
 
 set start_date = 조회시작날짜;
 set end_date = 조회종료날짜;
 
 select ac.id as 숙박업소id, ac.name as 숙박업소명, start_date as 조회시작년도월, end_date as 조회마지막년도월 ,sum(p.total_price) as 매출액 from payment p inner join reservation res on p.reservation_id = res.id inner join detailed_reservation dr on res.id = dr.reservation_id
inner join room r on dr.room_id = r.id inner join accommodation ac on r.accommodation_id = ac.id where ac.id =사업자ID and date_format(p.created_time,'%Y-%m-%d') >=조회시작날짜 and date_format(p.created_time,'%Y-%m-%d') <= 조회종료날짜  group by ac.id ;
END //
DELIMITER ;

--본인 숙소 리뷰확인

DELIMITER //
CREATE PROCEDURE 본인숙박업소리뷰조회
(in 사업자ID bigint)

BEGIN
select ac.name as 숙박업소명, r.title as 제목, r.content as 내용, r.star as 별점, r.photo as 사진 from review r inner join accommodation ac on r.accommodation_id = ac.id 
inner join owner o on ac.owner_id = o.id where o.id =사업자ID;
END //
DELIMITER ;