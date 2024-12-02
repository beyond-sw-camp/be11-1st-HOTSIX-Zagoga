-- user insert
INSERT INTO user (name, personal_id, phone_number, email, sex, level) VALUES
('홍길동', '123456-1234567', '010-1234-5678', 'hong@example.com', '남', 'Gold'),
('김영희', '234567-2345678', '010-2345-6789', 'kim@example.com', '여', 'Silver'),
('이철수', '345678-3456789', '010-3456-7890', 'lee@example.com', '남', 'Bronze'),
('박지민', '456789-4567890', '010-4567-8901', 'park@example.com', '여', 'Platinum'),
('최민수', '567890-5678901', '010-5678-9012', 'choi@example.com', '남', 'Vip'),
('정수연', '678901-6789012', '010-6789-0123', 'jeong@example.com', '여', 'Gold'),
('이상훈', '789012-7890123', '010-7890-1234', 'lee2@example.com', '남', 'Silver'),
('김하늘', '890123-8901234', '010-8901-2345', 'kim2@example.com', '여', 'Bronze'),
('오민재', '901234-9012345', '010-9012-3456', 'oh@example.com', '남', 'Gold'),
('한지민', '012345-0123456', '010-0123-4567', 'han@example.com', '여', 'Platinum');

-- owner insert
insert into owner(id, name, personal_id, phone_number, account_number) values(1,'김봉삼','760507-226981','010-8765-0009','134501-329456');
insert into owner(id, name, personal_id, phone_number, account_number) values(2,'황덕운','980103-229321','010-7775-1239','232323-733389');
insert into owner(id, name, personal_id, phone_number, account_number) values(3,'이봉출','660108-126999','010-4443-6729','134501-329456');
insert into owner(id, name, personal_id, phone_number, account_number) values(4,'김문덕','691207-226986','010-1234-6649','134501-329456');
insert into owner(id, name, personal_id, phone_number, account_number) values(5,'최봉이','501098-213381','010-5556-8869','134501-329456');
insert into owner(id, name, personal_id, phone_number, account_number) values(6,'이향림','700323-136923','010-6574-0329','134501-329456');
insert into owner(id, name, personal_id, phone_number, account_number) values(7,'신명춘','550631-223481','010-9993-3456','134501-329456');
insert into owner(id, name, personal_id, phone_number, account_number) values(8,'서명덕','861101-134687','010-4567-4511','134501-329456');
insert into owner(id, name, personal_id, phone_number, account_number) values(9,'강신구','950818-424989','010-1918-5594','134501-329456');
insert into owner(id, name, personal_id, phone_number, account_number) values(10,'지석삼','630404-226981','010-7766-1239','134501-329456');
-- admin insert
alter table admin modify column type enum('sever_admin','custom_service');
insert into admin(name, type) values('서버 관리자1','server_admin');
insert into admin(name, type) values('서버 관리자2','server_admin');
insert into admin(name, type) values('서버 관리자3','server_admin');
insert into admin(name, type) values('상담원 John','server_admin');
insert into admin(name, type) values('서버 관리자1','server_admin');
