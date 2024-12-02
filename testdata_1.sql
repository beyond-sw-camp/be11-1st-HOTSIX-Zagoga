-- user insert
INSERT INTO user (name, personal_id, phone_number, email, sex, level) VALUES
('홍길동', '123456-1234567', '010-1234-5678', 'hong@example.com', '남', 'Gold'),
('김영희', '234567-2345678', '010-2345-6789', 'kim@example.com', '여', 'Silver'),
('이철수', '345678-3456789', '010-3456-7890', 'lee@example.com', '남', 'Bronze'),
('박지민', '456789-4567890', '010-4567-8901', 'park@example.com', '여', 'Platinum'),
('최민수', '567890-5678901', '010-5678-9012', 'choi@example.com', '남', 'Vip'),
('정수연', '678901-6789012', '010-6789-0123', 'jeong@example.com', '여', 'Gold'),
('이상훈', '789012-7890123', '010-7890-1234', 'lee2@example.com', '남', 'Silver'),
('김하늘', '890123-8901234', '010-8901-2345', 'kim2@example.com', '여', 'Bronze'),
('오민재', '901234-9012345', '010-9012-3456', 'oh@example.com', '남', 'Gold'),
('한지민', '012345-0123456', '010-0123-4567', 'han@example.com', '여', 'Platinum');

-- owner insert
    insert into owner(id, name, personal_id, phone_number, account_number) values(1,'김봉삼','760507-226981','010-8765-0009','134501-329456');
    insert into owner(id, name, personal_id, phone_number, account_number) values(2,'황덕운','980103-229321','010-7775-1239','232323-733389');
    insert into owner(id, name, personal_id, phone_number, account_number) values(3,'이봉출','660108-126999','010-4443-6729','134501-329456');
    insert into owner(id, name, personal_id, phone_number, account_number) values(4,'김문덕','691207-226986','010-1234-6649','134501-329456');
    insert into owner(id, name, personal_id, phone_number, account_number) values(5,'최봉이','501098-213381','010-5556-8869','134501-329456');
    insert into owner(id, name, personal_id, phone_number, account_number) values(6,'이향림','700323-136923','010-6574-0329','134501-329456');
    insert into owner(id, name, personal_id, phone_number, account_number) values(7,'신명춘','550631-223481','010-9993-3456','134501-329456');
    insert into owner(id, name, personal_id, phone_number, account_number) values(8,'서명덕','861101-134687','010-4567-4511','134501-329456');
    insert into owner(id, name, personal_id, phone_number, account_number) values(9,'강신구','950818-424989','010-1918-5594','134501-329456');
    insert into owner(id, name, personal_id, phone_number, account_number) values(10,'지석삼','630404-226981','010-7766-1239','134501-329456');

-- admin insert
alter table admin modify column type enum('server_admin','custom_service');
insert into admin(name, type) values('서버 관리자1','server_admin'),
('서버 관리자2','server_admin'),
('서버 관리자3','server_admin'),
('상담원 John','custom_service'), 
('상담원 Harry','custom_service'),
('상담원 Lily','custom_service'),
('상담원 Adam','custom_service');

-- accomodation insert
insert into accommodation(owner_id, name, type, address, latitue, hardness, check_in_time, check_out_time, rent_time, business_num) 
values(1, "일", "hotel", "보라매로1", 1, 2, "오후3시", "오전11시", "4시간", "1234"),
(2, "이", "motel", "보라매로2", 2, 3, "오후2시", "오전11시", "4시간", "2345"),
(3, "삼", "pension", "보라매로3", 3, 4, "오후4시", "오전11시", "6시간", "3456"),
(4, "사", "hotel", "보라매로4", 4, 5, "오후5시", "오전11시", "5시간", "4567"),
(5, "오", "motel", "보라매로5", 5, 6, "오후3시", "오전11시", "3시간", "5678"),
(6, "육", "motel", "보라매로6", 6, 7, "오후3시", "오전11시", "4시간", "6789"),
(7, "칠", "hotel", "보라매로7", 7, 8, "오후4시", "오전11시", "3시간", "7890"),
(8, "팔", "hotel", "보라매로8", 8, 9, "오후3시", "오전11시", "4시간", "8901"),
(9, "구", "pension", "보라매로9", 9, 10, "오후2시", "오전11시", "4시간", "9012"),
(10, "십", "pension", "보라매로10", 10, 11, "오후3시", "오전11시", "3시간", "0123");

-- coupon insert
INSERT INTO coupon(name, discount, cp_describe) VALUES 
('생일축하쿠폰', '15%', '생일 기념 15% 할인'),
('첫 구매 쿠폰', '5%', '첫 구매 고객 5% 할인'),
('VIP 회원 쿠폰', '20%', 'VIP 회원 대상 20% 할인'),
('리뷰 작성 쿠폰', '3,000원', '리뷰 작성 감사 쿠폰 3,000원 할인'),
('주말 특가 쿠폰', '10%', '주말 한정 10% 할인'),
('무료배송 쿠폰', '100%', '전 제품 무료배송 혜택'),
('재구매 감사 쿠폰', '7%', '재구매 고객 대상 7% 할인'),
('한정 이벤트 쿠폰', '50%', '한정 이벤트 50% 할인 (특정 제품 대상)'),
('회원 추천 쿠폰', '5,000원', '추천 회원과 추천받은 회원에게 5,000원 할인'),
('앱 설치 쿠폰', '10%', '앱 설치 시 10% 할인');

-- coupon_list insert
INSERT INTO coupon_list(user_id, coupon_id, created_time, expire_time, usable) VALUES
(1, 1, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 1),
(2, 2, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 1),
(3, 4, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 1),
(4, 5, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 1),
(5, 6, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 1),
(6, 7, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 1),
(7, 8, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 1),
(8, 9, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 1),
(9, 10, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 1),
(10, 1, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), 1);

-- accommodation_facility 숙박편의시설
INSERT INTO accommodation_facility (accommodation_id, able_bbq, able_parking, able_sports, able_sauna, able_front, able_breakfast, able_swim) 
VALUES
(1, 1, 1, 0, 1, 0, 1, 1),
(2, 0, 1, 1, 0, 1, 0, 0),
(3, 1, 0, 1, 1, 1, 1, 0),
(4, 0, 0, 0, 1, 0, 1, 1),
(5, 1, 1, 1, 0, 1, 0, 1),
(6, 0, 1, 0, 1, 1, 1, 0),
(7, 1, 0, 1, 0, 0, 1, 1),
(8, 0, 1, 1, 1, 1, 0, 0),
(9, 1, 1, 0, 0, 1, 1, 1),
(10, 0, 0, 1, 1, 0, 0, 1);

-- insert room
insert into room(id, accommodation_id, type, people_max, off_peak_season_price, peak_season_price, rent_price, count) values(1,1,'트윈', 2, 50000,100000,0,5);
insert into room(id, accommodation_id, type, people_max, off_peak_season_price, peak_season_price, rent_price, count) values(2,2,'패밀리', 4, 80000,1500000,40000,3);
insert into room(id, accommodation_id, type, people_max, off_peak_season_price, peak_season_price, rent_price, count) values(3,2,'트윈', 2, 40000,100000,40000,10);
insert into room(id, accommodation_id, type, people_max, off_peak_season_price, peak_season_price, rent_price, count) values(4,3,'패밀리', 4, 100000,180000,0,4);
insert into room(id, accommodation_id, type, people_max, off_peak_season_price, peak_season_price, rent_price, count) values(5,4,'트윈', 2, 60000,100000,0,5);
insert into room(id, accommodation_id, type, people_max, off_peak_season_price, peak_season_price, rent_price, count) values(6,5,'트윈', 2, 80000,100000,30000,8);
insert into room(id, accommodation_id, type, people_max, off_peak_season_price, peak_season_price, rent_price, count) values(7,6,'트윈', 2, 45000,100000,50000,6);
insert into room(id, accommodation_id, type, people_max, off_peak_season_price, peak_season_price, rent_price, count) values(8,7,'트윈', 2, 100000,200000,0,8);
insert into room(id, accommodation_id, type, people_max, off_peak_season_price, peak_season_price, rent_price, count) values(9,8,'패밀리', 4, 150000,300000,0,2);
insert into room(id, accommodation_id, type, people_max, off_peak_season_price, peak_season_price, rent_price, count) values(10,9,'패밀리', 4, 100000,2000000,0,1);

-- favorite_list 즐겨찾기
INSERT INTO favorite_list (user_id, accommodation_id) VALUES
(1, 1),
(2, 2),
(1, 3),
(3, 4),
(2, 5),
(4, 6),
(1, 7),
(5, 8),
(3, 9),
(2, 10);

-- room_facility 객실 편의시설
INSERT INTO room_facility (room_id, bed_num, bed_type, has_bath, has_air_condition, has_tv, has_internet, has_ott, has_amenity, has_animal) VALUES
(1, 1, 'Single', 1, 1, 1, 1, 0, 1, 0),
(2, 2, 'Double', 0, 1, 0, 1, 1, 0, 1),
(3, 1, 'Queen', 1, 0, 1, 0, 0, 1, 0),
(4, 2, 'Single', 1, 1, 1, 1, 1, 1, 1),
(5, 3, 'Double', 0, 0, 0, 1, 0, 0, 0),
(6, 1, 'Queen', 1, 1, 1, 0, 1, 1, 1),
(7, 2, 'Single', 0, 1, 0, 1, 0, 1, 0),
(8, 3, 'Double', 1, 0, 1, 1, 1, 0, 1),
(9, 1, 'Queen', 0, 1, 1, 0, 0, 1, 0),
(10, 2, 'Single', 1, 1, 0, 1, 1, 1, 1);

-- reservation insert
insert into reservation(user_id) 
values(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

-- payment 결제
INSERT INTO payment (reservation_id, total_price, payment_type, created_time) VALUES
(1, 40000, '신용카드'),
(2, 50000, '현금'),
(3, 70000, '신용카드'),
(4, 66000, '신용카드'),
(5, 86000, '현금'),
(6, 44000, '신용카드'),
(7, 90000, '현금'),
(8, 67000, '신용카드'),
(9, 55000, '신용카드'),
(10, 87000, '현금')),
(11, 49000, '신용카드'),
(12, 60000, '현금'),
(13, 70000, '신용카드'),
(14, 87000, '신용카드'),
(15, 45000, '현금'),
(16, 65000, '신용카드'),
(17, 155000, '현금'),
(18, 75000, '신용카드'),
(19, 75000, '신용카드'),
(20, 85000, '현금');

-- admin insert 프로시저
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
CALL insert_owners();

-- accomodation insert 프로시저
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
CALL insert_accommodations();
