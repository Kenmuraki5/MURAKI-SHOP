-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Feb 25, 2024 at 10:51 AM
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
-- Database: `MURAKI_COMIC2`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admin`



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

INSERT INTO `Admin` (`admin_id`, `a_username`, `a_password`, `a_first_name`, `a_last_name`, `a_address`, `a_email`, `a_phone`, `a_image`, `otp`) VALUES
(1, 'admin', '$argon2id$v=19$m=65536,t=3,p=4$LAlOEKHjR3paHxiS+i6o6Q$dPgQBUUynSefTuqpxpNPEGx96xnhezcBn7+UB+dsh40', 'ad', 'min', '', '@mail', '0878888888', '', '');

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
(3, 'Haro Aso', 'Aso-sensei'),
(4, 'Hajime Isayama', 'Isayama-sensei'),
(5, 'Kishimoto Masashi', 'Masashi-sensei'),
(6, 'Ishida Sui', 'Sui-sensei'),
(7, 'Gotouge Koyoharu', 'Koyoharu-sensei'),
(8, 'Shirai Kaiu', 'Kaiu-sensei'),
(9, 'Isuna Hasekura', 'Hasekura-sensei'),
(10, 'Reki Kawahara', 'Kawahara-sensei'),
(11, 'Kugane Maruyama', 'Maruyama-sensei'),
(12, 'Tappei Nagatsuki', 'Nagatsuki-sensei'),
(13, 'Yu Kamiya', 'Kamiya-sensei'),
(14, 'Tsutomu Sato', 'Sato-sensei'),
(15, 'Natsume Akatsuki', 'Akatsuki-sensei'),
(16, 'Aneko Yusagi', 'Yusagi-sensei'),
(17, ' Mikawa Ghost', ' Mikawa Ghost'),
(18, 'Nishi Jouyou', 'Nishi Jouyou'),
(19, 'Asato, Asato', 'Asato, Asato'),
(20, 'Matsumoto, Naoya', 'Matsumoto, Naoya'),
(21, 'SUN SUN SUN', 'SUN SUN SUN'),
(22, 'Akasaka', 'Aka');

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
('9784046813619', 'Gimai Seikatsu Vol. 5', 'การแต่งงานใหม่ของพ่อทำให้อาซามุระ ยูตะ หนุ่ม ม.ปลาย ได้อาศัยใต้ชายคาเดียวกันกับ อายาเสะ ซากิ สาวสวยอันดับหนึ่งของชั้นปีในฐานะพี่ชายและน้องสาว\r\n\r\nเพราะต่างคนต่างโตมาในครอบครัวที่พ่อแม่แยกทางกัน ทั้งสองจึงระมัดระวังในความสัมพันธ์ระหว่างชายหญิงและให้สัญญาว่าจะไม่ก้าวก่าย ไม่ขัดแย้ง และรักษาระยะห่างที่พอเหมาะระหว่างกัน\r\n\r\nซากิขาดความรักความอบอุ่นและพยายามทำอะไรเองคนเดียวมาตลอด จนไม่รู้จักการพึ่งพาคนอื่น ขณะที่ยูตะก็สับสนกับการผูกสัมพันธ์ในฐานะพี่ชายคนสองคนที่มีส่วนคล้ายกัน นานวันก็ยิ่งค้นพบความรู้สึกสบายใจที่ได้ใช้ชีวิตร่วมกับอีกฝ่าย\r\n\r\nนี่คือเรื่องราวความรักที่ยังไม่แตกหน่อ จากชายหญิงซึ่งครั้งหนึ่งเป็นคนอื่นคนไกล ค่อยๆแง้มประตูหัวใจ ขยับชิดใกล้ และถักทอร้อยเรียงสายใยแห่งรักในแต่ละวันที่ล่วงเลย', 290, 'novel', 3, '2023-05-17', 'gimai vol5.jpeg', 91),
('9784049143980', 'Eighty six vol 12', 'Nine years ago, the Empire of Giad declared war on all neighboring countries using an army of autonomous drones known as the Legion. Threatened by the soulless killing machines, the Republic of San Magnolia, home to the silver-haired Alba race, evacuated its citizens inside 85 districts and developed supposedly unmanned drones known as Juggernauts to counter the Legion. Even after years of war, the Republic boasts that they have suffered zero casualties. However, the battlefield bathed in crimson recites a different melody...\r\n\r\nThe hand dealt to the Colorata people—a minority forced into living in the \"nonexistent\" 86th district—is one of utter contempt and scorn. Looked upon as human filth, they are ordered to pilot the Juggernauts as Processors under the command of Republican Handlers.\r\n\r\nVladilena Milizé, a republican soldier with a strong sense of justice, detests the way her countrymen treat the 86. When she is assigned to the Spearhead Squadron as their handler, she meets a group of oddballs and eventually grows attached to them—particularly their captain, Shinei Nouzen, a boy with a pure sense of purpose and resolve. However, the path they walk is one riddled with death, and growing close to an 86 may have just set Vladilena down a path of despair.\r\n', 290, 'novel', 4, '2023-05-17', 'eighty six vol 12.webp', 200),
('9784088918723', 'Oshi no Ko Vol. 4', '\"In the world of entertainment, lies are weapons.\"\r\n\r\nTwin brothers and sisters, Aqua and Ruby, have finally started performing arts activities. Aqua, who appeared in the romance reality show, formed a \"couple\" with Akane Kurokawa! After the show, what will the relationship between the members be? Meanwhile, after a surprising addition, Ruby\'s idol career has finally begun! As she follows her mother\'s legacy, what would happen next?', 90, 'manga', 5, '2022-06-16', 'oshi no ko vol 4.jpeg', 100),
('9786161023616', 'Sword Art Online Vol. 1', 'The first volume of the Sword Art Online light novel series.', 300, 'novel', 1, '2009-04-10', 'sword_art_online_vol1.jpg', 8),
('9786161023708', 'Spice and Wolf Vol. 1', 'The first volume of the Spice and Wolf light novel series.', 250, 'novel', 1, '2007-01-20', 'spice_and_wolf_vol1.jpg', 10),
('9786161023777', 'No Game No Life Vol. 1', 'The first volume of the No Game No Life light novel series.', 290, 'novel', 1, '2012-04-25', 'no_game_no_life_vol1.jpg', 6),
('9786161023807', 'Overlord Vol. 1', 'The first volume of the Overlord light novel series.', 280, 'novel', 1, '2012-07-30', 'overlord_vol1.jpg', 5),
('9786161023890', 'The Irregular at Magic High School Vol. 1', 'The first volume of The Irregular at Magic High School light novel series.', 270, 'novel', 2, '2011-07-08', 'irregular_at_magic_high_school_vol1.jpg', 9),
('9786161023951', 'Re:Zero Vol. 1', 'The first volume of the Re:Zero light novel series.', 320, 'novel', 1, '2014-01-25', 're_zero_vol1.jpg', 12),
('9786161023968', 'Konosuba: Vol. 1', 'The first volume of the Konosuba: God\'s Blessing on This Wonderful World! light novel series.', 300, 'novel', 2, '2013-09-30', 'konosuba_vol1.jpg', 7),
('9786164646193', 'คุณอาเรียโต๊ะข้างๆ พูดรัสเซียหวานใส่ซะหัวใจจะวาย เล่ม 2', '“หา? พูดว่าไง?”\r\n“เปล่านี่? ก็แค่บอกว่า \'หมอนี่โง่จริงๆเลย\' แค่นั้นเอง”\r\n“เลิกด่าเป็นภาษารัสเซียได้ไหม!?” คุณอาเรียยิ้มกริ่ม\r\nเธอคือสาวเจ้าของเรือนผมสีเงินผู้สวยไม่เป็นสองรองใครที่นั่งข้างผม...\r\nแต่ความจริงมันไม่ใช่อย่างนั้นเสียหน่อย\r\nภาษารัสเซียที่เธอพูดเมื่อกี๊นี้มันคือ \'สนใจฉันหน่อย\' ต่างหากล่ะ!\r\n \r\nอันที่จริงตัวผม คุเซะ มาซาจิกะ\r\nมีทักษะการฟังภาษารัสเซียระดับเทียบเท่าเจ้าของภาษา\r\nเพียงแต่ไม่เปิดเผยเรื่องนั้นให้ใครรู้ วันนี้ก็เป็นอีกวันที่อดยิ้มไม่อยู่\r\nเพราะคุณอาเรียมาหยอดคำหวานใส่เป็นภาษารัสเซียอีกแล้ว!?\r\n \r\nเรื่องราวเลิฟคอมเมดี้วัยใส\r\nกับนักเรียนสาวมัธยมปลายชาวรัสเซียผู้สวยเลิศเลอ\r\nจนเป็นที่หมายปองของใครต่อใคร!', 265, 'novel', 4, '2023-04-28', 'roshidere-volume-4-5-cover-v0-jvmy1xxiye491.jpg', 290),
('9786165752268', 'Kaiju No. 8, Vol. 7', 'Grotesque, Godzilla-like monsters called \"kaijuu\" have been appearing around Japan for many years. To combat these beasts, an elite military unit known as the Defense Corps risks their lives daily to protect civilians. Once a creature is killed, \"sweepers\"—working under the Professional Kaijuu Cleaner Corporation—are left to dispose of its remains.\r\n\r\nKafka Hibino, a 32-year-old man, is unsatisfied with his job as a sweeper. From a young age, he has aspired to join the Defense Corps and kill kaijuus for a living. After a few failed attempts, however, he gave up on his dreams and resigned himself to the mediocrity that provided a decent paycheck. Nevertheless, when an ambitious, 18-year-old recruit named Leno Ichikawa joins his cleaning team, Kafka is once again reminded of his desire to join the military.\r\n\r\nFollowing a chain of unfortunate events and an interaction with the junior sweeper, Kafka encounters a parasite-type kaijuu that forces its way in through his mouth—turning him into a humanoid monster. With his newfound powers, Kafka aims to give his lifelong dream a final try.', 90, 'manga', 1, '2023-04-29', 'KAIJYU no8 vol 7.jpeg', 200),
('9786165990424', 'ยอมเป็นแฟนเบอร์สองของเธอก็ได้ Vol. 2', '   ฉันก็ชอบคิริชิมะคุงเป็นอันดับสองเหมือนกัน”ผมกับคุณฮายาซากะมีคนที่ชอบที่สุดอยู่แล้วทั้งคู่\r\nแต่เราก็คบกันในฐานะที่เป็น ‘เบอร์สอง’ ของกันและกันเรากลับบ้านด้วยกัน นัวเนียกัน ทำเรื่องที่บอกใครไม่ได้แต่ถึงอย่างนั้น เบอร์สองก็ยังเป็นแค่เบอร์สอง ถ้าเกิดว่าวันนึง ‘เบอร์หนึ่ง’ ของใครเกิดเปลี่ยนใจมาคบหา ความสัมพันธ์แบบแฟน ‘เบอร์สอง’ จะถูกยกเลิกทันที ทั้งที่เราสัญญากันไว้อย่างนั้น—“ขอโทษนะ ฉันมันงี่เง่าเอง ดันชอบมากขึ้นเรื่อยๆซะแล้วสิ”ความสัมพันธ์ต่างอันดับอันน่าปวดตับของเขาและเธอ', 290, 'novel', 4, '2023-05-08', ' Watashi Nibanme no Kanojo de vol 2.jpeg', 50),
('9786169265001', 'Attack on Titan Vol. 1', 'The first volume of the popular Japanese manga series Attack on Titan.', 99, 'manga', 1, '2010-03-17', 'attack_on_titan_vol1.jpg', 10),
('9786169265061', 'My Hero Academia Vol. 1', 'The first volume of the popular Japanese manga series My Hero Academia.', 99, 'manga', 1, '2014-07-07', 'my_hero_academia_vol1.jpg', 30),
('9786169265078', 'Demon Slayer Vol. 1', 'The first volume of the Japanese manga series Demon Slayer.', 109, 'manga', 3, '2016-02-15', 'demon_slayer_vol1.jpg', 18),
('9786169953203', 'Alice in Borderland Vol. 1', 'The first volume of the Japanese manga series Alice in Borderland.', 109, 'manga', 2, '2010-11-25', 'alice_in_borderland_vol1.jpg', 20),
('9786169953227', 'The Promised Neverland Vol. 1', 'The first volume of the Japanese manga series The Promised Neverland.', 99, 'manga', 2, '2016-08-04', 'the_promised_neverland_vol1.jpg', 22),
('9786169953302', 'Tokyo Ghoul Vol. 1', 'The first volume of the Japanese manga series Tokyo Ghoul.', 89, 'manga', 3, '2011-09-17', 'tokyo_ghoul_vol1.jpg', 15),
('9789742454312', 'One Piece Vol. 1', 'The first volume of the popular Japanese manga series One Piece.', 119, 'manga', 1, '1997-07-22', 'one_piece_vol1.jpg', 21),
('9789742454329', 'Naruto Vol. 1', 'The first volume of the popular Japanese manga series Naruto.', 99, 'manga', 2, '1999-09-21', 'naruto_vol1.jpg', 23);

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
('9781760792831', 2),
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
('9786161023891', 16),
('9784046813619', 17),
('9786165990424', 18),
('9784049143980', 19),
('9786165752268', 20),
('9786164646193', 21),
('9784088918723', 22);

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
('9781760792831', 1),
('9784049143980', 1),
('9786161023616', 1),
('9786161023807', 1),
('9786161023890', 1),
('9786161023891', 1),
('9786165752268', 1),
('9786169265001', 1),
('9786169265061', 1),
('9786169265078', 1),
('9786169953203', 1),
('9786169953302', 1),
('9789742454312', 1),
('9789742454329', 1),
('9786161023777', 2),
('9786161023807', 2),
('9786161023951', 2),
('9786161023968', 2),
('9786169265061', 2),
('9789742454312', 2),
('9789742454329', 2),
('9784046813619', 3),
('9784049143980', 3),
('9784088918723', 3),
('9786161023708', 3),
('9786161023891', 3),
('9786165990424', 3),
('9786169265001', 3),
('9786169953203', 3),
('9786169953227', 3),
('9781760792831', 4),
('9786161023616', 4),
('9786164646193', 4),
('9784088918723', 5),
('9786161023951', 5),
('9786169953227', 5),
('9784046813619', 6),
('9784049143980', 6),
('9784088918723', 6),
('9786161023708', 6),
('9786161023890', 6),
('9786164646193', 6),
('9786165990424', 6),
('9786169953302', 6);

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
  `c_image` varchar(200) NOT NULL,
  `otp` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `price` double NOT NULL,
  `book_name` varchar(255) DEFAULT NULL,
  `book_img` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(2, 'Bongkoch Publishing'),
(3, 'KADOKAWA'),
(4, 'PHOENIX'),
(5, 'Luckpim');

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
-- Table structure for table `tokens_a`
--

CREATE TABLE `tokens_a` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(20) NOT NULL,
  `token` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tokens_a`
--

INSERT INTO `tokens_a` (`id`, `user_id`, `token`) VALUES
(1, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiaWF0IjoxNjg0Njg3NDE1fQ.v7h7hFJjFflgyQjFL5jPZZ5uB_tsfPAlDCWaO45o-Xo');

-- --------------------------------------------------------

--
-- Table structure for table `tokens_c`
--

CREATE TABLE `tokens_c` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(20) NOT NULL,
  `token` varchar(1000) NOT NULL
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
-- Indexes for table `tokens_a`
--
ALTER TABLE `tokens_a`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tokens_a_UN` (`token`) USING BTREE,
  ADD KEY `token_a_FK` (`user_id`);

--
-- Indexes for table `tokens_c`
--
ALTER TABLE `tokens_c`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tokens_c_UN` (`token`) USING BTREE,
  ADD KEY `token_c_FK` (`user_id`) USING BTREE;

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
  MODIFY `author_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(40) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Customer`
--
ALTER TABLE `Customer`
  MODIFY `customer_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Cust_Order`
--
ALTER TABLE `Cust_Order`
  MODIFY `order_id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `genre_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Order_Line`
--
ALTER TABLE `Order_Line`
  MODIFY `line_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Payment`
--
ALTER TABLE `Payment`
  MODIFY `payment_id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Publisher`
--
ALTER TABLE `Publisher`
  MODIFY `publisher_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Shipping_Method`
--
ALTER TABLE `Shipping_Method`
  MODIFY `shipping_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tokens_a`
--
ALTER TABLE `tokens_a`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tokens_c`
--
ALTER TABLE `tokens_c`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  ADD CONSTRAINT `order_line_ibfk_2` FOREIGN KEY (`isbn`) REFERENCES `Book` (`isbn`) ON UPDATE CASCADE;

--
-- Constraints for table `Payment`
--
ALTER TABLE `Payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Cust_Order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tokens_a`
--
ALTER TABLE `tokens_a`
  ADD CONSTRAINT `tokens_a_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Admin` (`admin_id`) ON DELETE CASCADE;

--
-- Constraints for table `tokens_c`
--
ALTER TABLE `tokens_c`
  ADD CONSTRAINT `tokens_c_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
