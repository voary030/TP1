-- Script pour créer des mots de passe hashés avec BCrypt
-- À exécuter après le script.sql

-- Mettre à jour les mots de passe avec BCrypt (cost factor 10)
-- Mot de passe: "password123" pour tous les étudiants de test
UPDATE Etudiant 
SET mot_de_passe = '$2a$10$xn3LI/AjqicFYZFruSwve.681477XaUTr7iU0t5s6f6xDrNYcZJOG';

-- Vérification
SELECT id_etudiant, nom, prenom, email, LEFT(mot_de_passe, 20) as mot_de_passe_hash
FROM Etudiant;

-- Note: Pour tester l'authentification avec Postman:
-- Email: rakoto@ituniv.mg
-- Password: password123
