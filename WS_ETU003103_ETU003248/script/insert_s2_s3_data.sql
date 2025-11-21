-- ============================================
-- DONNÉES COMPLÈTES POUR S2 ET S3
-- ============================================

-- Insérer les notes pour Semestre 2 - Jean
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(14.5, 1, 7, 'S1_2024'),   -- INF102: Bases de données
(13.0, 1, 8, 'S1_2024'),   -- INF103: Administration système
(15.5, 1, 9, 'S1_2024'),   -- INF105: Maintenance
(16.0, 1, 10, 'S1_2024'),  -- INF106: Compléments prog
(12.5, 1, 11, 'S1_2024'),  -- MTH103: Calcul matriciel
(13.5, 1, 12, 'S1_2024');  -- MTH105: Probabilité

-- Insérer les notes pour Semestre 2 - Marie
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(15.0, 2, 7, 'S1_2024'),   -- INF102: Bases de données
(14.5, 2, 8, 'S1_2024'),   -- INF103: Administration système
(16.5, 2, 9, 'S1_2024'),   -- INF105: Maintenance
(15.5, 2, 10, 'S1_2024'),  -- INF106: Compléments prog
(13.0, 2, 11, 'S1_2024'),  -- MTH103: Calcul matriciel
(14.0, 2, 12, 'S1_2024');  -- MTH105: Probabilité

-- Insérer les notes pour Semestre 2 - Paul
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(13.5, 3, 7, 'S1_2024'),   -- INF102: Bases de données
(12.5, 3, 8, 'S1_2024'),   -- INF103: Administration système
(14.0, 3, 9, 'S1_2024'),   -- INF105: Maintenance
(14.5, 3, 10, 'S1_2024'),  -- INF106: Compléments prog
(15.0, 3, 11, 'S1_2024'),  -- MTH103: Calcul matriciel
(12.5, 3, 12, 'S1_2024');  -- MTH105: Probabilité

-- Insérer les notes pour Semestre 3 - Jean
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(16.0, 1, 13, 'S1_2024'),  -- INF201: Programmation OO
(14.5, 1, 14, 'S1_2024'),  -- INF202: BDD objets
(15.0, 1, 15, 'S1_2024'),  -- INF203: Programmation système
(13.5, 1, 16, 'S1_2024'),  -- INF208: Réseaux
(12.5, 1, 17, 'S1_2024'),  -- MTH201: Méthodes numériques
(14.0, 1, 18, 'S1_2024');  -- ORG201: Bases de gestion

-- Insérer les notes pour Semestre 3 - Marie
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(15.5, 2, 13, 'S1_2024'),  -- INF201: Programmation OO
(16.0, 2, 14, 'S1_2024'),  -- INF202: BDD objets
(14.5, 2, 15, 'S1_2024'),  -- INF203: Programmation système
(15.5, 2, 16, 'S1_2024'),  -- INF208: Réseaux
(13.5, 2, 17, 'S1_2024'),  -- MTH201: Méthodes numériques
(15.5, 2, 18, 'S1_2024');  -- ORG201: Bases de gestion

-- Insérer les notes pour Semestre 3 - Paul
INSERT IGNORE INTO note (note, id_etudiant, id_matiere, id_session) VALUES
(14.0, 3, 13, 'S1_2024'),  -- INF201: Programmation OO
(13.5, 3, 14, 'S1_2024'),  -- INF202: BDD objets
(14.5, 3, 15, 'S1_2024'),  -- INF203: Programmation système
(12.5, 3, 16, 'S1_2024'),  -- INF208: Réseaux
(13.5, 3, 17, 'S1_2024'),  -- MTH201: Méthodes numériques
(12.0, 3, 18, 'S1_2024');  -- ORG201: Bases de gestion

-- Insérer les résultats pour S2
INSERT IGNORE INTO resultat (id_etudiant, id_semestre, id_parcours, moyenne_generale, credit_obtenu, credit_total, statut, annee_universitaire) VALUES
(1, 2, NULL, 14.42, 30.0, 30.0, 'Admis', '2024-2025'),  -- Jean S2
(2, 2, NULL, 14.92, 30.0, 30.0, 'Admis', '2024-2025'),  -- Marie S2
(3, 2, NULL, 13.75, 30.0, 30.0, 'Admis', '2024-2025');  -- Paul S2

-- Insérer les résultats pour S3
INSERT IGNORE INTO resultat (id_etudiant, id_semestre, id_parcours, moyenne_generale, credit_obtenu, credit_total, statut, annee_universitaire) VALUES
(1, 3, NULL, 14.25, 30.0, 30.0, 'Admis', '2024-2025'),  -- Jean S3
(2, 3, NULL, 15.08, 30.0, 30.0, 'Admis', '2024-2025'),  -- Marie S3
(3, 3, NULL, 13.67, 30.0, 30.0, 'Admis', '2024-2025');  -- Paul S3
