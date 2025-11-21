# Fonctionnalités Admin - Notes API

## Vue d'ensemble

Le système a été étendu avec un système d'administration permettant aux administrateurs de :
- Se connecter avec leurs propres identifiants
- Inscrire de nouveaux étudiants
- Consulter les notes de tous les étudiants (par semestre, par année, ou individuellement)

## Architecture de la base de données

### Nouvelle table `user`
```sql
CREATE TABLE user (
    id_user INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'ADMIN',
    est_actif BOOLEAN DEFAULT TRUE,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Modifications table `Etudiant`
- Ajout de `id_user_createur` (FK vers `user`) : admin qui a inscrit l'étudiant
- Ajout de `date_inscription` : date d'inscription de l'étudiant

### Modifications table `auth_token`
- Ajout de `id_user` (FK vers `user`) : pour les tokens admin
- Ajout de `user_type` : 'ETUDIANT' ou 'ADMIN'
- Constraint CHECK : soit `id_etudiant`, soit `id_user` doit être rempli

## Endpoints API

### Authentification

#### 1. Login Admin
```
POST /api/auth/admin/login
Content-Type: application/json

{
    "email": "admin@univ.mg",
    "mot_de_passe": "adminpass"
}
```

**Réponse :**
```json
{
    "success": true,
    "data": {
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
        "expiresIn": "24h",
        "student": {
            "id": 1,
            "firstName": "Système",
            "lastName": "Admin",
            "email": "admin@univ.mg"
        }
    }
}
```

#### 2. Login Étudiant (inchangé)
```
POST /api/auth/login
Content-Type: application/json

{
    "email": "jean.rakoto@univ.mg",
    "password": "jeanpass"
}
```

### Fonctionnalités Admin

#### 3. Inscrire un nouvel étudiant
```
POST /api/admin/students
Authorization: Bearer <admin_token>
Content-Type: application/json

{
    "numero": "ETU004",
    "nom": "Razafy",
    "prenom": "Sophie",
    "email": "sophie.razafy@univ.mg",
    "mot_de_passe": "sophiepass",
    "id_parcours": 1
}
```

**Réponse :**
```json
{
    "success": true,
    "data": {
        "idEtudiant": 4,
        "nom": "Razafy",
        "prenom": "Sophie",
        "email": "sophie.razafy@univ.mg",
        "userCreateur": {
            "idUser": 1,
            "nom": "Admin",
            "prenom": "Système"
        },
        "dateInscription": "2024-11-21T10:30:00"
    }
}
```

#### 4. Consulter les notes d'un étudiant
```
GET /api/admin/students/{studentId}/grades
Authorization: Bearer <admin_token>
```

**Exemple :**
```
GET /api/admin/students/1/grades
Authorization: Bearer <admin_token>
```

#### 5. Consulter toutes les notes
```
GET /api/admin/students/all-grades
Authorization: Bearer <admin_token>
```

#### 6. Filtrer les notes par semestre
```
GET /api/admin/students/all-grades?semestre=1
Authorization: Bearer <admin_token>
```

#### 7. Filtrer les notes par année
```
GET /api/admin/students/all-grades?annee=1
Authorization: Bearer <admin_token>
```

## Comptes admin de test

Deux comptes administrateurs sont disponibles :

1. **Admin Système**
   - Email: `admin@univ.mg`
   - Mot de passe: `adminpass`

2. **Directeur Pédagogique**
   - Email: `directeur@univ.mg`
   - Mot de passe: `dirpass`

## Utilisation avec Postman

1. **Importer la collection** : `postman/notes-api-admin.postman_collection.json`

2. **Se connecter en tant qu'admin** :
   - Exécuter la requête "Admin Login"
   - Copier le token de la réponse
   - Le coller dans la variable `admin_token` de la collection

3. **Tester les fonctionnalités admin** :
   - Créer un étudiant
   - Consulter les notes des étudiants

## Sécurité

### Validation des tokens
Tous les endpoints admin vérifient :
1. Présence du header `Authorization: Bearer <token>`
2. Validité du token (non expiré)
3. Type d'utilisateur = 'ADMIN'
4. Compte actif

### Erreurs courantes

#### Token manquant ou invalide
```json
{
    "success": false,
    "error": {
        "code": "AUTH_002",
        "message": "Token invalide ou expiré"
    }
}
```

#### Accès non autorisé (token étudiant sur endpoint admin)
```json
{
    "success": false,
    "error": {
        "code": "AUTH_003",
        "message": "Accès non autorisé - privilèges admin requis"
    }
}
```

## Workflow typique

### 1. Connexion admin
```bash
curl -X POST http://localhost:8080/api/auth/admin/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@univ.mg","mot_de_passe":"adminpass"}'
```

### 2. Inscription d'un étudiant
```bash
curl -X POST http://localhost:8080/api/admin/students \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "numero": "ETU004",
    "nom": "Razafy",
    "prenom": "Sophie",
    "email": "sophie.razafy@univ.mg",
    "mot_de_passe": "sophiepass",
    "id_parcours": 1
  }'
```

### 3. Consultation des notes
```bash
# Toutes les notes
curl -X GET http://localhost:8080/api/admin/students/all-grades \
  -H "Authorization: Bearer <token>"

# Par semestre
curl -X GET http://localhost:8080/api/admin/students/all-grades?semestre=1 \
  -H "Authorization: Bearer <token>"

# Par année
curl -X GET http://localhost:8080/api/admin/students/all-grades?annee=1 \
  -H "Authorization: Bearer <token>"

# Pour un étudiant spécifique
curl -X GET http://localhost:8080/api/admin/students/1/grades \
  -H "Authorization: Bearer <token>"
```

## Structure des réponses

### Réponse d'inscription étudiant
```json
{
    "success": true,
    "data": {
        "idEtudiant": 4,
        "nom": "Razafy",
        "prenom": "Sophie",
        "email": "sophie.razafy@univ.mg",
        "dateInscription": "2024-11-21T10:30:00",
        "userCreateur": {
            "idUser": 1,
            "nom": "Admin",
            "prenom": "Système",
            "email": "admin@univ.mg"
        }
    }
}
```

### Réponse de consultation de notes
```json
{
    "success": true,
    "data": [
        {
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
            "grades": [
                {
                    "subject": {
                        "id": 1,
                        "code": "INF101",
                        "name": "Programmation procédurale",
                        "credits": 7,
                        "type": "Informatique"
                    },
                    "grade": 15.50
                }
            ],
            "summary": {
                "totalCredits": 30,
                "average": 14.25,
                "passed": true
            }
        }
    ]
}
```

## Notes importantes

1. **Mots de passe en clair** : Pour les tests uniquement. En production, utiliser BCrypt.
2. **Traçabilité** : Chaque étudiant est lié à l'admin qui l'a inscrit via `id_user_createur`.
3. **Historique** : La `date_inscription` permet de tracker quand l'étudiant a été ajouté.
4. **Tokens** : Les tokens admin et étudiants sont stockés dans la même table `auth_token` mais différenciés par `user_type`.

## Tests

Pour tester le système complet :

1. Démarrer l'application : `docker-compose up -d`
2. Attendre 30 secondes (initialisation DB)
3. Tester le login admin
4. Inscrire un nouvel étudiant
5. Consulter ses notes (il n'aura pas de notes tant que vous n'en créez pas)
6. Consulter les notes des étudiants existants (Jean, Marie, Paul)
