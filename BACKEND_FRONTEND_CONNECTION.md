# 🔗 Guide de Connexion Backend-Frontend

## 📋 Configuration Complète

### 1. **Backend (Spring Boot)**

#### Port configuré
- **Port:** `8060` (défini dans Postman et utilisé par le frontend)

#### Variables d'environnement (.env)
```env
DB_HOST=localhost
DB_PORT=3306
DB_NAME=notes_db
DB_USER=notes_user
DB_PASSWORD=notes_pass_456
API_PORT=8060
JWT_SECRET=your_super_secret_key_change_this_in_production_123456789
```

---

### 2. **Frontend (Vue.js)**

#### Variables d'environnement (.env)
```env
VITE_API_URL=http://localhost:8060
VITE_USE_MOCK_API=false
```

#### Comportement du mode mock
- `VITE_USE_MOCK_API=true` → Utilise les données mock (pas de backend requis)
- `VITE_USE_MOCK_API=false` → Utilise l'API backend réelle

---

## 🚀 Étapes de Démarrage

### Étape 1: Générer les mots de passe hashés

```bash
cd WS_ETU003103_ETU003248
mvn exec:java -Dexec.mainClass="mg.itu.notesapi.PasswordHashGenerator"
```

**Sortie attendue:**
```
=== BCrypt Password Hash Generator ===

Email: admin@univ.mg
Password: AdminPass123!
BCrypt Hash: $2a$10$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
---
Email: secretaire@univ.mg
Password: SecPass123!
BCrypt Hash: $2a$10$yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
---
```

**Copiez les hashes générés** pour l'étape suivante.

---

### Étape 2: Insérer les utilisateurs admin dans la base

Connectez-vous à MySQL:
```bash
mysql -u notes_user -p notes_db
```

Puis exécutez (avec les vrais hashs de l'étape 1):
```sql
-- Insérer les utilisateurs admin
INSERT INTO users (username, email, mot_de_passe, role, est_actif) VALUES
('admin.bureau', 'admin@univ.mg', '$2a$10$VOTRE_HASH_ICI', 'ADMIN', TRUE),
('secretaire', 'secretaire@univ.mg', '$2a$10$VOTRE_HASH_ICI', 'USER', TRUE);
```

Vérifiez:
```sql
SELECT id_user, username, email, role FROM users;
```

---

### Étape 3: Démarrer le backend

**Option A: Avec Docker (recommandé)**
```bash
cd WS_ETU003103_ETU003248
start.bat
```

**Option B: Sans Docker**
```bash
cd WS_ETU003103_ETU003248
mvn spring-boot:run
```

**Vérification:**
- Backend démarre sur: `http://localhost:8060`
- Logs doivent montrer: `Started NotesApiApplication`

---

### Étape 4: Démarrer le frontend

```bash
cd vue-project
npm install
npm run dev
```

**Vérification:**
- Frontend démarre sur: `http://localhost:5173`
- Ouvrir dans le navigateur

---

## 🔐 Test de Connexion

### Comptes disponibles

| Email | Mot de passe | Rôle |
|-------|-------------|------|
| `admin@univ.mg` | `AdminPass123!` | ADMIN |
| `secretaire@univ.mg` | `SecPass123!` | USER |

### Test dans le navigateur

1. Accédez à `http://localhost:5173`
2. Entrez: `admin@univ.mg` / `AdminPass123!`
3. Cliquez sur "Se connecter"

**Console du navigateur (F12):**
- ✅ Pas de message `🔷 Using MOCK API` (car on utilise le vrai backend)
- ✅ Requête POST vers `http://localhost:8060/api/auth/admin/login`
- ✅ Réponse 200 avec token JWT

---

## 🔍 Débogage

### Problème 1: CORS Error

**Erreur:**
```
Access to XMLHttpRequest at 'http://localhost:8060/api/auth/admin/login' from origin 'http://localhost:5173' has been blocked by CORS policy
```

**Solution:**
- Vérifier que `SecurityConfig.java` contient `http://localhost:5173` dans `allowedOrigins`
- Redémarrer le backend

---

### Problème 2: 401 Unauthorized sur /api/auth/admin/login

**Erreur:**
```
POST http://localhost:8060/api/auth/admin/login 401
```

**Solution:**
- Vérifier que `SecurityConfig.java` autorise `/api/auth/**` (et pas seulement `/api/auth/login`)
- Code correct:
```java
.requestMatchers("/api/auth/**", "/actuator/health").permitAll()
```

---

### Problème 3: Backend ne démarre pas

**Erreur:**
```
Failed to configure a DataSource: 'url' attribute is not specified
```

**Solution:**
- Vérifier que MySQL est démarré
- Vérifier les credentials dans `.env`
- Tester la connexion:
```bash
mysql -h localhost -u notes_user -p
```

---

### Problème 4: Cannot find table 'users'

**Erreur:**
```
Table 'notes_db.users' doesn't exist
```

**Solution:**
- Exécuter le script d'initialisation:
```bash
mysql -u notes_user -p notes_db < script/init.sql
```

---

## 📊 Endpoints Utilisés par le Frontend

| Endpoint | Méthode | Auth | Description |
|----------|---------|------|-------------|
| `/api/auth/admin/login` | POST | Non | Connexion admin |
| `/api/semesters` | GET | Oui | Liste des semestres |
| `/api/semesters/{id}/parcours` | GET | Oui | Parcours par semestre |
| `/api/students` | GET | Oui | Liste des étudiants |
| `/api/students/{id}` | GET | Oui | Détails étudiant |
| `/api/students/{id}/semesters/{sid}/grades` | GET | Oui | Notes par semestre |
| `/api/students/{id}/years/{year}/grades` | GET | Oui | Notes annuelles |

---

## 🧪 Test avec Postman

Importez: `postman/notes-api-admin.postman_collection.json`

**Séquence de test:**
1. **Admin Login** → Récupérer le token
2. Copier le token dans la variable `{{admin_token}}`
3. Tester tous les autres endpoints

---

## ✅ Checklist de Connexion

Backend:
- [ ] MySQL démarré et accessible
- [ ] Table `users` existe avec données admin
- [ ] Backend démarre sans erreur sur port 8060
- [ ] CORS configuré avec `http://localhost:5173`
- [ ] `/api/auth/**` autorisé dans SecurityConfig

Frontend:
- [ ] `.env` contient `VITE_API_URL=http://localhost:8060`
- [ ] `.env` contient `VITE_USE_MOCK_API=false`
- [ ] `npm install` exécuté
- [ ] Frontend démarre sur port 5173

Test:
- [ ] Login admin réussit (pas d'erreur 401)
- [ ] Token JWT reçu et stocké
- [ ] Navigation vers /students fonctionne
- [ ] Données affichées (pas de mock)

---

## 🎯 En cas d'urgence: Mode Mock

Si le backend ne fonctionne pas, basculez temporairement en mode mock:

```env
# vue-project/.env
VITE_USE_MOCK_API=true
```

Puis:
```bash
npm run dev
```

L'application utilisera les données mock au lieu du backend.

---

## 📝 Logs Utiles

**Backend (Spring Boot):**
```bash
# Voir les logs
docker logs ws_etu003103_etu003248-api-1 -f

# Voir les requêtes SQL
# Modifier application.properties:
spring.jpa.show-sql=true
```

**Frontend (Vue.js):**
```javascript
// Console du navigateur (F12)
// Les appels API sont loggés automatiquement
```

---

Tout devrait maintenant fonctionner ! 🎉

Pour basculer entre mock et backend réel, il suffit de modifier `VITE_USE_MOCK_API` dans `.env` et relancer `npm run dev`.
