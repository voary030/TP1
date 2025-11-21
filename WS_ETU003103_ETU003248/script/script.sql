-- Table des semestres
CREATE TABLE semestre(
   id_semestre INT,
   libelle VARCHAR(50),  -- Ex: "S1", "S2", "S3", "S4"
   PRIMARY KEY(id_semestre)
);

-- Table des options/parcours (Développeur, Web, Réseaux et BDD)
CREATE TABLE parcours(
   id_parcours INT,
   libelle VARCHAR(100),  -- Ex: "Développeur", "Web", "Réseaux et Base de données"
   id_semestre INT NOT NULL,
   PRIMARY KEY(id_parcours),
   FOREIGN KEY(id_semestre) REFERENCES semestre(id_semestre)
);

-- Table des sessions d'examen
CREATE TABLE session(
   id_session VARCHAR(50),
   date_session DATE,
   libelle VARCHAR(50),  -- Ex: "Session normale", "Rattrapage"
   PRIMARY KEY(id_session)
);

-- Table inscription semestre avec parcours
CREATE TABLE inscription_semestre(
   id_inscription INT,
   filiere VARCHAR(50),
   id_semestre INT NOT NULL,
   id_parcours INT,  -- NULL si pas de parcours pour ce semestre
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
   mot_de_passe VARCHAR(255),  -- Pour l'authentification (hash)
   PRIMARY KEY(id_etudiant)
);

-- Table relation Etudiant - Inscription
CREATE TABLE etudiant_inscription(
   id_etudiant INT,
   id_inscription INT,
   annee_universitaire VARCHAR(20),  -- Ex: "2024-2025"
   PRIMARY KEY(id_etudiant, id_inscription),
   FOREIGN KEY(id_etudiant) REFERENCES Etudiant(id_etudiant),
   FOREIGN KEY(id_inscription) REFERENCES inscription_semestre(id_inscription)
);

-- Table des matières
CREATE TABLE Matiere(
   id_matiere INT,
   code_matiere VARCHAR(20),  -- Ex: "ALG101", "WEB201"
   libelle VARCHAR(100),
   credit DECIMAL(3,1),
   id_semestre INT NOT NULL,
   PRIMARY KEY(id_matiere),
   FOREIGN KEY(id_semestre) REFERENCES semestre(id_semestre)
);

-- Table des types de matière (pour plus de flexibilité)
CREATE TABLE type_matiere(
   id_type_matiere INT AUTO_INCREMENT,
   code_type VARCHAR(20) UNIQUE,  -- Ex: "OBLIGATOIRE", "OPTIONNELLE", "FACULTATIVE"
   libelle VARCHAR(50),
   description TEXT,
   PRIMARY KEY(id_type_matiere)
);

-- Table de liaison Matière - Parcours (architecture flexible)
CREATE TABLE matiere_parcours(
   id_matiere_parcours INT AUTO_INCREMENT,
   id_matiere INT NOT NULL,
   id_parcours INT NOT NULL,
   id_type_matiere INT NOT NULL,  -- Type de la matière pour ce parcours
   est_active BOOLEAN DEFAULT TRUE,  -- Permet de désactiver sans supprimer
   date_debut DATE,  -- Date de début de validité
   date_fin DATE,  -- Date de fin de validité (NULL = toujours valide)
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

-- Table des résultats (pour les moyennes et résultats finaux)
CREATE TABLE resultat(
   id_resultat INT AUTO_INCREMENT,
   id_etudiant INT NOT NULL,
   id_semestre INT NOT NULL,
   id_parcours INT,
   moyenne_generale DECIMAL(5,2),
   credit_obtenu DECIMAL(5,1),
   credit_total DECIMAL(5,1),
   statut VARCHAR(50),  -- Ex: "Admis", "Ajourné", "Redoublant"
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


