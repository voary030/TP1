# TP Compléments Web Services - Gestion des Notes

## 📋 Description

API REST pour la gestion des notes étudiantes avec système d'authentification. Supporte les semestres S1 à S4 avec gestion des parcours (options) pour le S4.

## 🎯 Fonctionnalités

### TP1a - Web Services des notes
- ✅ Récupération des notes par semestre
- ✅ Récupération des notes par année (L1 = S1+S2, L2 = S3+S4)
- ✅ Format JSON avec `status`, `data`, `error`
- ✅ Utilisation de camelCase
- ✅ Objet `meta` pour métadonnées

### TP1b - Gestion des erreurs
- ✅ Codes d'erreur personnalisés
- ✅ Messages explicites
- ✅ Gestion des cas :
  - Étudiant inexistant
  - Problème de connexion BDD
  - Erreurs imprévues

### TP1c - Authentification
- ✅ WS de login avec génération de token JWT
- ✅ Protection des endpoints (token requis)
- ✅ Gestion erreur "utilisateur non authentifié"

## 🏗️ Architecture de la base de données

### Points clés du modèle :

1. **Gestion des parcours (S4)** :
   - Table `parcours` : Développeur, Web, Réseaux et BDD
   - Table `matiere_parcours` : relation matière ↔ parcours avec indicateur `est_obligatoire`
   - Exemple : "Algo" est obligatoire pour "Réseaux et BDD" mais optionnelle pour "Web"

2. **Tables principales** :
   - `Etudiant` : informations étudiants + credentials
   - `Matiere` : matières avec crédits
   - `note` : notes des étudiants
   - `resultat` : moyennes et résultats finaux
   - `auth_token` : tokens JWT pour l'authentification

## 🚀 Installation et démarrage

### Prérequis
- Docker Desktop installé
- Postman installé (pour tester l'API)

### Étapes

1. **Cloner et configurer** :
```bash
cd c:\Users\ranto\Documents\S5\MrRojo\TP1

# Copier le fichier d'environnement
copy .env.example .env

# Modifier .env si nécessaire
```

2. **Démarrer avec Docker** :
```bash
docker-compose up -d
```

3. **Vérifier que tout fonctionne** :
```bash
# Vérifier les conteneurs
docker-compose ps

# Vérifier les logs
docker-compose logs -f app
```

4. **Arrêter les services** :
```bash
docker-compose down
```

5. **Nettoyer complètement (avec données)** :
```bash
docker-compose down -v
```

## 📡 Endpoints API

### Format de réponse standard

#### Succès :
```json
{
  "status": "success",
  "data": {
    // vos données ici
  },
  "meta": {
    "timestamp": "2024-11-18T10:30:00Z",
    "version": "1.0"
  }
}
```

#### Erreur :
```json
{
  "status": "error",
  "error": {
    "code": "ERR_001",
    "message": "Message d'erreur explicite",
    "details": "Informations supplémentaires"
  },
  "meta": {
    "timestamp": "2024-11-18T10:30:00Z",
    "version": "1.0"
  }
}
```

### 1. Authentification

#### POST `/api/auth/login`
Connexion et récupération du token JWT.

**Body** :
```json
{
  "email": "jean.rakoto@univ.mg",
  "password": "password123"
}
```

**Réponse** :
```json
{
  "status": "success",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "expiresIn": "24h",
    "student": {
      "id": 1,
      "firstName": "Jean",
      "lastName": "Rakoto",
      "email": "jean.rakoto@univ.mg"
    }
  }
}
```

**Codes d'erreur** :
- `AUTH_001` : Email ou mot de passe incorrect
- `AUTH_002` : Compte désactivé

### 2. Notes par semestre

#### GET `/api/students/{studentId}/semesters/{semesterId}/grades`

**Headers** :
```
Authorization: Bearer {token}
```

**Paramètres** :
- `studentId` : ID de l'étudiant
- `semesterId` : ID du semestre (1, 2, 3, ou 4)

**Réponse** :
```json
{
  "status": "success",
  "data": {
    "student": {
      "id": 1,
      "firstName": "Jean",
      "lastName": "Rakoto",
      "studentNumber": "ETU2024001"
    },
    "semester": {
      "id": 4,
      "label": "S4"
    },
    "track": {
      "id": 1,
      "label": "Développeur"
    },
    "grades": [
      {
        "subject": {
          "code": "ALG401",
          "label": "Algorithmique avancée",
          "credits": 4.0,
          "type": "obligatoire"
        },
        "grade": 15.5,
        "session": "Session normale"
      },
      {
        "subject": {
          "code": "PRG401",
          "label": "Programmation orientée objet",
          "credits": 5.0,
          "type": "obligatoire"
        },
        "grade": 12.0,
        "session": "Session normale"
      }
    ],
    "summary": {
      "averageGrade": 13.83,
      "totalCredits": 12.0,
      "obtainedCredits": 12.0,
      "status": "Admis"
    }
  },
  "meta": {
    "timestamp": "2024-11-18T10:30:00Z",
    "academicYear": "2024-2025"
  }
}
```

**Codes d'erreur** :
- `STU_001` : Étudiant non trouvé
- `SEM_001` : Semestre invalide
- `DB_001` : Erreur de connexion à la base de données
- `SYS_001` : Erreur système imprévue

### 3. Notes par année

#### GET `/api/students/{studentId}/years/{yearLevel}/grades`

**Headers** :
```
Authorization: Bearer {token}
```

**Paramètres** :
- `studentId` : ID de l'étudiant
- `yearLevel` : Niveau (L1 ou L2)
  - L1 = S1 + S2
  - L2 = S3 + S4

**Réponse** :
```json
{
  "status": "success",
  "data": {
    "student": {
      "id": 1,
      "firstName": "Jean",
      "lastName": "Rakoto"
    },
    "yearLevel": "L2",
    "semesters": [
      {
        "semester": {
          "id": 3,
          "label": "S3"
        },
        "grades": [...],
        "summary": {
          "averageGrade": 12.5,
          "totalCredits": 30.0,
          "obtainedCredits": 28.0
        }
      },
      {
        "semester": {
          "id": 4,
          "label": "S4"
        },
        "track": {
          "label": "Développeur"
        },
        "grades": [...],
        "summary": {
          "averageGrade": 13.83,
          "totalCredits": 30.0,
          "obtainedCredits": 30.0
        }
      }
    ],
    "yearSummary": {
      "overallAverage": 13.17,
      "totalCredits": 60.0,
      "obtainedCredits": 58.0,
      "status": "Admis"
    }
  },
  "meta": {
    "timestamp": "2024-11-18T10:30:00Z",
    "academicYear": "2024-2025"
  }
}
```

## 📋 Codes d'erreur

| Code | Description |
|------|-------------|
| `AUTH_001` | Email ou mot de passe incorrect |
| `AUTH_002` | Compte désactivé |
| `AUTH_003` | Token manquant ou invalide |
| `AUTH_004` | Token expiré |
| `STU_001` | Étudiant non trouvé |
| `SEM_001` | Semestre invalide |
| `YEAR_001` | Année invalide |
| `DB_001` | Erreur de connexion à la base de données |
| `DB_002` | Timeout de la base de données |
| `SYS_001` | Erreur système imprévue |
| `VAL_001` | Paramètres invalides |

## 🧪 Tests avec Postman

1. **Importer la collection** : `postman/notes-api.postman_collection.json`
2. **Importer l'environnement** : `postman/notes-api.postman_environment.json`
3. **Tester la séquence** :
   - Login (récupère automatiquement le token)
   - Notes S4
   - Notes L2

## 🛠️ Technologies suggérées

### Option 1 : Node.js + Express
```bash
npm init -y
npm install express mysql2 jsonwebtoken bcrypt dotenv cors
npm install --save-dev nodemon
```

### Option 2 : Python + Flask
```bash
pip install flask flask-cors pymysql pyjwt bcrypt python-dotenv
```

### Option 3 : Java + Spring Boot
- Spring Boot Starter Web
- Spring Boot Starter Data JPA
- MySQL Connector
- Spring Security + JWT

## 📁 Structure du projet suggérée

```
TP1/
├── docker-compose.yml
├── Dockerfile
├── .env.example
├── .env (à créer)
├── README.md
├── script/
│   └── script.sql
├── postman/
│   ├── notes-api.postman_collection.json
│   └── notes-api.postman_environment.json
└── src/
    ├── app.js (ou app.py, Main.java)
    ├── routes/
    │   ├── auth.routes.js
    │   └── grades.routes.js
    ├── controllers/
    │   ├── auth.controller.js
    │   └── grades.controller.js
    ├── middleware/
    │   └── auth.middleware.js
    ├── models/
    │   └── db.js
    └── utils/
        ├── response.js
        └── errors.js
```

## 📝 Notes importantes

1. **Sécurité** :
   - Ne jamais commiter le fichier `.env`
   - Utiliser des mots de passe forts en production
   - Hasher les mots de passe avec bcrypt

2. **Base de données** :
   - Les données d'exemple sont automatiquement insérées au démarrage
   - Voir `script/script.sql` pour les requêtes SQL utiles

3. **Modèle Robuste** :
   - Toujours renvoyer `status`, `data`, et `error`
   - Utiliser camelCase pour les propriétés JSON
   - Inclure `meta` pour les informations contextuelles

## 👥 Données de test

| Email | Mot de passe | Parcours |
|-------|--------------|----------|
| jean.rakoto@univ.mg | password123 | Développeur |
| marie.rasoa@univ.mg | password123 | Web |
| paul.rabe@univ.mg | password123 | Réseaux et BDD |

## 🐛 Dépannage

### Problème : Le conteneur de la BDD ne démarre pas
```bash
# Vérifier les logs
docker-compose logs db

# Nettoyer et redémarrer
docker-compose down -v
docker-compose up -d
```

### Problème : L'application ne se connecte pas à la BDD
- Vérifier que `DB_HOST=db` dans `.env`
- Attendre que la BDD soit complètement démarrée (healthcheck)

### Problème : Port déjà utilisé
Modifier les ports dans `.env` :
```
API_PORT=3001
DB_PORT=3307
```

## 📖 Ressources

- [Documentation Docker](https://docs.docker.com/)
- [Documentation Postman](https://learning.postman.com/)
- [JWT.io](https://jwt.io/)

## 📧 Contact

Pour toute question concernant ce TP, contactez votre enseignant.


structure de mon projet doit suivre ceci
Collection Postman
Mettre login/pass par défaut dans l’url authentification.
Repertoire projet (WS_ETU1_ETU2)