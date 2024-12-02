-- 인원수에 선택한 도시 내에서 리뷰많은 순으로 정렬 조회

DELIMITER //

CREATE PROCEDURE 인원수에 선택한 도시 내에서 리뷰많은 순으로 정렬 조회(
    IN max_capacity INT,
    IN address_keyword VARCHAR(255)
)
BEGIN
    SELECT 
        a.id AS accommodation_id,
        a.name AS accommodation_name,
        a.address AS accommodation_address,
        MAX(r.people_max) AS max_capacity,
        COUNT(rv.id) AS review_count
    FROM 
        accommodation a
    JOIN 
        room r ON a.id = r.accommodation_id
    LEFT JOIN 
        review rv ON a.id = rv.accommodation_id
    GROUP BY 
        a.id, a.name, a.address
    HAVING 
        MAX(r.people_max) >= max_capacity
        AND a.address LIKE CONCAT('%', address_keyword, '%')
    ORDER BY 
        review_count DESC;
END //

DELIMITER ;