-- 예약_객실
-- 쿠폰을 쓸수도, 안쓸 수도 있어서 여기 null 로 바꿔야함
ALTER TABLE detailed_reservation MODIFY coupon_id BIGINT NULL;

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

-- 