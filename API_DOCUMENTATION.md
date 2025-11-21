# Documentation API - Gestion des Notes

## Base URL
```
http://localhost:3000
```

## 🔐 Authentication

### Login
Obtenir un token JWT pour accéder aux endpoints protégés.

**Endpoint:** `POST /api/auth/login`

**Request Body:**
```json
{
  "email": "jean.rakoto@univ.mg",
  "password": "ETU003103"
}
```

**Response (200 OK):**
```json
{
  "status": "success",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "student": {
      "id": 1,
      "firstName": "Jean",
      "lastName": "Rakoto",
      "email": "jean.rakoto@univ.mg"
    }
  },
  "meta": {
    "timestamp": "2025-11-21T10:30:00Z",
    "version": "1.0"
  }
}
```

**Comptes de test:**
- `jean.rakoto@univ.mg` / `ETU003103`
- `marie.rasoa@univ.mg` / `ETU003248`
- `paul.rabe@univ.mg` / `ETU003103`

---

## 📚 Semestres

### Lister tous les semestres
**Endpoint:** `GET /api/semesters`  
**Auth:** Requise

**Response (200 OK):**
```json
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "name": "S1"
    },
    {
      "id": 2,
      "name": "S2"
    },
    {
      "id": 3,
      "name": "S3"
    },
    {
      "id": 4,
      "name": "S4"
    }
  ]
}
```

### Parcours d'un semestre
**Endpoint:** `GET /api/semesters/{semesterId}/parcours`  
**Auth:** Requise

**Exemple:** `GET /api/semesters/4/parcours`

**Response (200 OK):**
```json
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "name": "Développement",
      "semesterId": 4
    },
    {
      "id": 2,
      "name": "Web et Design",
      "semesterId": 4
    },
    {
      "id": 3,
      "name": "Bases de Données et Réseaux",
      "semesterId": 4
    }
  ]
}
```

---

## 👥 Étudiants

### Lister tous les étudiants avec moyennes
**Endpoint:** `GET /api/students`  
**Auth:** Requise

**Response (200 OK):**
```json
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "firstName": "Jean",
      "lastName": "Rakoto",
      "email": "jean.rakoto@univ.mg",
      "s1Average": 14.25,
      "s2Average": 13.50,
      "s3Average": 12.75,
      "s4Average": 13.98
    },
    {
      "id": 2,
      "firstName": "Marie",
      "lastName": "Rasoa",
      "email": "marie.rasoa@univ.mg",
      "s1Average": 14.00,
      "s2Average": null,
      "s3Average": null,
      "s4Average": null
    }
  ]
}
```

### Détails d'un étudiant
**Endpoint:** `GET /api/students/{studentId}`  
**Auth:** Requise

**Exemple:** `GET /api/students/1`

**Response (200 OK):**
```json
{
  "status": "success",
  "data": {
    "id": 1,
    "firstName": "Jean",
    "lastName": "Rakoto",
    "email": "jean.rakoto@univ.mg",
    "birthDate": "2002-05-15",
    "semesterAverages": {
      "S1": 14.25,
      "S2": 13.50,
      "S3": 12.75,
      "S4": 13.98
    }
  }
}
```

---

## 📊 Notes

### Notes d'un semestre
Obtenir toutes les notes d'un étudiant pour un semestre spécifique.

**Endpoint:** `GET /api/students/{studentId}/semesters/{semesterId}/grades`  
**Auth:** Requise

**Exemple:** `GET /api/students/1/semesters/1/grades`

**Response (200 OK):**
```json
{
  "status": "success",
  "data": {
    "student": {
      "id": 1,
      "firstName": "Jean",
      "lastName": "Rakoto",
      "email": "jean.rakoto@univ.mg"
    },
    "semester": {
      "id": 1,
      "name": "S1"
    },
    "track": null,
    "grades": [
      {
        "subject": {
          "id": 1,
          "code": "INF101",
          "name": "Programmation procédurale",
          "credits": 7,
          "type": "Matière obligatoire"
        },
        "grade": 15.5
      },
      {
        "subject": {
          "id": 2,
          "code": "INF104",
          "name": "HTML et Introduction au Web",
          "credits": 5,
          "type": "Matière obligatoire"
        },
        "grade": 14.0
      }
    ],
    "summary": {
      "totalCredits": 30,
      "average": 14.25,
      "passed": true
    }
  }
}
```

### Notes d'une année (L1 ou L2)
Obtenir les notes de deux semestres combinés (L1 = S1+S2, L2 = S3+S4).

**Endpoint:** `GET /api/students/{studentId}/years/{yearLevel}/grades`  
**Auth:** Requise

**Paramètres:**
- `yearLevel`: 1 (pour L1 = S1+S2) ou 2 (pour L2 = S3+S4)

**Exemple:** `GET /api/students/1/years/1/grades`

**Response (200 OK):**
```json
{
  "status": "success",
  "data": {
    "student": {
      "id": 1,
      "firstName": "Jean",
      "lastName": "Rakoto",
      "email": "jean.rakoto@univ.mg",
      "birthDate": "2002-05-15"
    },
    "semesters": [
      {
        "semesterId": 1,
        "semesterName": "SEMESTRE 1",
        "track": null,
        "totalCredits": 30,
        "average": 14.25,
        "passed": true,
        "grades": [
          {
            "subject": {
              "id": 1,
              "code": "INF101",
              "name": "Programmation procédurale",
              "credits": 7,
              "type": "Matière obligatoire"
            },
            "grade": 15.5
          }
        ]
      },
      {
        "semesterId": 2,
        "semesterName": "SEMESTRE 2",
        "track": null,
        "totalCredits": 30,
        "average": 13.50,
        "passed": true,
        "grades": [
          {
            "subject": {
              "id": 7,
              "code": "INF102",
              "name": "Bases de données relationnelles",
              "credits": 5,
              "type": "Matière obligatoire"
            },
            "grade": 14.0
          }
        ]
      }
    ],
    "summary": {
      "totalCredits": 60,
      "average": 13.88,
      "passed": true
    }
  }
}
```

---

## 🔒 Authentification des requêtes

Toutes les requêtes (sauf `/api/auth/login`) nécessitent un token JWT dans le header:

```
Authorization: Bearer {token}
```

**Exemple avec curl:**
```bash
curl -H "Authorization: Bearer eyJhbGc..." http://localhost:3000/api/students
```

**Exemple avec Axios (JavaScript):**
```javascript
axios.get('/api/students', {
  headers: {
    'Authorization': `Bearer ${token}`
  }
})
```

---

## ⚠️ Gestion des erreurs

### Format de réponse d'erreur
```json
{
  "status": "error",
  "error": {
    "code": "STU_001",
    "message": "Étudiant non trouvé avec l'ID: 999"
  },
  "meta": {
    "timestamp": "2025-11-21T10:30:00Z",
    "version": "1.0"
  }
}
```

### Codes d'erreur courants

| Code HTTP | Signification |
|-----------|---------------|
| 200 | Succès |
| 401 | Non authentifié (token manquant ou invalide) |
| 403 | Non autorisé |
| 404 | Ressource non trouvée |
| 500 | Erreur serveur |

### Codes d'erreur métier

| Code | Description |
|------|-------------|
| STU_001 | Étudiant non trouvé |
| SEM_001 | Aucune note pour ce semestre |
| YEAR_001 | Aucune note pour cette année |
| AUTH_001 | Credentials invalides |

---

## 📝 Notes importantes

### Parcours
- Les parcours ne s'appliquent qu'au **Semestre 4 (S4)**
- Trois parcours disponibles:
  - Développement (id: 1)
  - Web et Design (id: 2)
  - Bases de Données et Réseaux (id: 3)

### Calcul des moyennes
- Les moyennes sont **pondérées par les crédits** des matières
- Formule: `(Σ(note × crédit)) / Σ(crédit)`

### Mentions
- **TB** (Très Bien): moyenne ≥ 16
- **B** (Bien): 14 ≤ moyenne < 16
- **AB** (Assez Bien): 12 ≤ moyenne < 14
- **P** (Passable): 10 ≤ moyenne < 12
- **AR** (Ajourné): moyenne < 10

### Types de matières
- **Obligatoire**: Matière obligatoire pour le parcours
- **Optionnelle**: 1 UE à choisir parmi plusieurs
- **Facultative**: Points > 10 comptent uniquement

---

## 🧪 Test de l'API

### Avec Postman
1. Importer la collection: `postman/notes-api.postman_collection.json`
2. Importer l'environnement: `postman/notes-api.postman_environment.json`
3. Exécuter "Login" pour obtenir le token
4. Tester les autres endpoints

### Avec PowerShell
```bash
cd WS_ETU003103_ETU003248
.\test-api-complet.ps1
```

### Avec le frontend
```
http://localhost:8080
```

---

## 📚 Ressources

- **Backend Repository:** `WS_ETU003103_ETU003248/`
- **Frontend Repository:** `vue-project/`
- **Scripts SQL:** `WS_ETU003103_ETU003248/script/`
- **Documentation:** `INSTALLATION.md`, `PROJET_RESUME.md`

---

**Version:** 1.0  
**Date:** Novembre 2025  
**Auteurs:** ETU003103 & ETU003248
