-- 인원수 및 선택한 도시 리뷰평점 순으로 정렬 조회

DELIMITER //

CREATE PROCEDURE 인원_도시선택_리뷰평점순_정렬조회(
    IN 인원수 INT,
    IN 도시명 VARCHAR(255)
)
BEGIN
    SELECT 
        a.id AS accommodation_id,
        a.name AS accommodation_name,
        a.address AS accommodation_address,
        AVG(rv.star) AS average_rating
    FROM 
        accommodation a
    JOIN 
        room r ON a.id = r.accommodation_id
    LEFT JOIN 
        review rv ON a.id = rv.accommodation_id
    GROUP BY 
        a.id, a.name, a.address
    HAVING 
        MAX(r.people_max) >= 인원수
        AND a.address LIKE CONCAT('%', 도시명, '%')
    ORDER BY 
        average_rating DESC;
END //

DELIMITER ;