-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 13, 2025 at 04:02 AM
-- Server version: 10.6.22-MariaDB-log
-- PHP Version: 8.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `studyhtc_quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `chapters`
--

CREATE TABLE `chapters` (
  `chapter_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `chapter_name` varchar(255) NOT NULL,
  `chapter_number` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `learning_objectives` text DEFAULT NULL,
  `status` enum('active','inactive','draft') NOT NULL DEFAULT 'active',
  `difficulty_level` enum('beginner','intermediate','advanced') DEFAULT 'intermediate',
  `estimated_hours` int(11) DEFAULT NULL,
  `prerequisites` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `chapters`
--

INSERT INTO `chapters` (`chapter_id`, `class_id`, `subject_id`, `chapter_name`, `chapter_number`, `description`, `learning_objectives`, `status`, `difficulty_level`, `estimated_hours`, `prerequisites`, `created_at`, `updated_at`) VALUES
(6, 4, 1, 'Biodiversity and Classification', 1, NULL, NULL, 'active', 'intermediate', NULL, NULL, '2025-05-15 15:05:44', '2025-05-15 15:05:44'),
(7, 4, 1, 'Bacteria and Viruses', 2, NULL, NULL, 'active', 'intermediate', NULL, NULL, '2025-05-15 15:06:03', '2025-05-15 15:06:03');

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `class_id` int(11) NOT NULL,
  `class_name` varchar(255) NOT NULL,
  `instructor_email` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`class_id`, `class_name`, `instructor_email`, `created_at`, `updated_at`) VALUES
(4, '1st Year', 'test@test.com', '2025-05-15 15:05:29', '2025-05-15 15:05:29');

-- --------------------------------------------------------

--
-- Table structure for table `class_sections`
--

CREATE TABLE `class_sections` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `section_name` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `class_sections`
--

INSERT INTO `class_sections` (`id`, `class_id`, `section_name`, `created_at`, `updated_at`) VALUES
(7, 4, 'B', '2025-05-17 05:56:20', '2025-05-17 05:56:20'),
(10, 4, 'G', '2025-05-17 17:12:40', '2025-05-17 17:12:40');

-- --------------------------------------------------------

--
-- Table structure for table `dropdown`
--

CREATE TABLE `dropdown` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `options` text NOT NULL,
  `answer` varchar(255) NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `essay`
--

CREATE TABLE `essay` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fillintheblanks`
--

CREATE TABLE `fillintheblanks` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `options` text DEFAULT NULL,
  `answer` varchar(255) NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `fillintheblanks`
--

INSERT INTO `fillintheblanks` (`id`, `question`, `options`, `answer`, `chapter_id`, `topic_id`) VALUES
(3, 'Biodiversity and classification are fundamental concepts in biology that provide insight into the vast array of life forms on Earth and their __________ relationships.', NULL, 'evolutionary', 6, 3),
(4, 'The five-kingdom classification system was proposed by American ecologists __________ in 1969.', NULL, 'Rebert Whittaker', 6, 3),
(5, 'According to the five-kingdom system, all organisms were divided into five kingdoms: Monera, Protista, Fungi, Plantae, and __________.', NULL, 'Animalia', 6, 3),
(6, 'The kingdom Monera included __________ in the five-kingdom system.', NULL, 'prokaryotes', 6, 3),
(7, 'All other four kingdoms (Protista, Fungi, Plantae, and Animalia) included __________ in the five-kingdom system.', NULL, 'eukaryotes', 6, 3),
(8, 'In 1990, American microbiologist Carl Woese suggested that there are two separate groups of prokaryotes: Archaea and __________.', NULL, 'Bacteria', 6, 3),
(9, 'Carl Woese classified living organisms into three domains: Domain Archaea, Domain Bacteria, and Domain __________.', NULL, 'Eukarya', 6, 3),
(10, 'The evolutionary relationship among organisms is called __________.', NULL, 'phylogeny', 6, 3),
(11, 'A diagram to show phylogeny is called a __________ or evolutionary tree.', NULL, 'phylogenetic', 6, 3),
(12, 'Domain Archaea and Domain Bacteria both contain __________, but they differ in a number of features.', NULL, 'prokaryotes', 6, 3),
(13, 'Biodiversity highlights the variety of life at the genetic, species, and __________ levels.', NULL, 'ecosystem', 6, 3),
(14, 'Biologists now believe that Archaea and Bacteria evolved __________ from some common ancestor.', NULL, 'independently', 6, 3),
(15, 'According to __________ evidence, archaea are more closely related to eukaryotes than to bacteria.', NULL, 'molecular', 6, 3),
(16, 'In other words, Eukarya evolved from __________, after archaea split off from the Bacteria.', NULL, 'Archaea', 6, 3),
(17, 'The principles and methods of biological classification are used by scientists to __________ and categorize organisms.', NULL, 'organize', 6, 3),
(18, 'The three-domain system proposed by Carl Woese in 1990 effectively divided the former Kingdom Monera into two distinct prokaryotic domains: __________ and __________.', NULL, 'Archaea and Bacteria', 6, 3);

-- --------------------------------------------------------

--
-- Table structure for table `instructorinfo`
--

CREATE TABLE `instructorinfo` (
  `name` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `instructorinfo`
--

INSERT INTO `instructorinfo` (`name`, `email`, `password`) VALUES
('Hassan Tariq', 'Hassan.tariq771@gmail.com', 'hassan@nps'),
('Test Instructor', 'test@test.com', 'test123');

-- --------------------------------------------------------

--
-- Table structure for table `mcqdb`
--

CREATE TABLE `mcqdb` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `optiona` varchar(255) NOT NULL,
  `optionb` varchar(255) NOT NULL,
  `optionc` varchar(255) NOT NULL,
  `optiond` varchar(255) NOT NULL,
  `answer` char(1) NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `mcqdb`
--

INSERT INTO `mcqdb` (`id`, `question`, `optiona`, `optionb`, `optionc`, `optiond`, `answer`, `chapter_id`, `topic_id`) VALUES
(74, 'Which of the following is NOT one of the levels at which biodiversity is highlighted in the text?', 'Genetic level', 'Species level', 'Population level', 'Ecosystem level', 'c', 6, 3),
(75, 'What is the evolutionary relationship among organisms called?', 'Taxonomy', 'Classification', 'Phylogeny', 'Systematics', 'c', 6, 3),
(76, 'Who proposed the five-kingdom classification system?', 'Carl Woese', 'Robert Whittaker', 'Charles Darwin', 'Anton van Leeuwenhoek', 'b', 6, 3),
(77, 'In the five-kingdom system, which kingdom included all prokaryotes?', 'Protista', 'Fungi', 'Monera', 'Plantae', 'c', 6, 3),
(78, 'How many domains of life did Carl Woese suggest in 1990?', 'Two', 'Three', 'Four', 'Five', 'b', 6, 3),
(79, 'According to the three-domain system, which of the following domains contains prokaryotic organisms?', 'Eukarya only', 'Archaea only', 'Bacteria only', 'Both Archaea and Bacteria', 'd', 6, 3),
(80, 'A scientist draws a diagram to show the evolutionary history of a group of organisms. What is this diagram called?', 'Cladogram', 'Phylogenetic tree', 'Taxonomic key', 'Dichotomous chart', 'b', 6, 3),
(81, 'Which of the following statements about the five-kingdom system is true?', 'It grouped all eukaryotes into the kingdom Monera.', 'It was proposed after the three-domain system.', 'It separated organisms based on whether they were prokaryotic or eukaryotic.', 'It recognized Archaea as a distinct group from Bacteria.', 'c', 6, 3),
(82, 'Carl Woese\'s modification to the classification system primarily addressed a distinction within which group of organisms?', 'Eukaryotes', 'Fungi', 'Prokaryotes', 'Multicellular organisms', 'c', 6, 3),
(83, 'What type of evidence suggested that archaea are more closely related to eukaryotes than to bacteria?', 'Morphological evidence', 'Fossil evidence', 'Molecular evidence', 'Behavioral evidence', 'c', 6, 3),
(84, 'The shift from the five-kingdom system to the three-domain system primarily reflects a deeper understanding of:', 'The anatomical complexity of organisms.', 'The fundamental metabolic pathways shared across all life.', 'The evolutionary divergence within prokaryotes and their relationship to eukaryotes.', 'The ecological roles played by different life forms.', 'c', 6, 3),
(85, 'If a new organism is discovered that lacks a nucleus and membrane-bound organelles, but its ribosomal RNA sequence is more similar to Homo sapiens than to Escherichia coli, to which domain would it most likely be assigned?', 'Bacteria', 'Archaea', 'Eukarya (as a highly reduced form)', 'A new, sixth kingdom', 'b', 6, 3),
(86, 'Which of the following phylogenetic relationships is best supported by the information provided in the text?', 'Bacteria and Archaea are sister groups, and Eukarya diverged from Bacteria.', 'Archaea and Eukarya share a more recent common ancestor with each other than either does with Bacteria.', 'All three domains diverged simultaneously from a common ancestor.', 'Monera is a polyphyletic group, encompassing organisms from both Bacteria and Eukarya.', 'b', 6, 3),
(87, 'The concept of \"Monera\" as a single kingdom became problematic under the three-domain system because:', 'Some Monera were found to be eukaryotic.', 'Monera was discovered to be a polyphyletic group, containing organisms from two distinct domains.', 'Fungi were reclassified from Monera.', 'The definition of \"prokaryote\" changed.', 'b', 6, 3),
(88, 'If a diagram shows Bacteria branching off first, followed by a split between Archaea and Eukarya, what does this arrangement primarily illustrate about the evolutionary history of life?', 'Eukaryotes are the most ancient life forms.', 'Bacteria are more complex than Archaea.', 'The last universal common ancestor was likely a bacterium.', 'Archaea and Eukarya share a more recent common ancestor than either does with Bacteria.', 'd', 6, 3);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `section_id` int(11) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `class_id`, `section_id`, `title`, `message`, `created_at`, `created_by`, `is_active`) VALUES
(1, 4, 7, 'notification', 'hello', '2025-05-18 16:39:08', 'test@test.com', 0),
(2, 4, 7, 'Quiz Starting time', 'Quiz of Biology Chapter 1 Will start at 9:00Am. ', '2025-05-18 17:07:45', 'Hassan.tariq771@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `numericaldb`
--

CREATE TABLE `numericaldb` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` int(11) NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quizconfig`
--

CREATE TABLE `quizconfig` (
  `quizid` int(11) NOT NULL,
  `quiznumber` int(11) NOT NULL,
  `quizname` varchar(50) NOT NULL,
  `starttime` datetime NOT NULL,
  `endtime` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `attempts` int(11) NOT NULL,
  `mcq` int(11) NOT NULL,
  `numerical` int(11) NOT NULL,
  `dropdown` int(11) NOT NULL,
  `fill` int(11) NOT NULL,
  `short` int(11) NOT NULL,
  `essay` int(11) NOT NULL,
  `mcqmarks` int(11) NOT NULL,
  `numericalmarks` int(11) NOT NULL,
  `dropdownmarks` int(11) NOT NULL,
  `fillmarks` int(11) NOT NULL,
  `shortmarks` int(11) NOT NULL,
  `essaymarks` int(11) NOT NULL,
  `maxmarks` int(11) NOT NULL DEFAULT 0,
  `typea` int(11) DEFAULT 0,
  `typeamarks` int(11) DEFAULT 0,
  `typeb` int(11) DEFAULT 0,
  `typebmarks` int(11) DEFAULT 0,
  `typec` int(11) DEFAULT 0,
  `typecmarks` int(11) DEFAULT 0,
  `typed` int(11) DEFAULT 0,
  `typedmarks` int(11) DEFAULT 0,
  `typee` int(11) DEFAULT 0,
  `typeemarks` int(11) DEFAULT 0,
  `typef` int(11) DEFAULT 0,
  `typefmarks` int(11) DEFAULT 0,
  `total_questions` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `chapter_ids` text DEFAULT NULL,
  `topic_ids` text DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `section` varchar(50) DEFAULT NULL COMMENT 'Target section for the quiz',
  `section_id` int(11) DEFAULT NULL,
  `is_random` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `quizconfig`
--

INSERT INTO `quizconfig` (`quizid`, `quiznumber`, `quizname`, `starttime`, `endtime`, `duration`, `attempts`, `mcq`, `numerical`, `dropdown`, `fill`, `short`, `essay`, `mcqmarks`, `numericalmarks`, `dropdownmarks`, `fillmarks`, `shortmarks`, `essaymarks`, `maxmarks`, `typea`, `typeamarks`, `typeb`, `typebmarks`, `typec`, `typecmarks`, `typed`, `typedmarks`, `typee`, `typeemarks`, `typef`, `typefmarks`, `total_questions`, `class_id`, `chapter_ids`, `topic_ids`, `subject_id`, `section`, `section_id`, `is_random`) VALUES
(98, 1, '1st', '2025-05-18 21:01:00', '2025-05-19 21:01:00', 10, 1, 5, 0, 0, 0, 5, 0, 1, 0, 0, 0, 2, 0, 15, 5, 1, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 10, 4, '6', '', 1, 'B', NULL, 1),
(99, 2, '2nd', '2025-05-18 21:01:00', '2025-05-19 21:01:00', 10, 1, 5, 0, 0, 0, 5, 0, 1, 0, 0, 0, 2, 0, 15, 5, 1, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 10, 4, '6', '', 1, 'B', NULL, 1),
(100, 3, '3rd', '2025-05-18 21:02:00', '2025-05-19 21:02:00', 10, 1, 5, 0, 0, 0, 5, 0, 1, 0, 0, 0, 2, 0, 15, 5, 1, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 10, 4, '6', '', 1, 'B', NULL, 1),
(107, 4, '1st year chap 1', '2025-05-19 10:42:00', '2025-05-19 10:59:00', 10, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, '6,7', '', 1, 'B', NULL, 1),
(108, 5, 'testing', '2025-06-09 15:25:00', '2025-06-10 15:25:00', 10, 1, 5, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 25, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 4, '6', '', 1, 'B', NULL, 1),
(111, 7, '1st test b', '2025-06-12 15:48:00', '2025-06-13 15:48:00', 10, 1, 5, 0, 0, 0, 3, 0, 1, 0, 0, 0, 2, 0, 11, 5, 1, 0, 0, 0, 0, 0, 0, 3, 2, 0, 0, 8, 4, '6,7,8,9,10,11,12,13,14,15,16,17', NULL, 1, 'B', NULL, 1),
(113, 9, 'test 2', '2025-06-13 12:03:00', '2025-06-14 12:03:00', 10, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 2, 2, 5, 10, 1, 1, 0, 0, 0, 0, 1, 2, 1, 2, 1, 5, 4, NULL, '37', '1', NULL, 'A TEST', NULL, 1),
(116, 12, 'test 5', '2025-06-13 12:06:00', '2025-06-14 12:06:00', 10, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 5, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 4, '6', '0', 1, 'B', NULL, 1),
(118, 13, 'test', '2025-06-13 14:00:00', '2025-06-14 14:00:00', 10, 1, 3, 0, 0, 1, 3, 0, 1, 0, 0, 0, 2, 0, 9, 3, 1, 0, 0, 0, 0, 1, 0, 3, 2, 0, 0, 7, 4, '6', '3', 1, 'B', NULL, 1),
(119, 14, 'test 2', '2025-06-13 14:00:00', '2025-06-14 14:00:00', 10, 1, 3, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1, 0, 3, 0, 0, 0, 7, 4, '6', '3', 1, 'B', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `quizrecord`
--

CREATE TABLE `quizrecord` (
  `quizid` int(11) NOT NULL,
  `rollnumber` int(11) NOT NULL,
  `attempt` int(11) NOT NULL,
  `starttime` datetime NOT NULL,
  `endtime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_chapters`
--

CREATE TABLE `quiz_chapters` (
  `quiz_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `random_quiz_questions`
--

CREATE TABLE `random_quiz_questions` (
  `quizid` int(11) NOT NULL,
  `qtype` varchar(20) NOT NULL,
  `qid` int(11) NOT NULL,
  `serialnumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `random_quiz_questions`
--

INSERT INTO `random_quiz_questions` (`quizid`, `qtype`, `qid`, `serialnumber`) VALUES
(98, 'a', 13, 3),
(98, 'a', 16, 2),
(98, 'a', 17, 4),
(98, 'a', 19, 1),
(98, 'a', 20, 5),
(98, 'e', 2, 7),
(98, 'e', 4, 10),
(98, 'e', 5, 6),
(98, 'e', 7, 9),
(98, 'e', 8, 8),
(99, 'a', 13, 4),
(99, 'a', 15, 3),
(99, 'a', 16, 2),
(99, 'a', 18, 1),
(99, 'a', 19, 5),
(99, 'e', 2, 9),
(99, 'e', 3, 10),
(99, 'e', 4, 6),
(99, 'e', 6, 8),
(99, 'e', 8, 7),
(100, 'a', 12, 1),
(100, 'a', 13, 4),
(100, 'a', 17, 5),
(100, 'a', 20, 2),
(100, 'a', 48, 3),
(100, 'e', 3, 9),
(100, 'e', 4, 8),
(100, 'e', 5, 7),
(100, 'e', 7, 6),
(100, 'e', 8, 10),
(108, 'a', 12, 2),
(108, 'a', 14, 3),
(108, 'a', 15, 1),
(108, 'a', 18, 4),
(108, 'a', 20, 5),
(111, 'a', 13, 4),
(111, 'a', 14, 3),
(111, 'a', 15, 1),
(111, 'a', 64, 2),
(111, 'a', 66, 5),
(111, 'e', 4, 6),
(111, 'e', 8, 7),
(111, 'e', 30, 8),
(113, 'a', 72, 1),
(113, 'd', 2, 2),
(113, 'e', 38, 3),
(113, 'f', 2, 4),
(116, 'a', 12, 2),
(116, 'a', 14, 3),
(116, 'a', 18, 5),
(116, 'a', 19, 1),
(116, 'a', 48, 4),
(118, 'a', 74, 1),
(118, 'a', 80, 3),
(118, 'a', 88, 2),
(118, 'd', 10, 4),
(118, 'e', 47, 7),
(118, 'e', 59, 6),
(118, 'e', 60, 5),
(119, 'a', 77, 2),
(119, 'a', 81, 3),
(119, 'a', 87, 1),
(119, 'd', 16, 4),
(119, 'e', 45, 6),
(119, 'e', 48, 5),
(119, 'e', 50, 7);

-- --------------------------------------------------------

--
-- Table structure for table `response`
--

CREATE TABLE `response` (
  `quizid` int(11) NOT NULL,
  `rollnumber` int(11) NOT NULL,
  `attempt` int(11) NOT NULL,
  `qtype` varchar(20) NOT NULL,
  `qid` int(11) NOT NULL,
  `response` text NOT NULL,
  `serialnumber` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `result`
--

CREATE TABLE `result` (
  `quizid` int(11) NOT NULL,
  `rollnumber` int(11) NOT NULL,
  `attempt` int(11) NOT NULL,
  `mcqmarks` int(11) NOT NULL,
  `numericalmarks` int(11) NOT NULL,
  `dropdownmarks` int(11) NOT NULL,
  `fillmarks` int(11) NOT NULL,
  `shortmarks` int(11) NOT NULL,
  `essaymarks` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shortanswer`
--

CREATE TABLE `shortanswer` (
  `id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `shortanswer`
--

INSERT INTO `shortanswer` (`id`, `question`, `answer`, `chapter_id`, `topic_id`) VALUES
(39, 'Who proposed the five-kingdom classification system?', '[Your Answer Here]', 6, 3),
(40, 'In what year was the five-kingdom system proposed?', '[Your Answer Here]', 6, 3),
(41, 'What are the five kingdoms in Whittaker\'s classification system?', '[Your Answer Here]', 6, 3),
(42, 'Which kingdom in the five-kingdom system included prokaryotes?', '[Your Answer Here]', 6, 3),
(43, 'Which kingdoms in the five-kingdom system included eukaryotes?', '[Your Answer Here]', 6, 3),
(44, 'Who suggested there are two separate groups of prokaryotes?', '[Your Answer Here]', 6, 3),
(45, 'In what year did Carl Woese propose the three-domain system?', '[Your Answer Here]', 6, 3),
(46, 'What are the three domains of classification?', '[Your Answer Here]', 6, 3),
(47, 'Which two domains contain prokaryotes?', '[Your Answer Here]', 6, 3),
(48, 'What is phylogeny?', '[Your Answer Here]', 6, 3),
(49, 'What is a phylogenetic or evolutionary tree?', '[Your Answer Here]', 6, 3),
(50, 'How did Carl Woese\'s classification differ from Whittaker\'s regarding prokaryotes?', '[Your Answer Here]', 6, 3),
(51, 'What is the main distinction between the Monera kingdom and the two prokaryotic domains?', '[Your Answer Here]', 6, 3),
(52, 'According to molecular evidence, which domain is more closely related to eukaryotes?', '[Your Answer Here]', 6, 3),
(53, 'From which domain are eukaryotes believed to have evolved?', '[Your Answer Here]', 6, 3),
(54, 'What is the significance of the \"three-domain system\" in terms of classifying life?', '[Your Answer Here]', 6, 3),
(55, 'Briefly explain why the three-domain system was introduced after the five-kingdom system.', '[Your Answer Here]', 6, 3),
(56, 'Discuss the fundamental difference in the underlying principle of classification between Whittaker\'s five-kingdom system and Woese\'s three-domain system, particularly concerning prokaryotic diversity.', '[Your Answer Here]', 6, 3),
(57, 'Elaborate on the evolutionary implications of the statement: \"Eukarya evolved from Archaea, after archaea split off from the Bacteria.\"', '[Your Answer Here]', 6, 3),
(58, 'Besides the presence of prokaryotes, what key differences might exist between Archaea and Bacteria that led Woese to classify them as separate domains?', '[Your Answer Here]', 6, 3),
(59, 'How does the concept of \"phylogeny\" enhance our understanding of biodiversity beyond mere categorization?', '[Your Answer Here]', 6, 3),
(60, 'If new molecular evidence were to contradict the close relationship between Archaea and Eukarya, how might this impact the current three-domain system of classification?', '[Your Answer Here]', 6, 3);

-- --------------------------------------------------------

--
-- Table structure for table `studentinfo`
--

CREATE TABLE `studentinfo` (
  `name` varchar(30) NOT NULL,
  `rollnumber` int(11) NOT NULL,
  `department` varchar(20) NOT NULL,
  `program` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `section_id` int(11) DEFAULT NULL COMMENT 'Reference to class_sections table',
  `section` varchar(50) DEFAULT NULL COMMENT 'Student section'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL,
  `subject_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_name`) VALUES
(1, 'Biology');

-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE `topics` (
  `topic_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `topic_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `topics`
--

INSERT INTO `topics` (`topic_id`, `chapter_id`, `topic_name`, `created_at`, `updated_at`) VALUES
(3, 6, 'introduction to three domain classification', '2025-06-13 07:40:10', '2025-06-13 07:40:10'),
(4, 6, 'Domain Archaea', '2025-06-13 07:40:36', '2025-06-13 07:40:36'),
(5, 6, 'Domain Bacteria', '2025-06-13 07:40:51', '2025-06-13 07:40:51'),
(6, 6, 'Domain Eukarya', '2025-06-13 07:41:06', '2025-06-13 07:41:06');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chapters`
--
ALTER TABLE `chapters`
  ADD PRIMARY KEY (`chapter_id`),
  ADD UNIQUE KEY `uk_class_chapter_number` (`class_id`,`subject_id`,`chapter_number`),
  ADD UNIQUE KEY `uk_class_chapter_name` (`class_id`,`subject_id`,`chapter_name`),
  ADD KEY `idx_fk_class_id` (`class_id`),
  ADD KEY `idx_fk_subject_id` (`subject_id`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`class_id`),
  ADD KEY `instructor_email` (`instructor_email`);

--
-- Indexes for table `class_sections`
--
ALTER TABLE `class_sections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_class_section` (`class_id`,`section_name`),
  ADD KEY `idx_class_id` (`class_id`);

--
-- Indexes for table `dropdown`
--
ALTER TABLE `dropdown`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fk_dropdown_chapter` (`chapter_id`),
  ADD KEY `idx_fk_dropdown_topic` (`topic_id`);

--
-- Indexes for table `essay`
--
ALTER TABLE `essay`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fk_essay_chapter` (`chapter_id`),
  ADD KEY `idx_fk_essay_topic` (`topic_id`);

--
-- Indexes for table `fillintheblanks`
--
ALTER TABLE `fillintheblanks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fk_fillintheblanks_chapter` (`chapter_id`),
  ADD KEY `idx_fk_fillintheblanks_topic` (`topic_id`);

--
-- Indexes for table `instructorinfo`
--
ALTER TABLE `instructorinfo`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `mcqdb`
--
ALTER TABLE `mcqdb`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fk_mcqdb_chapter` (`chapter_id`),
  ADD KEY `idx_fk_mcqdb_topic` (`topic_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `fk_notification_class` (`class_id`),
  ADD KEY `fk_notification_section` (`section_id`);

--
-- Indexes for table `numericaldb`
--
ALTER TABLE `numericaldb`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fk_numericaldb_chapter` (`chapter_id`),
  ADD KEY `idx_fk_numericaldb_topic` (`topic_id`);

--
-- Indexes for table `quizconfig`
--
ALTER TABLE `quizconfig`
  ADD PRIMARY KEY (`quizid`),
  ADD KEY `fk_quiz_class` (`class_id`),
  ADD KEY `fk_quiz_subject` (`subject_id`),
  ADD KEY `fk_quiz_section` (`section_id`);

--
-- Indexes for table `quizrecord`
--
ALTER TABLE `quizrecord`
  ADD PRIMARY KEY (`quizid`,`rollnumber`,`attempt`),
  ADD KEY `rollnumber` (`rollnumber`);

--
-- Indexes for table `quiz_chapters`
--
ALTER TABLE `quiz_chapters`
  ADD PRIMARY KEY (`quiz_id`,`chapter_id`),
  ADD KEY `fk_quiz_chapter_chapter` (`chapter_id`);

--
-- Indexes for table `random_quiz_questions`
--
ALTER TABLE `random_quiz_questions`
  ADD PRIMARY KEY (`quizid`,`qtype`,`qid`);

--
-- Indexes for table `response`
--
ALTER TABLE `response`
  ADD PRIMARY KEY (`quizid`,`rollnumber`,`attempt`,`qtype`,`qid`),
  ADD KEY `rollnumber` (`rollnumber`),
  ADD KEY `idx_serialnumber` (`serialnumber`);

--
-- Indexes for table `result`
--
ALTER TABLE `result`
  ADD PRIMARY KEY (`quizid`,`rollnumber`,`attempt`),
  ADD KEY `rollnumber` (`rollnumber`);

--
-- Indexes for table `shortanswer`
--
ALTER TABLE `shortanswer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fk_shortanswer_chapter` (`chapter_id`),
  ADD KEY `idx_fk_shortanswer_topic` (`topic_id`);

--
-- Indexes for table `studentinfo`
--
ALTER TABLE `studentinfo`
  ADD PRIMARY KEY (`rollnumber`),
  ADD KEY `idx_section_id` (`section_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`),
  ADD UNIQUE KEY `subject_name_unique` (`subject_name`);

--
-- Indexes for table `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`topic_id`),
  ADD UNIQUE KEY `chapter_topic_unique` (`chapter_id`,`topic_name`),
  ADD KEY `idx_topic_chapter` (`chapter_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chapters`
--
ALTER TABLE `chapters`
  MODIFY `chapter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `class_sections`
--
ALTER TABLE `class_sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `dropdown`
--
ALTER TABLE `dropdown`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `essay`
--
ALTER TABLE `essay`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `fillintheblanks`
--
ALTER TABLE `fillintheblanks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `mcqdb`
--
ALTER TABLE `mcqdb`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `numericaldb`
--
ALTER TABLE `numericaldb`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `quizconfig`
--
ALTER TABLE `quizconfig`
  MODIFY `quizid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `shortanswer`
--
ALTER TABLE `shortanswer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `topics`
--
ALTER TABLE `topics`
  MODIFY `topic_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chapters`
--
ALTER TABLE `chapters`
  ADD CONSTRAINT `fk_chapter_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_chapter_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`instructor_email`) REFERENCES `instructorinfo` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `class_sections`
--
ALTER TABLE `class_sections`
  ADD CONSTRAINT `fk_section_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `dropdown`
--
ALTER TABLE `dropdown`
  ADD CONSTRAINT `fk_dropdown_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `essay`
--
ALTER TABLE `essay`
  ADD CONSTRAINT `fk_essay_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_essay_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `fillintheblanks`
--
ALTER TABLE `fillintheblanks`
  ADD CONSTRAINT `fk_fillintheblanks_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_fillintheblanks_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `mcqdb`
--
ALTER TABLE `mcqdb`
  ADD CONSTRAINT `fk_mcqdb_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_mcqdb_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notification_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_notification_section` FOREIGN KEY (`section_id`) REFERENCES `class_sections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `numericaldb`
--
ALTER TABLE `numericaldb`
  ADD CONSTRAINT `fk_numericaldb_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_numericaldb_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `quizconfig`
--
ALTER TABLE `quizconfig`
  ADD CONSTRAINT `fk_quiz_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_quiz_section` FOREIGN KEY (`section_id`) REFERENCES `class_sections` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_quiz_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `quizrecord`
--
ALTER TABLE `quizrecord`
  ADD CONSTRAINT `quizrecord_ibfk_1` FOREIGN KEY (`quizid`) REFERENCES `quizconfig` (`quizid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `quizrecord_ibfk_2` FOREIGN KEY (`rollnumber`) REFERENCES `studentinfo` (`rollnumber`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quiz_chapters`
--
ALTER TABLE `quiz_chapters`
  ADD CONSTRAINT `fk_quiz_chapter_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_quiz_chapter_quiz` FOREIGN KEY (`quiz_id`) REFERENCES `quizconfig` (`quizid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `random_quiz_questions`
--
ALTER TABLE `random_quiz_questions`
  ADD CONSTRAINT `fk_random_quiz_quizid` FOREIGN KEY (`quizid`) REFERENCES `quizconfig` (`quizid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `response`
--
ALTER TABLE `response`
  ADD CONSTRAINT `response_ibfk_1` FOREIGN KEY (`quizid`) REFERENCES `quizconfig` (`quizid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `response_ibfk_2` FOREIGN KEY (`rollnumber`) REFERENCES `studentinfo` (`rollnumber`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `result`
--
ALTER TABLE `result`
  ADD CONSTRAINT `result_ibfk_1` FOREIGN KEY (`quizid`) REFERENCES `quizconfig` (`quizid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `result_ibfk_2` FOREIGN KEY (`rollnumber`) REFERENCES `studentinfo` (`rollnumber`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shortanswer`
--
ALTER TABLE `shortanswer`
  ADD CONSTRAINT `fk_shortanswer_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_shortanswer_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `studentinfo`
--
ALTER TABLE `studentinfo`
  ADD CONSTRAINT `fk_student_section` FOREIGN KEY (`section_id`) REFERENCES `class_sections` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `topics`
--
ALTER TABLE `topics`
  ADD CONSTRAINT `fk_topics_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
