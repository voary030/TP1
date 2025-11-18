# TP1 Notes API - Spring Boot Implementation ✅

## 📋 Vue d'ensemble

Application Spring Boot REST API pour la gestion des notes d'étudiants avec authentification JWT, développée conformément aux spécifications du TP1 Web Services - IT University Madagascar.

## ✨ Fonctionnalités implémentées

### ✅ TP1a - Endpoints de consultation des notes

- **GET /api/students/{id}/semesters/{semesterId}/grades** - Notes d'un semestre
- **GET /api/students/{id}/years/{yearLevel}/grades** - Notes d'une année (2 semestres)
- Format de réponse standardisé : `{ "status", "data", "error", "meta" }`
- Nomenclature camelCase pour toutes les propriétés JSON
- Calcul automatique de la moyenne pondérée par crédits

### ✅ TP1b - Gestion des erreurs

| Code Erreur | Message | HTTP Status |
|-------------|---------|-------------|
| **AUTH_001** | Identifiants invalides | 401 |
| **AUTH_002** | Token invalide ou expiré | 401 |
| **AUTH_003** | Token manquant | 401 |
| **AUTH_004** | Accès refusé | 403 |
| **STU_001** | Étudiant non trouvé | 404 |
| **STU_002** | Étudiant inactif | 403 |
| **SEM_001** | Aucune note pour ce semestre | 404 |
| **YEAR_001** | Aucune note pour cette année | 404 |
| **DB_001** | Erreur de connexion DB | 503 |
| **DB_002** | Erreur de transaction DB | 503 |
| **VAL_001** | Erreur de validation | 400 |
| **VAL_002** | Format de données invalide | 400 |
| **SYS_001** | Erreur système inattendue | 500 |

### ✅ TP1c - Authentification JWT

- **POST /api/auth/login** - Authentification avec email/password
- Token JWT avec expiration 24h
- Tokens stockés en base avec statut actif/inactif
- Mots de passe hashés avec BCrypt (cost factor 10)
- Filtre JWT automatique pour toutes les routes protégées

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     REST Controllers                      │
│  AuthController      │      GradeController              │
└───────────────┬──────┴────────┬────────────────────────┘
                │               │
        ┌───────▼───────────────▼────────┐
        │         Services Layer          │
        │  AuthService  │  GradeService   │
        └───────┬───────────────┬─────────┘
                │               │
        ┌───────▼───────────────▼─────────┐
        │       Repository Layer           │
        │ EtudiantRepo │ NoteRepo │ etc.  │
        └───────┬───────────────┬──────────┘
                │               │
        ┌───────▼───────────────▼──────────┐
        │          JPA Entities             │
        │ Etudiant │ Note │ Matiere │ etc. │
        └───────────────┬──────────────────┘
                        │
                ┌───────▼────────┐
                │  MySQL 8.0 DB  │
                └────────────────┘
```

### Couches implémentées

1. **Entity Layer** (6 entités JPA)
   - `Etudiant` - Informations étudiant avec email unique
   - `Semestre` - Semestres académiques (S1-S4)
   - `Parcours` - 3 parcours: Développement, Web, BDD/Réseaux
   - `Matiere` - Matières avec crédits et type (obligatoire/optionnelle)
   - `TypeMatiere` - Types de matières (référence)
   - `Note` - Notes avec relation étudiant-matière
   - `AuthToken` - Tokens JWT avec expiration

2. **Repository Layer** (3 repositories)
   - `EtudiantRepository` - findByEmail(), existsByEmail()
   - `NoteRepository` - Queries JPQL avec JOIN FETCH pour performance
   - `AuthTokenRepository` - Validation de tokens actifs

3. **DTO Layer** (4 DTOs)
   - `ApiResponse<T>` - Wrapper générique avec factory methods
   - `LoginRequest` - Validation avec @Email, @NotBlank
   - `LoginResponse` - Token + infos étudiant
   - `SemesterGradesResponse` - Structure imbriquée complexe

4. **Service Layer** (2 services)
   - `AuthService` - Login, validation token, gestion BCrypt
   - `GradeService` - Récupération notes avec calculs moyennes

5. **Security Layer**
   - `JwtUtil` - Génération/validation tokens avec jjwt 0.12.3
   - `JwtAuthenticationFilter` - Filtre Spring Security
   - `SecurityConfig` - Configuration avec endpoints publics

6. **Exception Layer**
   - `ApiException` - Exception custom avec errorCode
   - `ErrorCodes` - 15 codes constants
   - `GlobalExceptionHandler` - @ControllerAdvice pour mapping HTTP status

## 📊 Base de données

### Schéma flexible avec type_matiere

- **Architecture temporelle** : `est_active`, `date_debut`, `date_fin` pour historique
- **Types de matières** : Table de référence (OBLIGATOIRE, OPTIONNELLE, FACULTATIVE)
- **Relations** : 
  - Matiere → Semestre (ManyToOne)
  - Matiere → Parcours (ManyToOne) pour matières S4
  - Matiere → TypeMatiere (ManyToOne)
  - Note → Etudiant + Matiere (ManyToOne)

### Données curriculum IT University

- **S1-S2** : 12 matières obligatoires (tronc commun)
- **S3** : 6 matières obligatoires
- **S4** : 13 matières optionnelles réparties en 3 parcours
  - Développement (5 matières)
  - Web et Design (4 matières)
  - Bases de Données et Réseaux (4 matières)

## 🔧 Technologies

| Composant | Version | Usage |
|-----------|---------|-------|
| **Java** | 17 | LTS pour stabilité |
| **Spring Boot** | 3.2.0 | Framework REST |
| **Spring Data JPA** | - | ORM Hibernate |
| **Spring Security** | - | Sécurité JWT |
| **jjwt** | 0.12.3 | Génération JWT |
| **MySQL Connector** | 8.3.0 | Driver JDBC |
| **Lombok** | - | Génération code |
| **Actuator** | - | Health checks |
| **Maven** | 3.9+ | Build tool |
| **Docker** | - | Containerisation |

## 📦 Déploiement Docker

### Multi-stage Dockerfile

1. **Stage Build** : Maven + OpenJDK 17
   - Résolution dépendances offline
   - Build avec `mvn clean package -DskipTests`
   
2. **Stage Runtime** : Eclipse Temurin 17 JRE Alpine
   - Utilisateur non-root pour sécurité
   - JVM settings optimisés pour containers
   - Health check sur `/actuator/health`

### docker-compose.yml

- Service **db** : MySQL 8.0 avec init scripts
- Service **app** : Dépend du health check DB
- Volumes : Persistence MySQL + scripts SQL
- Networks : Isolation des services
- Environment : Variables via `.env`

## 🧪 Tests Postman

### Collection complète (11 requêtes)

1. **Authentication** (3 tests)
   - Login Success → Sauvegarde automatique du token
   - Login Invalid Email → Vérifie AUTH_001
   - Login Invalid Password → Vérifie AUTH_001

2. **Grades - Semester** (4 tests)
   - S1 Grades Success → Vérifie format camelCase
   - S4 Grades with Track → Vérifie parcours
   - Student Not Found → Vérifie STU_001
   - No Grades for Semester → Vérifie SEM_001

3. **Grades - Year** (3 tests)
   - L1 Grades Success → Vérifie agrégation S1+S2
   - L2 Grades with Track → Vérifie S3+S4
   - No Grades for Year → Vérifie YEAR_001

### Assertions automatiques

```javascript
pm.test("Status is success", () => {
    pm.expect(response.status).to.eql("success");
});

pm.test("Response has meta timestamp", () => {
    pm.expect(response.meta).to.have.property("timestamp");
});

pm.test("Token saved to environment", () => {
    pm.environment.set("auth_token", response.data.token);
});
```

## 📝 Checklist de livraison

- [x] Code source Java/Spring Boot complet
- [x] Scripts SQL (schema + data + passwords)
- [x] Dockerfile multi-stage optimisé
- [x] docker-compose.yml fonctionnel
- [x] Collection Postman avec assertions
- [x] README.md avec instructions
- [x] API_DOCUMENTATION.md détaillée
- [x] ARCHITECTURE_FLEXIBLE.md (explications DB)
- [x] BUILD.md (guide démarrage rapide)
- [x] .env.example avec variables
- [x] .gitignore pour Spring Boot

## 🚀 Commandes essentielles

```powershell
# Lancer l'application
docker compose up -d

# Vérifier les logs
docker compose logs -f app

# Accéder à MySQL
docker compose exec db mysql -u notes_user -p notes_db

# Rebuild après changements
docker compose down; docker compose up -d --build

# Tester le health check
curl http://localhost:3000/actuator/health

# Login
curl -X POST http://localhost:3000/api/auth/login `
  -H "Content-Type: application/json" `
  -d '{\"email\":\"rakoto@ituniv.mg\",\"password\":\"password123\"}'

# Notes S1 (remplacer TOKEN)
curl -X GET http://localhost:3000/api/students/1/semesters/1/grades `
  -H "Authorization: Bearer TOKEN"
```

## 🎓 Étudiants de test

| ID | Nom | Email | Password | Parcours S4 |
|----|-----|-------|----------|-------------|
| 1 | Jean Rakoto | rakoto@ituniv.mg | password123 | Développement |
| 2 | Marie Rabe | rabe@ituniv.mg | password123 | Web et Design |
| 3 | Paul Rasoa | rasoa@ituniv.mg | password123 | BDD et Réseaux |

Tous ont des notes en **S1 et S4** pour démonstration.

## 📚 Documentation complémentaire

- **API_DOCUMENTATION.md** - Spécifications complètes des endpoints
- **ARCHITECTURE_FLEXIBLE.md** - Explication du pattern type_matiere
- **BUILD.md** - Guide de démarrage et troubleshooting
- **README.md** - Vue d'ensemble du projet

## 👨‍💻 Auteur

Projet développé pour le cours de Web Services - IT University Madagascar  
Semestre 5 - TP1 Notes API avec authentification JWT

---

**Status** : ✅ Prêt pour déploiement et tests  
**Version** : 1.0.0  
**Date** : Janvier 2025
