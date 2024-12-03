CREATE TABLE user (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NULL,
	personal_id varchar(255) NOT NULL,
	phone_number varchar(255) NOT NULL,
	email varchar(255) NULL,
	sex enum('남', '여') NULL,	
	level enum('Bronze', 'Silver','Gold','Platinum','Vip') NULL DEFAULT 'Bronze',
	created_time datetime NULL DEFAULT current_timestamp(),
	delete_user tinyint NULL DEFAULT 0
);

CREATE TABLE owner (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NULL,
	personal_id varchar(255) NOT NULL,
	phone_number varchar(255) NOT NULL,
	account_number varchar(255) NOT NULL,
	created_time datetime NULL DEFAULT current_timestamp(),
	delete_owner tinyint NULL DEFAULT 0
);

CREATE TABLE admin (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NULL,
	type enum('server_admin','customer_service') NULL,
	created_time datetime NULL DEFAULT current_timestamp()
);

CREATE TABLE cs_chat (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	owner_id bigint NULL,
	user_id bigint NULL,
	admin_id bigint NULL,
	contents varchar(3000) NULL,
	created_time datetime NULL DEFAULT current_timestamp(),
	sender enum('user','owner', 'admin') NULL,

	FOREIGN KEY(owner_id) REFERENCES owner(id),
	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(admin_id) REFERENCES admin(id)
);

CREATE TABLE coupon (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NOT NULL,
	discount varchar(255) NOT NULL,
	cp_describe varchar(255) NULL,
	update_time datetime NULL DEFAULT current_timestamp()
);

CREATE TABLE accommodation (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	owner_id bigint NOT NULL,
	name varchar(255) NOT NULL,
	type enum('hotel','motel','pension') NOT NULL,
	address varchar(255) NOT NULL,
	latitue decimal(9,6) NOT NULL,
	hardness decimal(9,6) NOT NULL,
	check_in_time varchar(255) NULL,
	check_out_time varchar(255) NULL,
	rent_time varchar(255) NULL,
	business_num varchar(255) NOT NULL,
	update_time datetime NULL DEFAULT current_timestamp(),
	delete_accommodation tinyint NULL DEFAULT 0,

	FOREIGN KEY(owner_id) REFERENCES owner(id)
);

CREATE TABLE room (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	accommodation_id bigint NOT NULL,
	type varchar(255) NOT NULL,
	people_max int NOT NULL,
	off_peak_season_price int NOT NULL,
	peak_season_price int NOT NULL,
	rent_price int NULL,
	count int NULL,

	FOREIGN KEY(accommodation_id) REFERENCES accommodation(id)
);

CREATE TABLE room_facility (
	id bigint	PRIMARY KEY NOT NULL auto_increment,
	room_id bigint NOT NULL,
	bed_num int NULL DEFAULT 1,
	bed_type enum('Single','Double','Queen') NULL DEFAULT 'Single',
	has_bath tinyint NULL DEFAULT 0,
	has_air_condition tinyint	NULL DEFAULT 0,
	has_tv tinyint NULL DEFAULT 0,
	has_internet tinyint NULL DEFAULT 0,
	has_ott tinyint NULL DEFAULT 0,
	has_amenity tinyint NULL DEFAULT 0,
	has_animal tinyint NULL DEFAULT 0,

	FOREIGN KEY(room_id) REFERENCES room(id)
);

CREATE TABLE reservation (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	user_id bigint NOT NULL,
	
	FOREIGN KEY(user_id) REFERENCES user(id)
);


CREATE TABLE coupon_list (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	user_id bigint NOT NULL,
	coupon_id bigint NOT NULL,
	created_time datetime NULL DEFAULT current_timestamp(),
	expire_time datetime NULL,
	usable tinyint NULL DEFAULT 0,

	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(coupon_id) REFERENCES coupon(id)
);

CREATE TABLE accommodation_facility (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	accommodation_id bigint NOT NULL,
	able_bbq tinyint NULL DEFAULT 0,
	able_parking tinyint NULL DEFAULT 0,
	able_sports tinyint NULL DEFAULT 0,
	able_sauna tinyint NULL DEFAULT 0,
	able_front tinyint NULL DEFAULT 0,
	able_breakfast tinyint NULL DEFAULT 0,
	able_swim tinyint	NULL DEFAULT 0,

	FOREIGN KEY(accommodation_id) REFERENCES accommodation(id)
);

CREATE TABLE payment (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	reservation_id bigint NULL,
	total_price int NOT NULL,
	payment_type varchar(255) NOT NULL,
	created_time datetime NOT NULL DEFAULT current_timestamp(),

	FOREIGN KEY(reservation_id) REFERENCES reservation(id)
);

CREATE TABLE favorite_list (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	user_id bigint NOT NULL,
	accommodation_id bigint NOT NULL,

	FOREIGN KEY(user_id) REFERENCES user(id),
	FOREIGN KEY(accommodation_id) REFERENCES accommodation(id)
);

CREATE TABLE detailed_reservation (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	reservation_id bigint NOT NULL,
	room_id bigint NOT NULL,
	coupon_id bigint NULL,
	check_in_day date NOT NULL,
	check_out_day date NOT NULL,
	num_people int NOT NULL,
	created_time datetime	NULL DEFAULT current_timestamp(),

	FOREIGN KEY(reservation_id) REFERENCES reservation(id),
	FOREIGN KEY(room_id) REFERENCES room(id),
	FOREIGN KEY(coupon_id) REFERENCES coupon(id)
);

CREATE TABLE review (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	accommodation_id bigint NOT NULL,
	payment_id bigint NOT NULL,
	title varchar(255) NULL,
	content varchar(10000) NULL,
	star int NULL,
	photo varchar(255) NULL,
	created_time datetime NULL DEFAULT current_timestamp(),

	FOREIGN KEY(accommodation_id) REFERENCES accommodation(id),
	FOREIGN KEY(payment_id) REFERENCES payment(id)
);

-- 다대다 관계 풀어내느라 새로 추가된 table
CREATE TABLE payment_detailed_reservation (
    payment_id BIGINT NOT NULL,
    detailed_reservation_id BIGINT NOT NULL,
    PRIMARY KEY (payment_id, detailed_reservation_id),
    FOREIGN KEY (payment_id) REFERENCES payment(id),
    FOREIGN KEY (detailed_reservation_id) REFERENCES detailed_reservation(id)
);