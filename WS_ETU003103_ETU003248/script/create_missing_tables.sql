-- Créer les tables manquantes
CREATE TABLE IF NOT EXISTS type_matiere(
   id_type_matiere INT AUTO_INCREMENT,
   code_type VARCHAR(20) UNIQUE,
   libelle VARCHAR(50),
   description TEXT,
   PRIMARY KEY(id_type_matiere)
);

CREATE TABLE IF NOT EXISTS matiere_parcours(
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

CREATE TABLE IF NOT EXISTS resultat(
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
