-- user insert


-- owner insert

-- admin insert
alter table admin modify column type enum('sever_admin','custom_service');
insert into admin(name, type) values('서버 관리자1','server_admin');
insert into admin(name, type) values('서버 관리자2','server_admin');
insert into admin(name, type) values('서버 관리자3','server_admin');
insert into admin(name, type) values('상담원 John','server_admin');
insert into admin(name, type) values('서버 관리자1','server_admin');
