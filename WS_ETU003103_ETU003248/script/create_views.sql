-- Script pour créer les vues SQL
-- Exécutez ce script si les vues ne sont pas créées automatiquement

USE notes_db;

-- Supprimer les vues si elles existent déjà
DROP VIEW IF EXISTS vue_notes_detaillees;
DROP VIEW IF EXISTS vue_moyennes_semestre;

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

-- Vérifier que les vues sont créées
SHOW FULL TABLES WHERE Table_type = 'VIEW';
