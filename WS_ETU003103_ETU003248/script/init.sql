-- ============================================
-- SCRIPT D'INITIALISATION COMPLET
-- ============================================

-- Table des semestres
CREATE TABLE semestre(
   id_semestre INT,
   libelle VARCHAR(50),
   PRIMARY KEY(id_semestre)
);

-- Table des options/parcours
CREATE TABLE parcours(
   id_parcours INT,
   libelle VARCHAR(100),
   id_semestre INT NOT NULL,
   PRIMARY KEY(id_parcours),
   FOREIGN KEY(id_semestre) REFERENCES semestre(id_semestre)
);

-- Table des sessions d'examen
CREATE TABLE session(
   id_session VARCHAR(50),
   date_session DATE,
   libelle VARCHAR(50),
   PRIMARY KEY(id_session)
);

-- Table inscription semestre avec parcours
CREATE TABLE inscription_semestre(
   id_inscription INT,
   filiere VARCHAR(50),
   id_semestre INT NOT NULL,
   id_parcours INT,
   date DATE,
   PRIMARY KEY(id_inscription),
   FOREIGN KEY(id_semestre) REFERENCES semestre(id_semestre),
   FOREIGN KEY(id_parcours) REFERENCES parcours(id_parcours)
);

-- Table Etudiant
CREATE TABLE Etudiant(
   id_etudiant INT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   date_naissance DATE,
   email VARCHAR(100),
   mot_de_passe VARCHAR(255),
   PRIMARY KEY(id_etudiant)
);

-- Table relation Etudiant - Inscription
CREATE TABLE etudiant_inscription(
   id_etudiant INT,
   id_inscription INT,
   annee_universitaire VARCHAR(20),
   PRIMARY KEY(id_etudiant, id_inscription),
   FOREIGN KEY(id_etudiant) REFERENCES Etudiant(id_etudiant),
   FOREIGN KEY(id_inscription) REFERENCES inscription_semestre(id_inscription)
);

-- Table des matières
CREATE TABLE Matiere(
   id_matiere INT,
   code_matiere VARCHAR(20),
   libelle VARCHAR(100),
   credit DECIMAL(3,1),
   id_semestre INT NOT NULL,
   PRIMARY KEY(id_matiere),
   FOREIGN KEY(id_semestre) REFERENCES semestre(id_semestre)
);

-- Table des types de matière
CREATE TABLE type_matiere(
   id_type_matiere INT AUTO_INCREMENT,
   code_type VARCHAR(20) UNIQUE,
   libelle VARCHAR(50),
   description TEXT,
   PRIMARY KEY(id_type_matiere)
);

-- Table de liaison Matière - Parcours
CREATE TABLE matiere_parcours(
   id_matiere_parcours INT AUTO_INCREMENT,
   id_matiere INT NOT NULL,
   id_parcours INT NOT NULL,
   id_type_matiere INT NOT NULL,
   est_active BOOLEAN DEFAULT TRUE,
   date_debut DATE,
   date_fin DATE,
   PRIMARY KEY(id_matiere_parcours),
   UNIQUE KEY unique_matiere_parcours_type (id_matiere, id_parcours, id_type_matiere),
   FOREIGN KEY(id_matiere) REFERENCES Matiere(id_matiere),
   FOREIGN KEY(id_parcours) REFERENCES parcours(id_parcours),
   FOREIGN KEY(id_type_matiere) REFERENCES type_matiere(id_type_matiere)
);

-- Table des notes
CREATE TABLE note(
   id_note INT AUTO_INCREMENT,
   note DECIMAL(5,2),
   id_etudiant INT NOT NULL,
   id_matiere INT NOT NULL,
   id_session VARCHAR(50) NOT NULL,
   PRIMARY KEY(id_note),
   FOREIGN KEY(id_etudiant) REFERENCES Etudiant(id_etudiant),
   FOREIGN KEY(id_matiere) REFERENCES Matiere(id_matiere),
   FOREIGN KEY(id_session) REFERENCES session(id_session)
);

-- Table des résultats
CREATE TABLE resultat(
   id_resultat INT AUTO_INCREMENT,
   id_etudiant INT NOT NULL,
   id_semestre INT NOT NULL,
   id_parcours INT,
   moyenne_generale DECIMAL(5,2),
   credit_obtenu DECIMAL(5,1),
   credit_total DECIMAL(5,1),
   statut VARCHAR(50),
   annee_universitaire VARCHAR(20) NOT NULL,
   PRIMARY KEY(id_resultat),
   FOREIGN KEY(id_etudiant) REFERENCES Etudiant(id_etudiant),
   FOREIGN KEY(id_semestre) REFERENCES semestre(id_semestre),
   FOREIGN KEY(id_parcours) REFERENCES parcours(id_parcours)
);

-- Table des tokens d'authentification
CREATE TABLE auth_token(
   id_token INT AUTO_INCREMENT,
   token VARCHAR(255) NOT NULL,
   id_etudiant INT NOT NULL,
   date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   date_expiration TIMESTAMP NOT NULL,
   est_actif BOOLEAN DEFAULT TRUE,
   PRIMARY KEY(id_token),
   UNIQUE(token),
   FOREIGN KEY(id_etudiant) REFERENCES Etudiant(id_etudiant)
);

-- Index pour améliorer les performances
CREATE INDEX idx_note_etudiant ON note(id_etudiant);
CREATE INDEX idx_note_matiere ON note(id_matiere);
CREATE INDEX idx_resultat_etudiant ON resultat(id_etudiant);
CREATE INDEX idx_token_actif ON auth_token(token, est_actif);

-- ============================================
-- INSERTION DES DONNÉES
-- ============================================

-- Insertion des semestres
INSERT INTO semestre (id_semestre, libelle) VALUES
(1, 'S1'),
(2, 'S2'),
(3, 'S3'),
(4, 'S4');

-- Insertion des parcours pour S4
INSERT INTO parcours (id_parcours, libelle, id_semestre) VALUES
(1, 'Développement', 4),
(2, 'Web et Design', 4),
(3, 'Bases de Données et Réseaux', 4);

-- Insertion des sessions
INSERT INTO session (id_session, date_session, libelle) VALUES
('S1_2024', '2024-12-15', 'Session normale'),
('S1_RATT_2025', '2025-02-10', 'Rattrapage');

-- Insertion des types de matière
INSERT INTO type_matiere (id_type_matiere, code_type, libelle, description) VALUES
(1, 'OBLIGATOIRE', 'Matière obligatoire', 'Matière obligatoire pour valider le parcours'),
(2, 'OPTIONNELLE', 'Matière optionnelle', 'Matière optionnelle à choisir parmi plusieurs'),
(3, 'FACULTATIVE', 'Matière facultative', 'Matière facultative, ne compte que les points au-dessus de 10');

-- Insertion des matières S1
INSERT INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre) VALUES
(1, 'INF101', 'Programmation procédurale', 7, 1),
(2, 'INF104', 'HTML et Introduction au Web', 5, 1),
(3, 'INF107', 'Informatique de Base', 4, 1),
(4, 'MTH101', 'Arithmétique et nombres', 4, 1),
(5, 'MTH102', 'Analyse mathématique', 6, 1),
(6, 'ORG101', 'Techniques de communication', 4, 1);

-- Insertion des matières S4 - Parcours Développement
INSERT INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre) VALUES
(19, 'INF204', 'Système d information géographique', 6, 4),
(20, 'INF205', 'Système d information', 6, 4),
(21, 'INF206', 'Interface Homme/Machine', 6, 4),
(22, 'INF207', 'Eléments d algorithmique', 6, 4),
(23, 'INF210', 'Mini-projet de développement', 10, 4),
(24, 'MTH203', 'MAO', 4, 4),
(25, 'MTH204', 'Géométrie', 4, 4);

-- Insertion des matières S4 - Autres parcours
INSERT INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre) VALUES
(30, 'INF209', 'Web dynamique', 6, 4),
(31, 'INF212', 'Mini-projet de Web et design', 10, 4),
(28, 'INF211', 'Mini-projet de BDD et réseaux', 10, 4),
(29, 'MTH202', 'Analyse des données', 4, 4);

-- Relation matière-parcours pour Développement
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(22, 1, 1, '2024-09-01'),
(23, 1, 1, '2024-09-01'),
(24, 1, 1, '2024-09-01'),
(20, 1, 2, '2024-09-01'),
(21, 1, 2, '2024-09-01'),
(25, 1, 2, '2024-09-01');

-- Relation matière-parcours pour Web
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(30, 2, 1, '2024-09-01'),
(31, 2, 1, '2024-09-01'),
(24, 2, 1, '2024-09-01'),
(21, 2, 2, '2024-09-01'),
(29, 2, 2, '2024-09-01');

-- Relation matière-parcours pour BDD et Réseaux
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(20, 3, 1, '2024-09-01'),
(28, 3, 1, '2024-09-01'),
(24, 3, 1, '2024-09-01'),
(22, 3, 2, '2024-09-01'),
(29, 3, 2, '2024-09-01');

-- INSERTION DES ÉTUDIANTS avec mot de passe BCrypt hashé pour "password123"
INSERT INTO Etudiant (id_etudiant, nom, prenom, date_naissance, email, mot_de_passe) VALUES
(1, 'Rakoto', 'Jean', '2002-05-15', 'jean.rakoto@univ.mg', '$2a$10$xn3LI/AjqicFYZFruSwve.681477XaUTr7iU0t5s6f6xDrNYcZJOG'),
(2, 'Rasoa', 'Marie', '2003-08-20', 'marie.rasoa@univ.mg', '$2a$10$xn3LI/AjqicFYZFruSwve.681477XaUTr7iU0t5s6f6xDrNYcZJOG'),
(3, 'Rabe', 'Paul', '2002-12-10', 'paul.rabe@univ.mg', '$2a$10$xn3LI/AjqicFYZFruSwve.681477XaUTr7iU0t5s6f6xDrNYcZJOG');

-- Inscriptions au S4
INSERT INTO inscription_semestre (id_inscription, filiere, id_semestre, id_parcours, date) VALUES
(1, 'Informatique', 4, 1, '2024-09-01'),
(2, 'Informatique', 4, 2, '2024-09-01'),
(3, 'Informatique', 4, 3, '2024-09-01');

-- Relation étudiant-inscription
INSERT INTO etudiant_inscription (id_etudiant, id_inscription, annee_universitaire) VALUES
(1, 1, '2024-2025'),
(2, 2, '2024-2025'),
(3, 3, '2024-2025');

-- Notes de Jean (Développement)
INSERT INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(15.5, 1, 22, 'S1_2024'),
(14.0, 1, 23, 'S1_2024'),
(13.5, 1, 20, 'S1_2024'),
(12.0, 1, 24, 'S1_2024'),
(13.0, 1, 25, 'S1_2024');

-- Notes de Marie (Web)
INSERT INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(16.5, 2, 30, 'S1_2024'),
(15.0, 2, 31, 'S1_2024'),
(14.5, 2, 21, 'S1_2024'),
(12.5, 2, 24, 'S1_2024'),
(13.5, 2, 29, 'S1_2024');

-- Notes de Paul (BDD)
INSERT INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(14.0, 3, 20, 'S1_2024'),
(15.0, 3, 28, 'S1_2024'),
(13.0, 3, 22, 'S1_2024'),
(12.5, 3, 24, 'S1_2024'),
(14.5, 3, 29, 'S1_2024');

-- Résultats S4
INSERT INTO resultat (id_etudiant, id_semestre, id_parcours, moyenne_generale, credit_obtenu, credit_total, statut, annee_universitaire) VALUES
(1, 4, 1, 13.73, 30.0, 30.0, 'Admis', '2024-2025'),
(2, 4, 2, 14.40, 30.0, 30.0, 'Admis', '2024-2025'),
(3, 4, 3, 13.87, 30.0, 30.0, 'Admis', '2024-2025');
