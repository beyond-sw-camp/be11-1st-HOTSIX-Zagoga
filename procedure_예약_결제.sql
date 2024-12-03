-- 예약_객실
-- 쿠폰을 쓸수도, 안쓸 수도 있어서 여기 null 로 바꿔야함
-- ALTER TABLE detailed_reservation MODIFY coupon_id BIGINT NULL;

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

CALL 예약_객실(1, 1, 1, '2024-12-04', '2024-12-05', 2);
CALL 예약_객실(2, 2, 2, '2024-12-05', '2024-12-07', 3);
CALL 예약_객실(3, 3, 3, '2024-12-06', '2024-12-09', 5);
CALL 예약_객실(4, 4, 4, '2024-12-07', '2024-12-08', 4);
CALL 예약_객실(5, 5, 5, '2024-12-08', '2024-12-10', 2);
CALL 예약_객실(6, 6, 6, '2024-12-09', '2024-12-16', 6);
CALL 예약_객실(7, 7, 7, '2024-12-10', '2024-12-12', 2);
CALL 예약_객실(8, 8, 8, '2024-12-11', '2024-12-18', 4);
CALL 예약_객실(9, 2, 9, '2024-12-15', '2024-12-16', 8);
CALL 예약_객실(10, 3, 10, '2024-12-15', '2024-12-18', 2);


DELIMITER ;

-- 결제_비성수기 / 성수기/대실 SELECT SUM(r.peak_season_price) INTO total_price 로 바꿈
-- payment table 수정 사항 : reservation_id를 null 허용하도록 수정해야함.
-- 그래야 단체 예약을 할 때에 null 값으로 넣고 / 단일 예약일 때는 바로 참조 가능
-- 테이블 하나 추가 되었음 zagoga.sql 181줄
-- ALTER TABLE payment MODIFY reservation_id BIGINT NULL;

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
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE 결제_성수기(
    IN p_user_id BIGINT,          -- 사용자 ID
    IN p_payment_type VARCHAR(255) -- 결제 유형 (예: '신용카드', '현금')
)
BEGIN
    DECLARE total_price INT DEFAULT 0;  -- 총 금액 저장 변수
    DECLARE new_payment_id BIGINT;      -- 새로 생성된 payment ID 저장 변수
    DECLARE representative_reservation_id BIGINT; -- 대표 reservation_id 저장 변수

    -- 해당 user_id의 모든 예약에 대한 성수기 가격 총합 계산
    SELECT SUM(r.peak_season_price) INTO total_price
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
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE 결제_대실(
    IN p_user_id BIGINT,          -- 사용자 ID
    IN p_payment_type VARCHAR(255) -- 결제 유형 (예: '신용카드', '현금')
)
BEGIN
    DECLARE total_price INT DEFAULT 0;  -- 총 금액 저장 변수
    DECLARE new_payment_id BIGINT;      -- 새로 생성된 payment ID 저장 변수
    DECLARE representative_reservation_id BIGINT; -- 대표 reservation_id 저장 변수

    -- 해당 user_id의 모든 예약에 대한 비성수기 가격 총합 계산
    SELECT SUM(r.rent_price) INTO total_price
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
END$$

DELIMITER ;

CALL 결제_비성수기(1, '신용카드');
CALL 결제_성수기(2,'현금');
CALL 결제_대실(3,'신용카드');
CALL 결제_성수기(4,'신용카드');
CALL 결제_대실(5, '현금');
CALL 결제_비성수기(6,'신용카드');
CALL 결제_비성수기(7, '현금');
CALL 결제_성수기(8,'신용카드');
CALL 결제_비성수기(9, '신용카드');
CALL 결제_성수기(10,'현금');

--회원가입 완료(쿠폰발급)**
DELIMITER $$

CREATE PROCEDURE 회원가입(
    IN p_name VARCHAR(255),
    IN p_personal_id VARCHAR(255),
    IN p_phone_number VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_sex ENUM('남', '여')
)
BEGIN
    INSERT INTO user (name, personal_id, phone_number, email, sex, level, created_time, delete_user)
    VALUES (p_name, p_personal_id, p_phone_number, p_email, p_sex, 'Bronze', CURRENT_TIMESTAMP(), 0);
    
    SET @user_id = LAST_INSERT_ID();
    
    
    SET @coupon_id = 2; 
    
    INSERT INTO coupon_list (user_id, coupon_id, created_time, usable)
    VALUES (@user_id, @coupon_id, CURRENT_TIMESTAMP(), 1); 
    
    SELECT @user_id AS user_id, @coupon_id AS coupon_id;
    
END$$

DELIMITER ;


-- 리뷰작성(결제한 사람만)**
DELIMITER $$

CREATE PROCEDURE 리뷰작성(
    IN p_user_id BIGINT,       
    IN p_accommodation_id BIGINT,
    IN p_payment_id BIGINT, 
    IN p_title VARCHAR(255),
    IN p_content TEXT,               
    IN p_star INT,                   
    IN p_photo VARCHAR(255)            
)
BEGIN
    DECLARE payment_exists INT;
    
    SELECT COUNT(*) INTO payment_exists
    FROM payment p
    WHERE p.reservation_id IN (SELECT r.id FROM reservation r WHERE r.user_id = p_user_id)
    AND p.id = p_payment_id;
    
    IF payment_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '미결제 고객은 이용할 수 없습니다.';
    ELSE
        INSERT INTO review (accommodation_id, payment_id, title, content, star, photo, created_time)
        VALUES (p_accommodation_id, p_payment_id, p_title, p_content, p_star, p_photo, CURRENT_TIMESTAMP());
        
        SELECT '작성이 완료되었습니다!' AS message;
    END IF;
END$$

DELIMITER ;

--내리뷰확인
DELIMITER $$

CREATE PROCEDURE 내가쓴리뷰조회(IN p_user_id BIGINT)
BEGIN
    SELECT 
        r.id AS review_id,
        a.name AS accommodation_name,
        a.type AS accommodation_type,
        r.title AS review_title,
        r.content AS review_content,
        r.star AS review_star,
        r.photo AS review_photo,
        r.created_time AS review_created_time
    FROM 
        review r
    JOIN 
        accommodation a ON r.accommodation_id = a.id
    WHERE 
        r.payment_id IN (SELECT p.id FROM payment p WHERE p.reservation_id IN 
                        (SELECT r.id FROM reservation r WHERE r.user_id = p_user_id))
    ORDER BY 
        r.created_time DESC;
    
END$$

DELIMITER ;

-- 유저정보조회
DELIMITER $$

CREATE PROCEDURE 유저정보조회(IN p_user_id BIGINT)
BEGIN
    SELECT 
        id AS user_id,
        name,
        personal_id,
        phone_number,
        email,
        sex,
        level,
        created_time,
        delete_user
    FROM 
        user
    WHERE 
        id = p_user_id;
END$$

DELIMITER ;


--쿠폰등록
DELIMITER $$

CREATE PROCEDURE 새쿠폰등록(
    IN p_name VARCHAR(255),         
    IN p_discount VARCHAR(255),         
    IN p_cp_describe VARCHAR(255)       
)
BEGIN
    INSERT INTO coupon (name, discount, cp_describe, update_time)
    VALUES (p_name, p_discount, p_cp_describe, CURRENT_TIMESTAMP());
    
    SELECT '쿠폰 등록이 완료되었습니다.' AS message;
END$$

DELIMITER ;



--쿠폰조회시 만료기간지났으면 사용불가처리
DELIMITER $$

CREATE PROCEDURE 쿠폰조회2(IN p_user_id BIGINT)
BEGIN
    SELECT 
        u.name AS user_name,           
        c.id AS coupon_id,          
        c.name AS coupon_name,      
        c.discount AS coupon_discount, 
        c.cp_describe AS coupon_description, 
        cl.created_time AS coupon_created_time, 
        cl.expire_time AS coupon_expire_time,  
        CASE
            WHEN cl.expire_time < CURRENT_TIMESTAMP THEN '사용불가' 
            ELSE DATE_FORMAT(cl.expire_time, '%Y-%m-%d')  
        END AS coupon_status
    FROM 
        coupon_list cl
    JOIN 
        coupon c ON cl.coupon_id = c.id
    JOIN 
        user u ON cl.user_id = u.id
    WHERE 
        cl.user_id = p_user_id
    ORDER BY 
        cl.created_time DESC;  
END$$

DELIMITER ;