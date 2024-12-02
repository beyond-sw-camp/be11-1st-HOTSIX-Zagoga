--업주 회원가입 프로시저

DELIMITER //
CREATE PROCEDURE 업주회원가입(in p_name varchar(255), in p_personal_id varchar(255), in p_phone_number varchar(255), in p_account_number varchar(255))
BEGIN
  insert into owner (name, personal_id, phone_number, account_number) values(p_name, p_personal_id, p_phone_number,p_account_number);
    END ;
END//
DELIMITER ;


--숙박업소 등록 프로시저

DELIMITER //
CREATE PROCEDURE 업소등록
(in p_owner_id bigint, in p_name varchar(255), in p_type varchar(255)
, in p_address varchar(255), in p_latitue decimal, in p_hardness decimal,in p_business_num varchar(255))

BEGIN
  insert into accommodation (owner_id, name, type, address, latitue, hardness, business_num) values(p_owner_id, p_name, p_type,p_address, p_latitue, p_hardness, p_business_num);
END//
DELIMITER ;


--숙박편의시설 등록 프로시저

DELIMITER //
CREATE PROCEDURE 숙박편의시설등록
(in p_accommodation_id bigint, in p_able_bbp tinyint, in p_able_parking tinyint, in p_able_sports tinyint, in p_able_sauna tinyint,
in p_able_front tinyint, in p_able_breakfast tinyint, in p_able_swim tinyint)

BEGIN
  insert into accommodation_facility ( accommodation_id, able_bbp, able_parking, able_sport, able_sauna, able_front, able_breakfast, able_swim) 
  values(p_accommodation_id, p_able_bbp, p_able_parking, p_able_sports, p_able_sauna, p_able_front, p_able_breakfast, p_able_swim);
END//
DELIMITER ;

--객실 등록 프로시저

DELIMITER //
CREATE PROCEDURE 객실등록
(in p_accommodation_id bigint, in p_type varchar(255), in p_people_max int, 
in p_off_peak_season_price int, in p_peak_season_price int, in p_rent_price int, p_count int)

BEGIN
  insert into room(accommodation_id, type, people_max , 
off_peak_season_price , peak_season_price ,rent_price, count) 
  values(p_accommodation_id , p_type , p_people_max , 
off_peak_season_price,peak_season_price ,rent_price, count);
END//
DELIMITER ;

--객실별 편의시설 등록 프로시저

DELIMITER //
CREATE PROCEDURE 객실별편의시설등록
(in p_room_id bigint, in p_bed_num int, in p_bed_type varchar(255), 
in p_has_bath tinyint, in p_has_air_condition tinyint, in p_has_tv tinyint, p_has_internet tinyint
,in p_has_ott tinyint, in p_has_amenity tinyint, in p_has_animal tinyint)

BEGIN
  insert into room_facility(room_id, bed_num, bed_type, 
has_bath, has_air_condition, has_tv, has_internet,has_ott, has_amenity, has_animal) 
  values(p_room_id, p_bed_num, p_bed_type, 
p_has_bath , p_has_air_condition, p_has_tv , p_has_internet,p_has_ott, p_has_amenity, p_has_animal);
END //
DELIMITER ;

--내 업소 예약확인

DELIMITER //
CREATE PROCEDURE 내업소예약확인
(in p_id bigint)

BEGIN
 select o.name as 업주명, ac.name as 숙박업소명, r.id as 객실, dr.check_in_day as 체크인날짜, dr.check_out_day as 체크아웃날짜 from detailed_reservation dr inner join room r on dr.room_id = r.id inner join accommodation ac on r.accommodation_id = ac.id
inner join owner o on ac.owner_id = o.id where o.id = p_id;
END //
DELIMITER ;

--월별매출확인

DELIMITER //
CREATE PROCEDURE 월별매출확인
(in p_id bigint, in p_created_time varchar(20))

BEGIN
 select ac.id as 숙박업소id, ac.name as 숙박업소명,date_format(p.created_time,'%Y-%m') as 년도월,sum(p.total_price) as 매출액 from payment p inner join reservation res on p.reservation_id = res.id inner join detailed_reservation dr on res.id = dr.reservation_id
inner join room r on dr.room_id = r.id inner join accommodation ac on r.accommodation_id = ac.id where ac.id =p_id and date_format(p.created_time,'%Y-%m') = p_created_time group by ac.id ;
END //
DELIMITER ;


--기간별 매출확인

DELIMITER //
CREATE PROCEDURE 기간별매출확인
(in p_id bigint, in p_created_time varchar(20), in p_created_time2 varchar(20))

BEGIN
 declare start_date varchar(20);
 declare end_date varchar(20);
 
 set start_date = p_created_time;
 set end_date = p_created_time2;
 
 select ac.id as 숙박업소id, ac.name as 숙박업소명, start_date as 조회시작년도월, end_date as 조회마지막년도월 ,sum(p.total_price) as 매출액 from payment p inner join reservation res on p.reservation_id = res.id inner join detailed_reservation dr on res.id = dr.reservation_id
inner join room r on dr.room_id = r.id inner join accommodation ac on r.accommodation_id = ac.id where ac.id =p_id and date_format(p.created_time,'%Y-%m-%d') >=p_created_time and date_format(p.created_time,'%Y-%m-%d') <= p_created_time2  group by ac.id ;
END //
DELIMITER ;

--본인 숙소 리뷰확인

DELIMITER //
CREATE PROCEDURE 본인숙박업소리뷰조회
(in p_id bigint)

BEGIN
select ac.name as 숙박업소명, r.title as 제목, r.content as 내용, r.star as 별점, r.photo as 사진 from review r inner join accommodation ac on r.accommodation_id = ac.id 
inner join owner o on ac.owner_id = o.id where o.id =p_id;
END //
DELIMITER ;