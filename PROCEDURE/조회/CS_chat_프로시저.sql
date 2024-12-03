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