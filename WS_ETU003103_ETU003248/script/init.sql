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

-- Table Admin/Utilisateur
CREATE TABLE user(
   id_user INT AUTO_INCREMENT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(100) UNIQUE NOT NULL,
   mot_de_passe VARCHAR(255) NOT NULL,
   role VARCHAR(20) DEFAULT 'ADMIN',
   est_actif BOOLEAN DEFAULT TRUE,
   date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(id_user)
);

-- Table Etudiant
CREATE TABLE Etudiant(
   id_etudiant INT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   date_naissance DATE,
   email VARCHAR(100),
   mot_de_passe VARCHAR(255),
   id_user_createur INT,
   date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(id_etudiant),
   FOREIGN KEY(id_user_createur) REFERENCES user(id_user)
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
   id_parcours INT,
   id_type_matiere INT,
   PRIMARY KEY(id_matiere),
   FOREIGN KEY(id_semestre) REFERENCES semestre(id_semestre),
   FOREIGN KEY(id_parcours) REFERENCES parcours(id_parcours),
   FOREIGN KEY(id_type_matiere) REFERENCES type_matiere(id_type_matiere)
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

CREATE TABLE users (
   id_user INT AUTO_INCREMENT,
   username VARCHAR(100) UNIQUE NOT NULL,
   email VARCHAR(150) UNIQUE NOT NULL,
   mot_de_passe VARCHAR(255) NOT NULL,
   role VARCHAR(30) NOT NULL,   -- ADMIN, ETUDIANT, ENSEIGNANT, etc.
   est_actif BOOLEAN DEFAULT TRUE,
   PRIMARY KEY(id_user)
);


-- Table des tokens d'authentification
CREATE TABLE auth_token(
   id_token INT AUTO_INCREMENT,
   token VARCHAR(255) NOT NULL,
   id_etudiant INT,
   id_user INT,
   user_type VARCHAR(20) NOT NULL,
   date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   date_expiration TIMESTAMP NOT NULL,
   est_actif BOOLEAN DEFAULT TRUE,
   PRIMARY KEY(id_token),
   UNIQUE(token),
   FOREIGN KEY(id_etudiant) REFERENCES Etudiant(id_etudiant),
   FOREIGN KEY(id_user) REFERENCES user(id_user),
   CHECK (
      (user_type = 'ETUDIANT' AND id_etudiant IS NOT NULL AND id_user IS NULL) OR
      (user_type = 'ADMIN' AND id_user IS NOT NULL AND id_etudiant IS NULL)
   )
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

-- Insertion des parcours pour S4 (selon IT University)
INSERT INTO parcours (id_parcours, libelle, id_semestre) VALUES
(1, 'Développement', 4),
(2, 'Web et Design', 4),
(3, 'Bases de Données et Réseaux', 4);

-- Insertion des sessions
INSERT INTO session (id_session, date_session, libelle) VALUES
('S1_2024', '2024-12-15', 'Session normale'),
('S1_RATT_2025', '2025-02-10', 'Rattrapage');

-- ============================================
-- INSERTION DES MATIÈRES - IT UNIVERSITY
-- ============================================

-- Matières du Semestre 1 (Tronc commun)
INSERT INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre) VALUES
(1, 'INF101', 'Programmation procédurale', 7, 1),
(2, 'INF104', 'HTML et Introduction au Web', 5, 1),
(3, 'INF107', 'Informatique de Base', 4, 1),
(4, 'MTH101', 'Arithmétique et nombres', 4, 1),
(5, 'MTH102', 'Analyse mathématique', 6, 1),
(6, 'ORG101', 'Techniques de communication', 4, 1);

-- Matières du Semestre 2 (Tronc commun)
INSERT INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre) VALUES
(7, 'INF102', 'Bases de données relationnelles', 5, 2),
(8, 'INF103', 'Bases de l\'administration système', 5, 2),
(9, 'INF105', 'Maintenance matériel et logiciel', 4, 2),
(10, 'INF106', 'Compléments de programmation', 6, 2),
(11, 'MTH103', 'Calcul Vectoriel et Matriciel', 6, 2),
(12, 'MTH105', 'Probabilité et Statistique', 4, 2);

-- Matières du Semestre 3 (Tronc commun)
INSERT INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre) VALUES
(13, 'INF201', 'Programmation orientée objet', 6, 3),
(14, 'INF202', 'Bases de données objets', 6, 3),
(15, 'INF203', 'Programmation système', 4, 3),
(16, 'INF208', 'Réseaux informatiques', 6, 3),
(17, 'MTH201', 'Méthodes numériques', 4, 3),
(18, 'ORG201', 'Bases de gestion', 4, 3);

-- Matières du Semestre 4 - Parcours Développement
INSERT INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre) VALUES
(19, 'INF204', 'Système d\'information géographique', 6, 4),
(20, 'INF205', 'Système d\'information', 6, 4),
(21, 'INF206', 'Interface Homme/Machine', 6, 4),
(22, 'INF207', 'Eléments d\'algorithmique', 6, 4),
(23, 'INF210', 'Mini-projet de développement', 10, 4),
(24, 'MTH203', 'MAO', 4, 4),
(25, 'MTH204', 'Géométrie', 4, 4),
(26, 'MTH205', 'Equations différentielles', 4, 4),
(27, 'MTH206', 'Optimisation', 4, 4);

-- Matières du Semestre 4 - Parcours Bases de Données et Réseaux
INSERT INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre) VALUES
(28, 'INF211', 'Mini-projet de bases de données et/ou de réseaux', 10, 4),
(29, 'MTH202', 'Analyse des données', 4, 4);

-- Matières du Semestre 4 - Parcours Web et Design
INSERT INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre) VALUES
(30, 'INF209', 'Web dynamique', 6, 4),
(31, 'INF212', 'Mini-projet de Web et design', 10, 4);

-- Insertion des types de matière
INSERT INTO type_matiere (id_type_matiere, code_type, libelle, description) VALUES
(1, 'OBLIGATOIRE', 'Matière obligatoire', 'Matière obligatoire pour valider le parcours'),
(2, 'OPTIONNELLE', 'Matière optionnelle', 'Matière optionnelle à choisir parmi plusieurs (1 UE parmi)'),
(3, 'FACULTATIVE', 'Matière facultative', 'Matière facultative, ne compte que les points au-dessus de 10');

-- ============================================
-- RELATION MATIÈRE-PARCOURS POUR S4
-- ============================================

-- Parcours 1: DÉVELOPPEMENT
-- Matières obligatoires
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(22, 1, 1, '2024-09-01'),  -- INF207: Eléments d'algorithmique (6 crédits)
(23, 1, 1, '2024-09-01'),  -- INF210: Mini-projet de développement (10 crédits)
(24, 1, 1, '2024-09-01');  -- MTH203: MAO (4 crédits)

-- Matières optionnelles (1 UE parmi 3)
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(19, 1, 2, '2024-09-01'),  -- INF204: Système d'information géographique (6 crédits)
(20, 1, 2, '2024-09-01'),  -- INF205: Système d'information (6 crédits)
(21, 1, 2, '2024-09-01');  -- INF206: Interface Homme/Machine (6 crédits)

-- Matières optionnelles mathématiques (1 UE parmi 3)
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(25, 1, 2, '2024-09-01'),  -- MTH204: Géométrie (4 crédits)
(26, 1, 2, '2024-09-01'),  -- MTH205: Equations différentielles (4 crédits)
(27, 1, 2, '2024-09-01');  -- MTH206: Optimisation (4 crédits)

-- Parcours 2: WEB ET DESIGN
-- Matières obligatoires
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(30, 2, 1, '2024-09-01'),  -- INF209: Web dynamique (6 crédits)
(31, 2, 1, '2024-09-01'),  -- INF212: Mini-projet de Web et design (10 crédits)
(24, 2, 1, '2024-09-01');  -- MTH203: MAO (4 crédits)

-- Matières optionnelles (1 UE parmi 3)
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(19, 2, 2, '2024-09-01'),  -- INF204: Système d'information géographique (6 crédits)
(20, 2, 2, '2024-09-01'),  -- INF205: Système d'information (6 crédits)
(21, 2, 2, '2024-09-01');  -- INF206: Interface Homme/Machine (6 crédits)

-- Matières optionnelles mathématiques (1 UE parmi 3)
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(29, 2, 2, '2024-09-01'),  -- MTH202: Analyse des données (4 crédits)
(25, 2, 2, '2024-09-01'),  -- MTH204: Géométrie (4 crédits)
(27, 2, 2, '2024-09-01');  -- MTH206: Optimisation (4 crédits)

-- Parcours 3: BASES DE DONNÉES ET RÉSEAUX
-- Matières obligatoires
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(20, 3, 1, '2024-09-01'),  -- INF205: Système d'information (6 crédits)
(28, 3, 1, '2024-09-01'),  -- INF211: Mini-projet BDD et/ou réseaux (10 crédits)
(24, 3, 1, '2024-09-01');  -- MTH203: MAO (4 crédits)

-- Matières optionnelles (1 UE parmi 3)
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(19, 3, 2, '2024-09-01'),  -- INF204: Système d'information géographique (6 crédits)
(21, 3, 2, '2024-09-01'),  -- INF206: Interface Homme/Machine (6 crédits)
(22, 3, 2, '2024-09-01');  -- INF207: Eléments d'algorithmique (6 crédits)

-- Matières optionnelles mathématiques (1 UE parmi 3)
INSERT INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(29, 3, 2, '2024-09-01'),  -- MTH202: Analyse des données (4 crédits)
(26, 3, 2, '2024-09-01'),  -- MTH205: Equations différentielles (4 crédits)
(27, 3, 2, '2024-09-01');  -- MTH206: Optimisation (4 crédits)

-- ============================================
-- INSERTION DES ÉTUDIANTS
-- ============================================

-- Insertion des utilisateurs admin
INSERT INTO user (id_user, nom, prenom, email, mot_de_passe, role, est_actif, date_creation) VALUES
(1, 'Admin', 'Système', 'admin@univ.mg', 'AdminPass123!', 'ADMIN', true, NOW()),
(2, 'Secrétaire', 'Bureau', 'secretaire@univ.mg', 'SecPass123!', 'USER', true, NOW());

INSERT INTO Etudiant (id_etudiant, nom, prenom, date_naissance, email, mot_de_passe, id_user_createur, date_inscription) VALUES
(1, 'Rakoto', 'Jean', '2002-05-15', 'jean.rakoto@univ.mg', 'jeanpass', 1, NOW()),
(2, 'Rasoa', 'Marie', '2003-08-20', 'marie.rasoa@univ.mg', 'mariepass', 1, NOW()),
(3, 'Rabe', 'Paul', '2002-12-10', 'paul.rabe@univ.mg', 'paulpass', 1, NOW());

-- ============================================
-- INSCRIPTIONS DES ÉTUDIANTS
-- ============================================

-- Inscription au S4 avec leurs parcours
INSERT INTO inscription_semestre (id_inscription, filiere, id_semestre, id_parcours, date) VALUES
(1, 'Informatique', 4, NULL, '2024-09-01'),  -- Jean: parcours Développement
(2, 'Informatique', 4, NULL, '2024-09-01'),  -- Marie: parcours Web et Design
(3, 'Informatique', 4, NULL, '2024-09-01');  -- Paul: parcours Bases de Données et Réseaux

INSERT INTO etudiant_inscription (id_etudiant, id_inscription, annee_universitaire) VALUES
(1, 1, '2024-2025'),
(2, 2, '2024-2025'),
(3, 3, '2024-2025');

-- ============================================
-- INSERTION DES NOTES - SEMESTRE 1
-- ============================================

-- Notes de Jean (S1)
INSERT INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(15.5, 1, 1, 'S1_2024'),  -- INF101: Programmation procédurale
(14.0, 1, 2, 'S1_2024'),  -- INF104: HTML et Introduction au Web
(16.0, 1, 3, 'S1_2024'),  -- INF107: Informatique de Base
(12.5, 1, 4, 'S1_2024'),  -- MTH101: Arithmétique et nombres
(13.0, 1, 5, 'S1_2024'),  -- MTH102: Analyse mathématique
(14.5, 1, 6, 'S1_2024');  -- ORG101: Techniques de communication

-- Notes de Marie (S1)
INSERT INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(14.0, 2, 1, 'S1_2024'),  -- INF101: Programmation procédurale
(16.5, 2, 2, 'S1_2024'),  -- INF104: HTML et Introduction au Web
(15.0, 2, 3, 'S1_2024'),  -- INF107: Informatique de Base
(11.0, 2, 4, 'S1_2024'),  -- MTH101: Arithmétique et nombres
(12.5, 2, 5, 'S1_2024'),  -- MTH102: Analyse mathématique
(15.5, 2, 6, 'S1_2024');  -- ORG101: Techniques de communication

-- Notes de Paul (S1)
INSERT INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(13.5, 3, 1, 'S1_2024'),  -- INF101: Programmation procédurale
(12.0, 3, 2, 'S1_2024'),  -- INF104: HTML et Introduction au Web
(14.5, 3, 3, 'S1_2024'),  -- INF107: Informatique de Base
(15.0, 3, 4, 'S1_2024'),  -- MTH101: Arithmétique et nombres
(14.0, 3, 5, 'S1_2024'),  -- MTH102: Analyse mathématique
(13.0, 3, 6, 'S1_2024');  -- ORG101: Techniques de communication

-- ============================================
-- INSERTION DES NOTES - SEMESTRE 4
-- ============================================

-- Notes de Jean (Parcours Développement)
INSERT INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(15.5, 1, 22, 'S1_2024'),  -- INF207: Eléments d'algorithmique
(14.0, 1, 23, 'S1_2024'),  -- INF210: Mini-projet de développement
(13.5, 1, 20, 'S1_2024'),  -- INF205: Système d'information (optionnelle choisie)
(12.0, 1, 24, 'S1_2024'),  -- MTH203: MAO
(13.0, 1, 25, 'S1_2024');  -- MTH204: Géométrie (optionnelle choisie)

-- Notes de Marie (Parcours Web et Design)
INSERT INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(16.5, 2, 30, 'S1_2024'),  -- INF209: Web dynamique
(15.0, 2, 31, 'S1_2024'),  -- INF212: Mini-projet de Web et design
(14.5, 2, 21, 'S1_2024'),  -- INF206: Interface Homme/Machine (optionnelle choisie)
(12.5, 2, 24, 'S1_2024'),  -- MTH203: MAO
(13.5, 2, 29, 'S1_2024');  -- MTH202: Analyse des données (optionnelle choisie)

-- Notes de Paul (Parcours Bases de Données et Réseaux)
INSERT INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(14.0, 3, 20, 'S1_2024'),  -- INF205: Système d'information
(15.0, 3, 28, 'S1_2024'),  -- INF211: Mini-projet BDD et/ou réseaux
(13.0, 3, 22, 'S1_2024'),  -- INF207: Eléments d'algorithmique (optionnelle choisie)
(12.5, 3, 24, 'S1_2024'),  -- MTH203: MAO
(14.5, 3, 29, 'S1_2024');  -- MTH202: Analyse des données (optionnelle choisie)

-- ============================================
-- RÉSULTATS DES ÉTUDIANTS
-- ============================================

-- Résultats Semestre 1
INSERT INTO resultat (id_etudiant, id_semestre, id_parcours, moyenne_generale, credit_obtenu, credit_total, statut, annee_universitaire) VALUES
(1, 1, NULL, 14.17, 30.0, 30.0, 'Admis', '2024-2025'),  -- Jean S1
(2, 1, NULL, 14.08, 30.0, 30.0, 'Admis', '2024-2025'),  -- Marie S1
(3, 1, NULL, 13.67, 30.0, 30.0, 'Admis', '2024-2025');  -- Paul S1

-- Résultats Semestre 4
INSERT INTO resultat (id_etudiant, id_semestre, id_parcours, moyenne_generale, credit_obtenu, credit_total, statut, annee_universitaire) VALUES
(1, 4, 1, 13.73, 30.0, 30.0, 'Admis', '2024-2025'),  -- Jean: Développement
(2, 4, 2, 14.40, 30.0, 30.0, 'Admis', '2024-2025'),  -- Marie: Web et Design
(3, 4, 3, 13.87, 30.0, 30.0, 'Admis', '2024-2025');  -- Paul: BDD et Réseaux

-- ============================================
-- VUES SQL POUR OPTIMISATION DES REQUÊTES
-- ============================================

-- Vue détaillée des notes avec toutes les informations
CREATE VIEW vue_notes_detaillees AS
SELECT 
    e.id_etudiant,
    e.nom AS nom_etudiant,
    e.prenom AS prenom_etudiant,
    n.note,
    m.id_matiere,
    m.code_matiere,
    m.libelle AS libelle_matiere,
    m.credit,
    s.id_semestre,
    s.libelle AS libelle_semestre,
    p.id_parcours,
    p.libelle AS libelle_parcours,
    sess.id_session,
    sess.libelle AS libelle_session,
    sess.date_session,
    ei.annee_universitaire,
    tm.code_type AS type_matiere,
    ins.filiere
FROM note n
INNER JOIN Etudiant e ON n.id_etudiant = e.id_etudiant
INNER JOIN Matiere m ON n.id_matiere = m.id_matiere
INNER JOIN semestre s ON m.id_semestre = s.id_semestre
INNER JOIN session sess ON n.id_session = sess.id_session
INNER JOIN etudiant_inscription ei ON e.id_etudiant = ei.id_etudiant
INNER JOIN inscription_semestre ins ON ei.id_inscription = ins.id_inscription
LEFT JOIN parcours p ON ins.id_parcours = p.id_parcours
LEFT JOIN matiere_parcours mp ON m.id_matiere = mp.id_matiere AND p.id_parcours = mp.id_parcours
LEFT JOIN type_matiere tm ON mp.id_type_matiere = tm.id_type_matiere
WHERE mp.est_active = TRUE OR mp.est_active IS NULL;

-- Vue des moyennes par semestre
CREATE VIEW vue_moyennes_semestre AS
SELECT 
    e.id_etudiant,
    e.nom AS nom_etudiant,
    e.prenom AS prenom_etudiant,
    s.id_semestre,
    s.libelle AS libelle_semestre,
    ei.annee_universitaire,
    p.libelle AS parcours,
    COUNT(n.id_note) AS nombre_notes,
    AVG(n.note) AS moyenne_semestre,
    SUM(m.credit) AS total_credits,
    SUM(CASE WHEN n.note >= 10 THEN m.credit ELSE 0 END) AS credits_obtenus
FROM Etudiant e
INNER JOIN etudiant_inscription ei ON e.id_etudiant = ei.id_etudiant
INNER JOIN inscription_semestre ins ON ei.id_inscription = ins.id_inscription
INNER JOIN semestre s ON ins.id_semestre = s.id_semestre
LEFT JOIN parcours p ON ins.id_parcours = p.id_parcours
LEFT JOIN Matiere m ON s.id_semestre = m.id_semestre
LEFT JOIN note n ON m.id_matiere = n.id_matiere AND e.id_etudiant = n.id_etudiant
GROUP BY e.id_etudiant, s.id_semestre, ei.annee_universitaire, p.libelle;