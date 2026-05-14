-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Mai 14, 2026 kell 10:13 EL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `protseduurtitpv24`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaklient` (IN `kustutaid` INT)   BEGIN
    DELETE FROM klient
    WHERE id = kustutaid;

    SELECT * FROM klient;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaloom` (IN `kustutaid` INT)   BEGIN
	SELECT * FROM loomad;
	DELETE FROM loomad WHERE loomid=kustutaid;
    SELECT * FROM loomad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaklient` (IN `uusnimi` VARCHAR(20), IN `uuslinn` VARCHAR(20), IN `uusvanus` INT, IN `uussaldo` INT)   BEGIN
    INSERT INTO klient(nimi, linn, vanus, saldo)
    VALUES (uusnimi, uuslinn, uusvanus, uussaldo);

    SELECT * FROM klient;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaloom` (IN `uusnimi` VARCHAR(20), IN `uuskaal` INT, IN `uusaasta` INT)   BEGIN
	INSERT INTO loomad(loomnimi, kaal, synniaasta)
    VALUES (uusnimi, uuskaal, uusaasta);
    SELECT * FROM loomad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loomahinnang` ()   BEGIN
	SELECT loomnimi, kaal, 
    IF(kaal>10, 'suur loom', 'väike loom') AS hinnang
    FROM loomad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `minmaxkaal` (OUT `minkaal` INT, OUT `maxkaal` INT, OUT `avgkaal` DECIMAL(6,2), OUT `sumkaal` INT, OUT `countloom` INT)   BEGIN
	SELECT MIN(kaal),MAX(kaal),AVG(kaal),SUM(kaal),COUNT(*)
    INTO minkaal, maxkaal, avgkaal, sumkaal, countloom
    FROM loomad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `minmaxsaldo` (OUT `minsaldo` INT, OUT `maxsaldo` INT)   BEGIN
    SELECT MIN(saldo), MAX(saldo)
    INTO minsaldo, maxsaldo
    FROM klient;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `muudaklient` (IN `kliendiID` INT, IN `uuslinn` VARCHAR(100), IN `uussaldo` DECIMAL(10,2))   BEGIN
    UPDATE klient
    SET linn = uuslinn,
        saldo = uussaldo
    WHERE id = kliendiID;

    SELECT * FROM klient;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `naitaklient` ()   BEGIN
    SELECT nimi, linn
    FROM klient;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `naitaloomad` ()   BEGIN
	SELECT loomnimi FROM loomad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `otsing1taht` (IN `taht` CHAR(1))   BEGIN
 SELECT * FROM loomad
 WHERE loomnimi LIKE Concat(taht, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `otsing1tahtklient` (IN `taht` CHAR(1))   BEGIN
    SELECT *
    FROM klient
    WHERE nimi LIKE CONCAT(taht, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tingimuslauseklient` ()   BEGIN
    SELECT 
        nimi,
        linn,
        saldo,
        IF(saldo > 100, 'hea klient', 'tava klient') AS hinnang
    FROM klient;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uue` (IN `klientid` INT)   BEGIN
    ALTER TABLE klient ADD email VARCHAR(100);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `klient`
--

CREATE TABLE `klient` (
  `id` int(11) NOT NULL,
  `nimi` varchar(100) DEFAULT NULL,
  `linn` varchar(100) DEFAULT NULL,
  `vanus` int(11) DEFAULT NULL,
  `saldo` decimal(10,2) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `klient`
--

INSERT INTO `klient` (`id`, `nimi`, `linn`, `vanus`, `saldo`, `email`) VALUES
(2, 'karina', 'tallinn', 32, 0.01, NULL),
(3, 'lisa', 'tallinn', 18, 5.03, NULL),
(4, 'milana', 'tallinn', 18, 2000.00, NULL);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `loomad`
--

CREATE TABLE `loomad` (
  `loomid` int(11) NOT NULL,
  `loomnimi` varchar(20) NOT NULL,
  `kaal` int(11) DEFAULT NULL,
  `synniaasta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `loomad`
--

INSERT INTO `loomad` (`loomid`, `loomnimi`, `kaal`, `synniaasta`) VALUES
(2, 'koer kummel', 125, 2020),
(3, 'papagoi', 1, 2025),
(4, 'kass', 1, 1000);

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `klient`
--
ALTER TABLE `klient`
  ADD PRIMARY KEY (`id`);

--
-- Indeksid tabelile `loomad`
--
ALTER TABLE `loomad`
  ADD PRIMARY KEY (`loomid`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `klient`
--
ALTER TABLE `klient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `loomad`
--
ALTER TABLE `loomad`
  MODIFY `loomid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
