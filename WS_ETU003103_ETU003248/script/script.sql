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

-- Table Admin/Utilisateur
CREATE TABLE user(
   id_user INT AUTO_INCREMENT,
   nom VARCHAR(50),
   prenom VARCHAR(50),
   email VARCHAR(100) UNIQUE NOT NULL,
   mot_de_passe VARCHAR(255) NOT NULL,
   role VARCHAR(20) DEFAULT 'ADMIN',  -- ADMIN, SUPER_ADMIN
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
   mot_de_passe VARCHAR(255),  -- Pour l'authentification (hash)
   id_user_createur INT,  -- Admin qui a inscrit l'étudiant
   date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(id_etudiant),
   FOREIGN KEY(id_user_createur) REFERENCES user(id_user)
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
   id_etudiant INT,
   id_user INT,
   user_type VARCHAR(20) NOT NULL,  -- 'ETUDIANT' ou 'ADMIN'
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


