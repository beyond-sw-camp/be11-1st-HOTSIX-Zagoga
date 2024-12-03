-- 위치 반경으로 숙소 검색하기

DELIMITER //

CREATE PROCEDURE 내근처숙소검색(
    IN 위도 DECIMAL(9,6),
    IN 경도 DECIMAL(9,6)
)
BEGIN
    SELECT 
        id,
        name,
        address,
        latitue,
        hardness
    FROM 
        accommodation
    WHERE 
        latitue >= ROUND(위도, 2) - 0.1 AND 
        latitue <= ROUND(위도, 2) + 0.1 AND 
        hardness >= ROUND(경도, 2) - 0.1 AND 
        hardness <= ROUND(경도, 2) + 0.1;
END //

DELIMITER ;
