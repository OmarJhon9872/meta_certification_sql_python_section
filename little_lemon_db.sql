-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.36 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para little_lemon_db
CREATE DATABASE IF NOT EXISTS `little_lemon_db` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `little_lemon_db`;

-- Volcando estructura para procedimiento little_lemon_db.BasicSalesReport
DELIMITER //
CREATE PROCEDURE `BasicSalesReport`()
BEGIN
	SELECT 
		count(BillAmount) count_sales,
		SUM(BillAmount) total_sales,
		AVG(BillAmount) avg_sales,
		MIN(BillAmount) min_sale,
		Max(BillAmount) max_sale
		FROM orders;
END//
DELIMITER ;

-- Volcando estructura para tabla little_lemon_db.bookings
CREATE TABLE IF NOT EXISTS `bookings` (
  `BookingID` int(11) NOT NULL AUTO_INCREMENT,
  `TableNo` int(11) DEFAULT NULL,
  `GuestFirstName` varchar(100) NOT NULL,
  `GuestLastName` varchar(100) NOT NULL,
  `BookingSlot` time NOT NULL,
  `EmployeeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`BookingID`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla little_lemon_db.bookings: 6 rows
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` (`BookingID`, `TableNo`, `GuestFirstName`, `GuestLastName`, `BookingSlot`, `EmployeeID`) VALUES
	(1, 12, 'Anna', 'Iversen', '19:00:00', 1),
	(2, 12, 'Joakim', 'Iversen', '19:00:00', 1),
	(3, 19, 'Vanessa', 'McCarthy', '15:00:00', 3),
	(4, 15, 'Marcos', 'Romero', '17:30:00', 4),
	(5, 5, 'Hiroki', 'Yamane', '18:30:00', 2),
	(6, 8, 'Diana', 'Pinto', '20:00:00', 5);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;

-- Volcando estructura para tabla little_lemon_db.employees
CREATE TABLE IF NOT EXISTS `employees` (
  `EmployeeID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Role` varchar(100) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Contact_Number` int(11) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Annual_Salary` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla little_lemon_db.employees: 6 rows
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` (`EmployeeID`, `Name`, `Role`, `Address`, `Contact_Number`, `Email`, `Annual_Salary`) VALUES
	(1, 'Mario Gollini', 'Manager', '724, Parsley Lane, Old Town, Chicago, IL', 351258074, 'Mario.g@littlelemon.com', '$70,000'),
	(2, 'Adrian Gollini', 'Assistant Manager', '334, Dill Square, Lincoln Park, Chicago, IL', 351474048, 'Adrian.g@littlelemon.com', '$65,000'),
	(3, 'Giorgos Dioudis', 'Head Chef', '879 Sage Street, West Loop, Chicago, IL', 351970582, 'Giorgos.d@littlelemon.com', '$50,000'),
	(4, 'Fatma Kaya', 'Assistant Chef', '132  Bay Lane, Chicago, IL', 351963569, 'Fatma.k@littlelemon.com', '$45,000'),
	(5, 'Elena Salvai', 'Head Waiter', '989 Thyme Square, EdgeWater, Chicago, IL', 351074198, 'Elena.s@littlelemon.com', '$40,000'),
	(6, 'John Millar', 'Receptionist', '245 Dill Square, Lincoln Park, Chicago, IL', 351584508, 'John.m@littlelemon.com', '$35,000');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;

-- Volcando estructura para procedimiento little_lemon_db.GuestStatus
DELIMITER //
CREATE PROCEDURE `GuestStatus`()
BEGIN
	SELECT 
		CONCAT(b.GuestFirstName," ",b.GuestLastName) Nombre,
		case 
			when u.Role = "Manager" OR u.Role = "Assistant Manager" then "Ready to pay" 
			when u.Role = "Head Chef" then "Ready to serve"
			when u.Role = "Assistant Chef" then "Preparing Order"
			when u.Role = "Head Waiter" then "Order served" 
		END status_booking
	FROM employees u LEFT JOIN bookings b ON 
	u.EmployeeID = b.EmployeeID;
END//
DELIMITER ;

-- Volcando estructura para tabla little_lemon_db.menuitems
CREATE TABLE IF NOT EXISTS `menuitems` (
  `ItemID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) DEFAULT NULL,
  `Type` varchar(100) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL,
  PRIMARY KEY (`ItemID`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla little_lemon_db.menuitems: 17 rows
/*!40000 ALTER TABLE `menuitems` DISABLE KEYS */;
INSERT INTO `menuitems` (`ItemID`, `Name`, `Type`, `Price`) VALUES
	(1, 'Olives', 'Starters', 5),
	(2, 'Flatbread', 'Starters', 5),
	(3, 'Minestrone', 'Starters', 8),
	(4, 'Tomato bread', 'Starters', 8),
	(5, 'Falafel', 'Starters', 7),
	(6, 'Hummus', 'Starters', 5),
	(7, 'Greek salad', 'Main Courses', 15),
	(8, 'Bean soup', 'Main Courses', 12),
	(9, 'Pizza', 'Main Courses', 15),
	(10, 'Greek yoghurt', 'Desserts', 7),
	(11, 'Ice cream', 'Desserts', 6),
	(12, 'Cheesecake', 'Desserts', 4),
	(13, 'Athens White wine', 'Drinks', 25),
	(14, 'Corfu Red Wine', 'Drinks', 30),
	(15, 'Turkish Coffee', 'Drinks', 10),
	(16, 'Turkish Coffee', 'Drinks', 10),
	(17, 'Kabasa', 'Main Courses', 17);
/*!40000 ALTER TABLE `menuitems` ENABLE KEYS */;

-- Volcando estructura para tabla little_lemon_db.menus
CREATE TABLE IF NOT EXISTS `menus` (
  `MenuID` int(11) NOT NULL,
  `ItemID` int(11) NOT NULL,
  `Cuisine` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`MenuID`,`ItemID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla little_lemon_db.menus: 12 rows
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` (`MenuID`, `ItemID`, `Cuisine`) VALUES
	(1, 1, 'Greek'),
	(1, 7, 'Greek'),
	(1, 10, 'Greek'),
	(1, 13, 'Greek'),
	(2, 3, 'Italian'),
	(2, 9, 'Italian'),
	(2, 12, 'Italian'),
	(2, 15, 'Italian'),
	(3, 5, 'Turkish'),
	(3, 17, 'Turkish'),
	(3, 11, 'Turkish'),
	(3, 16, 'Turkish');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;

-- Volcando estructura para tabla little_lemon_db.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `OrderID` int(11) NOT NULL,
  `TableNo` int(11) NOT NULL,
  `MenuID` int(11) DEFAULT NULL,
  `BookingID` int(11) DEFAULT NULL,
  `BillAmount` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`OrderID`,`TableNo`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla little_lemon_db.orders: 5 rows
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`OrderID`, `TableNo`, `MenuID`, `BookingID`, `BillAmount`, `Quantity`) VALUES
	(1, 12, 1, 1, 86, 2),
	(2, 19, 2, 2, 37, 1),
	(3, 15, 2, 3, 37, 1),
	(4, 5, 3, 4, 40, 1),
	(5, 8, 1, 5, 43, 1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Volcando estructura para procedimiento little_lemon_db.PeakHours
DELIMITER //
CREATE PROCEDURE `PeakHours`()
BEGIN
			select 
				hour(BookingSlot) hour_number,
				COUNT(*) number_of_bookings
			from bookings 
			group by hour(BookingSlot) 
			ORDER by hour(BookingSlot);
		END//
DELIMITER ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
