# ⚡ Commandes Rapides - Référence

Guide ultra-rapide des commandes essentielles.

---

## 🚀 Démarrage

### Démarrage Complet (Automatique)
```cmd
start-all.bat
```
Démarre backend + frontend automatiquement.

### Démarrage Backend Seul
```cmd
cd WS_ETU003103_ETU003248
start.bat
```

### Démarrage Frontend Seul
```cmd
cd vue-project
npm run dev
```

---

## 🔐 Configuration Initiale (Une Seule Fois)

### 1. Générer Hashes Admin
```cmd
generate-passwords.bat
```
Copier les UPDATE SQL affichés dans la console.

### 2. Insérer Admins
```cmd
cd WS_ETU003103_ETU003248
docker-compose up -d
mysql -u notes_user -p notes_db
```
Password: `notes2024`

```sql
-- Coller les UPDATE depuis étape 1
UPDATE users SET mot_de_passe = '$2a$...' WHERE username = 'admin.bureau';
UPDATE users SET mot_de_passe = '$2a$...' WHERE username = 'secretaire';
exit
```

---

## 🔍 Vérifications

### Backend Actif?
```cmd
curl http://localhost:8060/actuator/health
```
Doit retourner: `{"status":"UP"}`

### Admins Créés?
```cmd
mysql -u notes_user -p notes_db -e "SELECT username, email, role FROM users WHERE role='ADMIN';"
```

### Frontend Mode?
```cmd
type vue-project\.env | findstr VITE_USE_MOCK_API
```
Doit être: `VITE_USE_MOCK_API=false`

---

## 🛑 Arrêt

### Arrêter Backend
```cmd
cd WS_ETU003103_ETU003248
stop.bat
```

### Arrêter Frontend
`Ctrl + C` dans le terminal npm

### Arrêter MySQL Docker
```cmd
cd WS_ETU003103_ETU003248
docker-compose down
```

---

## 🔄 Redémarrage Propre

### Backend
```cmd
cd WS_ETU003103_ETU003248
stop.bat
docker-compose down -v
docker-compose up -d
timeout /t 10
start.bat
```

### Frontend
```cmd
cd vue-project
npm run dev
```

---

## 🧪 Tests

### Tester Backend API
```cmd
cd WS_ETU003103_ETU003248
.\test-api-complet.ps1
```

### Tester Frontend
1. Ouvrir http://localhost:5173
2. Login: `admin@univ.mg` / `AdminPass123!`
3. Vérifier liste étudiants

### Mode Mock (Sans Backend)
```env
# Modifier vue-project/.env
VITE_USE_MOCK_API=true
```
Puis:
```cmd
cd vue-project
npm run dev
```

---

## 🔧 Maintenance

### Nettoyer Base de Données
```cmd
cd WS_ETU003103_ETU003248
docker-compose down -v
docker-compose up -d
mysql -u notes_user -p notes_db < script\init.sql
mysql -u notes_user -p notes_db < script\data.sql
mysql -u notes_user -p notes_db < script\insert_admin_users.sql
```

### Rebuild Backend
```cmd
cd WS_ETU003103_ETU003248
mvn clean install
```

### Rebuild Frontend
```cmd
cd vue-project
npm install
npm run build
```

---

## 📊 Logs

### Logs Backend
```cmd
cd WS_ETU003103_ETU003248
mvn spring-boot:run
```

### Logs MySQL
```cmd
cd WS_ETU003103_ETU003248
docker-compose logs -f mysql
```

### Logs Frontend
Console F12 dans le navigateur (http://localhost:5173)

---

## 🐛 Debug Rapide

### Erreur 401 Unauthorized
```cmd
# Vérifier admins
mysql -u notes_user -p notes_db -e "SELECT * FROM users WHERE role='ADMIN';"

# Regénérer hashes
generate-passwords.bat
```

### Erreur CORS
```cmd
# Vérifier backend sur 8060
netstat -ano | findstr :8060

# Redémarrer backend
cd WS_ETU003103_ETU003248
stop.bat
start.bat
```

### Frontend ne se connecte pas
```cmd
# Vérifier .env
type vue-project\.env

# Doit avoir:
# VITE_API_URL=http://localhost:8060
# VITE_USE_MOCK_API=false
```

### Port 8060 occupé
```cmd
# Trouver processus
netstat -ano | findstr :8060

# Tuer processus (PID de la dernière colonne)
taskkill /PID <PID> /F

# Ou changer port dans WS_ETU003103_ETU003248/.env
```

---

## 🔐 Comptes

### Admins
| Email | Mot de Passe |
|-------|--------------|
| admin@univ.mg | AdminPass123! |
| secretaire@univ.mg | SecPass123! |

### Base MySQL
- **User:** notes_user
- **Password:** notes2024
- **Database:** notes_db
- **Port:** 3306

---

## 🌐 URLs

| Service | URL | Description |
|---------|-----|-------------|
| Frontend | http://localhost:5173 | Application Vue.js |
| Backend API | http://localhost:8060 | API REST Spring Boot |
| Health Check | http://localhost:8060/actuator/health | Status backend |
| MySQL | localhost:3306 | Base de données |

---

## 📁 Fichiers Importants

| Fichier | Chemin | Usage |
|---------|--------|-------|
| .env Frontend | `vue-project\.env` | Config API URL et mode |
| .env Backend | `WS_ETU003103_ETU003248\.env` | Config port et DB |
| api.js | `vue-project\src\services\api.js` | Client API |
| SecurityConfig | `WS_ETU003103_ETU003248\src\main\java\mg\itu\notesapi\config\SecurityConfig.java` | CORS et JWT |
| SQL Admins | `WS_ETU003103_ETU003248\script\insert_admin_users.sql` | Template admins |

---

## 📚 Documentation Complète

| Fichier | Contenu |
|---------|---------|
| `DEMARRAGE_RAPIDE.md` | ⭐ Guide démarrage express |
| `BACKEND_FRONTEND_CONNECTION.md` | Guide intégration + debug |
| `ETAT_ACTUEL_PROJET.md` | État complet du projet |
| `MOCK_API_GUIDE.md` | Développement sans backend |
| `API_DOCUMENTATION.md` | Référence API REST |
| `README.md` | Documentation principale |

---

## 💡 Workflow Quotidien

### Matin (Démarrage)
```cmd
# 1. Vérifier Docker lancé
docker ps

# 2. Démarrer tout
start-all.bat

# 3. Attendre 30 secondes

# 4. Ouvrir http://localhost:5173
```

### Développement Frontend
```cmd
# Mode mock (sans backend)
cd vue-project
# Modifier .env: VITE_USE_MOCK_API=true
npm run dev
```

### Développement Backend
```cmd
# Backend seul
cd WS_ETU003103_ETU003248
mvn spring-boot:run

# Tester avec Postman ou curl
```

### Soir (Arrêt)
```cmd
cd WS_ETU003103_ETU003248
stop.bat
# Ctrl+C dans terminal frontend
```

---

## ⚡ One-Liners Utiles

```cmd
# Backend health
curl http://localhost:8060/actuator/health

# Liste étudiants (avec token)
curl -H "Authorization: Bearer <TOKEN>" http://localhost:8060/api/students

# Compter admins
mysql -u notes_user -pnotes2024 notes_db -e "SELECT COUNT(*) FROM users WHERE role='ADMIN';"

# Voir version Java
java -version

# Voir version Node
node -v

# Rebuild complet frontend
cd vue-project && npm ci && npm run build

# Rebuild complet backend
cd WS_ETU003103_ETU003248 && mvn clean install -DskipTests

# Logs backend direct
cd WS_ETU003103_ETU003248 && mvn spring-boot:run | findstr "ERROR"
```

---

**Gardez ce fichier ouvert pendant le développement ! 📌**
