--회원가입 완료(쿠폰발급)
DELIMITER $$

CREATE PROCEDURE 회원가입(
    IN 사용자이름 VARCHAR(255),
    IN 주민번호 VARCHAR(255),
    IN 전화번호 VARCHAR(255),
    IN 이메일 VARCHAR(255),
    IN 성별 ENUM('남', '여')
)
BEGIN
    INSERT INTO user (name, personal_id, phone_number, email, sex, level, created_time, delete_user)
    VALUES (사용자이름, 주민번호, 전화번호, 이메일, 성별, 'Bronze', CURRENT_TIMESTAMP(), 0);
    
    SET @user_id = LAST_INSERT_ID();
    
    
    SET @coupon_id = 2; 
    
    INSERT INTO coupon_list (user_id, coupon_id, created_time, usable)
    VALUES (@user_id, @coupon_id, CURRENT_TIMESTAMP(), 1); 
    
    SELECT @user_id AS user_id, @coupon_id AS coupon_id;
    
END$$

DELIMITER ;


-- 리뷰작성(결제한 사람만)
DELIMITER $$

CREATE PROCEDURE 리뷰작성(
    IN 사용자id BIGINT,       
    IN 숙소id BIGINT,
    IN 결제id BIGINT, 
    IN 주제 VARCHAR(255),
    IN 내용 TEXT,               
    IN 별점 INT,                   
    IN 사진첨부 VARCHAR(255)            
)
BEGIN
    DECLARE payment_exists INT;
    
    SELECT COUNT(*) INTO payment_exists
    FROM payment p
    WHERE p.reservation_id IN (SELECT r.id FROM reservation r WHERE r.user_id = 사용자id)
    AND p.id = 결제id;
    
    IF payment_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '미결제 고객은 이용할 수 없습니다.';
    ELSE
        INSERT INTO review (accommodation_id, payment_id, title, content, star, photo, created_time)
        VALUES (숙소id, 결제id, 주제, 내용, 별점, 사진첨부, CURRENT_TIMESTAMP());
        
        SELECT '작성이 완료되었습니다!' AS message;
    END IF;
END$$

DELIMITER ;

--내리뷰확인
DELIMITER $$

CREATE PROCEDURE 내가쓴리뷰조회(IN 사용자id BIGINT)
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
                        (SELECT r.id FROM reservation r WHERE r.user_id = 사용자id))
    ORDER BY 
        r.created_time DESC;
    
END$$

DELIMITER ;

-- 유저정보조회
DELIMITER $$

CREATE PROCEDURE 유저정보조회(IN 사용자id BIGINT)
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
        id = 사용자id;
END$$

DELIMITER ;