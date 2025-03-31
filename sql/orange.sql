-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Mar 15 Octobre 2024 à 12:05
-- Version du serveur :  5.6.20-log
-- Version de PHP :  5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `orange`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insererClient`(
    IN pNom VARCHAR(255),
    IN pPrenom VARCHAR(255),
    IN pAdresse VARCHAR(255),
    IN pTelephone VARCHAR(20),
    IN pEmail VARCHAR(255),
    IN pMdp VARCHAR(255),
    IN pRole VARCHAR(50),
    IN pFidelite INT -- Ce paramètre est utilisé seulement pour les clients
)
BEGIN
    DECLARE identifiant INT;

    -- Insérer dans la table users
    INSERT INTO users (nom, prenom, adresse, telephone, email, mdp, role)
    VALUES (pNom, pPrenom, pAdresse, pTelephone, pEmail, pMdp, pRole);
   
    -- Récupérer l'identifiant de l'utilisateur nouvellement inséré
    SELECT idUser INTO identifiant FROM users WHERE email = pEmail;

    -- Insérer dans la table client ou technicien selon le rôle
    IF pRole = 'client' THEN
        INSERT INTO client (idClient, type, fidelite)
        VALUES (identifiant, 'Client', pFidelite);
    ELSEIF pRole = 'technicien' THEN
        INSERT INTO technicien (idTechnicien, specialite)
        VALUES (identifiant, 'General'); -- Vous pouvez modifier la spécialité si nécessaire
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insererIntervention`(
    IN pDateInterv DATE, 
    IN pDuree VARCHAR(50), 
    IN pStatut VARCHAR(50), 
    IN pDescription VARCHAR(50), 
    IN pIdMateriel INT
)
BEGIN
    DECLARE identifiant INT;
    DECLARE speciality VARCHAR(50);
    SELECT designation INTO speciality FROM materiel WHERE idMateriel = pIdMateriel;
    SELECT idTechnicien INTO identifiant FROM technicien WHERE specialite = speciality ORDER BY RAND() LIMIT 1;
    INSERT INTO intervention (date_inter, duree, statut, description, idMateriel, idTechnicien) 
    VALUES (pDateInterv, pDuree, pStatut, pDescription, pIdMateriel, identifiant);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insererTechnicien`(
    IN pNom VARCHAR(50), 
    IN pPrenom VARCHAR(50), 
    IN pAdresse VARCHAR(50), 
    IN pTelephone VARCHAR(50), 
    IN pEmail VARCHAR(50), 
    IN pMdp VARCHAR(50), 
    IN pSpecialite VARCHAR(50), 
    IN pPoste VARCHAR(50)
)
BEGIN
    DECLARE identifiant INT;
    INSERT INTO users (nom, prenom, adresse, telephone, email, mdp) VALUES (pNom, pPrenom, pAdresse, pTelephone, pEmail, pMdp);
    SELECT idUser INTO identifiant FROM users WHERE email = pEmail;
    INSERT INTO technicien (idTechnicien, specialite, dateEntree, poste) VALUES (identifiant, pSpecialite, NOW(), pPoste);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE IF NOT EXISTS `client` (
  `idClient` int(11) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `fidelite` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `client`
--

INSERT INTO `client` (`idClient`, `type`, `fidelite`) VALUES
(1, 'client', '1'),
(5, 'client', '1'),
(7, 'Client', '1');

-- --------------------------------------------------------

--
-- Structure de la table `hashing`
--

CREATE TABLE IF NOT EXISTS `hashing` (
  `cle` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `hashing`
--

INSERT INTO `hashing` (`cle`) VALUES
('40e8aed82c0662ab0f5b33d4ad9f6d7f44dcb99c');

-- --------------------------------------------------------

--
-- Structure de la table `intervention`
--

CREATE TABLE IF NOT EXISTS `intervention` (
`idIntervention` int(11) NOT NULL,
  `date_inter` date DEFAULT NULL,
  `duree` varchar(50) DEFAULT NULL,
  `statut` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `idMateriel` int(11) DEFAULT NULL,
  `idTechnicien` int(11) DEFAULT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=166 ;

--
-- Contenu de la table `intervention`
--

INSERT INTO `intervention` (`idIntervention`, `date_inter`, `duree`, `statut`, `description`, `idMateriel`, `idTechnicien`) VALUES
(1, '0000-00-00', 'Ã  remplir par le technicien', 'Ã  remplir par le technicien', ' ', 0, NULL),
(2, '2024-10-20', 'xv', 'xcv', ' cvxv', NULL, NULL),
(3, '0000-00-00', '', '', ' ', NULL, NULL),
(4, '0000-00-00', '', '', ' ', NULL, NULL),
(5, '0000-00-00', '', '', ' ', NULL, NULL),
(6, '0000-00-00', '', '', ' ', NULL, NULL),
(7, '0000-00-00', '', '', ' ', NULL, NULL),
(8, '0000-00-00', '', '', ' ', NULL, NULL),
(9, '0000-00-00', '', '', ' ', NULL, NULL),
(10, '0000-00-00', '', '', ' ', NULL, NULL),
(11, '2024-10-01', '1', 'gfgf', ' gfg', NULL, NULL),
(12, '0000-00-00', '', '', ' ', NULL, NULL),
(13, '0000-00-00', '', '', ' ', NULL, NULL),
(14, '0000-00-00', '', '', ' ', NULL, NULL),
(15, '0000-00-00', '', '', ' ', NULL, NULL),
(16, '0000-00-00', '', '', ' ', NULL, NULL),
(17, '0000-00-00', '', '', ' ', NULL, NULL),
(18, '0000-00-00', '', '', ' ', NULL, NULL),
(19, '0000-00-00', '', '', ' ', NULL, NULL),
(20, '0000-00-00', '', '', ' ', NULL, NULL),
(21, '0000-00-00', '', '', ' ', NULL, NULL),
(22, '0000-00-00', '', '', ' ', NULL, NULL),
(23, '0000-00-00', '', '', ' ', NULL, NULL),
(24, '0000-00-00', '', '', ' ', NULL, NULL),
(25, '0000-00-00', '', '', ' ', NULL, NULL),
(26, '0000-00-00', '', '', ' ', NULL, NULL),
(27, '0000-00-00', '', '', ' ', NULL, NULL),
(28, '0000-00-00', '', '', ' ', NULL, NULL),
(29, '0000-00-00', '', '', ' ', NULL, NULL),
(30, '0000-00-00', '', '', ' ', NULL, NULL),
(31, '0000-00-00', '', '', ' ', NULL, NULL),
(32, '0000-00-00', '', '', ' ', NULL, NULL),
(33, '0000-00-00', '', '', ' ', NULL, NULL),
(34, '0000-00-00', '', '', ' ', NULL, NULL),
(35, '0000-00-00', '', '', ' ', NULL, NULL),
(36, '0000-00-00', '', '', ' ', NULL, NULL),
(37, '0000-00-00', '', '', ' ', NULL, NULL),
(38, '0000-00-00', '', '', ' ', NULL, NULL),
(39, '0000-00-00', '', '', ' ', NULL, NULL),
(40, '0000-00-00', '', '', ' ', NULL, NULL),
(41, '0000-00-00', '', '', ' ', NULL, NULL),
(42, '0000-00-00', '', '', ' ', NULL, NULL),
(43, '0000-00-00', '', '', ' ', NULL, NULL),
(44, '0000-00-00', '', '', ' ', NULL, NULL),
(45, '0000-00-00', '', '', ' ', NULL, NULL),
(46, '0000-00-00', '', '', ' ', NULL, NULL),
(47, '0000-00-00', '', '', ' ', NULL, NULL),
(48, '0000-00-00', '', '', ' ', NULL, NULL),
(49, '0000-00-00', '', '', ' ', NULL, NULL),
(50, '0000-00-00', '', '', ' ', NULL, NULL),
(51, '0000-00-00', '', '', ' ', NULL, NULL),
(52, '0000-00-00', '', '', ' ', NULL, NULL),
(53, '0000-00-00', '', '', ' ', NULL, NULL),
(54, '0000-00-00', '', '', ' ', NULL, NULL),
(55, '0000-00-00', '', '', ' ', NULL, NULL),
(56, '0000-00-00', '', '', ' ', NULL, NULL),
(57, '0000-00-00', '', '', ' ', NULL, NULL),
(58, '0000-00-00', '', '', ' ', NULL, NULL),
(59, '0000-00-00', '', '', ' ', NULL, NULL),
(60, '0000-00-00', '', '', ' ', NULL, NULL),
(61, '0000-00-00', '', '', ' ', NULL, NULL),
(62, '0000-00-00', '', '', ' ', NULL, NULL),
(63, '0000-00-00', '', '', ' ', NULL, NULL),
(64, '0000-00-00', '', '', ' ', NULL, NULL),
(65, '0000-00-00', '', '', ' ', NULL, NULL),
(66, '0000-00-00', '', '', ' ', NULL, NULL),
(67, '0000-00-00', '', '', ' ', NULL, NULL),
(68, '0000-00-00', '', '', ' ', NULL, NULL),
(69, '0000-00-00', '', '', ' ', NULL, NULL),
(70, '0000-00-00', '', '', ' ', NULL, NULL),
(71, '0000-00-00', '', '', ' ', NULL, NULL),
(72, '0000-00-00', '', '', ' ', NULL, NULL),
(73, '0000-00-00', '', '', ' ', NULL, NULL),
(74, '0000-00-00', '', '', ' ', NULL, NULL),
(75, '0000-00-00', '', '', ' ', NULL, NULL),
(76, '0000-00-00', '', '', ' ', NULL, NULL),
(77, '0000-00-00', '', '', ' ', NULL, NULL),
(78, '0000-00-00', '', '', ' ', NULL, NULL),
(79, '0000-00-00', '', '', ' ', NULL, NULL),
(80, '0000-00-00', '', '', ' ', NULL, NULL),
(81, '0000-00-00', '', '', ' ', NULL, NULL),
(82, '0000-00-00', '', '', ' ', NULL, NULL),
(83, '0000-00-00', '', '', ' ', NULL, NULL),
(84, '0000-00-00', '', '', ' ', NULL, NULL),
(85, '0000-00-00', '', '', ' ', NULL, NULL),
(86, '0000-00-00', '', '', ' ', NULL, NULL),
(87, '0000-00-00', '', '', ' ', NULL, NULL),
(88, '0000-00-00', '', '', ' ', NULL, NULL),
(89, '0000-00-00', '', '', ' ', NULL, NULL),
(90, '0000-00-00', '', '', ' ', NULL, NULL),
(91, '0000-00-00', '', '', ' ', NULL, NULL),
(92, '0000-00-00', '', '', ' ', NULL, NULL),
(93, '0000-00-00', '', '', ' ', NULL, NULL),
(94, '0000-00-00', '', '', ' ', NULL, NULL),
(95, '0000-00-00', '', '', ' ', NULL, NULL),
(96, '0000-00-00', '', '', ' ', NULL, NULL),
(97, '0000-00-00', '', '', ' ', NULL, NULL),
(98, '0000-00-00', '', '', ' ', NULL, NULL),
(99, '0000-00-00', '', '', ' ', NULL, NULL),
(100, '0000-00-00', '', '', ' ', NULL, NULL),
(101, '0000-00-00', '', '', ' ', NULL, NULL),
(102, '0000-00-00', '', '', ' ', NULL, NULL),
(103, '0000-00-00', '', '', ' ', NULL, NULL),
(104, '0000-00-00', '', '', ' ', NULL, NULL),
(105, '0000-00-00', '', '', ' ', NULL, NULL),
(106, '0000-00-00', '', '', ' ', NULL, NULL),
(107, '0000-00-00', '', '', ' ', NULL, NULL),
(108, '0000-00-00', '', '', ' ', NULL, NULL),
(109, '0000-00-00', '', '', ' ', NULL, NULL),
(110, '0000-00-00', '', '', ' ', NULL, NULL),
(111, '0000-00-00', '', '', ' ', NULL, NULL),
(112, '0000-00-00', '', '', ' ', NULL, NULL),
(113, '0000-00-00', '', '', ' ', NULL, NULL),
(114, '0000-00-00', '', '', ' ', NULL, NULL),
(115, '0000-00-00', '', '', ' ', NULL, NULL),
(116, '0000-00-00', '', '', ' ', NULL, NULL),
(117, '0000-00-00', '', '', ' ', NULL, NULL),
(118, '0000-00-00', '', '', ' ', NULL, NULL),
(119, '0000-00-00', '', '', ' ', NULL, NULL),
(120, '0000-00-00', '', '', ' ', NULL, NULL),
(121, '0000-00-00', '', '', ' ', NULL, NULL),
(122, '0000-00-00', '', '', ' ', NULL, NULL),
(123, '0000-00-00', '', '', ' ', NULL, NULL),
(124, '0000-00-00', '', '', ' ', NULL, NULL),
(125, '0000-00-00', '', '', ' ', NULL, NULL),
(126, '0000-00-00', '', '', ' ', NULL, NULL),
(127, '0000-00-00', '', '', ' ', NULL, NULL),
(128, '0000-00-00', '', '', ' ', NULL, NULL),
(129, '0000-00-00', '', '', ' ', NULL, NULL),
(130, '0000-00-00', '', '', ' ', NULL, NULL),
(131, '0000-00-00', '', '', ' ', NULL, NULL),
(132, '0000-00-00', '', '', ' ', NULL, NULL),
(133, '0000-00-00', '', '', ' ', 0, NULL),
(134, '0000-00-00', '', '', ' ', 0, NULL),
(135, '0000-00-00', '', '', ' ', 0, NULL),
(136, '0000-00-00', '', '', ' ', 0, NULL),
(137, '0000-00-00', '', '', ' ', 0, NULL),
(138, '0000-00-00', '', '', ' ', 0, NULL),
(139, '0000-00-00', '', '', ' ', 0, NULL),
(140, '0000-00-00', '', '', ' ', 0, NULL),
(141, '0000-00-00', '', '', ' ', 0, NULL),
(142, '0000-00-00', '', '', ' ', 0, NULL),
(143, '0000-00-00', '', '', ' ', 0, NULL),
(144, '0000-00-00', '', '', ' ', 0, NULL),
(145, '2024-10-01', '1', 'df', ' df', 0, NULL),
(146, '0000-00-00', '', '', ' ', 0, NULL),
(147, '0000-00-00', '', '', ' ', 0, NULL),
(148, '0000-00-00', '', '', ' ', 0, NULL),
(149, '0000-00-00', '', '', ' ', 0, NULL),
(150, '0000-00-00', '', '', ' ', 0, NULL),
(151, '0000-00-00', '', '', ' ', 0, NULL),
(152, '0000-00-00', '', '', ' ', 0, NULL),
(153, '0000-00-00', '', '', ' ', 0, NULL),
(154, '0000-00-00', '', '', ' ', 0, NULL),
(155, '0000-00-00', '', '', ' ', 0, NULL),
(156, '0000-00-00', '', '', ' ', 0, NULL),
(157, '0000-00-00', '', '', ' ', 0, NULL),
(158, '0000-00-00', '', '', ' ', 0, NULL),
(159, '0000-00-00', '', '', ' ', 0, NULL),
(160, '0000-00-00', '', '', ' ', 0, NULL),
(161, '0000-00-00', '', '', ' ', 0, NULL),
(162, '2024-10-11', 'sd', 'sd', ' sd', 1, 2),
(163, '2024-10-01', '1', 'xcv', ' cvxv', 1, 2),
(164, '2024-10-03', '1', 'xcv', ' cvxv', 2, NULL),
(165, '2024-10-05', '1', 'xcv', ' cvxv', 1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `materiel`
--

CREATE TABLE IF NOT EXISTS `materiel` (
`idMateriel` int(11) NOT NULL,
  `designation` varchar(50) DEFAULT NULL,
  `marque` varchar(50) DEFAULT NULL,
  `modele` varchar(50) DEFAULT NULL,
  `prixachat` float DEFAULT NULL,
  `date_achat` date DEFAULT NULL,
  `idUser` int(11) DEFAULT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `materiel`
--

INSERT INTO `materiel` (`idMateriel`, `designation`, `marque`, `modele`, `prixachat`, `date_achat`, `idUser`) VALUES
(1, 'box wifi', '  dfdf', 'ancien', 0, '2024-10-01', 1),
(2, 'Choose', '  ', 'Choose', 0, '2024-10-01', 1),
(3, 'Choose', '  ', 'Choose', 0, '2024-10-01', 1),
(4, 'ordinateur', '  ', 'ancien', 0, '2024-10-01', 1);

-- --------------------------------------------------------

--
-- Structure de la table `technicien`
--

CREATE TABLE IF NOT EXISTS `technicien` (
  `idTechnicien` int(11) NOT NULL,
  `specialite` varchar(50) DEFAULT NULL,
  `dateEntree` date DEFAULT NULL,
  `poste` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `technicien`
--

INSERT INTO `technicien` (`idTechnicien`, `specialite`, `dateEntree`, `poste`) VALUES
(2, 'box wifi', '2024-09-17', 'manager'),
(3, 'telephone', '2024-09-17', 'manager'),
(4, 'ordinateur', '2024-09-17', 'manager'),
(6, 'General', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`idUser` int(11) NOT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `adresse` varchar(50) DEFAULT NULL,
  `telephone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `mdp` varchar(255) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`idUser`, `nom`, `prenom`, `adresse`, `telephone`, `email`, `mdp`, `role`) VALUES
(1, 'Nandakumaran', 'Anandan', 'Paris', '06', 'a@gmail.com', 'e60819d1d2465305c5435130384c7d702a8f83dc', NULL),
(2, 'Nandakumaran', 'Anandan', 'Paris', '06', 'b@gmail.com', 'e60819d1d2465305c5435130384c7d702a8f83dc', NULL),
(3, 'Nandakumaran', 'Anandan', 'Paris', '06', 'c@gmail.com', 'e60819d1d2465305c5435130384c7d702a8f83dc', NULL),
(4, 'Nandakumaran', 'Anandan', 'Paris', '06', 'd@gmail.com', 'e60819d1d2465305c5435130384c7d702a8f83dc', NULL),
(5, 'dahbi', 'ayoub', 'paris', '0767504870', 'ayoub@gmail.com', '9537cbe28f5ebe52a1d786b1d91150e16388386a', NULL),
(6, 'dahbi', 'ayoub', 'paris', '0767504870', 'a1@gmail.Com', 'e60819d1d2465305c5435130384c7d702a8f83dc', 'technicien'),
(7, 'a', 'a', 'a', '0767504871', 'ab@gmail.Com', 'e60819d1d2465305c5435130384c7d702a8f83dc', 'client');

--
-- Déclencheurs `users`
--
DELIMITER //
CREATE TRIGGER `avant_insertion` BEFORE INSERT ON `users`
 FOR EACH ROW BEGIN
    DECLARE hashKey VARCHAR(255);
    SELECT cle INTO hashKey FROM hashing;
    SET NEW.mdp = SHA1(CONCAT(NEW.mdp, hashKey));
END
//
DELIMITER ;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `client`
--
ALTER TABLE `client`
 ADD PRIMARY KEY (`idClient`);

--
-- Index pour la table `hashing`
--
ALTER TABLE `hashing`
 ADD PRIMARY KEY (`cle`);

--
-- Index pour la table `intervention`
--
ALTER TABLE `intervention`
 ADD PRIMARY KEY (`idIntervention`), ADD KEY `idMateriel` (`idMateriel`), ADD KEY `idTechnicien` (`idTechnicien`);

--
-- Index pour la table `materiel`
--
ALTER TABLE `materiel`
 ADD PRIMARY KEY (`idMateriel`), ADD KEY `idUser` (`idUser`);

--
-- Index pour la table `technicien`
--
ALTER TABLE `technicien`
 ADD PRIMARY KEY (`idTechnicien`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`idUser`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `intervention`
--
ALTER TABLE `intervention`
MODIFY `idIntervention` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=166;
--
-- AUTO_INCREMENT pour la table `materiel`
--
ALTER TABLE `materiel`
MODIFY `idMateriel` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
