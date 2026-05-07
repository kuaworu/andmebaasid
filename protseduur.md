## sql protseduurid
- store procedure - salvestatud protseduurid - хранимые процедуры
- sama nagu funktsioonid programmeerimises - mingi tegevused mis käivitakse automaatselt protseduuri kasutamisel.

### protseduur, mis lisab uus guest ja kuvab tabeli
```sql
-- protseduur, mis lisab uus guest ja kuvab tabeli
CREATE PROCEDURE lisaguest
-- @parameetrid
@uusnimi varchar(25),
@uusperenimi varchar(30),
@kuupaev date
AS
BEGIN
-- protseduuri sisu
	INSERT INTO guest(first_name, last_name, member_since)
	VALUES (@uusnimi, @uusperenimi, @kuupaev);
	SELECT * FROM guest;
END
```

<img width="251" height="269" alt="{084C770F-9B92-4EED-9B9F-3FC78097DDAF}" src="https://github.com/user-attachments/assets/0704579c-362c-4592-b511-56cef34c285e" />

<img width="428" height="201" alt="{4D9311C6-818A-4FFC-8F88-C55FC488FE18}" src="https://github.com/user-attachments/assets/f859a754-bcc4-45f9-9e73-5e683647312c" />

### protseduur, mis kustutab guest id järgi
```sql
-- protseduur, mis kustutab guest id järgi
CREATE PROCEDURE kustutaguest
@kustutaid int
AS

BEGIN
	DELETE FROM guest WHERE id=@kustutaid;
END
```

<img width="254" height="201" alt="{45B5DD73-69B2-4376-A68B-DA1792E1A0FC}" src="https://github.com/user-attachments/assets/88f45f6f-8f57-47b3-91ac-ec54a110828c" />

<img width="360" height="191" alt="{20E1E296-B7B9-4E69-B97A-71F80723D2D2}" src="https://github.com/user-attachments/assets/dd1498bb-b002-43b3-a23d-05a8b6a79c89" />

### otsing esimese tähe järgi
```sql
-- otsing esimese tähe järgi
CREATE PROCEDURE otsing1taht
@taht char(1)
AS
BEGIN
	SELECT * FROM guest WHERE last_name LIKE @taht + '%'; -- % teised sümboolid
END
```

<img width="276" height="215" alt="{8B8E03B6-75FB-43C1-97A6-3DB3095AE1A8}" src="https://github.com/user-attachments/assets/1937f42d-e7fa-4b3a-96f1-57586fea8ddd" />

<img width="323" height="182" alt="{9D6B45F1-1253-44BD-871A-3E0AF502F743}" src="https://github.com/user-attachments/assets/bb1ce763-b979-4f93-9148-285f045a9127" />

### protseduur veeru lisamiseks või kustutamiseks
```sql
-- protseduur veeru lisamiseks või kustutamiseks 
CREATE PROCEDURE muudatus
    @tegevus varchar(10),
    @tabelinimi varchar(25),
    @veerunimi varchar(25),
    @tyyp varchar(25) = NULL
AS
BEGIN
    DECLARE @sqltegevus varchar(max);

    SET @sqltegevus = CASE 
        WHEN @tegevus = 'add' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)

        WHEN @tegevus = 'drop' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
    END;

    PRINT @sqltegevus;
    EXEC (@sqltegevus);
END;
```

<img width="271" height="249" alt="{E3C8B9CD-4876-4CAB-8A99-8027910215A3}" src="https://github.com/user-attachments/assets/c17fe3ec-7b12-49f1-9cd2-68977a861f18" />

<img width="391" height="207" alt="{C20256E8-80E6-4B6D-BE02-83F5783E8BDC}" src="https://github.com/user-attachments/assets/29c12066-41cb-4414-91d8-2cb4396462b3" />

### protseduur, mis kuvab toodete nime, hinna ja lisab automaatselt hinnangu 
```sql
-- protseduur veeru lisamiseks või kustutamiseks 
CREATE PROCEDURE kuvaarvehinnang
AS
BEGIN
    SELECT 
        first_name,
        arvesumma,
        CASE 
            WHEN arvesumma <= 1000 THEN 'väike summa'
            ELSE 'suur summa'
        END AS hinnang
    FROM guest;
END;
```

<img width="259" height="273" alt="{5533C43D-2DE3-419B-81A0-CD4247CA1327}" src="https://github.com/user-attachments/assets/64a66054-beeb-43cb-92fd-9b81d97865c6" />

<img width="307" height="170" alt="{BACD5C7B-2B13-46D1-9821-94D28F2BCAC7}" src="https://github.com/user-attachments/assets/c5b8d708-22aa-4179-ae83-8e7057422a21" />
