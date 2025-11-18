# 🚀 GUIDE DE DÉMARRAGE RAPIDE - TP1 Notes API

## ⚠️ Problèmes rencontrés et solutions

### Problème 1 : Variables d'environnement non trouvées
**Erreur** : `The "DB_NAME" variable is not set. Defaulting to a blank string.`

**Solution** :
```powershell
# Créer le fichier .env
Copy-Item .env.example .env
```

### Problème 2 : Docker Desktop non démarré
**Erreur** : `open //./pipe/dockerDesktopLinuxEngine: The system cannot find the file specified`

**Solution** :
1. Démarrer **Docker Desktop** depuis le menu Windows
2. Attendre que l'icône Docker soit verte (dans la barre des tâches)
3. Relancer `docker compose up -d`

### Problème 3 : Redirection `<` non supportée dans PowerShell
**Erreur** : `L'opérateur « < » est réservé à une utilisation future.`

**Solution** : Utiliser `Get-Content` avec pipe :
```powershell
Get-Content script/update_passwords.sql | docker compose exec -T db mysql -u notes_user -pnotes_pass_456 notes_db
```

---

## 📋 ÉTAPES DE DÉMARRAGE (dans l'ordre)

### ✅ Étape 1 : Créer le fichier .env
```powershell
Copy-Item .env.example .env
```

### ✅ Étape 2 : Démarrer Docker Desktop
- Ouvrir **Docker Desktop**
- Attendre que l'icône soit **verte** ✓

### ✅ Étape 3 : Supprimer le warning "version"
Le fichier `docker-compose.yml` a `version: '3.8'` qui est obsolète.

```powershell
# On peut l'ignorer ou le supprimer
```

### ✅ Étape 4 : Lancer Docker Compose
```powershell
docker compose up -d
```

Cela va :
- ✅ Créer la base MySQL
- ✅ Exécuter `script/script.sql` automatiquement
- ✅ Builder l'application Spring Boot
- ✅ Démarrer l'API sur port 3000

### ✅ Étape 5 : Vérifier que tout fonctionne
```powershell
# Voir les conteneurs
docker compose ps

# Voir les logs
docker compose logs -f app

# Tester le health check (après quelques secondes)
curl http://localhost:3000/actuator/health
```

### ✅ Étape 6 : Initialiser les mots de passe
**Méthode 1 (Recommandée)** :
```powershell
Get-Content script/update_passwords.sql | docker compose exec -T db mysql -u notes_user -pnotes_pass_456 notes_db
```

**Méthode 2** :
```powershell
# Se connecter à MySQL
docker compose exec db mysql -u notes_user -pnotes_pass_456 notes_db

# Puis dans MySQL, copier-coller le contenu de update_passwords.sql
```

### ✅ Étape 7 : Tester l'API

**Test 1 - Health check** :
```powershell
curl http://localhost:3000/actuator/health
```

**Test 2 - Login** :
```powershell
$body = @{
    email = "rakoto@ituniv.mg"
    password = "password123"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:3000/api/auth/login" `
    -Method POST `
    -ContentType "application/json" `
    -Body $body
```

**Test 3 - Récupérer les notes** (remplacer TOKEN) :
```powershell
$token = "VOTRE_TOKEN_ICI"
Invoke-RestMethod -Uri "http://localhost:3000/api/students/1/semesters/1/grades" `
    -Method GET `
    -Headers @{ Authorization = "Bearer $token" }
```

---

## 🔍 VÉRIFICATIONS

### Vérifier que Docker Desktop est lancé :
```powershell
docker ps
```
Si ça fonctionne → Docker est OK ✓

### Vérifier que le fichier .env existe :
```powershell
Get-Content .env
```
Doit afficher :
```
DB_ROOT_PASSWORD=root_password_123
DB_NAME=notes_db
DB_USER=notes_user
DB_PASSWORD=notes_pass_456
...
```

### Vérifier les conteneurs :
```powershell
docker compose ps
```
Doit montrer :
- `notes_db` → healthy
- `notes_api` → running

---

## 🛠️ COMMANDES UTILES

```powershell
# Redémarrer tout
docker compose restart

# Arrêter tout
docker compose down

# Rebuild après modification du code
docker compose up -d --build

# Voir les logs en direct
docker compose logs -f

# Voir uniquement les logs de l'app
docker compose logs -f app

# Voir uniquement les logs de la DB
docker compose logs -f db

# Accéder au shell du conteneur MySQL
docker compose exec db bash

# Exécuter une requête SQL directement
docker compose exec db mysql -u notes_user -pnotes_pass_456 notes_db -e "SELECT * FROM Etudiant;"

# Nettoyer tout (ATTENTION : supprime les données)
docker compose down -v
```

---

## 🐛 DÉPANNAGE

### Problème : "Bind for 0.0.0.0:3000 failed: port is already allocated"
**Solution** :
```powershell
# Trouver ce qui utilise le port 3000
netstat -ano | findstr :3000

# Tuer le processus (remplacer PID)
taskkill /PID <PID> /F

# Ou changer le port dans .env
API_PORT=3001
```

### Problème : "Cannot connect to MySQL server"
**Solution** :
```powershell
# Vérifier que la DB est healthy
docker compose ps

# Attendre le health check (peut prendre 30-60 secondes)
docker compose logs -f db

# Redémarrer la DB
docker compose restart db
```

### Problème : "Access denied for user 'notes_user'"
**Solution** :
```powershell
# Vérifier le mot de passe dans .env
Get-Content .env | Select-String DB_PASSWORD

# Recréer la DB avec les bonnes credentials
docker compose down -v
docker compose up -d
```

---

## 📦 STRUCTURE FINALE

Après démarrage réussi :

```
✅ MySQL 8.0         → localhost:3306
✅ Spring Boot API   → localhost:3000
✅ Health Check      → localhost:3000/actuator/health
✅ Login endpoint    → localhost:3000/api/auth/login
✅ Grades endpoint   → localhost:3000/api/students/{id}/...
```

---

## 🎯 CHECKLIST RAPIDE

- [ ] Docker Desktop démarré (icône verte)
- [ ] Fichier `.env` créé (`Copy-Item .env.example .env`)
- [ ] `docker compose up -d` exécuté
- [ ] Attendre 30-60 secondes pour le build
- [ ] `docker compose ps` → 2 conteneurs "running"
- [ ] Mots de passe initialisés (`update_passwords.sql`)
- [ ] Test login avec Postman ou curl
- [ ] Récupération du token JWT
- [ ] Test endpoint notes avec le token

---

**Résumé en 3 commandes** :
```powershell
Copy-Item .env.example .env
docker compose up -d
docker compose logs -f
```

Puis attendre que l'application démarre et tester ! 🚀
