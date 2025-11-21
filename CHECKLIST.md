# ✅ Checklist de Déploiement et Test

## 📋 Avant de Démarrer

- [ ] Docker Desktop installé et démarré
- [ ] Git installé (optionnel)
- [ ] Ports 3000, 3306, 8080 disponibles
- [ ] Au moins 4GB RAM disponible
- [ ] Connexion Internet pour télécharger les images Docker

## 🔧 Configuration Initiale

- [ ] Fichier `.env` créé dans `WS_ETU003103_ETU003248/`
- [ ] Variables d'environnement configurées dans `.env`
- [ ] Fichier `.env` créé dans `vue-project/` (optionnel pour Docker)

## 🚀 Démarrage de l'Application

### Backend Spring Boot
- [ ] Base de données MySQL démarre correctement
- [ ] API Spring Boot démarre sans erreur
- [ ] API accessible sur http://localhost:3000
- [ ] Health check fonctionne: http://localhost:3000/actuator/health

### Frontend Vue.js
- [ ] Frontend construit sans erreur
- [ ] Nginx démarre correctement
- [ ] Frontend accessible sur http://localhost:8080
- [ ] Pas d'erreur console JavaScript

### Base de Données
- [ ] Tables créées (script init.sql exécuté)
- [ ] Données de test insérées
- [ ] Connexion possible depuis l'API

## 🧪 Tests Fonctionnels

### Authentification
- [ ] Page de login s'affiche correctement
- [ ] Connexion avec `jean.rakoto@univ.mg` / `ETU003103` fonctionne
- [ ] Token JWT reçu et stocké
- [ ] Header avec nom utilisateur affiché après connexion
- [ ] Bouton déconnexion fonctionne
- [ ] Redirection vers login si non authentifié

### Navigation
- [ ] Accès à la page semestres après login
- [ ] 4 cartes de semestres (S1, S2, S3, S4) affichées
- [ ] Clic sur semestre → liste étudiants
- [ ] Bouton retour fonctionne sur toutes les pages

### Liste des Étudiants
- [ ] Tableau des étudiants s'affiche
- [ ] Colonnes: Nom, Prénom, Email, S1, S2, S3, S4
- [ ] Au moins 3 étudiants visibles (Jean, Marie, Paul)
- [ ] Moyennes affichées correctement
- [ ] Clic sur nom → détails étudiant
- [ ] Clic sur moyenne → relevé du semestre

### Détails Étudiant
- [ ] Informations personnelles affichées
- [ ] Email correct
- [ ] Date de naissance formatée
- [ ] Tableau des moyennes S1-S4
- [ ] Résultats (Admis/Ajourné) corrects
- [ ] Boutons "Relevé L1" et "Relevé L2" présents
- [ ] Bouton retour fonctionne

### Relevé de Notes (Semestre)
- [ ] Format inspiré ITU respecté
- [ ] En-tête avec "IT UNIVERSITY" visible
- [ ] Nom et prénom de l'étudiant
- [ ] Numéro d'inscription affiché
- [ ] Tableau des notes complet
- [ ] Colonnes: UE, Intitulé, Crédits, Note/20, Résultat, Session
- [ ] Codes matières (INF101, MTH102, etc.)
- [ ] Notes affichées avec 2 décimales
- [ ] Résultats (P, AB, B, TB, AR) corrects
- [ ] Ligne de sous-total du semestre
- [ ] Résumé avec crédits totaux
- [ ] Moyenne générale calculée
- [ ] Mention affichée (Passable, Assez Bien, etc.)
- [ ] ADMIS(E) ou AJOURNÉ(E) correct
- [ ] Date et signature en pied de page

### Relevé Annuel (L1/L2)
- [ ] Deux tableaux distincts (un par semestre)
- [ ] Semestre 1 et Semestre 2 pour L1
- [ ] Semestre 3 et Semestre 4 pour L2
- [ ] Sous-total par semestre
- [ ] Total général de l'année
- [ ] Moyenne annuelle correcte
- [ ] Crédits cumulés corrects

### Gestion des Parcours (S4)
- [ ] Parcours affiché pour S4 uniquement
- [ ] "option dev", "option web" ou "option bdd" visible
- [ ] Matières du bon parcours affichées
- [ ] Jean → Développement
- [ ] Marie → Web et Design
- [ ] Paul → BDD et Réseaux

## 🔍 Tests API (avec Postman ou PowerShell)

### Authentication
- [ ] `POST /api/auth/login` retourne token
- [ ] Token valide et utilisable
- [ ] Login avec mauvais credentials retourne erreur 401

### Semestres
- [ ] `GET /api/semesters` retourne 4 semestres
- [ ] `GET /api/semesters/4/parcours` retourne 3 parcours

### Étudiants
- [ ] `GET /api/students` retourne liste avec moyennes
- [ ] `GET /api/students/1` retourne détails complets
- [ ] Moyennes calculées correctement

### Notes
- [ ] `GET /api/students/1/semesters/1/grades` retourne notes S1
- [ ] `GET /api/students/1/years/1/grades` retourne notes L1 (S1+S2)
- [ ] Format JSON correct et complet

## 🎨 Tests UI/UX

### Design
- [ ] Interface propre et professionnelle
- [ ] Couleurs cohérentes
- [ ] Textes lisibles
- [ ] Boutons bien visibles
- [ ] Hover effects fonctionnent
- [ ] Transitions fluides

### Responsive
- [ ] Desktop (1920x1080) ✓
- [ ] Laptop (1366x768) ✓
- [ ] Tablet (768x1024) ✓
- [ ] Mobile (375x667) ✓

### Accessibilité
- [ ] Contraste suffisant
- [ ] Tailles de police lisibles
- [ ] Boutons assez grands pour cliquer

## 🐛 Tests d'Erreur

### Gestion des erreurs
- [ ] Erreur 401 → redirection vers login
- [ ] Étudiant inexistant → message d'erreur
- [ ] API down → message d'erreur approprié
- [ ] Champs vides dans login → validation
- [ ] Token expiré → demande de reconnexion

### Cas limites
- [ ] Étudiant sans notes dans un semestre
- [ ] Moyenne exacte à 10.00 (Admis ou Ajourné?)
- [ ] Matière avec 0 crédit
- [ ] Parcours sans option

## 📊 Performance

- [ ] Page de login charge en < 2s
- [ ] Liste étudiants charge en < 3s
- [ ] Relevé de notes charge en < 2s
- [ ] Navigation entre pages fluide
- [ ] Pas de lag lors du scroll
- [ ] Images/icônes chargent rapidement

## 🔒 Sécurité

- [ ] Token JWT requis pour toutes les routes protégées
- [ ] Token stocké seulement dans localStorage
- [ ] Pas de mot de passe en clair dans le code
- [ ] CORS configuré correctement
- [ ] Pas de données sensibles dans les logs

## 📝 Documentation

- [ ] README.md à jour
- [ ] INSTALLATION.md complet
- [ ] API_DOCUMENTATION.md précis
- [ ] COMMANDES_UTILES.md utile
- [ ] Commentaires dans le code

## 🎓 Conformité Sujet

- [ ] WS sur les notes ✓
- [ ] Application Vue.js ✓
- [ ] Liste semestres avec liens ✓
- [ ] Liste étudiants avec moyennes S1-S4 ✓
- [ ] Clic moyenne → relevé ✓
- [ ] Clic étudiant → infos + moyennes ✓
- [ ] Liens L1 (S1+S2) et L2 (S3+S4) ✓
- [ ] Gestion des options/parcours ✓
- [ ] Format inspiré ITU ✓
- [ ] Docker fonctionnel ✓

## 📦 Avant de Soumettre

- [ ] Tous les tests ci-dessus passent ✓
- [ ] Code commité sur Git
- [ ] .gitignore configuré (pas de node_modules, .env)
- [ ] README complet avec instructions
- [ ] Scripts de démarrage testés
- [ ] Capture d'écran de l'application
- [ ] Export base de données disponible

## 🎉 Démo

### Scénario de démo
1. [ ] Démarrer l'application (start.bat)
2. [ ] Se connecter (jean.rakoto@univ.mg)
3. [ ] Naviguer vers semestres
4. [ ] Voir liste étudiants
5. [ ] Cliquer sur une moyenne → voir relevé
6. [ ] Retour → cliquer sur nom étudiant
7. [ ] Voir détails et moyennes
8. [ ] Cliquer sur "Relevé L1"
9. [ ] Montrer format L1 avec S1+S2
10. [ ] Se déconnecter

### Points à mettre en avant
- [ ] Design professionnel
- [ ] Format relevé fidèle à ITU
- [ ] Gestion des parcours S4
- [ ] Navigation intuitive
- [ ] Authentification sécurisée
- [ ] Docker facilite le déploiement

## 📞 Support

Si un test échoue:
1. Consulter COMMANDES_UTILES.md
2. Vérifier les logs Docker
3. Relancer avec docker-compose down -v && docker-compose up --build
4. Vérifier la configuration .env

---

## ✅ Validation Finale

- [ ] **Tous les tests passent** ✓
- [ ] **Application stable** ✓
- [ ] **Documentation complète** ✓
- [ ] **Prêt pour la démo** ✓

**Date de validation:** _________________

**Testé par:** ETU003103 & ETU003248

**Signature:** _________________

---

**🎉 PROJET VALIDÉ ET PRÊT POUR LA SOUMISSION ! 🎉**
