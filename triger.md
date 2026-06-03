## trigger - triger - päastik
andmebaasi objekt, mis automaatselt käivitud tabeli sündmused(INSERT, UPDATE, DELETE)
```sql
Create table linnad(
linnID int PRIMARY KEY IDENTITY (1,1),
linnanimi varchar(15) NOT NULL,
rahvaarv int);
 
-- tabel, mis täidab triger
Create table logi(
id int PRIMARY KEY IDENTITY (1,1),
kasutaja varchar(25),
aeg DATETIME,
toiming  varchar(100),
andmed TEXT -- triger automaatselt lisab mida sekretaar lisas/kustutas tabelisse linnad
)

select * from linnad;
select * from logi;

-- Jälgib andmete sisestamine tabelis linnad ja teeb vastava kirje tabelis logi
CREATE TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kasutaja, aeg, toiming, andmed)
SELECT
SYSTEM_USER, --kasutaja
GETDATE(),  --aeg
'on tehtud INSERT käsk',  --toiming
inserted.linnanimi  --andmed
FROM inserted;

-- kontrollimiseks insert into linnad
INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('tartu', 250000);

select * from linnad;
select * from logi;

-- trigeri muutmine
ALTER TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kasutaja, aeg, toiming, andmed)
SELECT
SYSTEM_USER, --kasutaja
GETDATE(),  --aeg
'on tehtud INSERT käsk',  --toiming
CONCAT('linn: ', inserted.linnanimi, ' rahvaarv: ', inserted.rahvaarv)  --andmed
FROM inserted;

INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('pärnu', 20000);

select * from linnad;
select * from logi;
```
<img width="894" height="358" alt="{6B6E8601-5A8D-43A5-89B1-DD601658140C}" src="https://github.com/user-attachments/assets/4624af2d-dfe8-4f41-ab5d-ed16d7e2c92e" />

```sql
-- delete triger
CREATE TRIGGER linnakustutamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR DELETE
AS
INSERT INTO logi(kasutaja, aeg, toiming, andmed)
SELECT
SYSTEM_USER, --kasutaja
GETDATE(),  --aeg
'on tehtud DELETE käsk',  --toiming
CONCAT('linn: ', deleted.linnanimi, ' rahvaarv: ', deleted.rahvaarv)  --andmed
FROM deleted;

-- kontroll - kuastutada tabelist linnad
DELETE FROM linnad WHERE linnID=1;
select * from linnad;
select * from logi;
```

<img width="1012" height="361" alt="{E30EB450-25A4-47E4-ADBB-5CD106E75C3F}" src="https://github.com/user-attachments/assets/dc7ef466-dd27-4e15-9a0e-25cf258f0809" />

```sql
-- update triger
CREATE TRIGGER linnauuendamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR UPDATE
AS
INSERT INTO logi(kasutaja, aeg, toiming, andmed)
SELECT
SYSTEM_USER, --kasutaja
GETDATE(),  --aeg
'on tehtud UPDATE käsk',  --toiming
CONCAT('VANAD: linn: ', deleted.linnanimi, ' rahvaarv: ', deleted.rahvaarv, 
' ||| UUED: linn: ', inserted.linnanimi, ' rahvaarv: ', inserted.rahvaarv)  --andmed
FROM deleted INNER JOIN inserted
ON deleted.linnID=inserted.linnID;

-- kontrollimiseks tuleb uuendada tabeli linn
UPDATE linnad SET linnanimi='pärnu-väike', rahvaarv=50 WHERE linnID=2;

select * from linnad;
select * from logi;
```

<img width="1343" height="391" alt="{30701909-C635-4F7E-9E97-B50A184632AF}" src="https://github.com/user-attachments/assets/f76246a7-9b94-4438-924e-887039b0dd51" />
