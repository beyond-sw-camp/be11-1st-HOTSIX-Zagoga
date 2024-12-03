-- 특정숙소의 객실편의시설여부 조회

DELIMITER //

CREATE PROCEDURE 특정숙소_객실편의시설여부_조회(IN 숙소id INT)
BEGIN
    SELECT 
		a.name,
        rf.bed_type,
        rf.bed_num,
        rf.has_bath,
        rf.has_air_condition,
        rf.has_tv,
        rf.has_internet,
        rf.has_ott,
        rf.has_amenity,
        rf.has_animal
    FROM 
        accommodation a
    JOIN 
        room r ON a.id = r.accommodation_id
    JOIN 
        room_facility rf ON r.id = rf.room_id
    WHERE 
        a.id = 숙소id;
END //

DELIMITER ;

