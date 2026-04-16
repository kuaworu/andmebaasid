# andmebaasid
andmebaasid seotud sql kood ja konspektid
## põhimõisted
- andmebaas - struktureeritud andmete kogum
- tabel = olem - сущность - entity
- veerg = väli - поле
- rida = kirje - записи
- andmebaasi haldussüsteem - tarkvara, millega abil saab luua andmebaas: mariaDB / XAMPP, SQL SERVER management studio.

<img width="235" height="250" alt="{D6EDACB8-015F-451E-AD2D-60C8C2EDF6A4}" src="https://github.com/user-attachments/assets/ad75e3be-05c5-4cc1-bb60-a6ccf292d9bb" />

- primaarne võti - PRIMARY KEY -veerg(tavaliselt id nimega), unikaalne identifikaator, mis eristab iga kirje.
- välisvõti - FOREIGN KEY -FK - veetg, mis loob seos teise tabeli primaarvõtega.
- päring - QUERY - запрос

## andmetüübid
```
1. numbrilised: INT, smallINT, float, decimal(5,2)
2. tekst/sümbulised: varchar(255), char(5), TEXT
3. loogilised: boolean, true/false, bit, bool
4. kuupäeva: date, time, datetime
```
## SQL - structure query language - struktureeritud päringu keel
- tabeli loomine
```sql
CREATE TABLE opilanee(
opilaneID int Primary Key identity(1,1), -- automaatselt täidab numbridega
eesnimi varchar(25),
perenimi varchar(30) NOT NULL,
synniaeg DATE,
stip bit,
mobiil varchar(13),
aarress TEXT,
keskminehinne decimal(2,1) ); --(2 - kokku, 1 - peale komat nt 4.5)

SELECT * FROM opilanee;
```
- andmete sisestamine tabelisse
```sql
INSERT INTO opilane1
VALUES ('nastja','jušinskaja','2007-11-15',1,'+372555555','tallinn',4.5);

INSERT INTO opilane1(perenimi, eesnimi, keskminehinne)
VALUES ('radasheva', 'natja', 4.5),
('smolenko', 'milana', 4.5),
('merkulova', 'irina', 4.5);
```

## seosed (tabelivahelised seosed)
- üks-ühele (nt mees-naine)
- üks-mitmele (nt ema-lapsed)

<img width="200" height="450" alt="{4A33CB14-06F6-4A1F-8F03-94D595920F62}" src="https://github.com/user-attachments/assets/b5164229-6876-4194-8671-fa0ccc21f4fd" />

- mitu-mitmele (nt õpilased-õpetajad)

## PIIRANGUD - ограничение(будет в тесте!!)
constraint - ограничения (5)
1. PRIMARY KEY
2. FOREIGN KEY
3. CHECK
4. NOT NULL
5. UNIQUE

```sql
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
```
