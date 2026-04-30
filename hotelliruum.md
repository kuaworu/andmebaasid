## andmebaas hotelliruumi reserveerimine

tabel guest
```sql
CREATE TABLE guest(
id int primary key identity(1,1),
first_name varchar(80),
last_name varchar(80),
member_since date
);

SELECT * FROM guest;

INSERT INTO guest
VALUES ('nastja', 'radasheva', '2026-05-05');
```
<img width="363" height="120" alt="{B2670B68-78E0-4BA0-BA53-941E43A79637}" src="https://github.com/user-attachments/assets/16eb2094-553d-45eb-8641-94f36a3659ed" />

tabel reservation
```sql
CREATE TABLE reservation(
id int primary key identity(1,1),
date_in date,
date_out date,
made_by varchar(80),
guest_id int,
foreign key (guest_id) references guest
);

INSERT INTO reservation
VALUES ('2000-05-05', '2000-05-06', 'kasutaja2', 1);

SELECT * FROM reservation;
```
<img width="351" height="123" alt="{01798AD7-0088-4683-AD82-253C9A8DE9B9}" src="https://github.com/user-attachments/assets/43cadf83-ce94-4830-86cb-4831eccd9f5a" />

tabel room_type
```sql
CREATE TABLE room_type(
room_type_id int primary key identity(1,1),
descriprion varchar(80),
max_capacity int
);

SELECT * FROM room_type;

INSERT INTO room_type
VALUES ('vannituba', 4);
```
<img width="284" height="133" alt="{166CB2AD-929D-4659-86BE-F3ACB259519C}" src="https://github.com/user-attachments/assets/44e9b8d5-ca5b-4968-a9a2-978911636895" />

tabel room
```sql
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
VALUES ('A102', 'class', 'vaba', 1, 1);
```
<img width="401" height="128" alt="{A9F19C80-FC77-4180-B0FE-3F78CF914A5E}" src="https://github.com/user-attachments/assets/84a4de88-ec37-46ef-94f7-f29954648b21" />

tabel reserved_room
```sql
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
VALUES (3, 1, 1, 'ready');
```
<img width="506" height="129" alt="{63307AFC-1391-4384-91C1-2F669CF4DE24}" src="https://github.com/user-attachments/assets/22c2b8d0-88f7-4423-b15c-e7095afc08da" />

tabel occupied_room
```sql
CREATE TABLE occupied_room(
occupied_room_id int primary key identity(1,1),
check_in date,
check_out date,
room_id int,
foreign key (room_id) references room(room_id),
reservation_id int
foreign key (reservation_id) references reservation(id)
);

SELECT * FROM occupied_room;

INSERT INTO occupied_room
VALUES ('2000-05-05', '2000-06-05', 1, 1);
```
<img width="454" height="134" alt="{0EFCCEE1-9A62-4859-A415-37BF397E823F}" src="https://github.com/user-attachments/assets/5e440ea1-fbd7-4157-8d8f-3055110113ef" />

tabel hosted_at
```sql
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
```
<img width="309" height="99" alt="{4C01A5C9-21E4-448C-A3C3-DA6D901CCE11}" src="https://github.com/user-attachments/assets/3c498276-7006-48d4-b0dd-d9b4726ee39e" />

<img width="944" height="558" alt="{60419528-D01D-41B2-B43E-29B6BE1242C7}" src="https://github.com/user-attachments/assets/35cf2687-d428-472f-ace6-2b16d19dba8b" />
