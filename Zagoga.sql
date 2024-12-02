CREATE TABLE user (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NULL,
	personal_id varchar(255) NOT NULL,
	phone_number varchar(255) NOT NULL,
	email varchar(255) NULL,
	sex enum('남', '여') NULL,	
	level enum('Bronze', 'Silver','Gold','Platinum','Vip') NULL DEFAULT 'Bronze',
	created_time datetime NULL DEFAULT current_timestamp(),
	delete_user boolean NULL DEFAULT 0
);

CREATE TABLE accommodation (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	owner_id bigint FOREIGN KEY NOT NULL REFERENCES owner('id'),
	name varchar(255) NOT NULL,
	type enum('hotel','motel','pension') NOT NULL,
	address varchar(255) NOT NULL,
	latitue decimal NOT NULL,
	hardness decimal NOT NULL,
	check_in_time varchar(255) NULL,
	check_out_time varchar(255) NULL,
	rent_time varchar(255) NULL,
	business_num varchar(255) NOT NULL,
	update_time datetime NULL DEFAULT current_timestamp(),
	delete_accommodation boolean NULL DEFAULT 0
);

CREATE TABLE reservation (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	user_id bigint FOREIGN KEY NOT NULL REFERENCES user('id')
);

CREATE TABLE owner (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NULL,
	personal_id varchar(255) NOT NULL,
	phone_number varchar(255) NOT NULL,
	account_number varchar(255) NOT NULL,
	created_time datetime NULL DEFAULT current_timestamp(),
	delete_owner boolean NULL DEFAULT 0
);

CREATE TABLE room (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	accommodation_id bigint FOREIGN KEY NOT NULL REFERENCES accommodation('id'),
	type varchar(255) NOT NULL,
	people_max int NOT NULL,
	off_peak_season_price int NOT NULL,
	peak_season_price int NOT NULL,
	rent_price int NULL,
	count int NULL
);

CREATE TABLE coupon_list (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	user_id bigint FOREIGN Key NOT NULL REFERENCES user('id'),
	coupon_id bigint FOREIGN KEY NOT NULL REFERENCES coupon('id'),
	created_time datetime NULL DEFAULT current_timestamp(),
	expire_time datetime NULL,
	usable boolean NULL DEFAULT 0
);

CREATE TABLE accommodation_facility (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	accommodation_id bigint FOREIGN KEY NOT NULL REFERENCES accodation('id'),
	able_bbq boolean NULL DEFAULT 0,
	able_parking boolean NULL DEFAULT 0,
	able_sports boolean NULL DEFAULT 0,
	able_sauna boolean NULL DEFAULT 0,
	able_front boolean NULL DEFAULT 0,
	able_breakfast boolean NULL DEFAULT 0,
	able_swim boolean	NULL DEFAULT 0
);

CREATE TABLE room_facility (
	id bigint	PRIMARY KEY NOT NULL auto_increment,
	room_id bigint FOREIGN KEY NOT NULL REFERENCES room('id'),
	bed_num int NULL DEFAULT 1,
	bed_type enum('Single','Double','Queen') NULL DEFAULT 'Single',
	has_bath boolean NULL DEFAULT 0,
	has_air_condition boolean	NULL DEFAULT 0,
	has_tv boolean NULL DEFAULT 0,
	has_internet boolean NULL DEFAULT 0,
	has_ott boolean NULL DEFAULT 0,
	has_amenity boolean NULL DEFAULT 0,
	has_animal boolean NULL DEFAULT 0
);

CREATE TABLE admin (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NULL,
	type enum('server_admin','customer_service','user') NULL,
	created_time datetime NULL DEFAULT current_timestamp()
);

CREATE TABLE cs_chat (
	Key bigint PRIMARY KEY NOT NULL auto_increment,
	owner_id bigint FOREIGN KEY NULL REFERENCES owner('id'),
	user_id bigint FOREIGN KEY NULL REFERENCES user('id'),
	admin_id bigint FOREIGN Key NULL REFERENCES admin('id'),
	contents varchar(3000) NULL,
	created_time' datetime NULL DEFAULT current_timestamp(),
	sender enum('user','owner', 'admin') NULL
);

CREATE TABLE payment (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	reservation_id bigint FOREIGN KEY NOT NULL,
	total_price int NOT NULL,
	payment_type varchar(255) NOT NULL,
	created_time datetime	NOT NULL DEFAULT current_timestamp()
);

CREATE TABLE favorite_list (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	user_id bigint FOREIGN Key NOT NULL REFERENCES user('id'),
	accodation_id bigint FOREIGN Key NOT NULL REFERENCES accodation('id')
);

CREATE TABLE coupon (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	name varchar(255) NOT NULL,
	discount varchar(255) NOT NULL,
	describe varchar(255) NULL,
	update_time datetime NULL DEFAULT current_timestamp()
);

CREATE TABLE detailed_reservation (
	id bigint PRIMARY KEY NOT NULL auto_increment,
	reservation_id bigint	FOREIGN Key NOT NULL REFERENCES reservation('id'),
	room_id bigint FOREIGN Key NOT NULL REFERENCES room('id'),
	coupon_id bigint FOREIGN KEY NOT NULL REFERENCES coupon('id'),
	check_in_day date NOT NULL,
	check_out_day date NOT NULL,
	num_people int NOT NULL,
	created_time datetime	NULL DEFAULT current_timestamp()
);

CREATE TABLE review (
	id bigint NOT NULL auto_increment,
	accommodation_id bigint FOREIGN Key NOT NULL REFERENCES accodation('id'),
	payment_id bigint FOREIGN KEY NOT NULL REFERENCES payment('id'),
	title varchar(255) NULL,
	content varchar(10000) NULL,
	star int NULL,
	photo datetime NULL DEFAULT current_timestamp()
);