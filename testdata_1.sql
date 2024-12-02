-- user insert
INSERT INTO user (name, personal_id, phone_number, email, sex, level, created_time, delete_user) VALUES
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

-- accomodation insert
insert into accommodation(owner_id, name, type, address, latitue, hardness, check_in_time, check_out_time, rent_time, business_num) 
values(1, '일', 'hotel', '보라매로1', 1, 2, '15:00', '11:00', '4시간', '1234'),
(2, '이', 'motel', '보라매로2', 2, 3, '14:00', '11:00', '5시간', "2345"),
(3, '삼', 'pension', '보라매로3', 3, 4, '16:00', '11:00', '6시간', '3456'),
(4, '사', 'hotel', '보라매로4', 4, 5, '17:00', '11:00', '5시간', '4567'),
(5, '오', 'motel', '보라매로5', 5, 6, '15:00', '11:00', '3시간', '5678'),
(6, '육', 'motel', '보라매로6', 6, 7, '15:00', '11:00', '4시간', '6789'),
(7, '칠', 'hotel', '보라매로7', 7, 8, '16:00', '11:00', '3시간', '7890'),
(8, '팔', 'hotel', '보라매로8', 8, 9, '15:00', '11:00', '4시간', '8901'),
(9, '구', 'pension', '보라매로9', 9, 10, '14:00', '11:00', '4시간', '9012'),
(10, '십', 'pension', '보라매로10', 10, 11, '15:00', '11:00', '3시간', '0123');

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

-- accommodation_facility 숙박편의시설
INSERT INTO accommodation_facility (accommodation_id, able_bbq, able_parking, able_sports, able_sauna, able_front, able_breakfast, able_swim) VALUES
(1, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, TRUE),
(2, FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, FALSE),
(3, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE),
(4, FALSE, FALSE, FALSE, TRUE, FALSE, TRUE, TRUE),
(5, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE),
(6, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE),
(7, TRUE, FALSE, TRUE, FALSE, FALSE, TRUE, TRUE),
(8, FALSE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE),
(9, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, TRUE),
(10, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE);


-- coupon insert
insert into 