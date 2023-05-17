/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `Publisher`;

CREATE TABLE `Publisher` (
  `publisher_id` INT(10) AUTO_INCREMENT,
  `publisher_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`publisher_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `Book`;

CREATE TABLE `Book` (
  `isbn` VARCHAR(13),
  `book_name` VARCHAR(255) NOT NULL,
  `book_description` TEXT NOT NULL,
  `book_price` DOUBLE NOT NULL,
  `book_category` ENUM("manga","novel") NOT NULL,
  `publisher_id` INT(10) NOT NULL,
  `publisher_date` DATE NOT NULL,
  `book_img` VARCHAR(200) NOT NULL,
  `in_stock` INT NOT NULL,
  PRIMARY KEY (`isbn`),
  FOREIGN KEY (`publisher_id`) REFERENCES `Publisher`(`publisher_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `Author`;

CREATE TABLE `Author` (
  `author_id` INT(5) AUTO_INCREMENT,
  `author_name` VARCHAR(255) NOT NULL,
  `author_alias` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`author_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `Book_Author`;

CREATE TABLE `Book_Author` (
  `isbn` VARCHAR(13),
  `author_id` INT(5),
  PRIMARY KEY (`isbn`, `author_id`),
  FOREIGN KEY (`isbn`) REFERENCES `Book`(`isbn`) on delete cascade on update cascade, 
  FOREIGN KEY (`author_id`) REFERENCES `Author`(`author_id`) on delete cascade on update cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `genres`;

CREATE TABLE `genres` (
  `genre_id` INT AUTO_INCREMENT,
  `genre` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`genre_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `book_genres`;

CREATE TABLE `book_genres` (
  `isbn` VARCHAR(13),
  `genre_id` INT,
  PRIMARY KEY (`isbn`, `genre_id`),
  FOREIGN KEY (`genre_id`) REFERENCES `genres`(`genre_id`) on delete cascade on update cascade, 
  FOREIGN KEY (`isbn`) REFERENCES `Book`(`isbn`) on delete cascade on update cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `Shipping_Method`;

CREATE TABLE `Shipping_Method` (
  `shipping_id` INT(10) AUTO_INCREMENT,
  `shipping_name` VARCHAR(255) NOT NULL,
  `cost` DOUBLE NOT NULL,
  PRIMARY KEY (`shipping_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `Customer`;

CREATE TABLE `Customer` (
  `customer_id` INT(20) AUTO_INCREMENT,
  `c_username` VARCHAR(255) NOT NULL,
  `c_password` VARCHAR(255) NOT NULL,
  `c_first_name` VARCHAR(255) NOT NULL,
  `c_last_name` VARCHAR(255) NOT NULL,
  `c_address` TEXT NOT NULL,
  `c_email` VARCHAR(255) NOT NULL,
  `c_phone` CHAR(10) NOT NULL,
  `c_image` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`customer_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `Cust_Order`;

CREATE TABLE `Cust_Order` (
  `order_id` INT(6) NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NOT NULL,
  `customer_id` INT(20) NOT NULL,
  `shipping_id` INT(10) NOT NULL,
  `address` TEXT NOT NULL,
  `total_price` DOUBLE NOT NULL,
  `status_value` ENUM("success", "shipping", "pending", "cancel") NOT NULL,
  PRIMARY KEY (`order_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`customer_id`) on delete cascade on update cascade, 
  FOREIGN KEY (`shipping_id`) REFERENCES `Shipping_Method`(`shipping_id`) on delete cascade on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `Order_Line`;

CREATE TABLE `Order_Line` (
  `line_id` INT AUTO_INCREMENT,
  `order_id` INT(6) ,
  `isbn` VARCHAR(13),
  `quantity` INT,
  `price` DOUBLE NOT NULL,
  PRIMARY KEY (`line_id`),
  FOREIGN KEY (`order_id`) REFERENCES `Cust_Order`(`order_id`) on delete cascade on update cascade,
  FOREIGN KEY (`isbn`) REFERENCES `Book`(`isbn`) on delete cascade on update cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `Payment`;

CREATE TABLE `Payment`(
	`payment_id` INT(6) NOT NULL AUTO_INCREMENT,
	`order_id` INT(6) NOT NULL,
    `payment_status` ENUM("success", "pending", "cancel") NOT NULL,
    `slip_img` VARCHAR(200) NOT NULL,
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (`order_id`) REFERENCES `Cust_Order`(`order_id`) on delete cascade on update cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `comment_id` INT(40) AUTO_INCREMENT,
  `isbn` VARCHAR(13),
  `customer_id` INT(20),
  `comment` TEXT NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  FOREIGN KEY (`isbn`) REFERENCES `Book`(`isbn`) on delete cascade on update cascade,
  FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`customer_id`) on delete cascade on update cascade
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `Admin`;

CREATE TABLE `Admin` (
  `admin_id` INT(20) NOT NULL AUTO_INCREMENT,
  `a_username` VARCHAR(255) NOT NULL,
  `a_password` VARCHAR(255) NOT NULL,
  `a_first_name` VARCHAR(255) NOT NULL,
  `a_last_name` VARCHAR(255) NOT NULL,
  `a_address` TEXT NOT NULL,
  `a_email` VARCHAR(255) NOT NULL,
  `a_phone` CHAR(10) NOT NULL,
  `a_image` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`admin_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

-- Insert data into Publisher table
INSERT INTO `Publisher` (`publisher_name`) VALUES 
('Siam Inter Comics'), 
('Bongkoch Publishing');

-- Insert data into Book table
INSERT INTO `Book` (`isbn`, `book_name`, `book_description`, `book_price`, `book_category`, `publisher_id`, `publisher_date`, `book_img`, `in_stock`)
VALUES 
('9786169265061', 'My Hero Academia Vol. 1', 'The first volume of the popular Japanese manga series My Hero Academia.', 99, 'manga', 1, '2014-07-07', 'my_hero_academia_vol1.jpg', 30),
('9786169953203', 'Alice in Borderland Vol. 1', 'The first volume of the Japanese manga series Alice in Borderland.', 109, 'manga', 2, '2010-11-25', 'alice_in_borderland_vol1.jpg', 20),
('9789742454312', 'One Piece Vol. 1', 'The first volume of the popular Japanese manga series One Piece.', 119, 'manga', 1, '1997-07-22', 'one_piece_vol1.jpg', 50),
('9786169265001', 'Attack on Titan Vol. 1', 'The first volume of the popular Japanese manga series Attack on Titan.', 99, 'manga', 1, '2010-03-17', 'attack_on_titan_vol1.jpg', 10),
('9786169953302', 'Tokyo Ghoul Vol. 1', 'The first volume of the Japanese manga series Tokyo Ghoul.', 89, 'manga', 3, '2011-09-17', 'tokyo_ghoul_vol1.jpg', 15),
('9789742454329', 'Naruto Vol. 1', 'The first volume of the popular Japanese manga series Naruto.', 99, 'manga', 2, '1999-09-21', 'naruto_vol1.jpg', 25),
('9786169265078', 'Demon Slayer Vol. 1', 'The first volume of the Japanese manga series Demon Slayer.', 109, 'manga', 3, '2016-02-15', 'demon_slayer_vol1.jpg', 18),
('9786169953227', 'The Promised Neverland Vol. 1', 'The first volume of the Japanese manga series The Promised Neverland.', 99, 'manga', 2, '2016-08-04', 'the_promised_neverland_vol1.jpg', 22),
('9786161023708', 'Spice and Wolf Vol. 1', 'The first volume of the Spice and Wolf light novel series.', 250, 'novel', 1, '2007-01-20', 'spice_and_wolf_vol1.jpg', 10),
('9786161023616', 'Sword Art Online Vol. 1', 'The first volume of the Sword Art Online light novel series.', 300, 'novel', 1, '2009-04-10', 'sword_art_online_vol1.jpg', 8),
('9786161023807', 'Overlord Vol. 1', 'The first volume of the Overlord light novel series.', 280, 'novel', 1, '2012-07-30', 'overlord_vol1.jpg', 5),
('9786161023951', 'Re:Zero Vol. 1', 'The first volume of the Re:Zero light novel series.', 320, 'novel', 1, '2014-01-25', 're_zero_vol1.jpg', 12),
('9786161023777', 'No Game No Life Vol. 1', 'The first volume of the No Game No Life light novel series.', 290, 'novel', 1, '2012-04-25', 'no_game_no_life_vol1.jpg', 6),
('9786161023890', 'The Irregular at Magic High School Vol. 1', 'The first volume of The Irregular at Magic High School light novel series.', 270, 'novel', 2, '2011-07-08', 'irregular_at_magic_high_school_vol1.jpg', 9),
('9786161023968', 'Konosuba: God\'s Blessing on This Wonderful World! Vol. 1', 'The first volume of the Konosuba: God\'s Blessing on This Wonderful World! light novel series.', 300, 'novel', 2, '2013-10-01', 'konosuba_vol1.jpg', 7),
('9786161023891', 'The Rising of the Shield Hero Vol. 1', 'The first volume of The Rising of the Shield Hero light novel series.', 280, 'novel', 2, '2013-08-25', 'rising_of_the_shield_hero_vol1.jpg', 11);

-- Insert data into Author table
INSERT INTO `Author` (`author_name`, `author_alias`) VALUES 
('Eiichiro Oda', 'Oda-sensei'), 
('Kohei Horikoshi', 'Horikoshi-sensei'), 
('Haro Aso', 'Aso-sensei'), 
('Hajime Isayama','Isayama-sensei'),
('Kishimoto Masashi','Masashi-sensei'),
('Ishida Sui','Sui-sensei'),
('Gotouge Koyoharu','Koyoharu-sensei'),
('Shirai Kaiu','Kaiu-sensei'),
('Isuna Hasekura','Hasekura-sensei'),
('Reki Kawahara','Kawahara-sensei'),
('Kugane Maruyama','Maruyama-sensei'),
('Tappei Nagatsuki','Nagatsuki-sensei'),
('Yu Kamiya','Kamiya-sensei'),
('Tsutomu Sato','Sato-sensei'),
('Natsume Akatsuki','Akatsuki-sensei'),
('Aneko Yusagi','Yusagi-sensei');

-- Insert data into Book_Author table
INSERT INTO `Book_Author` (`isbn`, `author_id`) VALUES 
('9789742454312', 1),
('9786169265061', 2),
('9786169953203', 3),
('9786169265001', 4),
('9789742454329', 5),
('9786169953302', 6),
('9786169265078', 7),
('9786169953227', 8),
('9786161023708', 9),
('9786161023616', 10),
('9786161023807', 11),
('9786161023951', 12),
('9786161023777', 13),
('9786161023890', 14),
('9786161023968', 15),
('9786161023891', 16);


-- Insert data into genres table
INSERT INTO `genres` (`genre`) VALUES ('Action'), ('Comedy'), ('Drama'), ('Harem')
, ('Mystery'), ('Romance'), ('Sport');

-- Insert data into book_genres table
INSERT INTO `book_genres` (`isbn`, `genre_id`) VALUES 
('9789742454312', 1),
('9789742454312', 2),
('9786169265061', 1),
('9786169265061', 2),
('9786169953203', 1),
('9786169953203', 3),
('9786169265001', 1),
('9786169265001', 3),
('9786169953302', 1),
('9786169953302', 6),
('9789742454329', 1),
('9789742454329', 2),
('9786169265078', 1),
('9786169953227', 3),
('9786169953227', 5),
('9786161023708', 3),
('9786161023708', 6),
('9786161023616', 1),
('9786161023616', 4),
('9786161023807', 1),
('9786161023807', 2),
('9786161023951', 2),
('9786161023951', 5),
('9786161023777', 2),
('9786161023890', 1),
('9786161023890', 6),
('9786161023968', 2),
('9786161023891', 1),
('9786161023891', 3);

-- Insert data into Shipping_Method table
INSERT INTO `Shipping_Method` (`shipping_name`, `cost`) VALUES ('Standard Shipping', 35.00), ('Express Shipping', 60.00);

-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Apr 23, 2023 at 08:35 AM
-- Server version: 5.7.39
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `MURAKI_COMIC`
--

-- --------------------------------------------------------

--
-- Table structure for table `tokens_a`
--
DROP TABLE IF EXISTS `tokens_a`;

CREATE TABLE `tokens_a` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(20) NOT NULL,
  `token` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tokens_a`
--
--
-- Indexes for dumped tables
--

--
-- Indexes for table `tokens_a`
--
ALTER TABLE `tokens_a`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tokens_a_UN` (`token`) USING BTREE,
  ADD KEY `token_a_FK` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tokens_a`
--
ALTER TABLE `tokens_a`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
COMMIT;
ALTER TABLE `tokens_a`
  ADD FOREIGN KEY (`user_id`) REFERENCES `Admin` (`admin_id`) ON DELETE CASCADE;
COMMIT;


DROP TABLE IF EXISTS `tokens_c`;

CREATE TABLE `tokens_c` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(20) NOT NULL,
  `token` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tokens_c`
--
ALTER TABLE `tokens_c`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tokens_c_UN` (`token`) USING BTREE,
  ADD KEY `token_c_FK` (`user_id`) USING BTREE;

ALTER TABLE `tokens_c`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `tokens_c`
  ADD FOREIGN KEY (`user_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE;
COMMIT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
