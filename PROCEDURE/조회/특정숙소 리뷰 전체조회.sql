-- 특정숙소 리뷰 전체조회

DELIMITER //

DELIMITER //
CREATE PROCEDURE 특정숙소 리뷰 전체조회(
    IN accommodation_id INT
)
BEGIN
    SELECT 
        r.id AS review_id,
        r.accommodation_id,
        r.star,
        r.content,
        r.created_time
    FROM 
        review r
    WHERE 
        r.accommodation_id = accommodation_id
    ORDER BY 
        r.created_time DESC;
END //

DELIMITER ;