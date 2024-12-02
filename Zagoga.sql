CREATE TABLE `user` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`name`	varchar(255)	NULL,
	`personal_id`	varchar(255)	NOT NULL,
	`phone_number`	varchar(255)	NOT NULL,
	`email`	varchar(255)	NULL,
	`sex`	enum	NULL	DEFAULT '남', '여',
	`level`	enum	NULL	DEFAULT 'Bronze', 'Silver', 'Gold', 'Platinum', 'Vip',
	`created_time`	datetime	NULL	DEFAULT current_timestamp(),
	`delete_user`	boolean	NULL	DEFAULT 0
);

CREATE TABLE `accommodation` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`owner_id`	bigint	NOT NULL,
	`name`	varchar(255)	NOT NULL,
	`type`	enum	NOT NULL	COMMENT 'hotel/motel/pension',
	`address`	varchar(255)	NOT NULL	COMMENT '도로명주소',
	`latitue`	decimal	NOT NULL,
	`hardness`	decimal	NOT NULL,
	`check_in_time`	varchar(255)	NULL,
	`check_out_time`	varchar(255)	NULL,
	`rent_time`	varchar(255)	NULL,
	`business_num`	varchar(255)	NOT NULL,
	`update_time`	datetime	NULL	DEFAULT current_timestamp(),
	`delete_accommodation`	boolean	NULL	DEFAULT 0
);

CREATE TABLE `reservation` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`user_id`	bigint	NOT NULL
);

CREATE TABLE `owner` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`name`	varchar(255)	NULL,
	`personal_id`	varchar(255)	NOT NULL,
	`phone_number`	varchar(255)	NOT NULL,
	`account_number`	varchar(255)	NOT NULL,
	`created_time`	datetime	NULL	DEFAULT current_timestamp(),
	`delete_owner`	boolean	NULL	DEFAULT 0
);

CREATE TABLE `room` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`accommodation_id`	bigint	NOT NULL,
	`type`	varchar(255)	NOT NULL,
	`people_max`	int	NOT NULL,
	`off_peak_season_price`	int	NOT NULL,
	`peak_season_price`	int	NOT NULL,
	`rent_price`	int	NULL,
	`count`	int	NULL
);

CREATE TABLE `coupon_list` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`user_id`	bigint	NOT NULL,
	`coupon_type_id`	bigint	NOT NULL,
	`created_time`	datetime	NULL	DEFAULT current_timestamp(),
	`expire_time`	datetime	NULL,
	`usable`	boolean	NULL	DEFAULT 0
);

CREATE TABLE `accommodation_facility` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`accommodation_id`	bigint	NOT NULL,
	`able_bbq`	boolean	NULL	DEFAULT 0,
	`able_parking`	boolean	NULL	DEFAULT 0,
	`able_sports`	boolean	NULL	DEFAULT 0,
	`able_sauna`	boolean	NULL	DEFAULT 0,
	`able_front`	boolean	NULL	DEFAULT 0,
	`able_breakfast`	boolean	NULL	DEFAULT 0,
	`able_swim`	boolean	NULL	DEFAULT 0
);

CREATE TABLE `room_facility` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`room_id`	bigint	NOT NULL,
	`bed_num`	int	NULL	DEFAULT 1,
	`bed_type`	enum	NULL	DEFAULT 'Single', 'Double', 'Queen'	COMMENT '침대사이즈',
	`has_bath`	boolean	NULL	DEFAULT 0,
	`has_air_condition`	boolean	NULL	DEFAULT 0,
	`has_tv`	boolean	NULL	DEFAULT 0,
	`has_internet`	boolean	NULL	DEFAULT 0,
	`has_ott`	boolean	NULL	DEFAULT 0,
	`has_amenity`	boolean	NULL	DEFAULT 0,
	`has_animal`	boolean	NULL	DEFAULT 0
);

CREATE TABLE `admin` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`name`	varchar(255)	NULL,
	`type`	enum	NULL	DEFAULT 'server_admin', ' customer_service'	COMMENT '서버관리자/상담원',
	`created_time`	datetime	NULL	DEFAULT current_timestamp()
);

CREATE TABLE `cs_chat` (
	`Key`	bigint	NOT NULL	DEFAULT auto_increment,
	`owner_id`	bigint	NULL,
	`user_id`	bigint	NULL,
	`admin_id`	bigint	NULL,
	`contents`	varchar(3000)	NULL,
	`created_time`	datetime	NULL	DEFAULT current_timestamp(),
	`sender`	enum	NULL	DEFAULT 'user', 'owner', 'admin'
);

CREATE TABLE `payment` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`reservation_id`	bigint	NOT NULL,
	`total_price`	int	NOT NULL,
	`payment_type`	varchar(255)	NOT NULL,
	`created_time`	datetime	NOT NULL	DEFAULT current_timestamp()
);

CREATE TABLE `favorite_list` (
	`id`	bigint	NOT NULL,
	`user_id`	bigint	NOT NULL,
	`accodation_id`	bigint	NOT NULL
);

CREATE TABLE `coupon` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`name`	varchar(255)	NOT NULL,
	`discount`	varchar(255)	NOT NULL,
	`describe`	varchar(255)	NULL,
	`update_time`	datetime	NULL	DEFAULT current_timestamp()
);

CREATE TABLE `detailed_reservation` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`reservation_id`	bigint	NOT NULL,
	`room_id`	bigint	NOT NULL,
	`coupon_id`	bigint	NOT NULL,
	`check_in_day`	date	NOT NULL,
	`check_out_day`	date	NOT NULL,
	`num_people`	int	NOT NULL,
	`created_time`	datetime	NULL	DEFAULT current_timestamp()
);

CREATE TABLE `review` (
	`id`	bigint	NOT NULL	DEFAULT auto_increment,
	`accommodation_id`	bigint	NOT NULL,
	`payment_id`	bigint	NOT NULL,
	`title`	varchar(255)	NULL,
	`content`	varchar(10000)	NULL,
	`star`	int	NULL	COMMENT '1-5',
	`photo`	datetime	NULL	DEFAULT current_timestamp()	COMMENT '방사진 경로'
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`id`
);

ALTER TABLE `accommodation` ADD CONSTRAINT `PK_ACCOMMODATION` PRIMARY KEY (
	`id`,
	`owner_id`
);

ALTER TABLE `reservation` ADD CONSTRAINT `PK_RESERVATION` PRIMARY KEY (
	`id`,
	`user_id`
);

ALTER TABLE `owner` ADD CONSTRAINT `PK_OWNER` PRIMARY KEY (
	`id`
);

ALTER TABLE `room` ADD CONSTRAINT `PK_ROOM` PRIMARY KEY (
	`id`,
	`accommodation_id`
);

ALTER TABLE `coupon_list` ADD CONSTRAINT `PK_COUPON_LIST` PRIMARY KEY (
	`id`,
	`user_id`,
	`coupon_type_id`
);

ALTER TABLE `accommodation_facility` ADD CONSTRAINT `PK_ACCOMMODATION_FACILITY` PRIMARY KEY (
	`id`,
	`accommodation_id`
);

ALTER TABLE `room_facility` ADD CONSTRAINT `PK_ROOM_FACILITY` PRIMARY KEY (
	`id`,
	`room_id`
);

ALTER TABLE `admin` ADD CONSTRAINT `PK_ADMIN` PRIMARY KEY (
	`id`
);

ALTER TABLE `cs_chat` ADD CONSTRAINT `PK_CS_CHAT` PRIMARY KEY (
	`Key`,
	`owner_id`,
	`user_id`,
	`admin_id`
);

ALTER TABLE `payment` ADD CONSTRAINT `PK_PAYMENT` PRIMARY KEY (
	`id`,
	`reservation_id`
);

ALTER TABLE `favorite_list` ADD CONSTRAINT `PK_FAVORITE_LIST` PRIMARY KEY (
	`id`,
	`user_id`,
	`accodation_id`
);

ALTER TABLE `coupon` ADD CONSTRAINT `PK_COUPON` PRIMARY KEY (
	`id`
);

ALTER TABLE `detailed_reservation` ADD CONSTRAINT `PK_DETAILED_RESERVATION` PRIMARY KEY (
	`id`,
	`reservation_id`,
	`room_id`,
	`coupon_id`
);

ALTER TABLE `review` ADD CONSTRAINT `PK_REVIEW` PRIMARY KEY (
	`id`,
	`accommodation_id`,
	`payment_id`
);

ALTER TABLE `accommodation` ADD CONSTRAINT `FK_owner_TO_accommodation_1` FOREIGN KEY (
	`owner_id`
)
REFERENCES `owner` (
	`id`
);

ALTER TABLE `reservation` ADD CONSTRAINT `FK_user_TO_reservation_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `room` ADD CONSTRAINT `FK_accommodation_TO_room_1` FOREIGN KEY (
	`accommodation_id`
)
REFERENCES `accommodation` (
	`id`
);

ALTER TABLE `coupon_list` ADD CONSTRAINT `FK_user_TO_coupon_list_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `coupon_list` ADD CONSTRAINT `FK_coupon_TO_coupon_list_1` FOREIGN KEY (
	`coupon_type_id`
)
REFERENCES `coupon` (
	`id`
);

ALTER TABLE `accommodation_facility` ADD CONSTRAINT `FK_accommodation_TO_accommodation_facility_1` FOREIGN KEY (
	`accommodation_id`
)
REFERENCES `accommodation` (
	`id`
);

ALTER TABLE `room_facility` ADD CONSTRAINT `FK_room_TO_room_facility_1` FOREIGN KEY (
	`room_id`
)
REFERENCES `room` (
	`id`
);

ALTER TABLE `cs_chat` ADD CONSTRAINT `FK_owner_TO_cs_chat_1` FOREIGN KEY (
	`owner_id`
)
REFERENCES `owner` (
	`id`
);

ALTER TABLE `cs_chat` ADD CONSTRAINT `FK_user_TO_cs_chat_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `cs_chat` ADD CONSTRAINT `FK_admin_TO_cs_chat_1` FOREIGN KEY (
	`admin_id`
)
REFERENCES `admin` (
	`id`
);

ALTER TABLE `payment` ADD CONSTRAINT `FK_reservation_TO_payment_1` FOREIGN KEY (
	`reservation_id`
)
REFERENCES `reservation` (
	`id`
);

ALTER TABLE `favorite_list` ADD CONSTRAINT `FK_user_TO_favorite_list_1` FOREIGN KEY (
	`user_id`
)
REFERENCES `user` (
	`id`
);

ALTER TABLE `favorite_list` ADD CONSTRAINT `FK_accommodation_TO_favorite_list_1` FOREIGN KEY (
	`accodation_id`
)
REFERENCES `accommodation` (
	`id`
);

ALTER TABLE `detailed_reservation` ADD CONSTRAINT `FK_reservation_TO_detailed_reservation_1` FOREIGN KEY (
	`reservation_id`
)
REFERENCES `reservation` (
	`id`
);

ALTER TABLE `detailed_reservation` ADD CONSTRAINT `FK_room_TO_detailed_reservation_1` FOREIGN KEY (
	`room_id`
)
REFERENCES `room` (
	`id`
);

ALTER TABLE `detailed_reservation` ADD CONSTRAINT `FK_coupon_list_TO_detailed_reservation_1` FOREIGN KEY (
	`coupon_id`
)
REFERENCES `coupon_list` (
	`id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_accommodation_TO_review_1` FOREIGN KEY (
	`accommodation_id`
)
REFERENCES `accommodation` (
	`id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_payment_TO_review_1` FOREIGN KEY (
	`payment_id`
)
REFERENCES `payment` (
	`id`
);