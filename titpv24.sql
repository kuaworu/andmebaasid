-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Aprill 23, 2026 kell 10:32 EL
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
-- Andmebaas: `titpv24`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `opetaja1`
--

CREATE TABLE `opetaja1` (
  `opetajaid` int(11) NOT NULL,
  `nimi` varchar(25) NOT NULL,
  `epost` varchar(40) NOT NULL,
  `ruum` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `opetaja1`
--

INSERT INTO `opetaja1` (`opetajaid`, `nimi`, `epost`, `ruum`) VALUES
(1, 'irina', 'merkulova@gmail.com', 'E120');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `opetamine`
--

CREATE TABLE `opetamine` (
  `opetamineID` int(11) NOT NULL,
  `kuupaev` date DEFAULT NULL,
  `oppeaine` varchar(30) DEFAULT NULL,
  `opilaneID` int(11) DEFAULT NULL,
  `hinne` int(11) DEFAULT NULL CHECK (`hinne` <= 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `opilane1`
--

CREATE TABLE `opilane1` (
  `opilaneID` int(11) NOT NULL,
  `eesnimi` varchar(25) DEFAULT NULL,
  `perenimi` varchar(30) NOT NULL,
  `synniaeg` date DEFAULT NULL,
  `stip` bit(1) DEFAULT NULL,
  `mobiil` varchar(13) DEFAULT NULL,
  `aadress` text DEFAULT NULL,
  `keskminehinne` decimal(2,1) DEFAULT NULL,
  `ryhmid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `opilane1`
--

INSERT INTO `opilane1` (`opilaneID`, `eesnimi`, `perenimi`, `synniaeg`, `stip`, `mobiil`, `aadress`, `keskminehinne`, `ryhmid`) VALUES
(1, 'anastasia', 'jušinskaja', '2002-04-01', b'0', '5555', 'tartu, punane tn 23', 5.0, NULL),
(2, 'natja', 'radasheva', NULL, NULL, NULL, NULL, 4.5, NULL),
(3, 'milana', 'smolenko', NULL, NULL, NULL, NULL, 4.5, NULL),
(4, 'irina', 'merkulova', NULL, NULL, NULL, NULL, 4.5, NULL),
(5, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL),
(6, NULL, '', NULL, NULL, NULL, NULL, NULL, 2);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `ryhm`
--

CREATE TABLE `ryhm` (
  `ryhmid` int(11) NOT NULL,
  `ryhmnimi` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `ryhm`
--

INSERT INTO `ryhm` (`ryhmid`, `ryhmnimi`) VALUES
(2, 'LOGITpv24'),
(1, 'TITpv24');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `tund1`
--

CREATE TABLE `tund1` (
  `tundID` int(11) NOT NULL,
  `kuupaev` date DEFAULT NULL,
  `tundnimi` varchar(30) DEFAULT NULL,
  `opetajaID` int(11) DEFAULT NULL,
  `opetamineID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `opetaja1`
--
ALTER TABLE `opetaja1`
  ADD PRIMARY KEY (`opetajaid`);

--
-- Indeksid tabelile `opetamine`
--
ALTER TABLE `opetamine`
  ADD PRIMARY KEY (`opetamineID`),
  ADD KEY `opilaneID` (`opilaneID`);

--
-- Indeksid tabelile `opilane1`
--
ALTER TABLE `opilane1`
  ADD PRIMARY KEY (`opilaneID`),
  ADD KEY `fk_ryhm` (`ryhmid`);

--
-- Indeksid tabelile `ryhm`
--
ALTER TABLE `ryhm`
  ADD PRIMARY KEY (`ryhmid`),
  ADD UNIQUE KEY `ryhmnimi` (`ryhmnimi`);

--
-- Indeksid tabelile `tund1`
--
ALTER TABLE `tund1`
  ADD PRIMARY KEY (`tundID`),
  ADD KEY `opetajaID` (`opetajaID`),
  ADD KEY `opetamineID` (`opetamineID`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `opetaja1`
--
ALTER TABLE `opetaja1`
  MODIFY `opetajaid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT tabelile `opetamine`
--
ALTER TABLE `opetamine`
  MODIFY `opetamineID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `opilane1`
--
ALTER TABLE `opilane1`
  MODIFY `opilaneID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT tabelile `ryhm`
--
ALTER TABLE `ryhm`
  MODIFY `ryhmid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT tabelile `tund1`
--
ALTER TABLE `tund1`
  MODIFY `tundID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `opetamine`
--
ALTER TABLE `opetamine`
  ADD CONSTRAINT `opetamine_ibfk_1` FOREIGN KEY (`opilaneID`) REFERENCES `opilane1` (`opilaneID`);

--
-- Piirangud tabelile `opilane1`
--
ALTER TABLE `opilane1`
  ADD CONSTRAINT `fk_ryhm` FOREIGN KEY (`ryhmid`) REFERENCES `ryhm` (`ryhmid`);

--
-- Piirangud tabelile `tund1`
--
ALTER TABLE `tund1`
  ADD CONSTRAINT `tund1_ibfk_1` FOREIGN KEY (`opetajaID`) REFERENCES `opetaja1` (`opetajaid`),
  ADD CONSTRAINT `tund1_ibfk_2` FOREIGN KEY (`opetamineID`) REFERENCES `opetamine` (`opetamineID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
