-- Insérer les sessions (si elles n'existent pas)
INSERT IGNORE INTO session (id_session, date_session, libelle) VALUES
('S1_2024', '2024-12-15', 'Session normale'),
('S1_RATT_2025', '2025-02-10', 'Rattrapage');

-- Insérer les types de matière
INSERT IGNORE INTO type_matiere (id_type_matiere, code_type, libelle, description) VALUES
(1, 'OBLIGATOIRE', 'Matière obligatoire', 'Matière obligatoire pour valider le parcours'),
(2, 'OPTIONNELLE', 'Matière optionnelle', 'Matière optionnelle à choisir parmi plusieurs'),
(3, 'FACULTATIVE', 'Matière facultative', 'Matière facultative, ne compte que les points au-dessus de 10');

-- Insérer les matières du Semestre 1
INSERT IGNORE INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre, id_parcours, id_type_matiere) VALUES
(1, 'INF101', 'Programmation procédurale', 7, 1, NULL, NULL),
(2, 'INF104', 'HTML et Introduction au Web', 5, 1, NULL, NULL),
(3, 'INF107', 'Informatique de Base', 4, 1, NULL, NULL),
(4, 'MTH101', 'Arithmétique et nombres', 4, 1, NULL, NULL),
(5, 'MTH102', 'Analyse mathématique', 6, 1, NULL, NULL),
(6, 'ORG101', 'Techniques de communication', 4, 1, NULL, NULL);

-- Insérer les matières du Semestre 2
INSERT IGNORE INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre, id_parcours, id_type_matiere) VALUES
(7, 'INF102', 'Bases de données relationnelles', 5, 2, NULL, NULL),
(8, 'INF103', 'Bases de l\'administration système', 5, 2, NULL, NULL),
(9, 'INF105', 'Maintenance matériel et logiciel', 4, 2, NULL, NULL),
(10, 'INF106', 'Compléments de programmation', 6, 2, NULL, NULL),
(11, 'MTH103', 'Calcul Vectoriel et Matriciel', 6, 2, NULL, NULL),
(12, 'MTH105', 'Probabilité et Statistique', 4, 2, NULL, NULL);

-- Insérer les matières du Semestre 3
INSERT IGNORE INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre, id_parcours, id_type_matiere) VALUES
(13, 'INF201', 'Programmation orientée objet', 6, 3, NULL, NULL),
(14, 'INF202', 'Bases de données objets', 6, 3, NULL, NULL),
(15, 'INF203', 'Programmation système', 4, 3, NULL, NULL),
(16, 'INF208', 'Réseaux informatiques', 6, 3, NULL, NULL),
(17, 'MTH201', 'Méthodes numériques', 4, 3, NULL, NULL),
(18, 'ORG201', 'Bases de gestion', 4, 3, NULL, NULL);

-- Insérer les matières du Semestre 4
INSERT IGNORE INTO Matiere (id_matiere, code_matiere, libelle, credit, id_semestre, id_parcours, id_type_matiere) VALUES
(19, 'INF204', 'Système d\'information géographique', 6, 4, NULL, NULL),
(20, 'INF205', 'Système d\'information', 6, 4, NULL, NULL),
(21, 'INF206', 'Interface Homme/Machine', 6, 4, NULL, NULL),
(22, 'INF207', 'Eléments d\'algorithmique', 6, 4, NULL, NULL),
(23, 'INF210', 'Mini-projet de développement', 10, 4, NULL, NULL),
(24, 'MTH203', 'MAO', 4, 4, NULL, NULL),
(25, 'MTH204', 'Géométrie', 4, 4, NULL, NULL),
(26, 'MTH205', 'Equations différentielles', 4, 4, NULL, NULL),
(27, 'MTH206', 'Optimisation', 4, 4, NULL, NULL),
(28, 'INF211', 'Mini-projet de bases de données et réseaux', 10, 4, NULL, NULL),
(29, 'MTH202', 'Analyse des données', 4, 4, NULL, NULL),
(30, 'INF209', 'Web dynamique', 6, 4, NULL, NULL),
(31, 'INF212', 'Mini-projet de Web et design', 10, 4, NULL, NULL);

-- Insérer les relations matière-parcours pour S4
-- Parcours 1: Développement
INSERT IGNORE INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(22, 1, 1, '2024-09-01'),  -- INF207: Eléments d'algorithmique (obligatoire)
(23, 1, 1, '2024-09-01'),  -- INF210: Mini-projet de développement (obligatoire)
(24, 1, 1, '2024-09-01'),  -- MTH203: MAO (obligatoire)
(19, 1, 2, '2024-09-01'),  -- INF204: SIG (optionnelle)
(20, 1, 2, '2024-09-01'),  -- INF205: SI (optionnelle)
(21, 1, 2, '2024-09-01'),  -- INF206: IHM (optionnelle)
(25, 1, 2, '2024-09-01'),  -- MTH204: Géométrie (optionnelle)
(26, 1, 2, '2024-09-01'),  -- MTH205: Equations diff (optionnelle)
(27, 1, 2, '2024-09-01');  -- MTH206: Optimisation (optionnelle)

-- Parcours 2: Web et Design
INSERT IGNORE INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(30, 2, 1, '2024-09-01'),  -- INF209: Web dynamique (obligatoire)
(31, 2, 1, '2024-09-01'),  -- INF212: Mini-projet Web (obligatoire)
(22, 2, 1, '2024-09-01'),  -- INF207: Algorithmique (obligatoire)
(24, 2, 1, '2024-09-01'),  -- MTH203: MAO (obligatoire)
(29, 2, 2, '2024-09-01'),  -- MTH202: Analyse des données (optionnelle)
(25, 2, 2, '2024-09-01'),  -- MTH204: Géométrie (optionnelle)
(26, 2, 2, '2024-09-01'),  -- MTH205: Equations diff (optionnelle)
(27, 2, 2, '2024-09-01');  -- MTH206: Optimisation (optionnelle)

-- Parcours 3: Bases de Données et Réseaux
INSERT IGNORE INTO matiere_parcours (id_matiere, id_parcours, id_type_matiere, date_debut) VALUES
(28, 3, 1, '2024-09-01'),  -- INF211: Mini-projet BDD/Réseaux (obligatoire)
(22, 3, 1, '2024-09-01'),  -- INF207: Algorithmique (obligatoire)
(24, 3, 1, '2024-09-01'),  -- MTH203: MAO (obligatoire)
(20, 3, 2, '2024-09-01'),  -- INF205: SI (optionnelle)
(29, 3, 2, '2024-09-01'),  -- MTH202: Analyse des données (optionnelle)
(25, 3, 2, '2024-09-01'),  -- MTH204: Géométrie (optionnelle)
(26, 3, 2, '2024-09-01'),  -- MTH205: Equations diff (optionnelle)
(27, 3, 2, '2024-09-01');  -- MTH206: Optimisation (optionnelle)

-- Insérer les notes pour Semestre 1 - Jean
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(15.0, 1, 1, 'S1_2024'),  -- INF101
(14.5, 1, 2, 'S1_2024'),  -- INF104
(16.0, 1, 3, 'S1_2024'),  -- INF107
(12.5, 1, 4, 'S1_2024'),  -- MTH101
(13.0, 1, 5, 'S1_2024'),  -- MTH102
(14.5, 1, 6, 'S1_2024');  -- ORG101

-- Insérer les notes pour Semestre 1 - Marie
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(14.0, 2, 1, 'S1_2024'),  -- INF101
(16.5, 2, 2, 'S1_2024'),  -- INF104
(15.0, 2, 3, 'S1_2024'),  -- INF107
(11.0, 2, 4, 'S1_2024'),  -- MTH101
(12.5, 2, 5, 'S1_2024'),  -- MTH102
(15.5, 2, 6, 'S1_2024');  -- ORG101

-- Insérer les notes pour Semestre 1 - Paul
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(13.5, 3, 1, 'S1_2024'),  -- INF101
(12.0, 3, 2, 'S1_2024'),  -- INF104
(14.5, 3, 3, 'S1_2024'),  -- INF107
(15.0, 3, 4, 'S1_2024'),  -- MTH101
(14.0, 3, 5, 'S1_2024'),  -- MTH102
(13.0, 3, 6, 'S1_2024');  -- ORG101

-- Insérer les notes pour Semestre 4 - Jean (Développement)
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(15.5, 1, 22, 'S1_2024'),  -- INF207
(14.0, 1, 23, 'S1_2024'),  -- INF210
(13.5, 1, 20, 'S1_2024'),  -- INF205 (optionnelle choisie)
(12.0, 1, 24, 'S1_2024'),  -- MTH203
(13.0, 1, 25, 'S1_2024');  -- MTH204 (optionnelle choisie)

-- Insérer les notes pour Semestre 4 - Marie (Web et Design)
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(16.5, 2, 30, 'S1_2024'),  -- INF209
(15.0, 2, 31, 'S1_2024'),  -- INF212
(14.5, 2, 21, 'S1_2024'),  -- INF206 (optionnelle choisie)
(12.5, 2, 24, 'S1_2024'),  -- MTH203
(13.5, 2, 29, 'S1_2024');  -- MTH202 (optionnelle choisie)

-- Insérer les notes pour Semestre 4 - Paul (BDD et Réseaux)
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(14.0, 3, 20, 'S1_2024'),  -- INF205
(15.0, 3, 28, 'S1_2024'),  -- INF211
(13.0, 3, 22, 'S1_2024'),  -- INF207 (optionnelle choisie)
(12.5, 3, 24, 'S1_2024'),  -- MTH203
(14.5, 3, 29, 'S1_2024');  -- MTH202 (optionnelle choisie)

-- Insérer les résultats
INSERT IGNORE INTO resultat (id_etudiant, id_semestre, id_parcours, moyenne_generale, credit_obtenu, credit_total, statut, annee_universitaire) VALUES
(1, 1, NULL, 14.17, 30.0, 30.0, 'Admis', '2024-2025'),  -- Jean S1
(2, 1, NULL, 14.08, 30.0, 30.0, 'Admis', '2024-2025'),  -- Marie S1
(3, 1, NULL, 13.67, 30.0, 30.0, 'Admis', '2024-2025'),  -- Paul S1
(1, 4, 1, 13.73, 30.0, 30.0, 'Admis', '2024-2025'),  -- Jean: Développement
(2, 4, 2, 14.40, 30.0, 30.0, 'Admis', '2024-2025'),  -- Marie: Web et Design
(3, 4, 3, 13.87, 30.0, 30.0, 'Admis', '2024-2025');  -- Paul: BDD et Réseaux
