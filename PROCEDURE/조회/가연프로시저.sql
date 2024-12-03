-- 예약_객실
-- 쿠폰을 쓸수도, 안쓸 수도 있어서 여기 null 로 바꿔야함
-- ALTER TABLE detailed_reservation MODIFY coupon_id BIGINT NULL;

DELIMITER //

CREATE PROCEDURE 예약_객실(
    IN 예약id BIGINT,
    IN 객실id BIGINT,
    IN 쿠폰id BIGINT,
    IN 체크인날짜 DATE,
    IN 체크아웃날짜 DATE,
    IN 인원수 INT
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
        예약id, 
        객실id, 
        쿠폰id, 
        체크인날짜, 
        체크아웃날짜, 
        인원수
    );
END//

CALL 예약_객실(1, 1, 1, '2024-12-04', '2024-12-05', 2);
CALL 예약_객실(2, 2, 2, '2024-12-05', '2024-12-07', 3);
CALL 예약_객실(3, 3, 3, '2024-12-06', '2024-12-09', 5);
CALL 예약_객실(4, 4, 4, '2024-12-07', '2024-12-08', 4);
CALL 예약_객실(5, 5, 5, '2024-12-08', '2024-12-10', 2);
CALL 예약_객실(6, 6, 6, '2024-12-09', '2024-12-16', 6);
CALL 예약_객실(7, 7, 7, '2024-12-10', '2024-12-12', 2);
CALL 예약_객실(8, 8, 8, '2024-12-11', '2024-12-18', 4);
CALL 예약_객실(9, 2, 9, '2024-12-15', '2024-12-16', 8);
CALL 예약_객실(10, 3, 10, '2024-12-15', '2024-12-18', 2);


-- 결제_비성수기 / 성수기/대실 SELECT SUM(r.peak_season_price) INTO total_price 로 바꿈
-- payment table 수정 사항 : reservation_id를 null 허용하도록 수정해야함.
-- 그래야 단체 예약을 할 때에 null 값으로 넣고 / 단일 예약일 때는 바로 참조 가능
-- 테이블 하나 추가 되었음 zagoga.sql 181줄
-- ALTER TABLE payment MODIFY reservation_id BIGINT NULL;

DELIMITER //

CREATE PROCEDURE 결제_단체(
    IN 사용자id BIGINT,          -- 사용자 ID
    IN 결제유형 VARCHAR(255) -- 결제 유형 (예: '신용카드', '현금')
)
BEGIN
    DECLARE total_price INT DEFAULT 0;  -- 총 금액 저장 변수
    DECLARE new_payment_id BIGINT;      -- 새로 생성된 payment ID 저장 변수
    DECLARE representative_reservation_id BIGINT; -- 대표 reservation_id 저장 변수

    -- 해당 user_id의 모든 예약에 대한 비성수기 가격 총합 계산
    SELECT SUM(r.off_peak_season_price) INTO total_price
    FROM detailed_reservation dr
    JOIN reservation res ON dr.reservation_id = res.id
    JOIN room r ON dr.room_id = r.id
    WHERE res.user_id = 사용자id;

    -- 대표 reservation_id를 가져옴 (첫 번째 reservation_id 사용)
    SELECT res.id INTO representative_reservation_id
    FROM reservation res
    WHERE res.user_id = 사용자id
    LIMIT 1;

    -- payment 테이블에 결제 정보 삽입
    INSERT INTO payment (reservation_id, total_price, payment_type)
    VALUES (
        representative_reservation_id,  -- 대표 reservation_id를 설정
        total_price,    -- 계산된 총 금액
        결제유형  -- 전달받은 결제 유형
    );

    -- 방금 생성된 payment ID 가져오기
    SET new_payment_id = LAST_INSERT_ID();

    -- payment_detailed_reservation 테이블에 관련 detailed_reservation ID 추가
    INSERT INTO payment_detailed_reservation (payment_id, detailed_reservation_id)
    SELECT new_payment_id, dr.id
    FROM detailed_reservation dr
    JOIN reservation res ON dr.reservation_id = res.id
    WHERE res.user_id = 사용자id;
END//

DELIMITER ;


---------------------------------------------------


-- 채팅_유저_오너
DELIMITER //

CREATE PROCEDURE 채팅_유저_오너 (
	IN 사업자id BIGINT,
	IN 유저id BIGINT,
	IN 메세지 VARCHAR(3000),
	IN 보내는사람 ENUM('user', 'owner')
)
BEGIN
	INSERT INTO cs_chat (owner_id, user_id, contents, sender)
	VALUES (사업자id, 유저id, 메세지, 보내는사람);
END//

DELIMITER ;

CALL 채팅_유저_오너(1, 2, '안녕하세요, 문의드립니다.', 'user');



-- 채팅_유저_상담원
DELIMITER //

CREATE PROCEDURE 채팅_유저_상담원 (
	IN 유저id BIGINT,
	IN 관리자id BIGINT,
	IN 메세지내용 VARCHAR(3000),
	IN 보내는사람 ENUM('user', 'admin')
)
BEGIN
	INSERT INTO cs_chat (user_id, admin_id, contents, sender)
	VALUES (유저id, 관리자id, 메세지내용, 보내는사람);
END//

DELIMITER ;
CALL 채팅_유저_상담원(2, 3, '상품 문의가 있어요.', 'user');

-- 채팅_오너_상담원
DELIMITER //

CREATE PROCEDURE 채팅_오너_상담원 (
	IN 사업자id BIGINT,
	IN 관리자id BIGINT,
	IN 메세지내용 VARCHAR(3000),
	IN 보내는사람 ENUM('owner', 'admin')
)
BEGIN
	INSERT INTO cs_chat (owner_id, admin_id, contents, sender)
	VALUES (사업자id, 관리자id, 메세지내용, 보내는사람);
END//

DELIMITER ;
CALL 채팅_오너_상담원(1, 3, '고객 요청 처리 부탁드립니다.', 'owner');

-- 채팅_내역_조회
DELIMITER //

CREATE PROCEDURE 채팅_내역_조회 (
	IN 보낸사람유형 ENUM('user', 'owner', 'admin'), 
	IN 보낸사람id BIGINT
)
BEGIN
	IF 보낸사람유형 = 'user' THEN
		SELECT * FROM cs_chat
		WHERE user_id = 보낸사람id AND sender = 'user';
	ELSEIF 보낸사람유형 = 'owner' THEN
		SELECT * FROM cs_chat
		WHERE owner_id = 보낸사람id AND sender = 'owner';
	ELSEIF 보낸사람유형 = 'admin' THEN
		SELECT * FROM cs_chat
		WHERE admin_id = 보낸사람id AND sender = 'admin';
	END IF;
END//

DELIMITER ;
CALL 채팅_내역_조회('user', 2);