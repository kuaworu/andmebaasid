CREATE DATABASE jušinskaja_baas;

-- ab kustutamine
DROP DATABASE BossiBaas;

-- andmebaasi kasutamine
use jušinskaja_baas;

-- tabeli loomine
CREATE TABLE opilane1(
opilaneID int Primary Key identity(1,1), -- automaatselt täidab numbridega
eesnimi varchar(25),
perenimi varchar(30) NOT NULL,
synniaeg DATE,
stip bit,
mobiil varchar(13),
aarress TEXT,
keskminehinne decimal(2,1) ); --(2 - kokku, 1 - peale komat nt 4.5)

SELECT * FROM opilane1;

-- tabeli täitmine
INSERT INTO opilane1
VALUES ('nastja','jušinskaja','2007-11-15',1,'+372555555','tallinn',4.5);

INSERT INTO opilane1(perenimi, eesnimi, keskminehinne)
VALUES ('radasheva', 'natja', 4.5),
('smolenko', 'milana', 4.5),
('merkulova', 'irina', 4.5);

-- andmete uueandamine tabelis
UPDATE opilane1 SET stip=1, aarress='tallinn';
UPDATE opilane1 SET stip=1, aarress='tartu' WHERE opilaneID=5;

-- kustutamine
-- tabeli kustutamine
DROP TABLE opilane;
-- andmete kustutamine tabelis
DELETE FROM opilane1 WHERE opilaneID=2;
SELECT * from opilane1;

-- FOREIGN KEY
CREATE TABLE opetamine(
opetamineID int PRIMARY KEY identity(1,1),
kuupaev DATE,
oppeaine varchar(30),
opilaneID int, 
FOREIGN KEY (opilaneID) REFERENCES opilane1(opilaneID),
hinne int CHECK(hinne<=5)
);

SELECT * from opetamine;
SELECT * from opilane1;

-- täidame tabeli
INSERT INTO opetamine
VALUES ('2026-04-16', 'andmebaasid', 1, 5);

-- iseseisvalt

CREATE TABLE opetaja2(
opetajaID int PRIMARY KEY identity(1,1),
nimi varchar(25),
epost varchar(40),
ruum TEXT,
);

SELECT * from opetaja2;

CREATE TABLE tund1(
tundID int PRIMARY KEY IDENTITY(1,1),
kuupaev DATE,
tundnimi varchar(30),
opetajaID int,
FOREIGN KEY (opetajaID) REFERENCES opetaja2(opetajaID),
opetamineID int,
FOREIGN KEY (opetamineID) REFERENCES opetamine(opetamineID)
);

SELECT * from tund1;

INSERT INTO opetaja2 (nimi, epost, ruum)
VALUES (2, 'irina', 'merkulova@gmail.com', 'E120');

INSERT INTO tund1 (kuupaev, tundnimi, opetajaID)
VALUES (2, '2026-04-16', 'andmebaas', 1, 3);

SELECT * from opilane1
SELECT * from opetaja2;
SELECT * from tund1;
