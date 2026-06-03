# create kasutajad konspekt

[põhimõisted](README.md) | [protseduurid sql serveris](protseduur.md) | [protseduurid xamppis](xampp_protseduurid.md) | [kasutaja sql serveris](kasutaja.md) | [kasutaja xamppis](kasutaja_xampp.md) | [create kasutajad konspekt](create_kasutajad.md) | [trigerid sql serveris](triger.md) | [trigerid xamppis](triger_xampp.md) | [hotelliruum](hotelliruum.md) | [keys - kodutöö](keys.md)

# 1
```sql
CREATE DATABASE praktiline_too_4;
USE praktiline_too_4;

CREATE TABLE loomad(
loomId int primary key identity(1,1),
loomNimi varchar(25) not null,
vanus int check(vanus>0),
chip  bit)

INSERT INTO loomad(loomnimi,vanus,chip)
VALUES ('koer cheburek', 1, 1);

SELECT * FROM loomad;

-- õiguste määramine
-- GRANT - õiguste lubamine - разрешение прав пользователя
-- DENY -kasutaja õiguste keelamine - запрет 

GRANT SELECT ON loomad TO director_nastja;
GRANT INSERT ON loomad TO director_nastja;
-- or all together
GRANT SELECT, INSERT ON loomad TO director_nastja;
-- saab uuendada ainult vanus!!!
GRANT UPDATE(vanus) ON loomad TO director_nastja;

DENY DELETE ON loomad TO director_nastja;
```

---

# 2
```sql
-- õiguste kontroll
-- director_nastja saab vaadata  tabelisisu
SELECT * FROM loomad;
-- director_nastja saab lisada andmeid tabelisse loomad
INSERT INTO loomad(loomnimi,vanus,chip)
VALUES ('kass bebe', 2, 0);


-- director_nastja ei saa kustutada tabelist
DELETE FROM loomad WHERE loomid=1

-- ei saa tabeleid luua
CREATE TABLE test_new(id int);

-- iga kasutaja ise saab kontrollida temale määratud õigused
SELECT * FROM fn_my_permissions('loomad','OBJECT')

-- uuendamine vanus kus loomid=1
UPDATE loomad SET vanus=2 WHERE loomid=1;
UPDATE loomad SET chip=0 WHERE loomid=1;
```
---

# 3

```sql
CREATE DATABASE movie;
USE movie;

CREATE TABLE movies(
movieid int primary key identity(1,1),
movienimi varchar(25) not null,
moviesyear int not null,
moviedir varchar(30) not null,
moviecost decimal(15,1))

INSERT INTO movies(movienimi, moviesyear, moviedir, moviecost)
VALUES ('The Green Mile', 1999, 'Frank Darabont', 60000000.00),
('Hachi: A Dog`s Tale', 2009, 'Lasse Hallström', 16000000.00),
('Van Helsing', 2004, 'Stephen Sommers', 160000000.00),
('Game of Thrones', 2011, 'David Benioff', 60000000.00),
('The Lord of the Rings', 2001, 'Peter Jackson', 93000000.00),
('Pirates of the Caribbean', 2003, 'Gore Verbinski', 140000000.00),
('The Witcher', 2019, 'Lauren Schmidt', 80000000.00);

SELECT * FROM movies;

CREATE TABLE guest(
guestid int primary key identity(1,1),
name VARCHAR(50) not null);

INSERT INTO guest (name)
VALUES ('milana'), ('nastja'), ('dasa'),
('elina'), ('lisa'), ('oleg'),('rene');

SELECT * FROM guest;
```
