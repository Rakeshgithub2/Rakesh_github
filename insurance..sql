-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 05, 2023 at 11:19 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `insurance`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@'127.0.0.1' PROCEDURE `procedure_cursor` ()   BEGIN
DECLARE plan_n VARCHAR(20);
DECLARE planid,p INT; 
DECLARE amnt,inamnt FLOAT;
DECLARE done INT DEFAULT 0;  
declare cur_1 cursor for select * from health_ins WHERE hplanid=3;
declare continue handler for not found set done=1;
open cur_1;
get_data:loop
fetch cur_1 into planid,plan_n,amnt,inamnt,p;
select planid,plan_n,amnt,inamnt,p;
if done=1 then
leave get_data;
end if;
end loop get_data;
end$$

--
-- Functions
--
CREATE DEFINER='root'@`127.0.0.1` FUNCTION `age_class` (`age` INT) RETURNS VARCHAR(20) CHARSET utf8mb4 DETERMINISTIC BEGIN  
    DECLARE Age_group VARCHAR(20);  
    IF age < 18 THEN  
        SET Age_group = 'youth';  
    ELSEIF (age >= 18 AND   
            age <= 39) THEN  
        SET Age_group = 'young adult';  
    ELSEIF (age >= 40 AND
            age<=49)THEN  
        SET Age_group = 'early middle-aged adults';
    ELSEIF (age >= 50 AND
            age<=59)THEN  
        SET Age_group = 'late middle-aged adults';
    ELSEIF (age > 60)THEN  
        SET Age_group = 'old peoples';
    END IF;  
    -- return the customer occupation  
    RETURN (Age_group);  
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `alogin`
--

CREATE TABLE `alogin` (
  `id` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `uname` varchar(100) NOT NULL,
  `pass` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `alogin`
--

INSERT INTO `alogin` (`id`, `name`, `uname`, `pass`) VALUES
(1, 'admin', 'admin', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `clogin`
--

CREATE TABLE `clogin` (
  `id` int(10) NOT NULL,
  `cname` varchar(50) NOT NULL,
  `uname` varchar(40) NOT NULL,
  `pass` varchar(60) NOT NULL,
  `wallet` int(11) NOT NULL DEFAULT 50000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clogin`
--

INSERT INTO `clogin` (`id`, `cname`, `uname`, `pass`, `wallet`) VALUES
(1, 'Sandhya', 'sandy', '12345', 50000),
(2, 'lahari', 'laharisai', '12345', 50000);

--
-- Triggers `clogin`
--
DELIMITER $$
CREATE TRIGGER `after_insert` AFTER INSERT ON `clogin` FOR EACH ROW BEGIN
INSERT INTO trigger_table VALUES(new.id,new.cname,new.uname,new.pass);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `health_ins`
--

CREATE TABLE `health_ins` (
  `hplanid` int(6) NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `pamnt` float NOT NULL,
  `iamnt` float NOT NULL,
  `tp` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `health_ins`
--

INSERT INTO `health_ins` (`hplanid`, `plan_name`, `pamnt`, `iamnt`, `tp`) VALUES
(4, 'SBI arogya premier', 1000, 12000, 3),
(7, 'SBI arogya premier', 1000, 12000, 3);

-- --------------------------------------------------------

--
-- Table structure for table `hreg`
--

CREATE TABLE `hreg` (
  `regid` int(5) NOT NULL,
  `cid` int(10) NOT NULL,
  `pid` int(11) NOT NULL,
  `iname` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `age` int(11) NOT NULL DEFAULT 0,
  `email` varchar(50) NOT NULL,
  `mobno` varchar(11) NOT NULL,
  `address` varchar(200) NOT NULL,
  `pname` varchar(15) NOT NULL,
  `disease` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hreg`
--

INSERT INTO `hreg` (`regid`, `cid`, `pid`, `iname`, `dob`, `age`, `email`, `mobno`, `address`, `pname`, `disease`) VALUES
(7, 1, 0, 'YASH', '1979-12-25', 13, 'Tabbu@gmail.com', '7123456890', 'Vijaynagar , Bagalore-40', 'Star Family hea', 'Covid');

--
-- Triggers `hreg`
--
DELIMITER $$
CREATE TRIGGER `age_update_hreg` BEFORE INSERT ON `hreg` FOR EACH ROW SET new.age=YEAR(CURRENT_TIMESTAMP)-YEAR(new.dob)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `life_ins`
--

CREATE TABLE `life_ins` (
  `lplanid` int(6) NOT NULL,
  `pname` varchar(100) NOT NULL,
  `pamnt` float NOT NULL,
  `iamnt` float NOT NULL,
  `tp` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `life_ins`
--

INSERT INTO `life_ins` (`lplanid`, `pname`, `pamnt`, `iamnt`, `tp`) VALUES
(2, 'Term', 2500, 25000, 2),
(3, 'Retirement plans', 3000, 35000, 5);

-- --------------------------------------------------------

--
-- Table structure for table `lreg`
--

CREATE TABLE `lreg` (
  `regid` int(6) NOT NULL,
  `cid` int(10) NOT NULL,
  `pid` int(11) NOT NULL,
  `iname` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `mobno` varchar(11) NOT NULL,
  `address` varchar(200) NOT NULL,
  `pname` varchar(15) NOT NULL,
  `nname` varchar(15) NOT NULL,
  `nrelation` varchar(20) NOT NULL,
  `ncontact` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lreg`
--

INSERT INTO `lreg` (`regid`, `cid`, `pid`, `iname`, `dob`, `email`, `mobno`, `address`, `pname`, `nname`, `nrelation`, `ncontact`) VALUES
(6, 1, 0, 'Venkat', '1991-12-16', 'Vc@gmail.com', '8724156728', 'Mysore-50', 'Term', 'Vaishnavi', 'wife', '9821023456'),
(7, 1, 0, 'Hamsa', '1997-12-14', 'Ham@gmail.com', '7123456890', 'Girinagar, Bangalore-49', 'Retirement plan', 'Hitesh', 'Cousin', '9821023447');

-- --------------------------------------------------------

--
-- Table structure for table `preg`
--

CREATE TABLE `preg` (
  `regid` int(5) NOT NULL,
  `cid` int(10) NOT NULL,
  `pid` int(11) NOT NULL,
  `iname` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `email` varchar(50) NOT NULL,
  `mobno` varchar(11) NOT NULL,
  `pname` varchar(50) NOT NULL,
  `propaddress` varchar(200) NOT NULL,
  `propsize` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `preg`
--

INSERT INTO `preg` (`regid`, `cid`, `pid`, `iname`, `dob`, `email`, `mobno`, `pname`, `propaddress`, `propsize`) VALUES
(4, 1, 0, 'Rakesh', '1988-02-21', 'Rocky@gmail.com', '9312456234', 'Home Structure', 'Harinagar, Bangalore-39', '50X60');

-- --------------------------------------------------------

--
-- Table structure for table `prop_ins`
--

CREATE TABLE `prop_ins` (
  `pplanid` int(6) NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `pamnt` float NOT NULL,
  `iamnt` float NOT NULL,
  `tp` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `prop_ins`
--

INSERT INTO `prop_ins` (`pplanid`, `plan_name`, `pamnt`, `iamnt`, `tp`) VALUES
(3, 'Contents', 60000, 12000000, 12);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_ins`
--

CREATE TABLE `vehicle_ins` (
  `vplanid` int(6) NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `pamnt` float NOT NULL,
  `iamnt` float NOT NULL,
  `tp` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vehicle_ins`
--

INSERT INTO `vehicle_ins` (`vplanid`, `plan_name`, `pamnt`, `iamnt`, `tp`) VALUES
(9047, 'Third-Party', 1500, 55000, 3),
(9051, 'xyz', 500, 50000, 20);

-- --------------------------------------------------------

--
-- Table structure for table `vreg`
--

CREATE TABLE `vreg` (
  `regid` int(5) NOT NULL,
  `cid` int(10) NOT NULL,
  `pid` int(11) NOT NULL,
  `iname` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobno` varchar(10) NOT NULL,
  `address` varchar(200) NOT NULL,
  `pname` varchar(40) NOT NULL,
  `vno` varchar(11) NOT NULL,
  `vtype` varchar(20) NOT NULL,
  `vbrand` varchar(20) NOT NULL,
  `regy` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vreg`
--

INSERT INTO `vreg` (`regid`, `cid`, `pid`, `iname`, `dob`, `email`, `mobno`, `address`, `pname`, `vno`, `vtype`, `vbrand`, `regy`) VALUES
(98471, 1, 0, 'sandhya ', '1993-11-23', 'san@gmail.com', '9123456780', 'Chandra Layout, Bangalore-72', 'Third-Party', 'KA-05-JJ-34', '2-Wheeler', 'Honda-Activa', 2021),
(98472, 1, 0, 'Lahari', '1990-04-06', 'lorry@gmail.com', '9846127830', 'Konankuntte , Bangalore-62', 'SBI vehicle', 'KA-07-SS-06', '4-Wheeler', 'Honda-I20', 2019),
(98473, 2, 0, 'abc', '2022-09-06', 'insaneopg@gmail.com', '145786', 'sddsdsd', 'Third-Party', 'dsds', '2-Wheeler', 'dsd', 214),
(98475, 6, 9051, 'purchase', '2002-06-07', 'chandan@123', '6360238845', 'purchase', 'xyz', '6556', '2-Wheeler', 'ghcgh', 2022);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alogin`
--
ALTER TABLE `alogin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clogin`
--
ALTER TABLE `clogin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `health_ins`
--
ALTER TABLE `health_ins`
  ADD PRIMARY KEY (`hplanid`);

--
-

--
-- Indexes for table `life_ins`
--
ALTER TABLE `life_ins`
  ADD PRIMARY KEY (`lplanid`);

--
-- Indexes for table `lreg`
--
ALTER TABLE `lreg`
  ADD PRIMARY KEY (`regid`),
  ADD KEY `cid` (`cid`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `preg`
--
ALTER TABLE `preg`
  ADD PRIMARY KEY (`regid`),
  ADD KEY `cid` (`cid`),
  ADD KEY `pid` (`pid`);

--
-- Indexes for table `prop_ins`
--
ALTER TABLE `prop_ins`
  ADD PRIMARY KEY (`pplanid`);

--
-- Indexes for table `vehicle_ins`
--
ALTER TABLE `vehicle_ins`
  ADD PRIMARY KEY (`vplanid`);

--
-- Indexes for table `vreg`
--
ALTER TABLE `vreg`
  ADD PRIMARY KEY (`regid`),
  ADD KEY `cid` (`cid`),
  ADD KEY `pid` (`pid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alogin`
--
ALTER TABLE `alogin`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `clogin`
--
ALTER TABLE `clogin`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `health_ins`
--
ALTER TABLE `health_ins`
  MODIFY `hplanid` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `hreg`
--
ALTER TABLE `hreg`
  MODIFY `regid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `life_ins`
--
ALTER TABLE `life_ins`
  MODIFY `lplanid` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lreg`
--
ALTER TABLE `lreg`
  MODIFY `regid` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `preg`
--
ALTER TABLE `preg`
  MODIFY `regid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `prop_ins`
--
ALTER TABLE `prop_ins`
  MODIFY `pplanid` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vehicle_ins`
--
ALTER TABLE `vehicle_ins`
  MODIFY `vplanid` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9052;

--
-- AUTO_INCREMENT for table `vreg`
--
ALTER TABLE `vreg`
  MODIFY `regid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98476;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hreg`
--
ALTER TABLE `hreg`
  ADD CONSTRAINT `hreg_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `clogin` (`id`),
  ADD CONSTRAINT `hreg_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `health_ins` (`hplanid`);

--
-- Constraints for table `lreg`
--
ALTER TABLE `lreg`
  ADD CONSTRAINT `lreg_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `clogin` (`id`),
  ADD CONSTRAINT `lreg_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `life_ins` (`lplanid`);

--
-- Constraints for table `preg`
--
ALTER TABLE `preg`
  ADD CONSTRAINT `preg_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `clogin` (`id`),
  ADD CONSTRAINT `preg_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `prop_ins` (`pplanid`);

--
-- Constraints for table `vreg`
--
ALTER TABLE `vreg`
  ADD CONSTRAINT `vreg_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `clogin` (`id`),
  ADD CONSTRAINT `vreg_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `vehicle_ins` (`vplanid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
