--쿠폰등록
DELIMITER $$

CREATE PROCEDURE 새쿠폰등록(
    IN 쿠폰이름 VARCHAR(255),         
    IN 할인금액 VARCHAR(255),         
    IN 할인내용 VARCHAR(255)       
)
BEGIN
    INSERT INTO coupon (name, discount, cp_describe, update_time)
    VALUES (쿠폰이름, 할인금액, 할인내용, CURRENT_TIMESTAMP());
    
    SELECT '쿠폰 등록이 완료되었습니다.' AS message;
END$$

DELIMITER ;



--쿠폰조회시 만료기간지났으면 사용불가처리
DELIMITER $$

CREATE PROCEDURE 쿠폰조회(IN 사용자id BIGINT)
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
        cl.user_id = 사용자id
    ORDER BY 
        cl.created_time DESC;  
END$$

DELIMITER ;

-- 쿠폰다운로드
DELIMITER $$

CREATE PROCEDURE 쿠폰다운로드(IN 사용자id BIGINT, IN 쿠폰id BIGINT)
BEGIN
    DECLARE coupon_exist INT;

    
    SELECT COUNT(*) INTO coupon_exist
    FROM coupon
    WHERE id = 쿠폰id;

    IF coupon_exist = 0 THEN
        
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The coupon does not exist.';
    ELSE
       
        IF EXISTS (SELECT 1 FROM coupon_list WHERE user_id = 사용자id AND coupon_id = 쿠폰id) THEN
          
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'You already own this coupon.';
        ELSE
           
            INSERT INTO coupon_list (user_id, coupon_id, created_time)
            VALUES (사용자id, 쿠폰id, CURRENT_TIMESTAMP);

            SELECT 'Coupon downloaded successfully.' AS message;
        END IF;
    END IF;
END$$

DELIMITER ;