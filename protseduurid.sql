CREATE DATABASE protseduurjusinskaja;
use protseduurjusinskaja;
-- ab hotell
-- guest tabel
CREATE TABLE guest(
id int primary key identity(1,1),
first_name varchar(80),
last_name varchar(80),
member_since date
);

SELECT * FROM guest;

INSERT INTO guest
VALUES ('nastja', 'radasheva', '2026-05-05');

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

-- kutse
EXEC lisaguest 'dasa', 'kovalenko', '2026-05-06'

-- protseduur, mis kustutab guest id järgi
CREATE PROCEDURE kustutaguest
@kustutaid int
AS

BEGIN
	DELETE FROM guest WHERE id=@kustutaid;
END

-- kutse
EXEC kustutaguest 2;
SELECT * FROM guest;

-- otsing esimese tähe järgi
CREATE PROCEDURE otsing1taht
@taht char(1)
AS
BEGIN
	SELECT * FROM guest WHERE last_name LIKE @taht + '%'; -- % teised sümboolid
END

-- kutse
EXEC otsing1taht 'K'

-- lisame uus veerg
ALTER TABLE guest ADD arvesumma money;

update guest set arvesumma=5000000 WHERE id=3

-- OUTPUT parameetrid (min ja max väärtus)
CREATE PROCEDURE minimaxArve
	@minArve MONEY OUTPUT,
	@maxArve MONEY OUTPUT
AS
BEGIN
	SELECT
		@minArve = MIN(arvesumma),
		@maxArve = MAX(arvesumma)
	FROM guest;
END;

-- kutse
DECLARE @minArve MONEY, @maxArve MONEY;
EXEC minmaxArve @minArve OUTPUT, @maxArve OUTPUT;
PRINT 'Min arve = ' + CONVERT(varchar, @minArve);
PRINT 'Max arve = ' + CONVERT(varchar, @maxArve);

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

-- kutse
EXEC muudatus 'add', 'guest', 'textveerg', int
EXEC muudatus 'drop', 'guest', 'textveerg'
SELECT * FROM guest

-- protseduur, mis kuvab toodete nime, hinna ja lisab automaatselt hinnangu 
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

-- kutse
EXEC kuvaarvehinnang;


-- lisaülesanne
CREATE TABLE room_type1(
    room_type_id int PRIMARY KEY IDENTITY(1,1),
    description varchar(80),
    max_capacity int
);

SELECT * FROM room_type1;

INSERT INTO room_type1(description, max_capacity)
VALUES ('vannituba', 4);

-- 1
CREATE PROCEDURE lisa_room_type1
    @description varchar(80),
    @max_capacity int
AS
BEGIN
    INSERT INTO room_type1(description, max_capacity)
    VALUES (@description, @max_capacity);

    SELECT * FROM room_type1;
END;

-- kutse
EXEC lisa_room_type1 'vannituba', 5;

-- 2
CREATE PROCEDURE kustuta_room_type11
    @kustutaid int
AS
BEGIN
    DELETE FROM room_type1
    WHERE room_type_id = @kustutaid;
END;

-- kutse
EXEC kustuta_room_type11 4;

SELECT * FROM room_type1;

-- 3
CREATE PROCEDURE otsing1taht_room_type1
    @taht char(1)
AS
BEGIN
    SELECT * FROM room_type1
    WHERE description LIKE @taht + '%'; -- % tähendab ülejäänud sümboleid
END;

-- kutse
EXEC otsing1taht_room_type1 'v';

-- 4
CREATE PROCEDURE minmaxroomtype2
    @minCapacity INT OUTPUT,
    @maxCapacity INT OUTPUT
AS
BEGIN
    SELECT
        @minCapacity = min(max_capacity),
        @maxCapacity = max(max_capacity)
    FROM room_type1;
END;

DECLARE @minCapacity int, @maxCapacity int;

EXEC minmaxroomtype2 @minCapacity OUTPUT, @maxCapacity OUTPUT;

PRINT 'min capacity = ' + CONVERT(VARCHAR, @minCapacity);
PRINT 'max capacity = ' + CONVERT(VARCHAR, @maxCapacity);

-- 5
CREATE PROCEDURE muudatus12
    @tegevus VARCHAR(10),
    @tabelinimi VARCHAR(25),
    @veerunimi VARCHAR(25),
    @tyyp VARCHAR(25) = NULL
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);

    SET @sql = CASE
        WHEN @tegevus = 'add' THEN
            'ALTER TABLE ' + @tabelinimi +
            ' ADD ' + @veerunimi + ' ' + @tyyp

        WHEN @tegevus = 'drop' THEN
            'ALTER TABLE ' + @tabelinimi +
            ' DROP COLUMN ' + @veerunimi
    END;

    PRINT @sql;
    EXEC(@sql);
END;

EXEC muudatus12 'add', 'room_type1', 'textveerg', 'INT';
EXEC muudatus12 'drop', 'room_type1', 'textveerg';

SELECT * FROM room_type1;

-- 6
CREATE PROCEDURE kuvaarvehinnang12
AS
BEGIN
    SELECT
        description,
        max_capacity,
        CASE
            WHEN max_capacity <= 4 THEN 'väike ruum'
            ELSE 'suur ruum'
        END AS hinnang
    FROM room_type1;
END;

EXEC kuvaarvehinnang12;
