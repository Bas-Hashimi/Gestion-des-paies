-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 04 juin 2026 à 12:15
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestions_des_paies_bismellah_hashimi_2026`
--
CREATE DATABASE IF NOT EXISTS `gestions_des_paies_bismellah_hashimi_2026` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gestions_des_paies_bismellah_hashimi_2026`;

-- --------------------------------------------------------

--
-- Structure de la table `t_contenir`
--

CREATE TABLE IF NOT EXISTS `t_contenir` (
  `id_fiche` int(11) NOT NULL,
  `id_deduction` int(11) NOT NULL,
  PRIMARY KEY (`id_fiche`,`id_deduction`),
  KEY `fk_contenir_deduction` (`id_deduction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_contrat`
--

CREATE TABLE IF NOT EXISTS `t_contrat` (
  `id_contrat` int(11) NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int(11) NOT NULL,
  `type_contrat` varchar(50) NOT NULL,
  `salaire_basse` decimal(10,2) NOT NULL,
  `date_debut` date NOT NULL,
  `iben` varchar(50) NOT NULL,
  `annee_apprentissage` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_contrat`),
  KEY `fk_contrat_utilisateur` (`id_utilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_contrat`
--

INSERT INTO `t_contrat` (`id_contrat`, `id_utilisateur`, `type_contrat`, `salaire_basse`, `date_debut`, `iben`, `annee_apprentissage`) VALUES
(1, 1, 'CDI', 8500.00, '2024-01-01', 'CH9300000000000000001', 1),
(2, 2, '', 800.00, '2025-08-01', 'CH9300000000000000002', 1),
(3, 3, 'CDI', 6500.00, '2020-03-15', 'CH9300000000000000003', NULL),
(4, 4, 'CDD', 4000.00, '2026-01-01', 'CH9300000000000000004', NULL),
(5, 5, 'CDI', 4500.00, '2025-06-01', 'CH9300000000000000005', NULL),
(6, 6, '', 1300.00, '2023-08-01', 'CH9300000000000000006', 3),
(7, 7, 'CDI', 5500.00, '2022-09-01', 'CH9300000000000000007', NULL),
(8, 8, 'CDI', 7000.00, '2019-11-01', 'CH9300000000000000008', NULL),
(9, 9, 'Stage', 1500.00, '2026-02-01', 'CH9300000000000000009', 1),
(10, 10, 'CDD', 3800.00, '2026-04-01', 'CH9300000000000000010', NULL),
(11, 11, 'CDI', 4800.00, '2024-05-15', 'CH9300000000000000011', NULL),
(12, 12, 'CDI', 5200.00, '2023-02-01', 'CH9300000000000000012', NULL),
(13, 13, '', 1000.00, '2024-08-01', 'CH9300000000000000013', 2),
(14, 14, 'CDI', 6000.00, '2021-07-01', 'CH9300000000000000014', NULL),
(15, 15, 'CDI', 9500.00, '2018-01-01', 'CH9300000000000000015', NULL),
(16, 16, 'CDI', 11000.00, '2015-10-01', 'CH9300000000000000016', NULL),
(17, 17, 'Stage', 1000.00, '2026-06-01', 'CH9300000000000000017', 1),
(18, 18, '', 1600.00, '2022-08-01', 'CH9300000000000000018', 4),
(19, 19, 'CDD', 4200.00, '2025-12-01', 'CH9300000000000000019', NULL),
(20, 20, 'CDI', 4500.00, '2026-03-01', 'CH9300000000000000020', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `t_contrat_deduction`
--

CREATE TABLE IF NOT EXISTS `t_contrat_deduction` (
  `id_contrat` int(11) NOT NULL,
  `id_deduction` int(11) NOT NULL,
  PRIMARY KEY (`id_contrat`,`id_deduction`),
  KEY `fk_cd_deduction` (`id_deduction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_deduction`
--

CREATE TABLE IF NOT EXISTS `t_deduction` (
  `id_deduction` int(11) NOT NULL AUTO_INCREMENT,
  `id_grille` int(11) NOT NULL,
  `libelle` varchar(100) NOT NULL,
  `taux` decimal(5,2) NOT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_deduction`),
  KEY `fk_deduction_grille` (`id_grille`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_fiche_paie`
--

CREATE TABLE IF NOT EXISTS `t_fiche_paie` (
  `id_fiche` int(11) NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int(11) NOT NULL,
  `salaire_brut` decimal(10,2) NOT NULL,
  `salaire_net` decimal(10,2) NOT NULL,
  `total_deductions` decimal(10,2) NOT NULL,
  `date_generation` date NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`id_fiche`),
  KEY `fk_fiche_utilisateur` (`id_utilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_fiche_paie`
--

INSERT INTO `t_fiche_paie` (`id_fiche`, `id_utilisateur`, `salaire_brut`, `salaire_net`, `total_deductions`, `date_generation`, `status`) VALUES
(1, 1, 8500.00, 7225.00, 1275.00, '2026-05-25', 'Payé'),
(2, 2, 800.00, 700.00, 100.00, '2026-05-25', 'Payé'),
(3, 3, 6500.00, 5525.00, 975.00, '2026-05-25', 'Payé'),
(4, 4, 4000.00, 3400.00, 600.00, '2026-05-25', 'Payé'),
(5, 5, 4500.00, 3825.00, 675.00, '2026-05-25', 'En attente'),
(6, 6, 1300.00, 1105.00, 195.00, '2026-05-25', 'Payé'),
(7, 7, 5500.00, 4675.00, 825.00, '2026-05-25', 'Payé'),
(8, 8, 7000.00, 5950.00, 1050.00, '2026-05-25', 'En attente'),
(9, 9, 1500.00, 1500.00, 0.00, '2026-05-25', 'Payé'),
(10, 10, 3800.00, 3230.00, 570.00, '2026-05-25', 'Payé'),
(11, 11, 4800.00, 4080.00, 720.00, '2026-05-25', 'Payé'),
(12, 12, 5200.00, 4420.00, 780.00, '2026-05-25', 'Payé'),
(13, 13, 1000.00, 850.00, 150.00, '2026-05-25', 'Payé'),
(14, 14, 6000.00, 5100.00, 900.00, '2026-05-25', 'En attente'),
(15, 15, 9500.00, 8075.00, 1425.00, '2026-05-25', 'Payé'),
(16, 16, 11000.00, 9350.00, 1650.00, '2026-05-25', 'Payé'),
(17, 17, 1000.00, 1000.00, 0.00, '2026-05-25', 'Payé'),
(18, 18, 1600.00, 1360.00, 240.00, '2026-05-25', 'En attente'),
(19, 19, 4200.00, 3570.00, 630.00, '2026-05-25', 'Payé'),
(20, 20, 4500.00, 3825.00, 675.00, '2026-05-25', 'Payé');

-- --------------------------------------------------------

--
-- Structure de la table `t_grille_salaire`
--

CREATE TABLE IF NOT EXISTS `t_grille_salaire` (
  `id_grille` int(11) NOT NULL AUTO_INCREMENT,
  `type_contrat` varchar(50) NOT NULL,
  `annee_apprentissage` int(11) DEFAULT NULL,
  `salaire_brut_mensuel` decimal(10,2) NOT NULL,
  `annee_validite` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_grille`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_grille_salaire`
--

INSERT INTO `t_grille_salaire` (`id_grille`, `type_contrat`, `annee_apprentissage`, `salaire_brut_mensuel`, `annee_validite`, `description`) VALUES
(1, 'Apprentissage ICT', 1, 800.00, 2026, '1ère année Apprenti ICT'),
(2, 'Apprentissage ICT', 2, 1000.00, 2026, '2ème année Apprenti ICT'),
(3, 'Apprentissage ICT', 3, 1300.00, 2026, '3ème année Apprenti ICT'),
(4, 'Apprentissage ICT', 4, 1600.00, 2026, '4ème année Apprenti ICT'),
(5, 'Apprentissage EDC', 3, 1400.00, 2026, '3ème année Commerce EDC'),
(6, 'CDI', NULL, 4500.00, 2026, 'Développeur Junior'),
(7, 'CDI', NULL, 5500.00, 2026, 'Développeur Intermédiaire'),
(8, 'CDI', NULL, 7500.00, 2026, 'Responsable informatique'),
(9, 'CDD', NULL, 4000.00, 2026, 'Assistant RH'),
(10, 'CDD', NULL, 4200.00, 2026, 'Comptable Junior'),
(11, 'Stage', NULL, 1500.00, 2026, 'Stagiaire Master'),
(12, 'Stage', NULL, 1000.00, 2026, 'Stagiaire Bachelor'),
(13, 'CDI', NULL, 4800.00, 2026, 'Technicien Support'),
(14, 'CDI', NULL, 5200.00, 2026, 'Administrateur Réseau'),
(15, 'CDI', NULL, 6000.00, 2026, 'Expert Cyber'),
(16, 'CDD', NULL, 3800.00, 2026, 'Secrétaire'),
(17, 'Apprentissage EDC', 1, 850.00, 2026, '1ère année Commerce EDC'),
(18, 'Apprentissage EDC', 2, 1100.00, 2026, '2ème année Commerce EDC'),
(19, 'CDI', NULL, 9500.00, 2026, 'Directeur RH'),
(20, 'CDI', NULL, 11000.00, 2026, 'Directeur Général');

-- --------------------------------------------------------

--
-- Structure de la table `t_utilisateur`
--

CREATE TABLE IF NOT EXISTS `t_utilisateur` (
  `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(42) NOT NULL,
  `prenom` varchar(66) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `fonction` varchar(100) NOT NULL,
  `statut` varchar(20) NOT NULL DEFAULT 'Actif',
  PRIMARY KEY (`id_utilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_utilisateur`
--

INSERT INTO `t_utilisateur` (`id_utilisateur`, `nom`, `prenom`, `mot_de_passe`, `role`, `fonction`, `statut`) VALUES
(1, 'Hashimi', 'Bismellah', 'hash1234', 'Admin', '', 'Actif'),
(2, 'Dupont', 'Jean', 'pass123', 'Employé', '', 'Actif'),
(3, 'Martin', 'Sophie', 'pass123', 'RH', '', 'Actif'),
(4, 'Bernard', 'Luc', 'pass123', 'Employé', '', 'Actif'),
(5, 'Dubois', 'Marie', 'pass123', 'Employé', '', 'Actif'),
(6, 'Thomas', 'Paul', 'pass123', 'Employé', '', 'Actif'),
(7, 'Robert', 'Alice', 'pass123', 'Employé', '', 'Actif'),
(8, 'Richard', 'Marc', 'pass123', 'Employé', '', 'Actif'),
(9, 'Petit', 'Julie', 'pass123', 'Employé', '', 'Actif'),
(10, 'Durand', 'Nicolas', 'pass123', 'Employé', '', 'Actif'),
(11, 'Leroy', 'Emma', 'pass123', 'Employé', '', 'Actif'),
(12, 'Moreau', 'Antoine', 'pass123', 'Employé', '', 'Actif'),
(13, 'Simon', 'Céline', 'pass123', 'Employé', '', 'Actif'),
(14, 'Laurent', 'Hugo', 'pass123', 'Employé', '', 'Actif'),
(15, 'Lefebvre', 'Chloé', 'pass123', 'Employé', '', 'Actif'),
(16, 'Michel', 'Lucas', 'pass123', 'Employé', '', 'Actif'),
(17, 'Garcia', 'Inès', 'pass123', 'Employé', '', 'Actif'),
(18, 'David', 'Léo', 'pass123', 'Employé', '', 'Actif'),
(19, 'Bertin', 'Léa', 'pass123', 'Employé', '', 'Actif'),
(20, 'Roux', 'Arthur', 'pass123', 'Employé', '', 'Actif');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `t_contenir`
--
ALTER TABLE `t_contenir`
  ADD CONSTRAINT `fk_contenir_deduction` FOREIGN KEY (`id_deduction`) REFERENCES `t_deduction` (`id_deduction`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_contenir_fiche` FOREIGN KEY (`id_fiche`) REFERENCES `t_fiche_paie` (`id_fiche`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `t_contrat`
--
ALTER TABLE `t_contrat`
  ADD CONSTRAINT `fk_contrat_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `t_utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `t_contrat_deduction`
--
ALTER TABLE `t_contrat_deduction`
  ADD CONSTRAINT `fk_cd_contrat` FOREIGN KEY (`id_contrat`) REFERENCES `t_contrat` (`id_contrat`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cd_deduction` FOREIGN KEY (`id_deduction`) REFERENCES `t_deduction` (`id_deduction`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `t_deduction`
--
ALTER TABLE `t_deduction`
  ADD CONSTRAINT `fk_deduction_grille` FOREIGN KEY (`id_grille`) REFERENCES `t_grille_salaire` (`id_grille`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `t_fiche_paie`
--
ALTER TABLE `t_fiche_paie`
  ADD CONSTRAINT `fk_fiche_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `t_utilisateur` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
