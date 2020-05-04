-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 01, 2020 at 08:35 PM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.0.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library_v2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `calculatefine` ()  NO SQL
BEGIN
UPDATE returntable
INNER JOIN loan on returntable.loanid = loan.loanid 
SET returntable.fine = DATEDIFF(returntable.returndate,loan.duedate)*0.5
WHERE loan.duedate < returntable.returndate;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `checkfine` ()  NO SQL
BEGIN
SELECT loanid, userid, loandate,
DATEDIFF(CURDATE(),duedate) *0.5 AS fine
FROM loan
WHERE duedate < CURDATE(); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_availability` ()  NO SQL
BEGIN
UPDATE waitinglist
INNER JOIN book on waitinglist.bookid = book.bookid AND book.quantity > 0
SET waitinglist.availability = 'Yes';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `duedate` ()  NO SQL
BEGIN
UPDATE loan
INNER JOIN
book on book.bookid = loan.bookid
SET loan.duedate = DATE_ADD(loan.loandate, INTERVAL book.loanlength DAY);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `authorid` int(11) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `firstname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`authorid`, `lastname`, `firstname`) VALUES
(1, 'Walliams', 'David\r'),
(2, 'Bronte', 'Emily\r'),
(3, 'UK Gov', 'UK Gov\r'),
(4, 'Donaldson', 'Julia\r'),
(5, 'Carty-Williams', 'Candace\r'),
(6, 'Wicks', 'Joe\r'),
(7, 'Yuval', 'Noah\r'),
(8, 'Hosseini', 'Khaled\r'),
(9, 'Brown', 'Dan\r'),
(10, 'Evans', 'Diana\r'),
(11, 'Orwell', 'George\r'),
(12, 'Adams', 'Douglas\r'),
(13, 'Rowling', 'J.K\r'),
(14, 'Michaels', 'Anne\r'),
(15, 'Kerr', 'Judith\r'),
(16, 'Harper', 'Lee\r'),
(18, 'Willardt', 'Kenneth\r'),
(19, 'Berry', 'Mary\r'),
(20, 'Austen ', 'Jane\r'),
(21, 'Coelho', 'Paulo\r'),
(22, 'Fluke', 'Joanne\r'),
(23, 'Popkey', 'Miranda\r'),
(24, 'Angelou', 'Maya ');

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `bookid` int(11) PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `title` varchar(50) NOT NULL,
  `authorid` int(11) NOT NULL,
  `genreid` int(11) NOT NULL,
  `under18` varchar(50) NOT NULL,
  `publishdate` date NOT NULL,
  `loanlength` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`bookid`, `title`, `authorid`, `genreid`, `under18`, `publishdate`, `loanlength`, `quantity`) VALUES
(1, 'Bad Dad', 1, 1, 'Yes', '2017-11-15', 14, 3),
(2, 'Wuthering Heights', 2, 2, 'No', '1847-12-15', 14, 5),
(3, 'Highway Code', 3, 3, 'No', '2019-04-05', 7, 1),
(4, 'The Gruffalo', 4, 4, 'Yes', '1999-03-05', 14, 5),
(5, 'Queenie', 5, 5, 'No', '2019-03-15', 14, 0),
(6, 'Joe\'s 30 Minute Meals', 6, 6, 'No', '2018-09-14', 14, 5),
(7, 'Sapiens A Brief History of Humankind', 7, 7, 'No', '2011-07-02', 14, 5),
(8, 'The Kite Runner', 8, 5, 'No', '2003-03-04', 14, 4),
(9, 'The Da Vinci Code', 9, 8, 'No', '2000-05-05', 14, 2),
(10, 'Ordinary People', 10, 5, 'No', '2018-04-20', 14, 5),
(11, '1984', 11, 10, 'No', '1949-08-06', 7, 5),
(12, 'The Hitchhiker\'s Guide to the Galaxy', 12, 10, 'No', '2007-05-30', 7, 3),
(13, 'Harry Potter and the Goblet of Fire', 13, 11, 'Yes', '2000-07-08', 7, 5),
(14, 'Fugitive Pieces', 14, 5, 'No', '2007-09-09', 14, 4),
(15, 'The Tiger That Came to Tea', 15, 4, 'Yes', '1968-01-10', 14, 5),
(16, 'To Kill A Mockingbird', 16, 5, 'Yes', '1960-01-07', 7, 2),
(17, 'The Restaurant at the End of the Universe', 12, 5, 'No', '2010-08-07', 14, 10),
(18, 'The Beauty Book', 18, 12, 'No', '2015-12-04', 7, 4),
(19, 'Fast Cakes', 19, 6, 'No', '1981-12-12', 7, 1),
(20, 'Animal Farm', 11, 5, 'No', '1950-08-07', 7, 1),
(21, 'Pride and Prejudice', 21, 2, 'Yes', '1813-01-28', 7, 7),
(22, 'The Alchemist', 22, 14, 'No', '1999-07-07', 14, 5),
(23, 'Slime', 1, 14, 'Yes', '2020-01-03', 7, 10),
(24, 'Coconut Layer Cake Murders', 24, 13, 'No', '2020-02-25', 7, 20),
(25, 'Topics of Conversation: A novel', 24, 5, 'No', '2020-01-02', 14, 10),
(26, 'I Know Why the Caged Bird Sings', 24, 9, 'Yes', '1969-06-01', 2, 5);

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `genreid` int(11) NOT NULL,
  `genre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`genreid`, `genre`) VALUES
(1, 'Young Adult\r'),
(2, 'Classic Fiction\r'),
(3, 'Reference\r'),
(4, 'Children\r'),
(5, 'Fiction\r'),
(6, 'Cookery\r'),
(7, 'History\r'),
(8, 'Thriller\r'),
(9, 'Biography\r'),
(10, 'Science Fiction\r'),
(11, 'Fantasy\r'),
(12, 'Nonfiction\r'),
(13, 'Crime\r'),
(14, 'NewAge');

-- --------------------------------------------------------

--
-- Table structure for table `librarycarddetail`
--

CREATE TABLE `librarycarddetail` (
  `userid` int(11) NOT NULL,
  `cardnumber` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `librarycarddetail`
--

INSERT INTO `librarycarddetail` (`userid`, `cardnumber`) VALUES
(1, '0000-1111-1111\r'),
(2, '0000-1111-2222\r'),
(3, '0000-1111-3333\r'),
(4, '0000-1111-4444\r'),
(5, '0000-1111-5555\r'),
(6, '0000-1111-6666\r'),
(7, '0000-1111-7777\r'),
(8, '0000-1111-8888\r'),
(9, '0000-1111-9999\r'),
(10, '0000-1111-1000');

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `loanid` int(11) AUTO_INCREMENT NOT NULL,
  `userid` int(11) NOT NULL,
  `bookid` int(11) NOT NULL,
  `loandate` date DEFAULT NULL,
  `duedate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`loanid`, `userid`, `bookid`, `loandate`, `duedate`) VALUES
(1, 2, 20, '2020-01-01', '2020-01-08'),
(2, 3, 1, '2020-11-02', '2020-11-16'),
(3, 1, 5, '2020-03-28', '2020-04-11'),
(4, 5, 10, '2020-11-04', '2020-11-18'),
(5, 4, 9, '2020-05-11', '2020-05-25'),
(6, 5, 1, '2020-04-12', '2020-04-26'),
(15, 5, 12, '2020-04-12', '2020-04-19'),
(16, 4, 1, '2020-04-20', '2020-05-04');

--
-- Triggers `loan`
--
DELIMITER $$
CREATE TRIGGER `subtract_quantity` BEFORE INSERT ON `loan` FOR EACH ROW UPDATE book
INNER JOIN loan on book.bookid = NEW.bookid

SET book.quantity = book.quantity - 1
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `userid` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `DoB` date NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`userid`, `firstname`, `lastname`, `DoB`, `email`) VALUES
(1, 'Samantha', 'Smith', '1970-07-19', 'samsmith@hotmail.com\r'),
(2, 'Julian', 'Page', '2001-04-13', 'jpage@hotmail.co.uk\r'),
(3, 'James', 'Parker', '1993-03-08', 'jamesparker@yahoo.com\r'),
(4, 'Victoria', 'Lewis', '1999-07-18', 'vlewis@gmail.com\r'),
(5, 'Sophia', 'Green', '1980-12-25', 'sogreen@hotmail.com\r'),
(6, 'Mary', 'Smith', '1969-05-24', 'marysmith@gmail.com\r'),
(7, 'Daniel', 'Wright', '1997-03-28', 'dwright@outlook.com\r'),
(8, 'Ethan', 'Harris', '1993-10-22', 'ethanharris93@gmail.com\r'),
(9, 'Julian', 'Jackson', '2003-01-18', 'julian2003@yahoo.com\r'),
(10, 'James', 'Parker', '1959-03-19', 'jparker@gmal.com\r');

-- --------------------------------------------------------

--
-- Table structure for table `returntable`
--

CREATE TABLE `returntable` (
  `loanid` int(11) NOT NULL,
  `bookid` int(11) NOT NULL,
  `returndate` date NOT NULL,
  `fine` double DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `returntable`
--

INSERT INTO `returntable` (`loanid`, `bookid`, `returndate`, `fine`) VALUES
(3, 5, '2020-04-12', 0.5),
(15, 12, '2020-04-13', 0);

--
-- Triggers `returntable`
--
DELIMITER $$
CREATE TRIGGER `add_quantity` BEFORE INSERT ON `returntable` FOR EACH ROW UPDATE book
SET book.quantity = book.quantity + 1
WHERE book.bookid = NEW.bookid
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `waitinglist`
--

CREATE TABLE `waitinglist` (
  `waitinglistId` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `bookid` int(11) NOT NULL,
  `availability` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `waitinglist`
--

INSERT INTO `waitinglist` (`waitinglistId`, `userid`, `bookid`, `availability`) VALUES
(1, 8, 20, 'Yes');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`authorid`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`bookid`),
  ADD UNIQUE KEY `bookid` (`bookid`),
  ADD KEY `genreid` (`genreid`),
  ADD KEY `authorid` (`authorid`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`genreid`);

--
-- Indexes for table `librarycarddetail`
--
ALTER TABLE `librarycarddetail`
  ADD PRIMARY KEY (`userid`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`loanid`),
  ADD KEY `cardnumber` (`userid`),
  ADD KEY `bookid` (`bookid`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`userid`);

--
-- Indexes for table `returntable`
--
ALTER TABLE `returntable`
  ADD PRIMARY KEY (`loanid`),
  ADD KEY `bookid` (`bookid`);

--
-- Indexes for table `waitinglist`
--
ALTER TABLE `waitinglist`
  ADD PRIMARY KEY (`waitinglistId`),
  ADD KEY `bookid` (`bookid`),
  ADD KEY `userid` (`userid`);



--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `librarycarddetail`
--
ALTER TABLE `librarycarddetail`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `loan`
--
ALTER TABLE `loan`
  MODIFY `loanid` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `waitinglist`
--
ALTER TABLE `waitinglist`
  MODIFY `waitinglistId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table 
--
ALTER TABLE `returntable`
MODIFY `loanid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table 
--
ALTER TABLE `member`
MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table 
--
ALTER TABLE `book`
MODIFY `bookid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table 
--
ALTER TABLE `author`
MODIFY `authorid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table 
--
ALTER TABLE `genre`
MODIFY `genreid` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`genreid`) REFERENCES `genre` (`genreid`),
  ADD CONSTRAINT `book_ibfk_2` FOREIGN KEY (`authorid`) REFERENCES `author` (`authorid`);

--
-- Constraints for table `librarycarddetail`
--
ALTER TABLE `librarycarddetail`
  ADD CONSTRAINT `librarycarddetail_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `member` (`userid`);

--
-- Constraints for table `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `librarycarddetail` (`userid`),
  ADD CONSTRAINT `loan_ibfk_2` FOREIGN KEY (`bookid`) REFERENCES `book` (`bookid`);

--
-- Constraints for table `returntable`
--
ALTER TABLE `returntable`
  ADD CONSTRAINT `returntable_ibfk_1` FOREIGN KEY (`loanid`) REFERENCES `loan` (`loanid`),
  ADD CONSTRAINT `returntable_ibfk_2` FOREIGN KEY (`bookid`) REFERENCES `book` (`bookid`);

--
-- Constraints for table `waitinglist`
--
ALTER TABLE `waitinglist`
  ADD CONSTRAINT `waitinglist_ibfk_1` FOREIGN KEY (`bookid`) REFERENCES `book` (`bookid`),
  ADD CONSTRAINT `waitinglist_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `librarycarddetail` (`userid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
