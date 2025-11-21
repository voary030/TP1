-- ============================================
-- DONNÉES D'EXEMPLE
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
(1, 'Admin', 'Système', 'admin@univ.mg', 'adminpass', 'ADMIN', true, NOW()),
(2, 'Directeur', 'Pédagogique', 'directeur@univ.mg', 'dirpass', 'ADMIN', true, NOW());

INSERT INTO Etudiant (id_etudiant, nom, prenom, date_naissance, email, mot_de_passe, id_user_createur, date_inscription) VALUES
(1, 'Rakoto', 'Jean', '2002-05-15', 'jean.rakoto@univ.mg', 'jeanpass', 1, NOW()),
(2, 'Rasoa', 'Marie', '2003-08-20', 'marie.rasoa@univ.mg', 'mariepass', 1, NOW()),
(3, 'Rabe', 'Paul', '2002-12-10', 'paul.rabe@univ.mg', 'paulpass', 1, NOW());

-- ============================================
-- INSCRIPTIONS DES ÉTUDIANTS
-- ============================================

-- Inscription au S4 avec leurs parcours
INSERT INTO inscription_semestre (id_inscription, filiere, id_semestre, date) VALUES
(1, 'Informatique', 4, 1, '2024-09-01'),  -- Jean: parcours Développement
(2, 'Informatique', 4, 2, '2024-09-01'),  -- Marie: parcours Web et Design
(3, 'Informatique', 4, 3, '2024-09-01');  -- Paul: parcours Bases de Données et Réseaux

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
-- REQUÊTES SQL UTILES POUR LES WEB SERVICES
-- ============================================

-- 1. Récupérer les notes d'un étudiant pour un semestre (ex: S4) - VERSION FLEXIBLE
-- Cette requête renvoit les notes avec le type de matière et le coefficient
SELECT 
    e.id_etudiant,
    e.nom,
    e.prenom,
    e.num_inscription,
    s.libelle AS semestre,
    p.libelle AS parcours,
    m.code_matiere,
    m.libelle AS matiere,
    m.credit,
    n.note,
    tm.libelle AS type_matiere,
    tm.code_type,
    mp.coefficient,
    mp.ordre_affichage,
    ROUND(n.note * mp.coefficient, 2) AS note_avec_coefficient,
    ses.libelle AS session_examen
FROM note n
INNER JOIN Etudiant e ON n.id_etudiant = e.id_etudiant
INNER JOIN Matiere m ON n.id_matiere = m.id_matiere
INNER JOIN semestre s ON m.id_semestre = s.id_semestre
INNER JOIN session ses ON n.id_session = ses.id_session
INNER JOIN etudiant_inscription ei ON e.id_etudiant = ei.id_etudiant
INNER JOIN inscription_semestre ins ON ei.id_inscription = ins.id_inscription
LEFT JOIN parcours p ON ins.id_parcours = p.id_parcours
LEFT JOIN matiere_parcours mp ON m.id_matiere = mp.id_matiere 
    AND p.id_parcours = mp.id_parcours 
    AND mp.est_active = TRUE
    AND (mp.date_fin IS NULL OR mp.date_fin >= CURDATE())
LEFT JOIN type_matiere tm ON mp.id_type_matiere = tm.id_type_matiere
WHERE e.id_etudiant = 1  -- Remplacer par le paramètre
  AND s.id_semestre = 4  -- Remplacer par le paramètre (S4)
  AND n.annee_universitaire = '2024-2025'
ORDER BY mp.ordre_affichage, m.libelle;

-- 2. Récupérer les notes d'un étudiant pour une année complète (ex: L1 = S1 + S2)
SELECT 
    e.id_etudiant,
    e.nom,
    e.prenom,
    s.libelle AS semestre,
    m.libelle AS matiere,
    m.credit,
    n.note,
    ses.libelle AS session_examen
FROM note n
INNER JOIN Etudiant e ON n.id_etudiant = e.id_etudiant
INNER JOIN Matiere m ON n.id_matiere = m.id_matiere
INNER JOIN semestre s ON m.id_semestre = s.id_semestre
INNER JOIN session ses ON n.id_session = ses.id_session
WHERE e.id_etudiant = 1
  AND s.id_semestre IN (1, 2)  -- L1 = S1 + S2, L2 = S3 + S4
  AND n.annee_universitaire = '2024-2025'
ORDER BY s.id_semestre, m.libelle;

-- 3. Calculer la moyenne d'un étudiant pour un semestre
SELECT 
    e.id_etudiant,
    e.nom,
    e.prenom,
    s.libelle AS semestre,
    ROUND(SUM(n.note * m.credit) / SUM(m.credit), 2) AS moyenne_generale,
    SUM(m.credit) AS total_credits
FROM note n
INNER JOIN Etudiant e ON n.id_etudiant = e.id_etudiant
INNER JOIN Matiere m ON n.id_matiere = m.id_matiere
INNER JOIN semestre s ON m.id_semestre = s.id_semestre
WHERE e.id_etudiant = 1
  AND s.id_semestre = 4
  AND n.annee_universitaire = '2024-2025'
  AND n.note >= 10  -- Uniquement les matières validées
GROUP BY e.id_etudiant, e.nom, e.prenom, s.libelle;

-- 4. Vérifier l'authentification d'un étudiant
SELECT 
    id_etudiant,
    nom,
    prenom,
    email,
    mot_de_passe
FROM Etudiant
WHERE email = 'jean.rakoto@univ.mg';  -- Paramètre

-- 5. Créer/Vérifier un token d'authentification
-- Insertion d'un nouveau token
INSERT INTO auth_token (token, id_etudiant, date_expiration) 
VALUES ('abc123xyz', 1, DATE_ADD(NOW(), INTERVAL 24 HOUR));

-- Vérifier si un token est valide
SELECT 
    t.id_token,
    t.id_etudiant,
    e.nom,
    e.prenom,
    t.date_expiration
FROM auth_token t
INNER JOIN Etudiant e ON t.id_etudiant = e.id_etudiant
WHERE t.token = 'abc123xyz'
  AND t.est_actif = TRUE
  AND t.date_expiration > NOW();

-- 6. Récupérer toutes les matières d'un parcours avec leur statut - VERSION FLEXIBLE
SELECT 
    p.libelle AS parcours,
    m.code_matiere,
    m.libelle AS matiere,
    m.credit,
    tm.libelle AS type_matiere,
    tm.code_type,
    mp.coefficient,
    mp.ordre_affichage,
    mp.est_active,
    mp.date_debut,
    mp.date_fin,
    CASE 
        WHEN mp.date_fin IS NOT NULL AND mp.date_fin < CURDATE() THEN 'Expirée'
        WHEN mp.est_active = FALSE THEN 'Désactivée'
        ELSE 'Active'
    END AS statut_validite
FROM matiere_parcours mp
INNER JOIN parcours p ON mp.id_parcours = p.id_parcours
INNER JOIN Matiere m ON mp.id_matiere = m.id_matiere
INNER JOIN type_matiere tm ON mp.id_type_matiere = tm.id_type_matiere
WHERE p.id_parcours = 2  -- Parcours Web
  AND mp.est_active = TRUE
  AND (mp.date_fin IS NULL OR mp.date_fin >= CURDATE())
ORDER BY mp.ordre_affichage, tm.id_type_matiere, m.libelle;

-- 7. Vue pour simplifier l'accès aux matières actives par parcours
CREATE VIEW v_matiere_parcours_active AS
SELECT 
    mp.id_matiere_parcours,
    p.id_parcours,
    p.libelle AS parcours,
    m.id_matiere,
    m.code_matiere,
    m.libelle AS matiere,
    m.credit,
    tm.id_type_matiere,
    tm.code_type,
    tm.libelle AS type_matiere,
    mp.coefficient,
    mp.ordre_affichage
FROM matiere_parcours mp
INNER JOIN parcours p ON mp.id_parcours = p.id_parcours
INNER JOIN Matiere m ON mp.id_matiere = m.id_matiere
INNER JOIN type_matiere tm ON mp.id_type_matiere = tm.id_type_matiere
WHERE mp.est_active = TRUE
  AND (mp.date_fin IS NULL OR mp.date_fin >= CURDATE());

-- 8. Exemple d'utilisation de la vue
SELECT * FROM v_matiere_parcours_active
WHERE parcours = 'Web'
ORDER BY ordre_affichage;