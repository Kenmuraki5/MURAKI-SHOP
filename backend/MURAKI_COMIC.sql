-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Apr 22, 2023 at 11:21 PM
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
-- Table structure for table `Admin`
--

CREATE TABLE `Admin` (
  `admin_id` int(20) NOT NULL,
  `a_username` varchar(255) NOT NULL,
  `a_password` varchar(255) NOT NULL,
  `a_first_name` varchar(255) NOT NULL,
  `a_last_name` varchar(255) NOT NULL,
  `a_address` text NOT NULL,
  `a_email` varchar(255) NOT NULL,
  `a_phone` char(10) NOT NULL,
  `a_image` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Admin`
--

INSERT INTO `Admin` (`admin_id`, `a_username`, `a_password`, `a_first_name`, `a_last_name`, `a_address`, `a_email`, `a_phone`, `a_image`) VALUES
(1, 'admin', '$argon2id$v=19$m=65536,t=3,p=4$ZE8IOFbjDnBFYGj0inkJyw$7JHJjZdwxv2lZ4Krk2AucICLl7KJ9esUSatbhgPCV7U', 'ad', 'min', '', '@mail', '0878888888', '');

-- --------------------------------------------------------

--
-- Table structure for table `Author`
--

CREATE TABLE `Author` (
  `author_id` int(5) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `author_alias` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Author`
--

INSERT INTO `Author` (`author_id`, `author_name`, `author_alias`) VALUES
(1, 'Eiichiro Oda', 'Oda-sensei'),
(2, 'Kohei Horikoshi', 'Horikoshi-sensei'),
(3, 'Haro Aso', 'Aso-sensei');

-- --------------------------------------------------------

--
-- Table structure for table `Book`
--

CREATE TABLE `Book` (
  `isbn` varchar(13) NOT NULL,
  `book_name` varchar(255) NOT NULL,
  `book_description` text NOT NULL,
  `book_price` double NOT NULL,
  `book_category` enum('manga','novel') NOT NULL,
  `publisher_id` int(10) NOT NULL,
  `publisher_date` date NOT NULL,
  `book_img` varchar(200) NOT NULL,
  `in_stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Book`
--

INSERT INTO `Book` (`isbn`, `book_name`, `book_description`, `book_price`, `book_category`, `publisher_id`, `publisher_date`, `book_img`, `in_stock`) VALUES
('9786169265061', 'My Hero Academia Vol. 1', 'The first volume of the popular Japanese manga series My Hero Academia.', 99, 'manga', 1, '2014-07-07', 'my_hero_academia_vol1.jpg', 30),
('9786169953203', 'Alice in Borderland Vol. 1', 'The first volume of the Japanese manga series Alice in Borderland.', 109, 'novel', 2, '2010-11-25', 'alice_in_borderland_vol1.jpg', 20),
('9789742454312', 'One Piece Vol. 1', 'The first volume of the popular Japanese manga series One Piece.', 119, 'manga', 1, '1997-07-22', 'one_piece_vol1.jpg', 50);

-- --------------------------------------------------------

--
-- Table structure for table `Books`
--

CREATE TABLE `Books` (
  `isbn` varchar(13) NOT NULL,
  `book_name` varchar(100) DEFAULT NULL,
  `book_img` varchar(100) DEFAULT NULL,
  `book_desc` varchar(100) DEFAULT NULL,
  `publishered_date` date DEFAULT NULL,
  `publisher_id` int(11) DEFAULT NULL,
  `book_stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Book_Author`
--

CREATE TABLE `Book_Author` (
  `isbn` varchar(13) NOT NULL,
  `author_id` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Book_Author`
--

INSERT INTO `Book_Author` (`isbn`, `author_id`) VALUES
('9789742454312', 1),
('9786169265061', 2),
('9786169953203', 3);

-- --------------------------------------------------------

--
-- Table structure for table `book_genres`
--

CREATE TABLE `book_genres` (
  `isbn` varchar(13) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `book_genres`
--

INSERT INTO `book_genres` (`isbn`, `genre_id`) VALUES
('9786169265061', 1),
('9786169953203', 1),
('9789742454312', 1),
('9786169265061', 2),
('9789742454312', 2),
('9786169953203', 3);

-- --------------------------------------------------------

--
-- Table structure for table `Book_order`
--

CREATE TABLE `Book_order` (
  `order_id` varchar(6) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `date_of_borrow` date DEFAULT NULL,
  `end_of_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Book_order_line`
--

CREATE TABLE `Book_order_line` (
  `order_line_id` int(11) NOT NULL,
  `order_id` varchar(6) DEFAULT NULL,
  `isbn` varchar(13) DEFAULT NULL,
  `status` enum('Borrowed','Returned') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Book_possession`
--

CREATE TABLE `Book_possession` (
  `customer_id` int(11) DEFAULT NULL,
  `isbn` varchar(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Book_type`
--

CREATE TABLE `Book_type` (
  `isbn` varchar(13) NOT NULL,
  `Type_id` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(40) NOT NULL,
  `isbn` varchar(13) DEFAULT NULL,
  `customer_id` int(20) DEFAULT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `isbn`, `customer_id`, `comment`, `created_at`) VALUES
(1, '9786169265061', 1, 'hello', '2023-04-17 18:23:30'),
(2, '9786169265061', 1, 'youngohm', '2023-04-17 18:23:41'),
(3, '9786169953203', 1, 'hello', '2023-04-17 19:03:33'),
(4, '9786169953203', NULL, 'I love it', '2023-04-22 22:42:26'),
(5, '9786169953203', 5, 'hello', '2023-04-22 22:45:55');

-- --------------------------------------------------------

--
-- Table structure for table `Customer`
--

CREATE TABLE `Customer` (
  `customer_id` int(20) NOT NULL,
  `c_username` varchar(255) NOT NULL,
  `c_password` varchar(255) NOT NULL,
  `c_first_name` varchar(255) NOT NULL,
  `c_last_name` varchar(255) NOT NULL,
  `c_address` text NOT NULL,
  `c_email` varchar(255) NOT NULL,
  `c_phone` char(10) NOT NULL,
  `c_image` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Customer`
--

INSERT INTO `Customer` (`customer_id`, `c_username`, `c_password`, `c_first_name`, `c_last_name`, `c_address`, `c_email`, `c_phone`, `c_image`) VALUES
(1, 'johndoe', 'password123', 'John', 'Doe', '123 Main Street, Bangkok, Thailand', 'johndoe@email.com', '0891234567', 'youngohm.jpeg'),
(2, 'janedoe', 'password456', 'Jane', 'Doe', '456 Second Avenue, Bangkok, Thailand', 'janedoe@email.com', '0827654321', 'jane_doe.jpg'),
(3, 'kenmuralo', '$argon2id$v=19$m=65536,t=3,p=4$AIULtStDfLbbXjmZkmNbCQ$/q4k5KhwpRO4UQDkm15/FHWZ5tnaeA7/u9O/UdtNGok', 'qere', 'adfdf', 'adfdf', 'ere@gmail.com', '0987654321', ''),
(4, 'Kenmuraki2345', '$argon2id$v=19$m=65536,t=3,p=4$MMWvCk/DENlwKKtJIaWaJw$86il/dsllGSZ4wZhfC/ucc14W+BHwXIkjEeo1UWaG4c', 'ken', 'muraki', 'hello123456789', 'miraki@gmail.com', '0987654321', ''),
(5, 'hello123ken', '$argon2id$v=19$m=65536,t=3,p=4$ZE8IOFbjDnBFYGj0inkJyw$7JHJjZdwxv2lZ4Krk2AucICLl7KJ9esUSatbhgPCV7U', 'Yusuke', 'Urameshi', 'tokyo', 'Urameshi@gmail.com', '0987654321', 'yusuke.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `Cust_Order`
--

CREATE TABLE `Cust_Order` (
  `order_id` int(6) NOT NULL,
  `order_date` datetime NOT NULL,
  `customer_id` int(20) NOT NULL,
  `shipping_id` int(10) NOT NULL,
  `address` text NOT NULL,
  `total_price` double NOT NULL,
  `status_value` enum('success','shipping','pending','cancel') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Cust_Order`
--

INSERT INTO `Cust_Order` (`order_id`, `order_date`, `customer_id`, `shipping_id`, `address`, `total_price`, `status_value`) VALUES
(1, '2023-04-07 12:30:00', 1, 1, '123 Main Street, Bangkok', 500, 'shipping'),
(2, '2023-04-07 13:15:00', 2, 2, '456 Main Street, Chiang Mai', 700, 'pending'),
(3, '2023-04-07 14:00:00', 3, 3, '789 Main Street, Phuket', 900, 'success');

-- --------------------------------------------------------

--
-- Table structure for table `generes`
--

CREATE TABLE `generes` (
  `genre_id` int(11) NOT NULL,
  `genre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `generes`
--

INSERT INTO `generes` (`genre_id`, `genre`) VALUES
(1, 'Action'),
(2, 'Adventure'),
(3, 'Mystery'),
(4, 'Horror');

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `genre_id` int(11) NOT NULL,
  `genre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`genre_id`, `genre`) VALUES
(1, 'Action'),
(2, 'Comedy'),
(3, 'Drama'),
(4, 'Harem'),
(5, 'Mystery'),
(6, 'Romance'),
(7, 'Sport');

-- --------------------------------------------------------

--
-- Table structure for table `Order_Line`
--

CREATE TABLE `Order_Line` (
  `line_id` int(11) NOT NULL,
  `order_id` int(6) DEFAULT NULL,
  `isbn` varchar(13) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Order_Line`
--

INSERT INTO `Order_Line` (`line_id`, `order_id`, `isbn`, `quantity`, `price`) VALUES
(1, 1, '9789742454312', 1, 119),
(2, 1, '9786169265061', 2, 198),
(3, 2, '9789742454312', 1, 119),
(4, 2, '9786169265061', 1, 99),
(5, 2, '9786169953203', 1, 109),
(6, 3, '9789742454312', 3, 327),
(7, 3, '9786169265061', 1, 99),
(8, 3, '9786169953203', 2, 218);

-- --------------------------------------------------------

--
-- Table structure for table `Payment`
--

CREATE TABLE `Payment` (
  `payment_id` int(6) NOT NULL,
  `order_id` int(6) NOT NULL,
  `payment_status` enum('success','pending','cancel') NOT NULL,
  `slip_img` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Payment`
--

INSERT INTO `Payment` (`payment_id`, `order_id`, `payment_status`, `slip_img`) VALUES
(1, 1, 'pending', 'https://example.com/slip1.jpg'),
(2, 2, 'cancel', 'https://example.com/slip2.jpg'),
(3, 3, 'success', 'https://example.com/slip3.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `Publisher`
--

CREATE TABLE `Publisher` (
  `publisher_id` int(10) NOT NULL,
  `publisher_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Publisher`
--

INSERT INTO `Publisher` (`publisher_id`, `publisher_name`) VALUES
(1, 'Siam Inter Comics'),
(2, 'Bongkoch Publishing');

-- --------------------------------------------------------

--
-- Table structure for table `Shipping_Method`
--

CREATE TABLE `Shipping_Method` (
  `shipping_id` int(10) NOT NULL,
  `shipping_name` varchar(255) NOT NULL,
  `cost` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Shipping_Method`
--

INSERT INTO `Shipping_Method` (`shipping_id`, `shipping_name`, `cost`) VALUES
(1, 'Standard Shipping', 35),
(2, 'Express Shipping', 60);

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(20) NOT NULL,
  `token` varchar(700) NOT NULL,
  `role` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tokens`
--

INSERT INTO `tokens` (`id`, `user_id`, `token`, `role`) VALUES
(8, 5, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXN0b21lcl9pZCI6NSwiY191c2VybmFtZSI6ImhlbGxvMTIza2VuIiwiY19wYXNzd29yZCI6IiRhcmdvbjJpZCR2PTE5JG09NjU1MzYsdD0zLHA9NCRaRThJT0ZiakRuQkZZR2owaW5rSnl3JDdKSEpqWmR3eHYybFo0S3JrMkF1Y0lDTGw3S0o5ZXNVU2F0YmhnUENWN1UiLCJjX2ZpcnN0X25hbWUiOiJZdXN1a2UiLCJjX2xhc3RfbmFtZSI6IlVyYW1lc2hpIiwiY19hZGRyZXNzIjoidG9reW8iLCJjX2VtYWlsIjoiVXJhbWVzaGlAZ21haWwuY29tIiwiY19waG9uZSI6IjA5ODc2NTQzMjEiLCJjX2ltYWdlIjoieXVzdWtlLmpwZWciLCJ0eXBlIjoiY3VzdG9tZXIiLCJpYXQiOjE2ODIyMDMzMjJ9.dQVAhMC5-ML8Sey3r5Orkn8222XzzC5sZRYNW60k07E', 'customer');

-- --------------------------------------------------------

--
-- Table structure for table `Type`
--

CREATE TABLE `Type` (
  `Type_id` char(3) NOT NULL,
  `book_type` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `Author`
--
ALTER TABLE `Author`
  ADD PRIMARY KEY (`author_id`);

--
-- Indexes for table `Book`
--
ALTER TABLE `Book`
  ADD PRIMARY KEY (`isbn`),
  ADD KEY `publisher_id` (`publisher_id`);

--
-- Indexes for table `Books`
--
ALTER TABLE `Books`
  ADD PRIMARY KEY (`isbn`),
  ADD KEY `NN` (`book_name`,`book_desc`,`book_stock`);

--
-- Indexes for table `Book_Author`
--
ALTER TABLE `Book_Author`
  ADD PRIMARY KEY (`isbn`,`author_id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `book_genres`
--
ALTER TABLE `book_genres`
  ADD PRIMARY KEY (`isbn`,`genre_id`),
  ADD KEY `genre_id` (`genre_id`);

--
-- Indexes for table `Book_order`
--
ALTER TABLE `Book_order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `NN` (`date_of_borrow`,`end_of_date`);

--
-- Indexes for table `Book_order_line`
--
ALTER TABLE `Book_order_line`
  ADD PRIMARY KEY (`order_line_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `isbn` (`isbn`),
  ADD KEY `NN` (`status`);

--
-- Indexes for table `Book_possession`
--
ALTER TABLE `Book_possession`
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `isbn` (`isbn`);

--
-- Indexes for table `Book_type`
--
ALTER TABLE `Book_type`
  ADD PRIMARY KEY (`isbn`,`Type_id`),
  ADD KEY `Type_id` (`Type_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `isbn` (`isbn`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `Customer`
--
ALTER TABLE `Customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `Cust_Order`
--
ALTER TABLE `Cust_Order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `shipping_id` (`shipping_id`);

--
-- Indexes for table `generes`
--
ALTER TABLE `generes`
  ADD PRIMARY KEY (`genre_id`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`genre_id`);

--
-- Indexes for table `Order_Line`
--
ALTER TABLE `Order_Line`
  ADD PRIMARY KEY (`line_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `isbn` (`isbn`);

--
-- Indexes for table `Payment`
--
ALTER TABLE `Payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `Publisher`
--
ALTER TABLE `Publisher`
  ADD PRIMARY KEY (`publisher_id`);

--
-- Indexes for table `Shipping_Method`
--
ALTER TABLE `Shipping_Method`
  ADD PRIMARY KEY (`shipping_id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tokens_UN` (`token`),
  ADD KEY `token_FK` (`user_id`);

--
-- Indexes for table `Type`
--
ALTER TABLE `Type`
  ADD PRIMARY KEY (`Type_id`),
  ADD KEY `UNIQUE` (`book_type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Admin`
--
ALTER TABLE `Admin`
  MODIFY `admin_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Author`
--
ALTER TABLE `Author`
  MODIFY `author_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(40) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Customer`
--
ALTER TABLE `Customer`
  MODIFY `customer_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Cust_Order`
--
ALTER TABLE `Cust_Order`
  MODIFY `order_id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `generes`
--
ALTER TABLE `generes`
  MODIFY `genre_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `genre_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Order_Line`
--
ALTER TABLE `Order_Line`
  MODIFY `line_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `Payment`
--
ALTER TABLE `Payment`
  MODIFY `payment_id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Publisher`
--
ALTER TABLE `Publisher`
  MODIFY `publisher_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Shipping_Method`
--
ALTER TABLE `Shipping_Method`
  MODIFY `shipping_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Book`
--
ALTER TABLE `Book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `Publisher` (`publisher_id`);

--
-- Constraints for table `Book_Author`
--
ALTER TABLE `Book_Author`
  ADD CONSTRAINT `book_author_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `Book` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `book_author_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `Author` (`author_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `book_genres`
--
ALTER TABLE `book_genres`
  ADD CONSTRAINT `book_genres_ibfk_1` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `book_genres_ibfk_2` FOREIGN KEY (`isbn`) REFERENCES `Book` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Book_order`
--
ALTER TABLE `Book_order`
  ADD CONSTRAINT `book_order_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Book_order_line`
--
ALTER TABLE `Book_order_line`
  ADD CONSTRAINT `book_order_line_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Book_order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `book_order_line_ibfk_2` FOREIGN KEY (`isbn`) REFERENCES `Books` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Book_possession`
--
ALTER TABLE `Book_possession`
  ADD CONSTRAINT `book_possession_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `book_possession_ibfk_2` FOREIGN KEY (`isbn`) REFERENCES `Books` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Book_type`
--
ALTER TABLE `Book_type`
  ADD CONSTRAINT `book_type_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `Books` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `book_type_ibfk_2` FOREIGN KEY (`Type_id`) REFERENCES `Type` (`Type_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `Book` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Cust_Order`
--
ALTER TABLE `Cust_Order`
  ADD CONSTRAINT `cust_order_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cust_order_ibfk_2` FOREIGN KEY (`shipping_id`) REFERENCES `Shipping_Method` (`shipping_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Order_Line`
--
ALTER TABLE `Order_Line`
  ADD CONSTRAINT `order_line_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Cust_Order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_line_ibfk_2` FOREIGN KEY (`isbn`) REFERENCES `Book` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Payment`
--
ALTER TABLE `Payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Cust_Order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `token_FK` FOREIGN KEY (`user_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
