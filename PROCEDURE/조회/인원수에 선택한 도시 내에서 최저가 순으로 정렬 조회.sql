-- 인원수 및 선택한 도시 최저가 순으로 정렬 조회

DELIMITER //

CREATE PROCEDURE 인원_도시선택_최저가순_정렬조회(
    IN 도시명 VARCHAR(255),
    IN 인원수 INT
)
BEGIN
    SELECT 
        a.id AS accommodation_id,
        a.name AS accommodation_name,
        r.type AS room_type,
        r.off_peak_season_price,
        r.people_max
    FROM 
        accommodation a
    JOIN 
        room r ON a.id = r.accommodation_id
    WHERE 
        a.address LIKE CONCAT('%', 도시명, '%') 
        AND r.people_max >= 인원수 
    ORDER BY 
        r.off_peak_season_price ASC;
END //

DELIMITER ;