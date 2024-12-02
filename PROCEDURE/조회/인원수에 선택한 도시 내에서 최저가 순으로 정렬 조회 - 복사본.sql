-- 인원수 및 선택한 도시 최저가 순으로 정렬 조회

DELIMITER //

CREATE PROCEDURE 인원수 및 선택한 도시 최저가 순으로 정렬 조회(
    IN p_city VARCHAR(255),
    IN p_num_people INT
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
        a.address LIKE CONCAT('%', p_city, '%') 
        AND r.people_max >= p_num_people 
    ORDER BY 
        r.off_peak_season_price ASC;
END //

DELIMITER ;