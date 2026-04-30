CREATE DATABASE hotelljusinskaja;
use hotelljusinskaja;

-- 1 - guest
CREATE TABLE guest(
id int primary key identity(1,1),
first_name varchar(80),
last_name varchar(80),
member_since date
);

SELECT * FROM guest;

INSERT INTO guest
VALUES ('irina', 'merkulova', '2026-05-05');


-- 2 - reservation
CREATE TABLE reservation(
id int primary key identity(1,1),
date_in date,
date_out date,
made_by varchar(80),
guest_id int,
foreign key (guest_id) references guest(id)
);

INSERT INTO reservation
VALUES ('2000-05-05', '2000-05-06', 'kasutaja2', 1);

SELECT * FROM reservation;

-- 3 - room_type
CREATE TABLE room_type(
room_type_id int primary key identity(1,1),
descriprion varchar(80),
max_capacity int
);

SELECT * FROM room_type;

INSERT INTO room_type
VALUES ('vannituba', 4);

-- 4 - room
CREATE TABLE room(
room_id int primary key identity(1,1),
number varchar(10),
name varchar(40),
status varchar(10),
smoke bit,
room_type_id int,
foreign key (room_type_id) references room_type(room_type_id)
);

SELECT * FROM room;

INSERT INTO room
VALUES ('A105', 'class', 'vaba', 1, 1);

-- 5 - reserved_room
CREATE TABLE reserved_room(
reserved_room_id int primary key identity(1,1),
number_of_rooms int,
room_type_id int,
foreign key (room_type_id) references room_type(room_type_id),
reservation_id int,
foreign key (reservation_id) references reservation(id),
status varchar(20)
);

SELECT * FROM reserved_room;

INSERT INTO reserved_room
VALUES (2, 1, 1, ' not ready');

-- 6 - occupied_room
CREATE TABLE occupied_room(
occupied_room_id int primary key identity(1,1),
check_in date,
check_out date,
room_id int,
foreign key (room_id) references room(room_id),
reservation_id int,  
foreign key (reservation_id) references reservation(id)
);

SELECT * FROM occupied_room;

INSERT INTO occupied_room
VALUES ('2000-05-05', '2000-06-05', 1, 1);

-- 7 - hosted_at
CREATE TABLE hosted_at(
hosted_at_id int primary key identity(1,1),
guest_id int,
foreign key (guest_id) references guest(id),
occupied_room_id int,
foreign key (occupied_room_id) references occupied_room(occupied_room_id)
);

SELECT * FROM hosted_at;

INSERT INTO hosted_at(guest_id, occupied_room_id)
VALUES (1, 1);