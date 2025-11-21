-- ============================================
-- CRÉATION DE TOUTES LES TABLES
-- ============================================

-- Table des semestres
CREATE TABLE IF NOT EXISTS semestre(
   id_semestre INT PRIMARY KEY,
   libelle VARCHAR(50)
);

-- Table des options/parcours
CREATE TABLE IF NOT EXISTS parcours(
   id_parcours INT PRIMARY KEY AUTO_INCREMENT,
   libelle VARCHAR(100),
   id_semestre INT NOT NULL,
   FOREIGN KEY(id_semestre) REFERENCES semestre(id_semestre)
);

-- Table des sessions d'examen
CREATE TABLE IF NOT EXISTS session(
   id_session VARCHAR(50) PRIMARY KEY,
   date_session DATE,
   libelle VARCHAR(50)
);

-- Table Admin/Utilisateur
CREATE TABLE IF NOT EXISTS user(
   id_user INT AUTO_INCREMENT PRIMARY KEY,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(100) UNIQUE NOT NULL,
   mot_de_passe VARCHAR(255) NOT NULL,
   role VARCHAR(20) DEFAULT 'ADMIN',
   est_actif BOOLEAN DEFAULT TRUE,
   date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table Etudiant
CREATE TABLE IF NOT EXISTS Etudiant(
   id_etudiant INT PRIMARY KEY AUTO_INCREMENT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   date_naissance DATE,
   email VARCHAR(100),
   mot_de_passe VARCHAR(255),
   id_user_createur INT,
   date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY(id_user_createur) REFERENCES user(id_user)
);

-- Table des matières
CREATE TABLE IF NOT EXISTS Matiere(
   id_matiere INT PRIMARY KEY AUTO_INCREMENT,
   code_matiere VARCHAR(20),
   libelle VARCHAR(100),
   credit DECIMAL(3,1),
   id_semestre INT NOT NULL,
   id_parcours INT,
   id_type_matiere INT,
   FOREIGN KEY(id_semestre) REFERENCES semestre(id_semestre)
);

-- Table des types de matière
CREATE TABLE IF NOT EXISTS type_matiere(
   id_type_matiere INT AUTO_INCREMENT PRIMARY KEY,
   code_type VARCHAR(20) UNIQUE,
   libelle VARCHAR(50),
   description TEXT
);

-- Ajouter les contraintes de clé étrangère pour Matiere (après création de type_matiere)
ALTER TABLE Matiere ADD CONSTRAINT fk_matiere_type 
FOREIGN KEY(id_type_matiere) REFERENCES type_matiere(id_type_matiere);

ALTER TABLE Matiere ADD CONSTRAINT fk_matiere_parcours 
FOREIGN KEY(id_parcours) REFERENCES parcours(id_parcours);

-- Table de liaison Matière - Parcours
CREATE TABLE IF NOT EXISTS matiere_parcours(
   id_matiere_parcours INT AUTO_INCREMENT PRIMARY KEY,
   id_matiere INT NOT NULL,
   id_parcours INT NOT NULL,
   id_type_matiere INT NOT NULL,
   est_active BOOLEAN DEFAULT TRUE,
   date_debut DATE,
   date_fin DATE,
   UNIQUE KEY unique_matiere_parcours_type (id_matiere, id_parcours, id_type_matiere),
   FOREIGN KEY(id_matiere) REFERENCES Matiere(id_matiere),
   FOREIGN KEY(id_parcours) REFERENCES parcours(id_parcours),
   FOREIGN KEY(id_type_matiere) REFERENCES type_matiere(id_type_matiere)
);

-- Table des notes
CREATE TABLE IF NOT EXISTS note(
   id_note INT AUTO_INCREMENT PRIMARY KEY,
   note DECIMAL(5,2),
   id_etudiant INT NOT NULL,
   id_matiere INT NOT NULL,
   id_session VARCHAR(50) NOT NULL,
   FOREIGN KEY(id_etudiant) REFERENCES Etudiant(id_etudiant),
   FOREIGN KEY(id_matiere) REFERENCES Matiere(id_matiere),
   FOREIGN KEY(id_session) REFERENCES session(id_session)
);

-- Table des résultats
CREATE TABLE IF NOT EXISTS resultat(
   id_resultat INT AUTO_INCREMENT PRIMARY KEY,
   id_etudiant INT NOT NULL,
   id_semestre INT NOT NULL,
   id_parcours INT,
   moyenne_generale DECIMAL(5,2),
   credit_obtenu DECIMAL(5,1),
   credit_total DECIMAL(5,1),
   statut VARCHAR(50),
   annee_universitaire VARCHAR(20) NOT NULL,
   FOREIGN KEY(id_etudiant) REFERENCES Etudiant(id_etudiant),
   FOREIGN KEY(id_semestre) REFERENCES semestre(id_semestre),
   FOREIGN KEY(id_parcours) REFERENCES parcours(id_parcours)
);

-- Table des tokens d'authentification
CREATE TABLE IF NOT EXISTS auth_token(
   id_token INT AUTO_INCREMENT PRIMARY KEY,
   token VARCHAR(255) NOT NULL UNIQUE,
   id_etudiant INT,
   id_user INT,
   user_type VARCHAR(20) NOT NULL,
   date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   date_expiration TIMESTAMP NOT NULL,
   est_actif BOOLEAN DEFAULT TRUE,
   FOREIGN KEY(id_etudiant) REFERENCES Etudiant(id_etudiant),
   FOREIGN KEY(id_user) REFERENCES user(id_user)
);

-- Créer les index
CREATE INDEX idx_note_etudiant ON note(id_etudiant);
CREATE INDEX idx_note_matiere ON note(id_matiere);
CREATE INDEX idx_resultat_etudiant ON resultat(id_etudiant);
CREATE INDEX idx_token_actif ON auth_token(token, est_actif);
