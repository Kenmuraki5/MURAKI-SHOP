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
  FOREIGN KEY (`isbn`) REFERENCES `Book`(`isbn`), 
  FOREIGN KEY (`author_id`) REFERENCES `Author`(`author_id`)
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
  FOREIGN KEY (`genre_id`) REFERENCES `genres`(`genre_id`), 
  FOREIGN KEY (`isbn`) REFERENCES `Book`(`isbn`)
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
  FOREIGN KEY (`customer_id`) REFERENCES `Customer`(`customer_id`), 
  FOREIGN KEY (`shipping_id`) REFERENCES `Shipping_Method`(`shipping_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `Order_Line`;

CREATE TABLE `Order_Line` (
  `line_id` INT AUTO_INCREMENT,
  `order_id` INT(6) ,
  `isbn` VARCHAR(13),
  `quantity` INT,
  `price` DOUBLE NOT NULL,
  PRIMARY KEY (`line_id`),
  FOREIGN KEY (`order_id`) REFERENCES `Cust_Order`(`order_id`),
  FOREIGN KEY (`isbn`) REFERENCES `Book`(`isbn`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `Payment`;

CREATE TABLE `Payment`(
	`payment_id` INT(6) NOT NULL AUTO_INCREMENT,
	`order_id` INT(6) NOT NULL,
    `payment_status` ENUM("success", "pending", "cancel") NOT NULL,
    `slip_img` VARCHAR(200) NOT NULL,
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (`order_id`) REFERENCES `Cust_Order`(`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
INSERT INTO `Publisher` (`publisher_name`) VALUES ('Siam Inter Comics'), ('Bongkoch Publishing');

-- Insert data into Book table
INSERT INTO `Book` (`isbn`, `book_name`, `book_description`, `book_price`, `book_category`, `publisher_id`, `publisher_date`, `book_img`, `in_stock`)
VALUES 
('9789742454312', 'One Piece Vol. 1', 'The first volume of the popular Japanese manga series One Piece.', 119.00, 'manga', 1, '1997-07-22', 'one_piece_vol1.jpg', 50),
('9786169265061', 'My Hero Academia Vol. 1', 'The first volume of the popular Japanese manga series My Hero Academia.', 99.00, 'manga', 1, '2014-07-07', 'my_hero_academia_vol1.jpg', 30),
('9786169953203', 'Alice in Borderland Vol. 1', 'The first volume of the Japanese manga series Alice in Borderland.', 109.00, 'novel', 2, '2010-11-25', 'alice_in_borderland_vol1.jpg', 20);

-- Insert data into Author table
INSERT INTO `Author` (`author_name`, `author_alias`) VALUES ('Eiichiro Oda', 'Oda-sensei'), ('Kohei Horikoshi', 'Horikoshi-sensei'), ('Haro Aso', 'Aso-sensei');

-- Insert data into Book_Author table
INSERT INTO `Book_Author` (`isbn`, `author_id`) VALUES 
('9789742454312', 1),
('9786169265061', 2),
('9786169953203', 3),
('9786169953203', 1);

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
('9786169953203', 3);

-- Insert data into Shipping_Method table
INSERT INTO `Shipping_Method` (`shipping_name`, `cost`) VALUES ('Standard Shipping', 35.00), ('Express Shipping', 60.00);

-- Insert data into Customer table
INSERT INTO `Customer` (`c_username`, `c_password`, `c_first_name`, `c_last_name`, `c_address`, `c_email`, `c_phone`, `c_image`)
VALUES 
('johndoe', 'password123', 'John', 'Doe', '123 Main Street, Bangkok, Thailand', 'johndoe@email.com', '0891234567', 'john_doe.jpg'),
('janedoe', 'password456', 'Jane', 'Doe', '456 Second Avenue, Bangkok, Thailand', 'janedoe@email.com', '0827654321', 'jane_doe.jpg');

-- Insert data into Cust_Order table
INSERT INTO Cust_Order (order_date, customer_id, shipping_id, address, total_price, status_value) VALUES
('2023-04-07 12:30:00', 1, 1, '123 Main Street, Bangkok', 500.00, 'shipping'),
('2023-04-07 13:15:00', 2, 2, '456 Main Street, Chiang Mai', 700.00, 'pending'),
('2023-04-07 14:00:00', 3, 3, '789 Main Street, Phuket', 900.00, 'success');

-- Insert data into Order_Line table
INSERT INTO Order_Line (order_id, isbn, quantity, price) VALUES
(1, '9789742454312', 1, 119.00),
(1, '9786169265061', 2, 198.00),
(2, '9789742454312', 1, 119.00),
(2, '9786169265061', 1, 99.00),
(2, '9786169953203', 1, 109.00),
(3, '9789742454312', 3, 327.00),
(3, '9786169265061', 1, 99.00),
(3, '9786169953203', 2, 218.00);

-- Insert data into Payment table
INSERT INTO Payment (order_id, payment_status, slip_img) VALUES
(1, 'pending', 'https://example.com/slip1.jpg'),
(2, 'cancel', 'https://example.com/slip2.jpg'),
(3, 'success', 'https://example.com/slip3.jpg');

-- Insert data into Admin table
insert into `Admin` (`a_username`,`a_password`,`a_first_name`,`a_last_name`,`a_email`,`a_phone`) values
("admin",'password','ad','min',"@mail","0878888888");
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;