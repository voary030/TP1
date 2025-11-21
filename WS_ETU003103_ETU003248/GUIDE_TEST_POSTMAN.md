# 🧪 Guide de Test - API Notes avec Vues SQL

## 📋 Prérequis

1. ✅ Docker Desktop lancé
2. ✅ Application démarrée avec `docker-compose up -d --build`
3. ✅ Postman installé
4. ✅ Collection importée : `notes-api-complete-avec-vues.postman_collection.json`

---

## 🚀 Étape 1 : Démarrer l'Application

```powershell
cd "c:\Users\ranto\Documents\S5\MrRojo\TP1\WS_ETU003103_ETU003248"
docker-compose up -d --build
```

**Attendez 2-3 minutes** que tout démarre.

---

## 🔍 Étape 2 : Vérifier que les Vues sont Créées

### Option A : Via Docker CLI
```powershell
docker exec -it mysql-notes mysql -uroot -prootpass notes_db -e "SHOW FULL TABLES WHERE Table_type = 'VIEW';"
```

### Option B : Créer manuellement les vues
Si les vues ne sont pas créées automatiquement :
```powershell
docker exec -i mysql-notes mysql -uroot -prootpass notes_db < script/create_views.sql
```

### Vérifier le contenu d'une vue
```powershell
docker exec -it mysql-notes mysql -uroot -prootpass notes_db -e "SELECT * FROM vue_notes_detaillees LIMIT 5;"
docker exec -it mysql-notes mysql -uroot -prootpass notes_db -e "SELECT * FROM vue_moyennes_semestre;"
```

---

## 📬 Étape 3 : Tester avec Postman

### 1️⃣ **Importer la Collection**
- Ouvrir Postman
- Cliquer sur **Import**
- Sélectionner le fichier : `postman/notes-api-complete-avec-vues.postman_collection.json`

### 2️⃣ **Tester l'Authentification**

#### A. Login Étudiant
1. Aller dans **1. AUTHENTIFICATION** → **Login Étudiant - Jean**
2. Cliquer sur **Send**
3. ✅ Le token est automatiquement sauvegardé dans la variable `studentToken`

**Réponse attendue** :
```json
{
    "success": true,
    "data": {
        "token": "eyJhbGciOiJIUzI1NiJ9...",
        "expiresIn": "24h",
        "student": {
            "id": 1,
            "firstName": "Jean",
            "lastName": "Dupont",
            "email": "jean.dupont@univ.mg"
        }
    },
    "message": null
}
```

#### B. Login Admin
1. Aller dans **1. AUTHENTIFICATION** → **Login Admin**
2. Cliquer sur **Send**
3. ✅ Le token est automatiquement sauvegardé dans la variable `adminToken`

---

### 3️⃣ **Tester les Vues - Côté Étudiant**

#### A. Voir Toutes Mes Notes Détaillées
**Request** : `GET /api/vue-notes/mes-notes`
- Dossier : **2. VUE NOTES - ÉTUDIANT** → **Mes Notes Détaillées (Toutes)**
- Le token étudiant est automatiquement ajouté

**Réponse attendue** :
```json
{
    "success": true,
    "data": [
        {
            "idEtudiant": 1,
            "nomEtudiant": "Dupont",
            "prenomEtudiant": "Jean",
            "note": 15.50,
            "idMatiere": 1,
            "codeMatiere": "ALG101",
            "libelleMatiere": "Algorithmique",
            "credit": 4.0,
            "idSemestre": 1,
            "libelleSemestre": "S1",
            "idParcours": 1,
            "libelleParcours": "Développeur",
            "idSession": "NORM_2024",
            "libelleSession": "Session normale",
            "dateSession": "2024-06-15",
            "anneeUniversitaire": "2024-2025",
            "typeMatiere": "OBLIGATOIRE",
            "filiere": "Informatique"
        }
    ]
}
```

#### B. Notes d'un Semestre Spécifique
**Request** : `GET /api/vue-notes/mes-notes/semestre/1`
- Retourne uniquement les notes du Semestre 1

#### C. Notes d'une Année Universitaire
**Request** : `GET /api/vue-notes/mes-notes/annee/2024-2025`
- Retourne toutes les notes de l'année 2024-2025

#### D. Mes Moyennes
**Request** : `GET /api/vue-notes/mes-moyennes`

**Réponse attendue** :
```json
{
    "success": true,
    "data": [
        {
            "idEtudiant": 1,
            "nomEtudiant": "Dupont",
            "prenomEtudiant": "Jean",
            "idSemestre": 1,
            "libelleSemestre": "S1",
            "anneeUniversitaire": "2024-2025",
            "parcours": "Développeur",
            "nombreNotes": 5,
            "moyenneSemestre": 13.80,
            "totalCredits": 20.0,
            "creditsObtenus": 18.0
        }
    ]
}
```

#### E. Moyenne d'un Semestre
**Request** : `GET /api/vue-notes/mes-moyennes/semestre/1`
- Retourne la moyenne calculée pour le Semestre 1

---

### 4️⃣ **Tester les Vues - Côté Admin**

#### A. Voir Toutes les Notes de Tous les Étudiants
**Request** : `GET /api/vue-notes/admin/notes`
- Dossier : **3. VUE NOTES - ADMIN** → **Toutes les Notes**
- Utilise le token admin automatiquement

#### B. Notes d'un Étudiant Spécifique
**Request** : `GET /api/vue-notes/admin/notes/etudiant/1`
- Voir toutes les notes de l'étudiant avec ID=1

#### C. Notes d'un Semestre (Tous les Étudiants)
**Request** : `GET /api/vue-notes/admin/notes/semestre/1`
- Voir toutes les notes du Semestre 1 de tous les étudiants

#### D. Notes par Année Universitaire
**Request** : `GET /api/vue-notes/admin/notes/annee/2024-2025`

#### E. Toutes les Moyennes
**Request** : `GET /api/vue-notes/admin/moyennes`
- Voir les moyennes de tous les étudiants

#### F. Moyennes par Semestre
**Request** : `GET /api/vue-notes/admin/moyennes/semestre/1`

#### G. Moyennes par Année
**Request** : `GET /api/vue-notes/admin/moyennes/annee/2024-2025`

---

### 5️⃣ **Tester la Création d'Étudiant (Admin)**

**Request** : `POST /api/admin/students`
- Dossier : **4. ADMIN - GESTION ÉTUDIANTS** → **Créer un Nouvel Étudiant**

**Body** :
```json
{
    "numero": "ETU004",
    "nom": "Nouveau",
    "prenom": "Étudiant",
    "email": "nouveau.etudiant@univ.mg",
    "mot_de_passe": "nouveaupass",
    "id_parcours": 1
}
```

**Réponse attendue** :
```json
{
    "success": true,
    "data": {
        "idEtudiant": 4,
        "numero": "ETU004",
        "nom": "Nouveau",
        "prenom": "Étudiant",
        "email": "nouveau.etudiant@univ.mg",
        "dateInscription": "2025-11-21T10:30:00"
    }
}
```

---

## 🔐 Tokens JWT

Les tokens sont **automatiquement sauvegardés** dans les variables Postman :
- `{{studentToken}}` : Token de l'étudiant
- `{{adminToken}}` : Token de l'admin

Ils sont **valables 24h** et inclus automatiquement dans les headers :
```
Authorization: Bearer {{studentToken}}
```

---

## 🎯 Cas d'Erreur à Tester

### 1. Token Invalide
Modifier manuellement un token et envoyer une requête :
```json
{
    "success": false,
    "message": "Token invalide ou expiré"
}
```

### 2. Accès Non Autorisé (Étudiant avec Endpoint Admin)
Utiliser le token étudiant sur un endpoint admin :
```json
{
    "success": false,
    "message": "Accès non autorisé - privilèges admin requis"
}
```

### 3. Étudiant Non Trouvé
```json
{
    "success": false,
    "message": "Étudiant non trouvé avec l'ID: 999"
}
```

---

## 📊 Vérification des Données dans MySQL

### Se connecter à MySQL
```powershell
docker exec -it mysql-notes mysql -uroot -prootpass notes_db
```

### Requêtes utiles
```sql
-- Voir les vues disponibles
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- Tester la vue des notes détaillées
SELECT * FROM vue_notes_detaillees LIMIT 10;

-- Tester la vue des moyennes
SELECT * FROM vue_moyennes_semestre;

-- Compter les notes
SELECT COUNT(*) FROM vue_notes_detaillees;

-- Voir les étudiants
SELECT id_etudiant, nom, prenom, email FROM Etudiant;

-- Voir les admins
SELECT id_user, nom, prenom, email, role FROM user;
```

---

## ✅ Checklist de Test

- [ ] Docker démarré
- [ ] Application buildée et lancée
- [ ] Vues SQL créées (vérifiées avec `SHOW TABLES`)
- [ ] Login étudiant réussi
- [ ] Login admin réussi
- [ ] Récupération des notes détaillées (étudiant)
- [ ] Récupération des moyennes (étudiant)
- [ ] Récupération de toutes les notes (admin)
- [ ] Récupération de toutes les moyennes (admin)
- [ ] Création d'un nouvel étudiant (admin)
- [ ] Test avec token invalide (erreur attendue)
- [ ] Test d'accès non autorisé (erreur attendue)

---

## 🐛 En Cas de Problème

### Les vues ne sont pas créées
```powershell
docker exec -i mysql-notes mysql -uroot -prootpass notes_db < script/create_views.sql
```

### Relancer complètement Docker
```powershell
docker-compose down
docker-compose up -d --build
```

### Voir les logs
```powershell
docker-compose logs -f notes-api
docker-compose logs -f mysql-notes
```

### Rebuild complet
```powershell
docker-compose down -v  # Supprime aussi les volumes
docker-compose up -d --build
```

---

## 📝 Notes

- Les vues sont **en lecture seule** (immutable)
- Les vues sont **automatiquement mises à jour** quand les données changent
- Les vues **optimisent les performances** en pré-calculant les jointures
- Les tokens JWT expirent après **24 heures**
