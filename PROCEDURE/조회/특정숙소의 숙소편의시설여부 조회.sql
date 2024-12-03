-- 특정숙소의 편의시설여부 조회

DELIMITER //

CREATE PROCEDURE 특정숙소의 편의시설여부(IN accommodationId INT)
BEGIN
    SELECT 
		a.name,
        af.*
    FROM 
        accommodation a
    JOIN 
        accommodation_facility af ON a.id = af.accommodation_id
    WHERE 
        a.id = accommodationId;
END //

DELIMITER ;
