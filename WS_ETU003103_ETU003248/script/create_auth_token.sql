-- Créer la table auth_token
CREATE TABLE IF NOT EXISTS auth_token(
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
   FOREIGN KEY(id_user) REFERENCES user(id_user)
);
