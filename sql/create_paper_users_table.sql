CREATE TABLE `paper_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `header` varchar(255) DEFAULT NULL,
  `activated_on` date DEFAULT NULL,
  `expires_on` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
