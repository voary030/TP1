-- Insérer les utilisateurs admin
INSERT INTO user (id_user, nom, prenom, email, mot_de_passe, role, est_actif, date_creation) VALUES
(1, 'Admin', 'Système', 'admin@univ.mg', 'AdminPass123!', 'ADMIN', true, NOW()),
(2, 'Secrétaire', 'Bureau', 'secretaire@univ.mg', 'SecPass123!', 'USER', true, NOW());

-- Insérer les étudiants
INSERT INTO Etudiant (id_etudiant, nom, prenom, date_naissance, email, mot_de_passe, id_user_createur, date_inscription) VALUES
(1, 'Rakoto', 'Jean', '2002-05-15', 'jean.rakoto@univ.mg', 'jeanpass', 1, NOW()),
(2, 'Rasoa', 'Marie', '2003-08-20', 'marie.rasoa@univ.mg', 'mariepass', 1, NOW()),
(3, 'Rabe', 'Paul', '2002-12-10', 'paul.rabe@univ.mg', 'paulpass', 1, NOW());

-- Insérer les semestres
INSERT INTO semestre (id_semestre, libelle) VALUES
(1, 'S1'),
(2, 'S2'),
(3, 'S3'),
(4, 'S4');

-- Insérer les parcours pour S4
INSERT INTO parcours (id_parcours, libelle, id_semestre) VALUES
(1, 'Développeur', 4),
(2, 'Web et Design', 4),
(3, 'Bases de Données et Réseaux', 4);
