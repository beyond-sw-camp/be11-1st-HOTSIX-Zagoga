-- 특정숙소 리뷰 전체조회

DELIMITER //
CREATE PROCEDURE 특정숙소_리뷰_전체조회(
    IN 숙소id INT
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
        r.accommodation_id = 숙소id
    ORDER BY 
        r.created_time DESC;
END //

DELIMITER ;