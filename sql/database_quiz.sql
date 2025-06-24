/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.22-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: studyhtc_quiz
-- ------------------------------------------------------
-- Server version	10.6.22-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `studyhtc_quiz`
--


--
-- Table structure for table `chapters`
--

DROP TABLE IF EXISTS `chapters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `chapters` (
  `chapter_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`chapter_id`),
  UNIQUE KEY `uk_class_chapter_number` (`class_id`,`subject_id`,`chapter_number`),
  UNIQUE KEY `uk_class_chapter_name` (`class_id`,`subject_id`,`chapter_name`),
  KEY `idx_fk_class_id` (`class_id`),
  KEY `idx_fk_subject_id` (`subject_id`),
  CONSTRAINT `fk_chapter_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_chapter_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chapters`
--

LOCK TABLES `chapters` WRITE;
/*!40000 ALTER TABLE `chapters` DISABLE KEYS */;
INSERT INTO `chapters` (`chapter_id`, `class_id`, `subject_id`, `chapter_name`, `chapter_number`, `description`, `learning_objectives`, `status`, `difficulty_level`, `estimated_hours`, `prerequisites`, `created_at`, `updated_at`) VALUES (6,4,1,'Biodiversity and Classification',1,NULL,NULL,'active','intermediate',NULL,NULL,'2025-05-15 15:05:44','2025-05-15 15:05:44'),(7,4,1,'Bacteria and Viruses',2,NULL,NULL,'active','intermediate',NULL,NULL,'2025-05-15 15:06:03','2025-05-15 15:06:03');
/*!40000 ALTER TABLE `chapters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_sections`
--

DROP TABLE IF EXISTS `class_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `section_name` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_class_section` (`class_id`,`section_name`),
  KEY `idx_class_id` (`class_id`),
  CONSTRAINT `fk_section_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_sections`
--

LOCK TABLES `class_sections` WRITE;
/*!40000 ALTER TABLE `class_sections` DISABLE KEYS */;
INSERT INTO `class_sections` (`id`, `class_id`, `section_name`, `created_at`, `updated_at`) VALUES (7,4,'B','2025-05-17 05:56:20','2025-05-17 05:56:20'),(10,4,'G','2025-05-17 17:12:40','2025-05-17 17:12:40');
/*!40000 ALTER TABLE `class_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `classes` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) NOT NULL,
  `instructor_email` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`class_id`),
  KEY `instructor_email` (`instructor_email`),
  CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`instructor_email`) REFERENCES `instructorinfo` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` (`class_id`, `class_name`, `instructor_email`, `created_at`, `updated_at`) VALUES (4,'1st Year','test@test.com','2025-05-15 15:05:29','2025-05-15 15:05:29');
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dropdown`
--

DROP TABLE IF EXISTS `dropdown`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dropdown` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `options` text NOT NULL,
  `answer` varchar(255) NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_fk_dropdown_chapter` (`chapter_id`),
  KEY `idx_fk_dropdown_topic` (`topic_id`),
  CONSTRAINT `fk_dropdown_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dropdown`
--

LOCK TABLES `dropdown` WRITE;
/*!40000 ALTER TABLE `dropdown` DISABLE KEYS */;
/*!40000 ALTER TABLE `dropdown` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `essay`
--

DROP TABLE IF EXISTS `essay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `essay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_fk_essay_chapter` (`chapter_id`),
  KEY `idx_fk_essay_topic` (`topic_id`),
  CONSTRAINT `fk_essay_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_essay_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `essay`
--

LOCK TABLES `essay` WRITE;
/*!40000 ALTER TABLE `essay` DISABLE KEYS */;
INSERT INTO `essay` (`id`, `question`, `answer`, `chapter_id`, `topic_id`) VALUES (3,'Explain Unique characteristics of the Domain Archaea','domain archaea',6,4),(4,'Explain characteristics of domain archaea along with their significance.','domain archaea',6,4),(5,'Discuss the diverse roles that bacteria play in both natural ecosystems and their interactions with other organisms','role',6,5),(6,'Compare and contrast the key characteristics of the Domain Bacteria with those of Eukarya','key characteristics',6,5),(7,'Analyze the significance of various structural components found in bacteria. Explain how each of these structures contributes to the survival, adaptation, and overall function of bacterial organisms.','structural components',6,5),(8,'Explain major groups of Bacteria','major groups',6,5),(9,'What is Taxonomic hierarchy? explain classification of Human and Sparrow','classification',6,7),(10,'Define taxonomic Hierarchy and explain first four taxons','taxonomic Hierarchy',6,7);
/*!40000 ALTER TABLE `essay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fillintheblanks`
--

DROP TABLE IF EXISTS `fillintheblanks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `fillintheblanks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `options` text DEFAULT NULL,
  `answer` varchar(255) NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_fk_fillintheblanks_chapter` (`chapter_id`),
  KEY `idx_fk_fillintheblanks_topic` (`topic_id`),
  CONSTRAINT `fk_fillintheblanks_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_fillintheblanks_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fillintheblanks`
--

LOCK TABLES `fillintheblanks` WRITE;
/*!40000 ALTER TABLE `fillintheblanks` DISABLE KEYS */;
INSERT INTO `fillintheblanks` (`id`, `question`, `options`, `answer`, `chapter_id`, `topic_id`) VALUES (3,'Biodiversity and classification are fundamental concepts in biology that provide insight into the vast array of life forms on Earth and their __________ relationships.',NULL,'evolutionary',6,3),(4,'The five-kingdom classification system was proposed by American ecologists __________ in 1969.',NULL,'Rebert Whittaker',6,3),(5,'According to the five-kingdom system, all organisms were divided into five kingdoms: Monera, Protista, Fungi, Plantae, and __________.',NULL,'Animalia',6,3),(6,'The kingdom Monera included __________ in the five-kingdom system.',NULL,'prokaryotes',6,3),(7,'All other four kingdoms (Protista, Fungi, Plantae, and Animalia) included __________ in the five-kingdom system.',NULL,'eukaryotes',6,3),(8,'In 1990, American microbiologist Carl Woese suggested that there are two separate groups of prokaryotes: Archaea and __________.',NULL,'Bacteria',6,3),(9,'Carl Woese classified living organisms into three domains: Domain Archaea, Domain Bacteria, and Domain __________.',NULL,'Eukarya',6,3),(10,'The evolutionary relationship among organisms is called __________.',NULL,'phylogeny',6,3),(11,'A diagram to show phylogeny is called a __________ or evolutionary tree.',NULL,'phylogenetic',6,3),(12,'Domain Archaea and Domain Bacteria both contain __________, but they differ in a number of features.',NULL,'prokaryotes',6,3),(13,'Biodiversity highlights the variety of life at the genetic, species, and __________ levels.',NULL,'ecosystem',6,3),(14,'Biologists now believe that Archaea and Bacteria evolved __________ from some common ancestor.',NULL,'independently',6,3),(15,'According to __________ evidence, archaea are more closely related to eukaryotes than to bacteria.',NULL,'molecular',6,3),(16,'In other words, Eukarya evolved from __________, after archaea split off from the Bacteria.',NULL,'Archaea',6,3),(17,'The principles and methods of biological classification are used by scientists to __________ and categorize organisms.',NULL,'organize',6,3),(18,'The three-domain system proposed by Carl Woese in 1990 effectively divided the former Kingdom Monera into two distinct prokaryotic domains: __________ and __________.',NULL,'Archaea and Bacteria',6,3),(53,'In the five-kingdom system, the Domain Archaea was included in Kingdom _________.',NULL,'Monera',6,4),(54,'The name Archaea comes from the Greek word \"_________\" which means \"ancient.\"',NULL,'archaios',6,4),(55,'Archaea are _________ which diverged from bacteria in very ancient times.',NULL,'prokaryotes',6,4),(56,'Individual archaeans range from 0.1 _________ to over 15 _________ in diameter.',NULL,'micrometers, micrometers',6,4),(57,'Some archaeans form aggregates or filaments up to 200 _________ in length.',NULL,'micrometers',6,4),(58,'Archaea occur in various shapes, such as spherical, rod-shape, spiral, lobed, or _________.',NULL,'rectangular',6,4),(59,'Archaea reproduce asexually by binary or multiple fission, fragmentation, or _________.',NULL,'budding',6,4),(60,'_________ and _________ do not occur in archaea.',NULL,'Mitosis, meiosis',6,4),(61,'Archaea were initially classified as a group of bacteria and were called _________.',NULL,'archaebacteria',6,4),(62,'The cell membrane of Archaea contains lipids with _________ between glycerol and fatty acid chains.',NULL,'ether-linkage',6,4),(63,'The fatty acid chains in archaeal cell membranes are _________.',NULL,'branched',6,4),(64,'Bacteria and Eukarya have membrane lipids with fatty acids attached to glycerol by _________.',NULL,'ester linkages',6,4),(65,'The fatty acid chains in bacterial and Eukarya membranes are _________.',NULL,'unbranched',6,4),(66,'The cell walls of archaea lack cellulose and _________.',NULL,'peptidoglycan',6,4),(67,'Some archaea have _________ instead of peptidoglycan in their cell walls.',NULL,'pseudopeptidoglycan',6,4),(68,'Bacterial cell walls contain _________, a polymer consisting of sugars and amino acids.',NULL,'peptidoglycan',6,4),(69,'In Eukarya, plant cell walls are composed of _________, and fungal cell walls are composed of _________.',NULL,'cellulose, chitin',6,4),(70,'Archaea share several genetic sequences and regulatory features with _________, highlighting their evolutionary relationship.',NULL,'eukaryotes',6,4),(71,'A unique metabolic process found in Archaea but not in bacteria or Eukarya is _________ (production of methane).',NULL,'methanogenesis',6,4),(72,'The archaeans which live in high acidity and alkalinity are a source of _________ that can function under harsh conditions.',NULL,'enzymes',6,4),(73,'_________ archaeans are a vital part of sewage treatment.',NULL,'Methanogen',6,4),(74,'Methanogen archaeans carry out _________ digestion and produce biogas.',NULL,'anaerobic',6,4),(75,'_________ Archaea are used to extract metals such as gold, cobalt, and copper from ores in mineral processing.',NULL,'Acidophillic',6,4),(76,'In humans, intestinal gas is largely the result of metabolism of _________.',NULL,'methanogens',6,4),(77,'_________ produce methane as a metabolic byproduct.',NULL,'Methanogens',6,4),(78,'_________ are a major group of Archaea that live in extremely saline environments.',NULL,'Halobacteria',6,4),(79,'_________ are a major group of Archaea found in hot environments.',NULL,'Thermococci',6,4),(80,'_________ are a major group of Archaea involved in the nitrogen cycle.',NULL,'Thaumarchaeota',6,4),(81,'The enzymes of DNA replication extracted from archaeans can work best at _________ temperatures and allow rapid cloning of DNA.',NULL,'high',6,4),(82,'The ether-linkage between glycerol and fatty acid chains in archaeal cell membranes contributes to their increased _________ to extreme conditions.',NULL,'resistance',6,4),(83,'The fact that Archaea diverged from bacteria in very ancient times supports their classification into a separate _________ of life.',NULL,'domain',6,4),(84,'The presence of _________ (a distinct polysaccharide) in some archaeal cell walls is a key differentiator from bacterial cell walls.',NULL,'pseudopeptidoglycan',6,4),(85,'While bacteria exhibit photosynthesis and nitrogen fixation, Archaea are uniquely characterized by _________ as a metabolic pathway.',NULL,'methanogenesis',6,4),(86,'The use of enzymes from acidophilic Archaea in DNA cloning highlights their significance in _________ applications due to their stability in harsh environments.',NULL,'laboratory',6,4),(87,'In the five-kingdom system, the Domain Bacteria was included in kingdom ________________________________________.',NULL,'Monera',6,5),(88,'Like archaea, bacteria possess a ________________________________________ cell, meaning they lack a true nucleus and membrane-bound organelles.',NULL,'prokaryotic',6,5),(89,'Bacteria have a cell wall composed of ________________________________________, a unique polymer providing structural support.',NULL,'peptidoglycan',6,5),(90,'The genetic material of bacteria consists of a single, circular chromosome composed of DNA, located in the ________________________________________ region.',NULL,'nucleoid',6,5),(91,'Small, circular DNA molecules that can be transferred between bacteria, aiding in genetic diversity and adaptation, are known as ________________________________________.',NULL,'plasmids',6,5),(92,'Bacteria primarily reproduce asexually through ________________________________________, a process resulting in two identical daughter cells.',NULL,'binary fission',6,5),(93,'Regarding nutritional modes, bacteria can be ________________________________________ (self-feeding) or ________________________________________ (feeding on organic matter).',NULL,'autotrophs, heterotrophs',6,5),(94,'Bacteria exhibit various shapes, such as spherical (cocci), rod-shaped (________________________________________), spiral-shaped (spirilla), and comma-shaped (vibrios).',NULL,'bacilli',6,5),(95,'When bacterial cells are found in pairs, they are referred to as ________________________________________, while chains are called streptococci.',NULL,'diplococci',6,5),(96,'Many bacteria possess whip-like structures called ________________________________________ that enable movement.',NULL,'flagella',6,5),(97,'Pili and fimbriae are hair-like structures that help in ________________________________________ to surfaces and ________________________________________ with other bacteria.',NULL,'attachment, exchange of genetic material',6,5),(98,'Bacteria that thrive in extreme conditions such as high temperatures are called ________________________________________.',NULL,'thermophiles',6,5),(99,'Some bacteria cause diseases in humans, animals, and plants, producing toxins or other ________________________________________ factors.',NULL,'virulence',6,5),(100,'An example of a mutualistic symbiotic relationship mentioned involves bacteria where both organisms ________________________________________.',NULL,'benefit',6,5),(101,'Escherichia coli* is an example of a bacterium belonging to the ________________________________________ group.',NULL,'Proteobacteria',6,5),(102,'Mycobacterium tuberculosis* is classified under the ________________________________________ group of bacteria.',NULL,'Actinobacteria',6,5),(103,'The domain Eukarya encompasses all organisms with eukaryotic cells, which are fundamentally different from the ___________ cells of Bacteria and Archaea.',NULL,'prokaryotic',6,6),(104,'Eukaryotic cells are characterized by possessing a true nucleus that is enclosed by a ___________.',NULL,'nuclear membrane',6,6),(105,'In addition to a nucleus, eukaryotic cells contain various ___________-bounded organelles such as mitochondria, endoplasmic reticulum, and the Golgi apparatus.',NULL,'membrane',6,6),(106,'Chloroplasts, a type of membrane-bounded organelle, are specifically found in plant cells and ___________.',NULL,'algae',6,6),(107,'The cytoskeleton of eukaryotic cells is a complex network comprised of microtubules, microfilaments, and ___________ filaments, which provides structural support and facilitates intracellular transport.',NULL,'intermediate',6,6),(108,'Eukaryotic DNA is organized into multiple ___________ chromosomes, which are located within the ___________.',NULL,'linear; nucleus',6,6),(109,'Eukaryotic DNA is associated with proteins called ___________, which play a crucial role in the organization and regulation of genetic material.',NULL,'histone',6,6),(110,'Most eukaryotes primarily undergo ___________ reproduction, a process involving meiosis and fertilization that leads to ___________.',NULL,'sexual; genetic diversity',6,6),(111,'While sexual reproduction promotes diversity, some eukaryotes can also reproduce asexually through ___________, resulting in genetically ___________ offspring.',NULL,'mitosis; identical',6,6),(112,'In multicellular eukaryotes, cells differentiate into specialized types, which then form ___________ and organs with specific functions.',NULL,'tissues',6,6),(113,'The widely accepted theory for the origin of eukaryotes, particularly their organelles like mitochondria and chloroplasts, is ___________.',NULL,'endosymbiosis',6,6),(114,'According to the endosymbiotic theory, certain prokaryotic cells were ___________ by a host cell, establishing a ___________ relationship that led to the evolution of eukaryotic organelles.',NULL,'engulfed; symbiotic',6,6),(135,'The classification of living organisms is organized into a _________ system that allows scientists to categorize and understand the relationships between different forms of life.',NULL,'hierarchical',6,7),(136,'The primary levels of the taxonomic hierarchy are kingdom, phylum, class, order, family, genus, and _________.',NULL,'species',6,7),(137,'The highest level of classification, currently divided into Archaea, Bacteria, and Eukarya, is known as the _________.',NULL,'Domain',6,7),(138,'The taxonomic rank just below domain, which groups all forms of life sharing fundamental characteristics, is the _________.',NULL,'Kingdom',6,7),(139,'In the domain Eukarya, kingdoms such as Animalia, Plantae, Fungi, and _________ exist.',NULL,'Protista',6,7),(140,'Organisms within a _________ share a basic body plan and significant structural features.',NULL,'phylum',6,7),(141,'Within the kingdom Animalia, the phylum _________ includes all animals with a notochord.',NULL,'Chordata',6,7),(142,'Class further divides organisms within a phylum based on more specific common traits, exemplified by the class _________ within Chordata, characterized by hair and mammary glands.',NULL,'Mammalia',6,7),(143,'Order categorizes organisms within a class based on additional shared characteristics and evolutionary history, such as the order _________ which includes humans, monkeys, and apes.',NULL,'Primates',6,7),(144,'The family _________ groups organisms within the order Primates that are even more closely related, including great apes and humans.',NULL,'Hominidae',6,7),(145,'The genus _________ is a more specific rank within a family, grouping species that are very closely related and often visually similar, like humans and our closest extinct relatives.',NULL,'Homo',6,7),(146,'The most specific level of classification, representing a single type of organism whose members can interbreed and produce fertile offspring, is the _________.',NULL,'species',6,7),(147,'Modern humans are referred to by the species name Homo _________.',NULL,'sapiens',6,7),(148,'The presence of a notochord at some stage of development is a defining characteristic of the phylum _________.',NULL,'Chordata',6,7),(149,'The three domains of life are Archaea, Bacteria, and _________.',NULL,'Eukarya',6,7),(150,'Which taxonomic level directly precedes \"Order\" and groups organisms based on more specific common traits?',NULL,'Class',6,7),(151,'What is the criterion for determining if members of a species belong to the same group, beyond visual similarity or shared habitat?',NULL,'Ability to interbreed and produce fertile offspring',6,7);
/*!40000 ALTER TABLE `fillintheblanks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructorinfo`
--

DROP TABLE IF EXISTS `instructorinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructorinfo` (
  `name` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructorinfo`
--

LOCK TABLES `instructorinfo` WRITE;
/*!40000 ALTER TABLE `instructorinfo` DISABLE KEYS */;
INSERT INTO `instructorinfo` (`name`, `email`, `password`) VALUES ('Hassan Tariq','Hassan.tariq771@gmail.com','hassan@nps'),('Test Instructor','test@test.com','test123');
/*!40000 ALTER TABLE `instructorinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mcqdb`
--

DROP TABLE IF EXISTS `mcqdb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mcqdb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `optiona` varchar(255) NOT NULL,
  `optionb` varchar(255) NOT NULL,
  `optionc` varchar(255) NOT NULL,
  `optiond` varchar(255) NOT NULL,
  `answer` char(1) NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_fk_mcqdb_chapter` (`chapter_id`),
  KEY `idx_fk_mcqdb_topic` (`topic_id`),
  CONSTRAINT `fk_mcqdb_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_mcqdb_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mcqdb`
--

LOCK TABLES `mcqdb` WRITE;
/*!40000 ALTER TABLE `mcqdb` DISABLE KEYS */;
INSERT INTO `mcqdb` (`id`, `question`, `optiona`, `optionb`, `optionc`, `optiond`, `answer`, `chapter_id`, `topic_id`) VALUES (74,'Which of the following is NOT one of the levels at which biodiversity is highlighted in the text?','Genetic level','Species level','Population level','Ecosystem level','c',6,3),(75,'What is the evolutionary relationship among organisms called?','Taxonomy','Classification','Phylogeny','Systematics','c',6,3),(76,'Who proposed the five-kingdom classification system?','Carl Woese','Robert Whittaker','Charles Darwin','Anton van Leeuwenhoek','b',6,3),(77,'In the five-kingdom system, which kingdom included all prokaryotes?','Protista','Fungi','Monera','Plantae','c',6,3),(78,'How many domains of life did Carl Woese suggest in 1990?','Two','Three','Four','Five','b',6,3),(79,'According to the three-domain system, which of the following domains contains prokaryotic organisms?','Eukarya only','Archaea only','Bacteria only','Both Archaea and Bacteria','d',6,3),(80,'A scientist draws a diagram to show the evolutionary history of a group of organisms. What is this diagram called?','Cladogram','Phylogenetic tree','Taxonomic key','Dichotomous chart','b',6,3),(81,'Which of the following statements about the five-kingdom system is true?','It grouped all eukaryotes into the kingdom Monera.','It was proposed after the three-domain system.','It separated organisms based on whether they were prokaryotic or eukaryotic.','It recognized Archaea as a distinct group from Bacteria.','c',6,3),(82,'Carl Woese\'s modification to the classification system primarily addressed a distinction within which group of organisms?','Eukaryotes','Fungi','Prokaryotes','Multicellular organisms','c',6,3),(83,'What type of evidence suggested that archaea are more closely related to eukaryotes than to bacteria?','Morphological evidence','Fossil evidence','Molecular evidence','Behavioral evidence','c',6,3),(84,'The shift from the five-kingdom system to the three-domain system primarily reflects a deeper understanding of:','The anatomical complexity of organisms.','The fundamental metabolic pathways shared across all life.','The evolutionary divergence within prokaryotes and their relationship to eukaryotes.','The ecological roles played by different life forms.','c',6,3),(85,'If a new organism is discovered that lacks a nucleus and membrane-bound organelles, but its ribosomal RNA sequence is more similar to Homo sapiens than to Escherichia coli, to which domain would it most likely be assigned?','Bacteria','Archaea','Eukarya (as a highly reduced form)','A new, sixth kingdom','b',6,3),(86,'Which of the following phylogenetic relationships is best supported by the information provided in the text?','Bacteria and Archaea are sister groups, and Eukarya diverged from Bacteria.','Archaea and Eukarya share a more recent common ancestor with each other than either does with Bacteria.','All three domains diverged simultaneously from a common ancestor.','Monera is a polyphyletic group, encompassing organisms from both Bacteria and Eukarya.','b',6,3),(87,'The concept of \"Monera\" as a single kingdom became problematic under the three-domain system because:','Some Monera were found to be eukaryotic.','Monera was discovered to be a polyphyletic group, containing organisms from two distinct domains.','Fungi were reclassified from Monera.','The definition of \"prokaryote\" changed.','b',6,3),(88,'If a diagram shows Bacteria branching off first, followed by a split between Archaea and Eukarya, what does this arrangement primarily illustrate about the evolutionary history of life?','Eukaryotes are the most ancient life forms.','Bacteria are more complex than Archaea.','The last universal common ancestor was likely a bacterium.','Archaea and Eukarya share a more recent common ancestor than either does with Bacteria.','d',6,3),(114,'In the five-kingdom system, which kingdom did the Domain Archaea belong to?','Plantae','Animalia','Fungi','Monera','D',6,4),(115,'From which Greek word does the name \"Archaea\" originate?','archon','archaios','archeo','archos','B',6,4),(116,'What is the typical size range for individual archaeans?','1 micrometers to 15 micrometers','0.1 micrometers to 15 micrometers','0.01 micrometers to 1.5 micrometers','10 micrometers to 150 micrometers','B',6,4),(117,'Which of the following shapes are NOT mentioned for archaeans?','Spherical','Rod-shape','Helical','Rectangular','C',6,4),(118,'Which of the following methods of reproduction is NOT used by Archaea?','Binary fission','Mitosis','Fragmentation','Budding','B',6,4),(119,'Archaea were initially classified as a group of bacteria and called:','Eubacteria','Cyanobacteria','Archaebacteria','Protobacteria','C',6,4),(120,'What type of linkage connects glycerol and fatty acid chains in the cell membranes of Archaea?','Ester-linkage','Ether-linkage','Peptide-linkage','Glycosidic-linkage','B',6,4),(121,'The fatty acid chains in archaeal cell membranes are:','Unbranched','Branched','Saturated','Unsaturated','B',6,4),(122,'Which component is characteristic of bacterial cell walls but absent in archaeal cell walls?','Cellulose','Chitin','Peptidoglycan','Proteins','C',6,4),(123,'What do some archaea have in their cell walls instead of peptidoglycan?','Cellulose','Chitin','Pseudopeptidoglycan','Lignin','C',6,4),(124,'Which unique metabolic process is found in Archaea but not in Bacteria or Eukarya?','Photosynthesis','Nitrogen fixation','Fermentation','Methanogenesis','D',6,4),(125,'Which group of Archaea is involved in the nitrogen cycle?','Methanogens','Halobacteria','Thermococci','Thaumarchaeota','D',6,4),(126,'What do methanogen archaeans produce as a metabolic byproduct?','Carbon dioxide','Oxygen','Methane','Hydrogen sulfide','C',6,4),(127,'What is a key application of acidophilic Archaea in mineral processing?','Production of biogas','Sewage treatment','Extraction of metals from ores','DNA replication','C',6,4),(128,'What are Halobacteria known for?','Producing methane','Living in hot environments','Living in extremely saline environments','Involvement in the nitrogen cycle','C',6,4),(129,'The unique cell membrane composition of Archaea, specifically the ether-linkages and branched fatty acid chains, primarily contributes to their:','Ability to perform photosynthesis.','Greater resistance to extreme environmental conditions.','Efficient DNA replication at low temperatures.','Formation of aggregates and filaments.','B',6,4),(130,'If a newly discovered microorganism is found to have a cell wall primarily composed of pseudopeptidoglycan and its membrane lipids contain ether-linked branched chains, into which domain would it most likely be classified?','Bacteria','Eukarya','Archaea','Fungi','C',6,4),(131,'A scientist isolates an enzyme from an extremophile microorganism that functions optimally at 90°C. Based on the provided text, this enzyme is most likely extracted from a species belonging to which domain?','Bacteria','Eukarya','Archaea','Viruses','C',6,4),(132,'The process of methanogenesis is significant not only ecologically but also in industrial applications. This is because methanogens are a vital part of:','Aerobic digestion for water purification.','The synthesis of antibiotics.','Anaerobic digestion leading to biogas production.','The decomposition of plant matter in forests.','C',6,4),(133,'The statement \"Archaea share several genetic sequences and regulatory features with eukaryotes, highlighting their evolutionary relationship\" implies that:','Archaea are a direct ancestor of eukaryotes.','Eukaryotes evolved from a type of archaea.','Archaea and Eukarya share a more recent common ancestor with each other than either does with Bacteria.','Archaea can interbreed with eukaryotes to produce fertile offspring.','C',6,4),(134,'Consider a scenario where a microorganism is capable of nitrogen fixation, has a cell wall with peptidoglycan, and its cell membrane contains ester linkages. Based on this information, this microorganism would most likely be classified as a:','Methanogen','Halobacterium','Bacterium','Thaumarchaeota','C',6,4),(135,'The fact that \"Mitosis and meiosis do not occur in archaea\" suggests that their genetic material is:','Organized into multiple linear chromosomes that undergo complex segregation.','Replicated and distributed through simpler, non-mitotic mechanisms.','Absent, as they are prokaryotes.','Exchanged frequently through sexual reproduction.','B',6,4),(136,'Why would enzymes extracted from archaeans living in high acidity and alkalinity be particularly useful for rapid cloning of DNA in a laboratory?','They are less expensive to produce than other enzymes.','They can function efficiently under the harsh conditions, like high temperatures, required for techniques like PCR.','They catalyze a wider range of reactions than enzymes from other organisms.','They are less likely to denature in the presence of common laboratory contaminants.','B',6,4),(137,'If a microbial community is producing significant amounts of biogas from organic waste, which group of Archaea would you expect to be predominant in that environment?','Halobacteria','Thermococci','Methanogens','Thaumarchaeota','C',6,4),(138,'The divergence of Archaea from bacteria \"in very ancient times\" and their unique characteristics support the idea of:','A single, unified kingdom of prokaryotes.','A three-domain system of classification (Archaea, Bacteria, Eukarya).','Archaea being a transitional form between bacteria and eukaryotes.','Archaea being more closely related to viruses than to bacteria.','B',6,4),(139,'In the five-kingdom system, organisms belonging to the Domain Bacteria were previously classified under which kingdom?','Fungi','Protista','Monera','Animalia','C',6,5),(140,'What is the unique polymer that composes the cell wall of bacteria and provides structural support?','Cellulose','Chitin','Peptidoglycan','Lignin','C',6,5),(141,'Which of the following best describes the genetic material of bacteria?','Multiple linear chromosomes within a nucleus','A single, circular chromosome in the nucleoid region','RNA strands in the cytoplasm','Chromosomes enclosed within a membrane','B',6,5),(142,'How do bacteria primarily reproduce?','Sexual reproduction','Budding','Binary fission','Spore formation','C',6,5),(143,'Which bacterial shape is described as spherical?','Bacilli','Spirilla','Vibrios','Cocci','D',6,5),(144,'Hair-like structures in some bacteria that help in attachment to surfaces are called:','Flagella','Cilia','Pili and Fimbriae','Pseudopods','C',6,5),(145,'Which term describes bacteria that thrive in conditions of high salinity?','Thermophiles','Acidophiles','Halophiles','Psychrophiles','C',6,5),(146,'An example of a bacterium that belongs to the Proteobacteria group is:','Bacillus subtilis','Streptomyces','Escherichia coli','Anabaena','C',6,5),(147,'Which characteristic differentiates bacteria from Eukarya, according to the provided text?','Presence of flagella','Ability to perform photosynthesis','Lack of a true nucleus and membrane-bound organelles','Possession of a cell wall','C',6,5),(148,'The presence of plasmids in most bacteria is significant primarily because it contributes to:','Increased cell size','Enhanced rigidity of the cell wall','Genetic diversity and adaptation','More efficient binary fission','C',6,5),(149,'A bacterium that is described as a \"decomposer\" would fall under which nutritional mode?','Autotroph','Photosynthetic','Chemosynthetic','Heterotroph','D',6,5),(150,'If bacteria are found arranged in chains, what term would specifically describe this arrangement?','Diplococci','Staphylococci','Streptococci','Tetrads','C',6,5),(151,'A bacterial species that can produce energy in the absence of oxygen through fermentation would be categorized as:','Obligate aerobe','Microaerophile','Obligate anaerobe or Facultative anaerobe','Aerotolerant aerobe only','C',6,5),(152,'The fact that some bacteria cause diseases in humans, animals, and plants producing toxins or other virulence factors primarily describes their:','Symbiotic role','Extremophilic nature','Pathogenicity','Nutritional mode','C',6,5),(153,'Rhizobium, mentioned as an example of Proteobacteria, is often known for its mutualistic relationship with plants. This aligns with which general characteristic of bacteria?','Pathogenicity','Extremophilism','Respiration diversity','Symbiosis','D',6,5),(154,'Which of the following statements incorrectly characterizes bacteria based on the provided text?','All bacteria have a single, circular chromosome.','Some bacteria can thrive in high temperatures.','All bacteria are heterotrophic.','Bacteria primarily reproduce asexually.','C',6,5),(155,'Given the description of bacterial cell structure, which of the following processes would not occur within a membrane-bound organelle in a bacterium?','Protein synthesis','DNA replication','Energy production (e.g., cellular respiration)','Photosynthesis (in photosynthetic bacteria)','A',6,5),(156,'Which of the following is a defining characteristic of eukaryotic cells?','Absence of a nucleus','Presence of a true nucleus enclosed by a nuclear membrane','Lack of membrane-bounded organelles','DNA organized in a single circular chromosome','B',6,6),(157,'According to the text, what is the primary function of the cytoskeleton in eukaryotic cells?','Digestion of waste materials','Production of energy','Structural support, cell movement, and intracellular transport','Storage of genetic material','C',6,6),(158,'How is the DNA organized in eukaryotic cells?','As a single circular chromosome in the cytoplasm','In multiple linear chromosomes within the nucleus','Without any associated proteins','As loose genetic material scattered throughout the cell','B',6,6),(159,'Which type of reproduction is primarily associated with genetic diversity in eukaryotes?','Asexual reproduction through mitosis','Sexual reproduction involving meiosis and fertilization','Binary fission','Budding','B',6,6),(160,'What is the proposed origin of certain organelles like mitochondria and chloroplasts in eukaryotic cells?','Spontaneous generation','De novo synthesis within the host cell','Engulfment of prokaryotic cells through endosymbiosis','Direct inheritance from the earliest eukaryotic ancestor','C',6,6),(161,'The presence of membrane-bounded organelles in eukaryotes is crucial because it allows for:','Simpler cellular organization compared to prokaryotes.','The efficient compartmentalization of various metabolic processes.','Unrestricted movement of genetic material within the cell.','Direct interaction of all enzymes with the entire cytoplasm.','B',6,6),(162,'The association of DNA with histone proteins in eukaryotic chromosomes primarily indicates:','A simpler mechanism for gene expression.','A less organized and more chaotic genetic structure.','A highly organized and regulated system for genetic material.','An evolutionary link to organisms with plasmids only.','C',6,6),(163,'Considering the description of complex cellular organization in multicellular eukaryotes, which of the following is an accurate inference?','All cells in a multicellular eukaryote retain the ability to perform all functions of the organism.','Cellular differentiation leads to a division of labor among cells, enhancing overall organismal efficiency.','Tissues and organs are merely random aggregations of similar cells.','Specialized cells lose their nucleus and genetic material over time.','B',6,6),(164,'If a eukaryotic organism were unable to undergo meiosis, what would be the most significant long-term consequence for its population?','All offspring would be genetically identical, leading to increased genetic diversity.','There would be a significant reduction in genetic variation, making the population less adaptable.','The organism would exclusively reproduce sexually, increasing its reproductive rate.','Its cells would lose their true nucleus and become prokaryotic over generations.','B',6,6),(165,'The theory of endosymbiosis provides a compelling explanation for the presence of which of the following characteristics in eukaryotic cells, that is absent in prokaryotes?','A complex cytoskeleton','Multiple linear chromosomes','Membrane-bounded organelles like mitochondria and chloroplasts','The ability to reproduce asexually','C',6,6),(166,'What is the primary purpose of the hierarchical system in classifying living organisms?','To determine the age of organisms.','To categorize and understand relationships between life forms.','To identify the geographical distribution of species.','To measure the size of different organisms.','B',6,7),(167,'Which of the following is the singular term for \"taxa\" in the biological classification system?','Taxonomy','Taxon','Taxic','Taxis','B',6,7),(168,'Which of the following represents the correct order of the primary levels of taxonomic hierarchy from broadest to most specific?','Species, Genus, Family, Order, Class, Phylum, Kingdom, Domain','Domain, Kingdom, Phylum, Class, Order, Family, Genus, Species','Kingdom, Domain, Phylum, Class, Order, Family, Genus, Species','Domain, Phylum, Kingdom, Class, Order, Family, Genus, Species','B',6,7),(169,'What is currently considered the highest level of classification in the taxonomic hierarchy?','Kingdom','Phylum','Domain','Species','C',6,7),(170,'How many domains are currently recognized in the classification of living organisms?','Two','Three','Four','Five','B',6,7),(171,'Which of the following is NOT one of the three recognized domains of life?','Archaea','Bacteria','Protista','Eukarya','C',6,7),(172,'Which taxonomic rank is just below \"Domain\" and groups together forms of life sharing fundamental characteristics?','Phylum','Class','Kingdom','Order','C',6,7),(173,'In the domain Eukarya, which of the following is explicitly mentioned as a kingdom?','Viruses','Protista','Algae','Monera','B',6,7),(174,'What characteristic defines the organisms grouped within the kingdom Animalia, as given in the example?','They produce their own food.','They are all single-celled.','They are heterotrophic and typically move.','They absorb nutrients from the environment.','C',6,7),(175,'What is the defining characteristic for organisms belonging to the phylum Chordata, according to the text?','Having a backbone.','Having a notochord.','Possessing gills.','Living in water.','B',6,7),(176,'The class Mammalia is characterized by which of the following features?','Laying eggs and having scales.','Having feathers and wings.','Possessing hair and mammary glands.','Being cold-blooded.','C',6,7),(177,'Based on the provided text, which taxonomic rank categorizes organisms within a class based on additional shared characteristics and evolutionary history?','Family','Order','Genus','Species','B',6,7),(178,'What shared characteristics define the order Primates, as exemplified in the text?','Aquatic habitat and fins.','Large brains and opposable thumbs.','Shells and slow movement.','Burrowing behavior and small eyes.','B',6,7),(179,'Within the order Primates, which family includes great apes and humans?','Felidae','Canidae','Hominidae','Ursidae','C',6,7),(180,'What distinguishes a genus from a family in the taxonomic hierarchy?','A genus is broader than a family.','A genus groups species that are very closely related and often visually similar.','A genus is based solely on geographical distribution.','A genus includes only extinct organisms.','B',6,7),(181,'Which genus is explicitly stated to include humans and our closest extinct relatives?','Pan','Gorilla','Pongo','Homo','D',6,7),(182,'What is the most specific level of classification in the taxonomic hierarchy?','Genus','Family','Species','Order','C',6,7),(183,'What is the primary criterion for members of a species to be classified together?','They share the same diet.','They can interbreed and produce fertile offspring.','They live in the same geographical area.','They have similar body sizes.','B',6,7),(184,'The term Homo sapiens refers to which specific group of organisms?','All primates','Great apes','Modern humans','Early hominids','C',6,7),(185,'If two organisms belong to the same Class but different Orders, what can be definitively concluded about their relationship?','They cannot interbreed.','They share a basic body plan but differ in more specific characteristics.','They belong to different Kingdoms.','They are in the same family.','B',6,7),(186,'A scientist discovers a new organism that photosynthesizes and is multicellular with specialized tissues, but lacks the ability to move independently. Into which kingdom would it most likely be classified?','Animalia','Fungi','Plantae','Protista','C',6,7),(187,'The classification system\'s hierarchy implies that organisms in the same \'Order\' are more closely related than organisms in the same \'Class\'. Which of the following statements best supports this inference?','Orders are directly below Classes in the hierarchy, indicating a narrower grouping.','Organisms in the same class share only a basic body plan.','Orders categorize based on \"additional shared characteristics and evolutionary history.\"','The definition of \'Order\' emphasizes visual similarity more than \'Class\'.','C',6,7),(188,'Which of the following statements correctly applies the concept of shared characteristics across different taxonomic levels?','All organisms in the same Family share a notochord.','All organisms in the same Kingdom share the ability to interbreed.','All organisms in the same Phylum share significant structural features.','All organisms in the same Genus have mammary glands.','C',6,7),(189,'Consider an organism classified as Canis familiaris. Based on the hierarchy, which of the following is true?','Canis is its species, and familiaris is its genus.','It belongs to the order Primates.','It is in the same genus as Homo sapiens.','It shares common attributes with other members of its family, Canidae.','D',6,7),(190,'The transition from \"Phylum\" to \"Class\" involves further dividing organisms based on:','Fundamental characteristics.','Basic body plans.','More specific common traits.','The ability to produce fertile offspring.','C',6,7);
/*!40000 ALTER TABLE `mcqdb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `section_id` int(11) DEFAULT NULL,
  `title` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`notification_id`),
  KEY `fk_notification_class` (`class_id`),
  KEY `fk_notification_section` (`section_id`),
  CONSTRAINT `fk_notification_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_notification_section` FOREIGN KEY (`section_id`) REFERENCES `class_sections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` (`notification_id`, `class_id`, `section_id`, `title`, `message`, `created_at`, `created_by`, `is_active`) VALUES (1,4,7,'notification','hello','2025-05-18 16:39:08','test@test.com',0),(2,4,7,'Quiz Starting time','Quiz of Biology Chapter 1 Will start at 9:00Am. ','2025-05-18 17:07:45','Hassan.tariq771@gmail.com',1);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `numericaldb`
--

DROP TABLE IF EXISTS `numericaldb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `numericaldb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `answer` int(11) NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_fk_numericaldb_chapter` (`chapter_id`),
  KEY `idx_fk_numericaldb_topic` (`topic_id`),
  CONSTRAINT `fk_numericaldb_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_numericaldb_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `numericaldb`
--

LOCK TABLES `numericaldb` WRITE;
/*!40000 ALTER TABLE `numericaldb` DISABLE KEYS */;
/*!40000 ALTER TABLE `numericaldb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_chapters`
--

DROP TABLE IF EXISTS `quiz_chapters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_chapters` (
  `quiz_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  PRIMARY KEY (`quiz_id`,`chapter_id`),
  KEY `fk_quiz_chapter_chapter` (`chapter_id`),
  CONSTRAINT `fk_quiz_chapter_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_quiz_chapter_quiz` FOREIGN KEY (`quiz_id`) REFERENCES `quizconfig` (`quizid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_chapters`
--

LOCK TABLES `quiz_chapters` WRITE;
/*!40000 ALTER TABLE `quiz_chapters` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_chapters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizconfig`
--

DROP TABLE IF EXISTS `quizconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizconfig` (
  `quizid` int(11) NOT NULL AUTO_INCREMENT,
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
  `is_random` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`quizid`),
  KEY `fk_quiz_class` (`class_id`),
  KEY `fk_quiz_subject` (`subject_id`),
  KEY `fk_quiz_section` (`section_id`),
  CONSTRAINT `fk_quiz_class` FOREIGN KEY (`class_id`) REFERENCES `classes` (`class_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_quiz_section` FOREIGN KEY (`section_id`) REFERENCES `class_sections` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_quiz_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizconfig`
--

LOCK TABLES `quizconfig` WRITE;
/*!40000 ALTER TABLE `quizconfig` DISABLE KEYS */;
INSERT INTO `quizconfig` (`quizid`, `quiznumber`, `quizname`, `starttime`, `endtime`, `duration`, `attempts`, `mcq`, `numerical`, `dropdown`, `fill`, `short`, `essay`, `mcqmarks`, `numericalmarks`, `dropdownmarks`, `fillmarks`, `shortmarks`, `essaymarks`, `maxmarks`, `typea`, `typeamarks`, `typeb`, `typebmarks`, `typec`, `typecmarks`, `typed`, `typedmarks`, `typee`, `typeemarks`, `typef`, `typefmarks`, `total_questions`, `class_id`, `chapter_ids`, `topic_ids`, `subject_id`, `section`, `section_id`, `is_random`) VALUES (98,1,'1st','2025-05-18 21:01:00','2025-05-19 21:01:00',10,1,5,0,0,0,5,0,1,0,0,0,2,0,15,5,1,0,0,0,0,0,0,5,2,0,0,10,4,'6','',1,'B',NULL,1),(99,2,'2nd','2025-05-18 21:01:00','2025-05-19 21:01:00',10,1,5,0,0,0,5,0,1,0,0,0,2,0,15,5,1,0,0,0,0,0,0,5,2,0,0,10,4,'6','',1,'B',NULL,1),(100,3,'3rd','2025-05-18 21:02:00','2025-05-19 21:02:00',10,1,5,0,0,0,5,0,1,0,0,0,2,0,15,5,1,0,0,0,0,0,0,5,2,0,0,10,4,'6','',1,'B',NULL,1),(107,4,'1st year chap 1','2025-05-19 10:42:00','2025-05-19 10:59:00',10,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,4,'6,7','',1,'B',NULL,1),(120,5,'1','2025-06-13 14:12:00','2025-06-14 14:12:00',10,1,4,0,0,1,4,0,1,0,0,0,0,0,4,4,1,0,0,0,0,1,0,4,0,0,0,9,4,'6','3',1,'B',NULL,1),(121,6,'2','2025-06-13 14:12:00','2025-06-14 14:12:00',10,1,4,0,0,1,4,0,1,0,0,0,1,0,8,4,1,0,0,0,0,1,0,4,1,0,0,9,4,'6','3',1,'B',NULL,1),(122,7,'3','2025-06-13 14:25:00','2025-06-14 14:25:00',10,1,4,0,0,1,4,0,1,0,0,0,2,0,12,4,1,0,0,0,0,1,0,4,2,0,0,9,4,'6','0',1,'B',NULL,1),(123,8,'4','2025-06-13 14:25:00','2025-06-14 14:25:00',10,1,4,0,0,1,4,0,1,0,0,0,2,0,12,4,1,0,0,0,0,1,0,4,2,0,0,9,4,'6,7','0',1,'B',NULL,1);
/*!40000 ALTER TABLE `quizconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizrecord`
--

DROP TABLE IF EXISTS `quizrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizrecord` (
  `quizid` int(11) NOT NULL,
  `rollnumber` int(11) NOT NULL,
  `attempt` int(11) NOT NULL,
  `starttime` datetime NOT NULL,
  `endtime` datetime DEFAULT NULL,
  PRIMARY KEY (`quizid`,`rollnumber`,`attempt`),
  KEY `rollnumber` (`rollnumber`),
  CONSTRAINT `quizrecord_ibfk_1` FOREIGN KEY (`quizid`) REFERENCES `quizconfig` (`quizid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `quizrecord_ibfk_2` FOREIGN KEY (`rollnumber`) REFERENCES `studentinfo` (`rollnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizrecord`
--

LOCK TABLES `quizrecord` WRITE;
/*!40000 ALTER TABLE `quizrecord` DISABLE KEYS */;
INSERT INTO `quizrecord` (`quizid`, `rollnumber`, `attempt`, `starttime`, `endtime`) VALUES (120,1,1,'2025-06-13 14:14:10','2025-06-13 14:15:14'),(120,2,1,'2025-06-13 14:15:25','2025-06-13 14:15:55'),(121,1,1,'2025-06-13 14:16:45',NULL),(121,2,1,'2025-06-13 14:16:01','2025-06-13 14:16:31'),(122,1,1,'2025-06-13 15:02:01','2025-06-13 15:02:05'),(123,1,1,'2025-06-13 15:02:09','2025-06-13 15:02:12');
/*!40000 ALTER TABLE `quizrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `random_quiz_questions`
--

DROP TABLE IF EXISTS `random_quiz_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `random_quiz_questions` (
  `quizid` int(11) NOT NULL,
  `qtype` varchar(20) NOT NULL,
  `qid` int(11) NOT NULL,
  `serialnumber` int(11) NOT NULL,
  PRIMARY KEY (`quizid`,`qtype`,`qid`),
  CONSTRAINT `fk_random_quiz_quizid` FOREIGN KEY (`quizid`) REFERENCES `quizconfig` (`quizid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `random_quiz_questions`
--

LOCK TABLES `random_quiz_questions` WRITE;
/*!40000 ALTER TABLE `random_quiz_questions` DISABLE KEYS */;
INSERT INTO `random_quiz_questions` (`quizid`, `qtype`, `qid`, `serialnumber`) VALUES (98,'a',13,3),(98,'a',16,2),(98,'a',17,4),(98,'a',19,1),(98,'a',20,5),(98,'e',2,7),(98,'e',4,10),(98,'e',5,6),(98,'e',7,9),(98,'e',8,8),(99,'a',13,4),(99,'a',15,3),(99,'a',16,2),(99,'a',18,1),(99,'a',19,5),(99,'e',2,9),(99,'e',3,10),(99,'e',4,6),(99,'e',6,8),(99,'e',8,7),(100,'a',12,1),(100,'a',13,4),(100,'a',17,5),(100,'a',20,2),(100,'a',48,3),(100,'e',3,9),(100,'e',4,8),(100,'e',5,7),(100,'e',7,6),(100,'e',8,10),(120,'a',74,2),(120,'a',76,3),(120,'a',80,1),(120,'a',87,4),(120,'d',12,5),(120,'e',39,9),(120,'e',40,8),(120,'e',41,6),(120,'e',52,7),(121,'a',77,4),(121,'a',82,1),(121,'a',84,3),(121,'a',86,2),(121,'d',13,5),(121,'e',48,8),(121,'e',49,6),(121,'e',55,9),(121,'e',57,7),(122,'a',76,2),(122,'a',81,3),(122,'a',85,4),(122,'a',86,1),(122,'d',10,5),(122,'e',39,8),(122,'e',54,6),(122,'e',56,7),(122,'e',60,9),(123,'a',74,1),(123,'a',77,3),(123,'a',78,2),(123,'a',85,4),(123,'d',14,5),(123,'e',39,8),(123,'e',42,6),(123,'e',48,9),(123,'e',54,7);
/*!40000 ALTER TABLE `random_quiz_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `response`
--

DROP TABLE IF EXISTS `response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `response` (
  `quizid` int(11) NOT NULL,
  `rollnumber` int(11) NOT NULL,
  `attempt` int(11) NOT NULL,
  `qtype` varchar(20) NOT NULL,
  `qid` int(11) NOT NULL,
  `response` text NOT NULL,
  `serialnumber` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`quizid`,`rollnumber`,`attempt`,`qtype`,`qid`),
  KEY `rollnumber` (`rollnumber`),
  KEY `idx_serialnumber` (`serialnumber`),
  CONSTRAINT `response_ibfk_1` FOREIGN KEY (`quizid`) REFERENCES `quizconfig` (`quizid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `response_ibfk_2` FOREIGN KEY (`rollnumber`) REFERENCES `studentinfo` (`rollnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `response`
--

LOCK TABLES `response` WRITE;
/*!40000 ALTER TABLE `response` DISABLE KEYS */;
INSERT INTO `response` (`quizid`, `rollnumber`, `attempt`, `qtype`, `qid`, `response`, `serialnumber`) VALUES (120,1,1,'a',74,'A',2),(120,1,1,'a',76,'A',3),(120,1,1,'a',80,'C',1),(120,1,1,'a',87,'A',4),(120,1,1,'d',12,'',5),(120,1,1,'e',39,'',9),(120,1,1,'e',40,'',8),(120,1,1,'e',41,'',6),(120,1,1,'e',52,'',7),(120,2,1,'a',74,'B',2),(120,2,1,'a',76,'B',3),(120,2,1,'a',80,'A',1),(120,2,1,'a',87,'C',4),(120,2,1,'d',12,'',5),(120,2,1,'e',39,'',9),(120,2,1,'e',40,'',8),(120,2,1,'e',41,'',6),(120,2,1,'e',52,'',7),(121,1,1,'a',77,'',4),(121,1,1,'a',82,'',1),(121,1,1,'a',84,'',3),(121,1,1,'a',86,'',2),(121,1,1,'d',13,'',5),(121,1,1,'e',48,'',8),(121,1,1,'e',49,'',6),(121,1,1,'e',55,'',9),(121,1,1,'e',57,'',7),(121,2,1,'a',77,'C',4),(121,2,1,'a',82,'A',1),(121,2,1,'a',84,'B',3),(121,2,1,'a',86,'A',2),(121,2,1,'d',13,'',5),(121,2,1,'e',48,'',8),(121,2,1,'e',49,'',6),(121,2,1,'e',55,'',9),(121,2,1,'e',57,'',7),(122,1,1,'a',76,'',2),(122,1,1,'a',81,'',3),(122,1,1,'a',85,'',4),(122,1,1,'a',86,'',1),(122,1,1,'d',10,'',5),(122,1,1,'e',39,'',8),(122,1,1,'e',54,'',6),(122,1,1,'e',56,'',7),(122,1,1,'e',60,'',9),(123,1,1,'a',74,'',1),(123,1,1,'a',77,'',3),(123,1,1,'a',78,'',2),(123,1,1,'a',85,'',4),(123,1,1,'d',14,'',5),(123,1,1,'e',39,'',8),(123,1,1,'e',42,'',6),(123,1,1,'e',48,'',9),(123,1,1,'e',54,'',7);
/*!40000 ALTER TABLE `response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `result`
--

DROP TABLE IF EXISTS `result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `result` (
  `quizid` int(11) NOT NULL,
  `rollnumber` int(11) NOT NULL,
  `attempt` int(11) NOT NULL,
  `mcqmarks` int(11) NOT NULL,
  `numericalmarks` int(11) NOT NULL,
  `dropdownmarks` int(11) NOT NULL,
  `fillmarks` int(11) NOT NULL,
  `shortmarks` int(11) NOT NULL,
  `essaymarks` int(11) NOT NULL,
  PRIMARY KEY (`quizid`,`rollnumber`,`attempt`),
  KEY `rollnumber` (`rollnumber`),
  CONSTRAINT `result_ibfk_1` FOREIGN KEY (`quizid`) REFERENCES `quizconfig` (`quizid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `result_ibfk_2` FOREIGN KEY (`rollnumber`) REFERENCES `studentinfo` (`rollnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `result`
--

LOCK TABLES `result` WRITE;
/*!40000 ALTER TABLE `result` DISABLE KEYS */;
INSERT INTO `result` (`quizid`, `rollnumber`, `attempt`, `mcqmarks`, `numericalmarks`, `dropdownmarks`, `fillmarks`, `shortmarks`, `essaymarks`) VALUES (120,1,1,0,0,0,0,0,0),(120,2,1,1,0,0,0,0,0),(121,2,1,1,0,0,0,0,0),(122,1,1,0,0,0,0,0,0),(123,1,1,0,0,0,0,0,0);
/*!40000 ALTER TABLE `result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shortanswer`
--

DROP TABLE IF EXISTS `shortanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shortanswer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `topic_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_fk_shortanswer_chapter` (`chapter_id`),
  KEY `idx_fk_shortanswer_topic` (`topic_id`),
  CONSTRAINT `fk_shortanswer_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_shortanswer_topic` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`topic_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shortanswer`
--

LOCK TABLES `shortanswer` WRITE;
/*!40000 ALTER TABLE `shortanswer` DISABLE KEYS */;
INSERT INTO `shortanswer` (`id`, `question`, `answer`, `chapter_id`, `topic_id`) VALUES (39,'Who proposed the five-kingdom classification system?','[Your Answer Here]',6,3),(40,'In what year was the five-kingdom system proposed?','[Your Answer Here]',6,3),(41,'What are the five kingdoms in Whittaker\'s classification system?','[Your Answer Here]',6,3),(42,'Which kingdom in the five-kingdom system included prokaryotes?','[Your Answer Here]',6,3),(43,'Which kingdoms in the five-kingdom system included eukaryotes?','[Your Answer Here]',6,3),(44,'Who suggested there are two separate groups of prokaryotes?','[Your Answer Here]',6,3),(45,'In what year did Carl Woese propose the three-domain system?','[Your Answer Here]',6,3),(46,'What are the three domains of classification?','[Your Answer Here]',6,3),(47,'Which two domains contain prokaryotes?','[Your Answer Here]',6,3),(48,'What is phylogeny?','[Your Answer Here]',6,3),(49,'What is a phylogenetic or evolutionary tree?','[Your Answer Here]',6,3),(50,'How did Carl Woese\'s classification differ from Whittaker\'s regarding prokaryotes?','[Your Answer Here]',6,3),(51,'What is the main distinction between the Monera kingdom and the two prokaryotic domains?','[Your Answer Here]',6,3),(52,'According to molecular evidence, which domain is more closely related to eukaryotes?','[Your Answer Here]',6,3),(53,'From which domain are eukaryotes believed to have evolved?','[Your Answer Here]',6,3),(54,'What is the significance of the \"three-domain system\" in terms of classifying life?','[Your Answer Here]',6,3),(55,'Briefly explain why the three-domain system was introduced after the five-kingdom system.','[Your Answer Here]',6,3),(56,'Discuss the fundamental difference in the underlying principle of classification between Whittaker\'s five-kingdom system and Woese\'s three-domain system, particularly concerning prokaryotic diversity.','[Your Answer Here]',6,3),(57,'Elaborate on the evolutionary implications of the statement: \"Eukarya evolved from Archaea, after archaea split off from the Bacteria.\"','[Your Answer Here]',6,3),(58,'Besides the presence of prokaryotes, what key differences might exist between Archaea and Bacteria that led Woese to classify them as separate domains?','[Your Answer Here]',6,3),(59,'How does the concept of \"phylogeny\" enhance our understanding of biodiversity beyond mere categorization?','[Your Answer Here]',6,3),(60,'If new molecular evidence were to contradict the close relationship between Archaea and Eukarya, how might this impact the current three-domain system of classification?','[Your Answer Here]',6,3),(63,'What is the approximate diameter range of individual archaeans?','From 0.1 micrometers to over 15 micrometers.',6,4),(66,'What cellular processes related to division do not occur in archaea?','Mitosis and meiosis.',6,4),(72,'Name a metabolic process unique to Archaea.','Methanogenesis (production of methane).',6,4),(76,'Which group of Archaea is involved in the nitrogen cycle?','Thaumarchaeota.',6,4),(78,'Explain why the ether-linkages and branched fatty acid chains in archaeal cell membranes contribute to their resistance to extreme conditions.','The ether-linkages and branched fatty acid chains provide greater stability and rigidity to the cell membrane, making it more resistant to denaturation or breakdown under extreme temperatures, pH, or salinity.',6,4),(80,'In what way does methanogenesis highlight the metabolic uniqueness of Archaea compared to Bacteria and Eukarya?','Methanogenesis (the production of methane) is a unique metabolic pathway exclusively found in certain groups of Archaea and is not observed in any bacteria or eukaryotes, making it a distinct characteristic of this domain.',6,4),(81,'What evolutionary implication is suggested by Archaea sharing genetic sequences and regulatory features with eukaryotes?','It suggests that Archaea and Eukarya share a closer evolutionary relationship and a more recent common ancestor with each other than either does with Bacteria, indicating a shared evolutionary history.',6,4),(82,'Beyond their ability to survive in harsh environments, what is the significance of archaeans living in high acidity and alkalinity for laboratory applications?','They are a source of enzymes (like DNA replication enzymes) that can function under harsh conditions, such as high temperatures, which is useful for rapid cloning of DNA in laboratory techniques like PCR.',6,4),(83,'If human intestinal gas is largely a result of methanogen metabolism, what does this imply about their habitat within the human body?','It implies that methanogens inhabit anaerobic environments within the human gut, where they metabolize substrates to produce methane gas.',6,4),(86,'Explain why Archaea are a unique domain, distinct from Bacteria, highlighting their fundamental differences.','Archaea are a unique domain due to distinct biochemical and genetic properties. Their cell membranes feature ether-linked, branched fatty acids, unlike bacteria\'s ester-linked ones, contributing to extreme environment survival. Their cell walls lack peptidoglycan, distinguishing them from bacteria. Unique metabolic processes, like methanogenesis, and shared genetic features with Eukarya further solidify their separate evolutionary classification.',6,4),(87,'Compare archaeal, bacterial, and eukaryotic cell membrane compositions, detailing how archaeal membrane enables survival in extreme environments.','Archaeal cell membranes have ether-linkages and branched fatty acid chains, conferring unique stability. In contrast, Bacteria and Eukarya have ester-linkages and unbranched chains. This structural difference makes archaeal membranes highly resistant to denaturation by extreme temperatures, pH, or salinity, enabling them to thrive in harsh environments where other life forms cannot survive.',6,4),(88,'Contrast the cell wall compositions across Archaea, Bacteria, and Eukarya, and discuss their significance for classification and cellular integrity.','Archaea lack peptidoglycan in their cell walls, using polysaccharides, proteins, or pseudopeptidoglycan instead. Bacteria uniquely possess peptidoglycan for structural support. Eukaryotic cell walls (if present) are cellulose (plants) or chitin (fungi). These fundamental differences are vital for taxonomic classification and illustrate varied strategies for cellular integrity and environmental adaptation across domains.',6,4),(89,'Describe methanogenesis as a unique metabolic process in Archaea. What are its ecological and practical implications?','Methanogenesis, methane production, is an exclusive metabolic pathway of certain Archaea. Ecologically, methanogens are crucial in anaerobic environments, contributing to the carbon cycle. Practically, they are vital in sewage treatment through anaerobic digestion, producing biogas (methane), which is a renewable energy source, aiding in waste management and energy generation.',6,4),(90,'What does the shared genetic and regulatory features between Archaea and Eukarya suggest about their evolutionary relationship?','The shared genetic sequences and regulatory features between Archaea and Eukarya suggest a closer evolutionary relationship between these two domains than either has with Bacteria. This implies a more recent common ancestor for Archaea and Eukarya, or that Eukarya may have evolved directly from an archaeal lineage, highlighting a pivotal divergence in the tree of life.',6,4),(91,'Discuss the biotechnological significance of extremophilic archaeans (high acidity/alkalinity), providing a specific application example.','Extremophilic archaeans, such as those from high acidity or alkalinity, are biotechnologically significant as a source of highly stable enzymes (extremozymes). These enzymes function optimally under harsh conditions that would denature most other proteins. For instance, archaeal DNA replication enzymes thrive at high temperatures, making them invaluable for rapid DNA cloning techniques like Polymerase Chain Reaction (PCR) in molecular biology laboratories.',6,4),(92,'Explain the role of methanogen archaeans in sewage treatment and biogas production, detailing their metabolic contribution.','Methanogen archaeans are fundamental to sewage treatment by conducting anaerobic digestion, breaking down organic waste in oxygen-free environments. During this process, they produce methane as a byproduct. This methane is captured as biogas, serving as a renewable energy source. Their metabolic activity efficiently treats wastewater while simultaneously generating clean energy, highlighting their critical environmental and practical utility.',6,4),(93,'Given the absence of mitosis and meiosis in Archaea, discuss the implications for their genetic organization and propagation mechanisms.','The absence of mitosis and meiosis in Archaea implies a simpler genetic organization, typically a single circular chromosome, without the complex eukaryotic chromosomal segregation mechanisms. Their genetic propagation occurs through asexual processes like binary fission, which involve direct replication and division of the genetic material. This also suggests that genetic diversity, if present, is maintained through horizontal gene transfer rather than sexual recombination.',6,4),(94,'Characterize the \"extreme conditions\" where Archaea thrive, referencing specific groups, and explain their cellular adaptations for survival.','Archaea thrive in \"extreme conditions\" such as high temperatures (e.g., Thermococci), extreme salinity (e.g., Halobacteria), or very high/low pH. Their cellular adaptations include unique ether-linked, branched membrane lipids that provide superior membrane stability and rigidity. These specialized membranes and extremophilic enzymes allow their cellular components to remain functional and intact under environmental stresses that would otherwise destroy most other forms of life.',6,4),(95,'Beyond lacking a true nucleus and membrane-bound organelles, what other fundamental characteristic do bacterial cells share with archaeal cells regarding their genetic material?','',6,5),(96,'How does the unique composition of the bacterial cell wall contribute to the organism\'s structural integrity and overall shape?','',6,5),(97,'Explain the significance of plasmids in bacteria, particularly in relation to genetic diversity.','',6,5),(98,'Describe the primary method of reproduction in bacteria and what the outcome of this process is.','',6,5),(99,'In what ways do bacteria exhibit diversity in their morphology and arrangement, providing examples for each?','',6,5),(100,'Differentiate between the functions of flagella and pili/fimbriae in bacterial cells.','',6,5),(101,'Briefly explain what an \"obligate anaerobe\" and a \"facultative anaerobe\" are in terms of oxygen requirement.','',6,5),(102,'How do extremophilic bacteria challenge our understanding of habitable environments, providing examples of the conditions they can tolerate?','',6,5),(103,'Discuss the dual nature of bacteria, encompassing both pathogenicity and symbiotic relationships.','',6,5),(104,'Identify two major groups of bacteria and provide an example of a specific bacterium belonging to each group.','',6,5),(105,'Why is peptidoglycan considered a \"unique polymer\" when discussing bacterial cell wall composition, and what does this imply about its presence in other domains?','',6,5),(106,'Based on the nutritional modes described, how might a photosynthetic bacterium differ from a decomposer bacterium in terms of obtaining energy?','',6,5),(107,'If a bacterial infection is being treated, how might understanding the various respiratory modes of bacteria (e.g., obligate aerobe vs. obligate anaerobe) be relevant to treatment strategies?','',6,5),(108,'Some bacteria were included in Kingdom Monera. What does this historical classification suggest about the initial understanding of bacterial life compared to the current three-domain system?','',6,5),(109,'In what fundamental ways do eukaryotic cells differ from prokaryotic cells, as implied by their classification into separate domains?','Eukaryotic cells are fundamentally different from prokaryotic cells due to the presence of a true nucleus enclosed by a nuclear membrane and various membrane-bounded organelles. Prokaryotic cells lack these internal compartmentalizations, having their genetic material in a nucleoid region and no membrane-bound organelles.',6,6),(110,'Describe the key components of a eukaryotic cell\'s internal structure beyond the nucleus, highlighting how these components contribute to cellular function.','Beyond the nucleus, eukaryotic cells contain membrane-bounded organelles like mitochondria for energy production, endoplasmic reticulum for protein and lipid synthesis, and the Golgi apparatus for modifying and packaging molecules. Chloroplasts in plants and algae perform photosynthesis. The cytoskeleton provides structural support, facilitates cell movement, and aids intracellular transport.',6,6),(111,'Explain the multifaceted role of the cytoskeleton in eukaryotic cells, providing examples of its contributions to cellular activities.','The cytoskeleton, composed of microtubules, microfilaments, and intermediate filaments, serves multiple crucial roles. It provides structural support, maintaining cell shape. It also enables various forms of cell movement, such as crawling or muscle contraction, and facilitates intracellular transport of organelles and vesicles throughout the cell.',6,6),(112,'How is the genetic material in eukaryotes organized, and what is the significance of its association with histone proteins?','In eukaryotes, DNA is organized into multiple linear chromosomes located within the nucleus. This DNA is intimately associated with histone proteins, which help compact the long DNA strands into a more manageable structure and play a vital role in regulating gene expression by controlling access to the DNA.',6,6),(113,'Compare and contrast the two main modes of reproduction in eukaryotes, explaining the primary outcome of each in terms of genetic variation.','Eukaryotes primarily reproduce sexually through meiosis and fertilization, which shuffles genetic material, leading to increased genetic diversity in offspring. They can also reproduce asexually via mitosis, producing genetically identical offspring. Asexual reproduction allows for rapid population growth, while sexual reproduction enhances adaptability to changing environments.',6,6),(114,'To what extent does cellular differentiation contribute to the complexity observed in multicellular eukaryotes, and what is the ultimate result of this process?','Cellular differentiation extensively contributes to the complexity of multicellular eukaryotes by allowing cells to specialize for specific functions. This specialization leads to the formation of distinct tissues and organs, resulting in a division of labor that increases the overall efficiency and complexity of the organism as a whole.',6,6),(115,'Elaborate on the theory of endosymbiosis, explaining how it accounts for the evolutionary origin of specific eukaryotic organelles mentioned in the text.','The theory of endosymbiosis proposes that eukaryotic cells originated when a host cell engulfed certain prokaryotic cells, leading to a symbiotic relationship. Specifically, this theory explains the presence of mitochondria (from engulfed aerobic bacteria) and chloroplasts (from engulfed photosynthetic cyanobacteria) as membrane-bounded organelles within eukaryotic cells.',6,6),(116,'Why is the presence of a nuclear membrane considered a defining characteristic that differentiates eukaryotic cells from prokaryotic cells?','The nuclear membrane is a defining characteristic because it encloses the genetic material (DNA) within a true nucleus, creating a distinct compartment for transcription and replication. This spatial separation allows for more complex gene regulation and processing of RNA, which is absent in prokaryotes where genetic material is in the cytoplasm.',6,6),(117,'Beyond providing structural support, how do the various membrane-bounded organelles collectively enhance the efficiency and specialization of eukaryotic cells?','Membrane-bounded organelles enhance efficiency and specialization by compartmentalizing various metabolic processes, preventing interference between incompatible reactions and allowing for optimized conditions within each organelle. This division of labor enables eukaryotic cells to perform a vast array of complex functions simultaneously, leading to cellular specialization within multicellular organisms.',6,6),(118,'If eukaryotes primarily reproduced only through mitosis, what would be the long-term implications for their adaptation and survival in changing environments?','If eukaryotes only reproduced through mitosis, their populations would experience a severe reduction in genetic diversity. Without the genetic recombination provided by meiosis, populations would have limited variation, making them less adaptable and vulnerable to environmental changes, diseases, and novel selective pressures, potentially leading to extinction.',6,6),(119,'How does the organization of DNA into multiple linear chromosomes, as opposed to a single circular one, potentially offer advantages for eukaryotic genetic regulation and cellular processes?','The organization of DNA into multiple linear chromosomes allows for more intricate and independent regulation of gene expression across different chromosomal regions. It also facilitates complex processes like mitosis and meiosis, where precise segregation of large amounts of genetic material is critical. The linear structure also provides telomeres, which protect chromosome ends during replication.',6,6),(120,'Based on the provided characteristics, how do the features of \"Complex Cellular Organization\" and \"Cell Structure\" collectively justify the classification of Eukarya as a distinct domain?','The \"Cell Structure\" of eukaryotes, with its true nucleus and membrane-bounded organelles, sets them apart from prokaryotes by allowing for internal compartmentalization and functional specialization at the cellular level. This foundation enables \"Complex Cellular Organization,\" where cells differentiate into tissues and organs, demonstrating a level of complexity in multicellularity that justifies Eukarya\'s classification as a distinct and evolutionarily advanced domain.',6,6),(121,'What specific evidence from the characteristics presented would lead scientists to hypothesize that eukaryotes have a distinct evolutionary pathway compared to Bacteria and Archaea?','The text points to \"Evolutionary Relationships\" through endosymbiosis as evidence of a distinct pathway, suggesting that eukaryotes arose from the engulfment of prokaryotic cells. This is supported by the unique presence of complex membrane-bounded organelles like mitochondria and chloroplasts in eukaryotes, features not found in Bacteria or Archaea, indicating a separate evolutionary history involving symbiotic events.',6,6),(122,'Explain the fundamental purpose of the hierarchical classification system for living organisms. How does this system aid scientists in their understanding of life?','',6,7),(123,'Identify and briefly describe the three currently recognized domains of life. What is the primary characteristic that differentiates organisms within the Eukarya domain from the other two?','',6,7),(124,'Discuss the role of a \"Kingdom\" in the taxonomic hierarchy. Provide an example to illustrate how different forms of life are grouped at this level.','',6,7),(125,'How does the Phylum level further refine classification below the Kingdom? Using the example of Chordata, explain what defining feature organisms within this phylum share.','',6,7),(126,'Describe the characteristics that distinguish a \"Class\" from a \"Phylum.\" What specific traits characterize the Mammalia class within the phylum Chordata?','',6,7),(127,'In what ways does the \"Order\" categorize organisms beyond the \"Class\" level? Illustrate this with the example of Primates, highlighting their shared features.','',6,7),(128,'Explain the relationship between \"Family\" and \"Order\" in the classification system. What makes organisms within the same family, such as Hominidae, more closely related than those only in the same order?','',6,7),(129,'What is the significance of the \"Genus\" in the taxonomic hierarchy, and how does it relate to the \"Family\"? Provide an example of how species are grouped within a genus.','',6,7),(130,'Define \"Species\" as the most specific level of classification. What is the critical biological criterion that determines whether organisms belong to the same species?','',6,7),(131,'Considering the entire hierarchy, how do the levels progressively become more specific? Explain why the ability to interbreed is reserved for the species level, rather than higher ranks.','',6,7),(132,'Why is it important for the taxonomic hierarchy to be organized from broad to specific levels? How does this structure benefit the study of evolutionary relationships?','',6,7),(133,'If two different organisms belong to the same Class but are in different Orders, what does this imply about their shared characteristics and evolutionary divergence?','',6,7),(134,'Choose any two adjacent levels (e.g., Kingdom and Phylum) and elaborate on how the classification becomes more detailed or specialized from the higher to the lower rank.','',6,7);
/*!40000 ALTER TABLE `shortanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentinfo`
--

DROP TABLE IF EXISTS `studentinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentinfo` (
  `name` varchar(30) NOT NULL,
  `rollnumber` int(11) NOT NULL,
  `department` varchar(20) NOT NULL,
  `program` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `section_id` int(11) DEFAULT NULL COMMENT 'Reference to class_sections table',
  `section` varchar(50) DEFAULT NULL COMMENT 'Student section',
  PRIMARY KEY (`rollnumber`),
  KEY `idx_section_id` (`section_id`),
  CONSTRAINT `fk_student_section` FOREIGN KEY (`section_id`) REFERENCES `class_sections` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentinfo`
--

LOCK TABLES `studentinfo` WRITE;
/*!40000 ALTER TABLE `studentinfo` DISABLE KEYS */;
INSERT INTO `studentinfo` (`name`, `rollnumber`, `department`, `program`, `password`, `email`, `section_id`, `section`) VALUES ('1',1,'1st Year','','123','1@test.com',7,'B'),('2',2,'1st Year','','123','2t@test.com',7,'B');
/*!40000 ALTER TABLE `studentinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(255) NOT NULL,
  PRIMARY KEY (`subject_id`),
  UNIQUE KEY `subject_name_unique` (`subject_name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` (`subject_id`, `subject_name`) VALUES (1,'Biology');
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `topic_id` int(11) NOT NULL AUTO_INCREMENT,
  `chapter_id` int(11) NOT NULL,
  `topic_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`topic_id`),
  UNIQUE KEY `chapter_topic_unique` (`chapter_id`,`topic_name`),
  KEY `idx_topic_chapter` (`chapter_id`),
  CONSTRAINT `fk_topics_chapter` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`chapter_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
INSERT INTO `topics` (`topic_id`, `chapter_id`, `topic_name`, `created_at`, `updated_at`) VALUES (3,6,'introduction to three domain classification','2025-06-13 07:40:10','2025-06-13 07:40:10'),(4,6,'Domain Archaea','2025-06-13 07:40:36','2025-06-13 07:40:36'),(5,6,'Domain Bacteria','2025-06-13 07:40:51','2025-06-13 07:40:51'),(6,6,'Domain Eukarya','2025-06-13 07:41:06','2025-06-13 07:41:06'),(7,6,'Taxonomic Hierarchy','2025-06-17 13:42:22','2025-06-17 13:42:22');
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'studyhtc_quiz'
--

--
-- Dumping routines for database 'studyhtc_quiz'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-24  0:14:03
