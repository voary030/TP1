-- ============================================
-- INSERTION DES UTILISATEURS ADMIN
-- ============================================

-- Mot de passe hashé avec BCrypt pour "AdminPass123!"
-- Hash généré avec: BCrypt.hashpw("AdminPass123!", BCrypt.gensalt(10))
INSERT INTO users (username, email, mot_de_passe, role, est_actif) VALUES
('admin.bureau', 'admin@univ.mg', '$2a$10$xYzAbC123.ExampleHashForAdminPass', 'ADMIN', TRUE),
('secretaire', 'secretaire@univ.mg', '$2a$10$xYzAbC123.ExampleHashForSecPass', 'USER', TRUE);

-- Note: Ces hashs sont des exemples. Pour les vrais hashs, utilisez PasswordHashGenerator.java
-- Ou utilisez le script update_admin_passwords.sql après avoir lancé l'application
