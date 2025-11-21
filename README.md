# 🎓 Application de Gestion des Notes - IT University

> Projet de développement web Full Stack avec Vue.js 3 et Spring Boot  
> **IT University Madagascar - Décembre 2024**

## 📝 Description

Application complète de gestion des notes étudiantes permettant aux **administrateurs** de :
- Consulter les moyennes de tous les étudiants
- Visualiser les relevés de notes par semestre
- Générer des relevés annuels (L1 et L2)
- Gérer les parcours optionnels pour le S4
- Interface inspirée des relevés officiels ITU

**⚠️ Note importante:** Seuls les **administrateurs** ont accès à l'application (login). Les étudiants sont uniquement des entités de données dans le système.

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                  Environnement Local                     │
├──────────────┬──────────────────┬──────────────────────┤
│   Frontend   │    Backend API   │   Base de Données    │
│   Vue.js 3   │   Spring Boot 3  │      MySQL 8.0       │
│   + Vite     │   + Spring       │      (Docker)        │
│   Port 5173  │   Security JWT   │      Port 3306       │
│              │   Port 8060      │                      │
└──────────────┴──────────────────┴──────────────────────┘
```

## ✨ Fonctionnalités

### Interface d'Administration
- ✅ Authentification sécurisée JWT (admin uniquement)
- ✅ Liste de tous les étudiants avec moyennes S1-S4
- ✅ Détails d'un étudiant (informations personnelles)
- ✅ Consultation des relevés par semestre (S1 à S4)
- ✅ Relevés annuels formatés (L1 = S1+S2, L2 = S3+S4)
- ✅ Calcul automatique des résultats (Admis/Ajourné/Redoublement)
- ✅ Attribution automatique des mentions

### Gestion des Parcours (S4)
- 🎯 Développement
- 🎨 Web et Design
- 💾 Bases de Données et Réseaux

### Architecture Technique
- 🔐 **Authentification:** JWT avec BCrypt
- 🎨 **Composants:** 7 composants partagés réutilisables
- 🔄 **API Mode:** Bascule mock/real API via variables d'environnement
- 📱 **Responsive:** Interface adaptative
- ♻️ **Code:** Refactorisé avec composables et shared components (réduction 77-80%)

## 🚀 Démarrage Rapide

### Option 1: Démarrage Automatique ⚡

```cmd
start-all.bat
```

Le script démarre automatiquement :
1. Backend (Spring Boot + MySQL Docker)
2. Frontend (Vue.js + Vite)

**Accès:** http://localhost:5173

### Option 2: Démarrage Manuel

#### Étape 1: Générer les mots de passe admin
```cmd
generate-passwords.bat
```

#### Étape 2: Insérer les utilisateurs admin
```cmd
cd WS_ETU003103_ETU003248
docker-compose up -d
mysql -u notes_user -p notes_db < script\insert_admin_users.sql
```
Mot de passe MySQL: `notes2024`

#### Étape 3: Démarrer le backend
```cmd
cd WS_ETU003103_ETU003248
start.bat
```
Attendre 30 secondes pour l'initialisation complète.

#### Étape 4: Démarrer le frontend
```cmd
cd vue-project
npm run dev
```

**Accès:** http://localhost:5173

### Prérequis
- ✅ Java JDK 17+
- ✅ Maven 3.8+
- ✅ Node.js 18+ et npm
- ✅ Docker Desktop (pour MySQL)
- 💾 4GB RAM disponible
- 🔌 Ports 5173, 8060, 3306 libres

## 🔐 Comptes Administrateur

| Utilisateur | Email | Mot de passe | Rôle |
|-------------|-------|--------------|------|
| Admin Bureau | admin@univ.mg | AdminPass123! | ADMIN |
| Secrétaire | secretaire@univ.mg | SecPass123! | ADMIN |

## 📱 Utilisation

1. **Connexion**  
   Connectez-vous avec un compte administrateur sur http://localhost:5173

2. **Navigation**  
   - `/students` → Liste de tous les étudiants avec moyennes S1-S4
   - Clic sur un étudiant → Détails et choix du relevé
   - Choix du semestre → Relevé de notes détaillé
   - L1/L2 → Relevé annuel complet

3. **Fonctionnalités**
   - Bouton Retour intelligent dans chaque vue
   - Calcul automatique des résultats et mentions
   - Format officiel ITU pour les relevés

## 🎨 Structure du Code (Refactorisé)

### Composants Partagés (`src/Components/shared/`)
```
BackButton.vue          → Navigation intelligente
LoadingSpinner.vue      → Indicateur de chargement uniforme
TranscriptHeader.vue    → En-tête ITU University
StudentInfoSection.vue  → Informations étudiant
GradesTable.vue         → Tableau de notes avec totaux
TranscriptSummary.vue   → Résumé (crédits, moyenne, mention)
TranscriptFooter.vue    → Pied de page avec date/signature
```

### Composables (`src/composables/`)
```
useGradeFormat.js  → formatGrade, getResult, getResultClass, getMention
useDateFormat.js   → formatDate, formatBirthDate, formatSession
```

### Fichiers de Configuration
```
.env                          → VITE_API_URL, VITE_USE_MOCK_API
src/services/api.js           → Client API avec intercepteurs JWT
src/services/mockApi.js       → Données de test (mode mock)
src/assets/transcript.css     → Styles partagés relevés
```

## 🔄 Modes de Fonctionnement

### Mode Production (Backend Réel)
```env
# vue-project/.env
VITE_API_URL=http://localhost:8060
VITE_USE_MOCK_API=false
```

### Mode Développement (Mock API)
```env
# vue-project/.env
VITE_API_URL=http://localhost:8060
VITE_USE_MOCK_API=true
```

Le mode mock permet de développer le frontend sans backend actif.

## 📊 Données de Test

### Étudiants Disponibles
| Nom | Email | Parcours S4 |
|-----|-------|-------------|
| Jean RAKOTO | jean.rakoto@univ.mg | Développement |
| Marie RASOA | marie.rasoa@univ.mg | Web et Design |
| Paul RABE | paul.rabe@univ.mg | BDD et Réseaux |
   - Clic sur nom → Détails de l'étudiant
   - Clic sur moyenne → Relevé du semestre

3. **Relevés de notes**  
   - Relevés par semestre (S1, S2, S3, S4)
   - Relevés annuels (L1, L2)
   - Format inspiré des relevés ITU officiels

## 🛠️ Technologies

### Frontend
- **Vue.js 3.5** - Framework JavaScript progressif avec Composition API
- **Vue Router 4** - Routage SPA avec navigation guards
- **Pinia 2** - State management avec persistence localStorage
- **Axios** - Client HTTP avec intercepteurs JWT
- **Vite 7** - Build tool ultra-rapide avec HMR

### Backend
- **Spring Boot 3.2** - Framework Java enterprise
- **Spring Security** - JWT authentication avec BCrypt
- **Spring Data JPA** - ORM avec Hibernate
- **MySQL 8.0** - Base de données relationnelle
- **Docker** - Containerisation MySQL

### DevOps
- **Maven** - Build et gestion de dépendances
- **Docker Compose** - Orchestration MySQL
- **Windows Scripts** - Automatisation démarrage (.bat)

## 📚 Documentation

### Guides Principaux
- 🚀 [Démarrage Rapide](DEMARRAGE_RAPIDE.md) - **COMMENCEZ ICI**
- 🔌 [Connexion Backend-Frontend](BACKEND_FRONTEND_CONNECTION.md) - Guide complet intégration
- 📖 [Installation Complète](INSTALLATION.md)
- 🧪 [Guide Mock API](MOCK_API_GUIDE.md) - Développement frontend sans backend

### Documentation Technique
- 🔧 [Documentation API REST](API_DOCUMENTATION.md)
- 💻 [Commandes Utiles](COMMANDES_UTILES.md)
- ✅ [Checklist de Test](CHECKLIST.md)
- 📊 [Résumé du Projet](PROJET_RESUME.md)
- 🔄 [Résumé Refactoring](REFACTORING_SUMMARY.md)

### Tests
- 📮 [Guide Postman](GUIDE_TEST_POSTMAN.md)
- 🧪 [Tests API Complets](GUIDE_RAPIDE_POSTMAN.md)
- 👑 [Fonctionnalités Admin](ADMIN_FEATURES.md)

## 📂 Structure du Projet

```
TP1/
├── WS_ETU003103_ETU003248/         # Backend Spring Boot
│   ├── src/main/java/mg/itu/notesapi/
│   │   ├── entity/                 # Entités JPA (Student, Grade, etc.)
│   │   ├── controller/             # REST Controllers
│   │   ├── service/                # Business logic
│   │   ├── repository/             # Data access layer
│   │   ├── dto/                    # Data Transfer Objects
│   │   ├── config/                 # SecurityConfig, CORS, JWT
│   │   └── exception/              # Exception handlers
│   ├── script/                     # Scripts SQL
│   │   ├── init.sql                # Création tables
│   │   ├── data.sql                # Données étudiants
│   │   ├── insert_admin_users.sql  # Utilisateurs admin
│   │   └── create_views.sql        # Vues SQL
│   ├── docker-compose.yml          # MySQL Docker
│   ├── start.bat / stop.bat        # Scripts Windows
│   └── .env                        # Configuration
│
├── vue-project/                    # Frontend Vue.js
│   ├── src/
│   │   ├── views/                  # Pages principales
│   │   │   ├── LoginView.vue       # Page de connexion
│   │   │   ├── StudentsView.vue    # Liste étudiants
│   │   │   ├── StudentDetailView.vue
│   │   │   ├── SemestersView.vue   # Choix semestre
│   │   │   ├── SemesterGradesView.vue
│   │   │   └── YearGradesView.vue  # Relevés L1/L2
│   │   ├── Components/             # Composants Vue
│   │   │   └── shared/             # Composants réutilisables
│   │   ├── composables/            # Logique réutilisable
│   │   ├── router/                 # Configuration routes
│   │   ├── stores/                 # Pinia stores (auth)
│   │   ├── services/               # API client
│   │   │   ├── api.js              # Client principal
│   │   │   ├── mockApi.js          # Mock API
│   │   │   └── mockData.js         # Données de test
│   │   └── assets/                 # CSS et ressources
│   ├── .env                        # Variables environnement
│   └── package.json                # Dépendances npm
│
├── postman/                        # Collections Postman
├── start-all.bat                   # Démarrage complet
├── generate-passwords.bat          # Génération hashes BCrypt
└── Documentation (14 fichiers MD)  # Guides complets
```

## 🎯 Points Forts du Projet

✅ **Architecture moderne** - Séparation frontend/backend avec API REST  
✅ **Code refactorisé** - Composants réutilisables, réduction 77-80%  
✅ **Sécurité renforcée** - JWT + BCrypt, admin-only access  
✅ **Mode développement** - Mock API pour frontend standalone  
✅ **Design professionnel** - Interface inspirée relevés ITU officiels  
✅ **Documentation exhaustive** - 14 fichiers MD, guides pas-à-pas  
✅ **Scripts automatisés** - Démarrage et génération mots de passe  
✅ **Tests complets** - Collections Postman incluses  

## 🧪 Tests et Validation

### Tester l'API Backend
```cmd
cd WS_ETU003103_ETU003248
.\test-api-complet.ps1
```

### Tester le Frontend
```cmd
cd vue-project
npm run dev
# Ouvrir http://localhost:5173
# Login: admin@univ.mg / AdminPass123!
```

### Tester avec Postman
1. Importer `postman/notes-api-complete-avec-vues.postman_collection.json`
2. Configurer environnement (port 8060)
3. Tester les endpoints (voir [GUIDE_TEST_POSTMAN.md](WS_ETU003103_ETU003248/GUIDE_TEST_POSTMAN.md))

## 🐛 Résolution de Problèmes

### Backend ne démarre pas
```cmd
cd WS_ETU003103_ETU003248
docker-compose down -v
docker-compose up -d
mvn clean install
start.bat
```

### Frontend ne se connecte pas
1. Vérifier backend actif: `curl http://localhost:8060/actuator/health`
2. Vérifier `.env`: `VITE_USE_MOCK_API=false`
3. Vérifier console F12 pour erreurs CORS

### Erreur 401 Unauthorized
- Vérifier que les admins sont insérés dans la base
- Vérifier mot de passe correspond au hash BCrypt
- Vérifier JWT token valide dans localStorage

### Port déjà utilisé
Modifier dans `WS_ETU003103_ETU003248/.env`:
```env
API_PORT=8061  # Changer le port si 8060 occupé
```

### Plus de détails
📖 [BACKEND_FRONTEND_CONNECTION.md](BACKEND_FRONTEND_CONNECTION.md) - Guide debug complet

## 📊 Données et Calculs

### Base de Données
- **4 semestres** (S1, S2, S3, S4)
- **3 parcours S4** (Développement, Web et Design, BDD et Réseaux)
- **3 étudiants** de test avec notes complètes
- **Matières** obligatoires et optionnelles par parcours
- **Crédits** L1=60, L2=60 (total 120 ECTS)

### Règles de Calcul
```
Moyenne semestre = Σ(note × crédit) / Σ(crédits)
Moyenne annuelle = (Moyenne S1 + Moyenne S2) / 2  (pour L1)

Résultats:
- Admis: Moyenne ≥ 10/20
- Ajourné: Moyenne < 10/20
- Redoublement: Non validation L1 ou L2

Mentions:
- TB (Très Bien): ≥ 16/20
- B (Bien): ≥ 14/20
- AB (Assez Bien): ≥ 12/20
- P (Passable): ≥ 10/20
- AR (Ajourné/Redoublement): < 10/20
```

## 🎓 Conformité Académique

Ce projet répond à tous les critères du sujet :

### Backend (Spring Boot)
- ✅ Web Services REST complets avec Spring Boot
- ✅ Authentification JWT + Spring Security
- ✅ Base de données MySQL avec JPA/Hibernate
- ✅ Endpoints pour étudiants, notes, semestres
- ✅ DTOs et gestion des erreurs
- ✅ Docker Compose fonctionnel

### Frontend (Vue.js)
- ✅ Application Vue.js 3 avec Composition API
- ✅ Vue Router pour navigation SPA
- ✅ Pinia pour state management
- ✅ Liste étudiants avec moyennes S1-S4
- ✅ Relevés de notes détaillés par semestre
- ✅ Relevés annuels L1 et L2
- ✅ Gestion parcours optionnels S4
- ✅ Format inspiré relevés ITU officiels
- ✅ Interface responsive et moderne

### Architecture et Qualité
- ✅ Séparation frontend/backend (ports 5173/8060)
- ✅ API REST bien documentée
- ✅ Code refactorisé et réutilisable
- ✅ Tests Postman inclus
- ✅ Documentation exhaustive (14 fichiers)
- ✅ Scripts d'automatisation
- ✅ Mode mock pour développement frontend standalone

## 🚀 Pour Aller Plus Loin

### Améliorations Possibles
- 🔐 Authentification multi-facteurs
- 📧 Notifications par email
- 📄 Export PDF des relevés
- 📊 Tableaux de bord statistiques
- 🌍 Internationalisation (i18n)
- 🎨 Thèmes personnalisables
- 📱 Application mobile (React Native/Flutter)

### Déploiement Production
```cmd
# Backend
cd WS_ETU003103_ETU003248
mvn clean package -DskipTests
docker build -t notes-api .

# Frontend
cd vue-project
npm run build
docker build -t notes-frontend .
```

## 👥 Équipe

**Étudiants:**
- ETU003103
- ETU003248

**Établissement:**  
IT University Madagascar  
**Promotion:** L3 Informatique  
**Année:** 2024-2025

## 📄 Licence

Ce projet est réalisé dans le cadre académique.  
© 2024 IT University Madagascar

---

## 📞 Support

Pour toute question ou problème:

1. 📖 Consulter la documentation (14 fichiers MD)
2. 🐛 Vérifier [BACKEND_FRONTEND_CONNECTION.md](BACKEND_FRONTEND_CONNECTION.md)
3. 💻 Essayer le mode mock avec `VITE_USE_MOCK_API=true`
4. 🔍 Vérifier les logs console (F12)

**Bon développement ! 🚀**

**Projet:**  
TP Vue.js - Gestion des Notes

**Date:**  
Novembre 2025

## 📄 Licence

Projet académique - IT University Madagascar

## 🙏 Remerciements

- IT University pour l'encadrement
- Spring Boot et Vue.js communities
- Docker pour la containerisation

---

## 📞 Support

Pour toute question ou problème :
1. Consulter la [documentation](INSTALLATION.md)
2. Vérifier la [checklist](CHECKLIST.md)
3. Voir les [commandes utiles](COMMANDES_UTILES.md)

---

<div align="center">

**🎉 Projet complet et opérationnel ! 🎉**

Made with ❤️ by ETU003103 & ETU003248

[Documentation](INSTALLATION.md) • [API](API_DOCUMENTATION.md) • [Tests](CHECKLIST.md)

</div>
