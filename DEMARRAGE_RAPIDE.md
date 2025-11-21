# 🚀 Démarrage Rapide - Backend + Frontend

## Option 1: Démarrage Automatique (Recommandé)

### 1️⃣ Générer les mots de passe admin
```bash
generate-passwords.bat
```
**→ Copiez les hashs générés**

### 2️⃣ Insérer les admin dans MySQL
```bash
mysql -u notes_user -p notes_db
```
Puis coller les SQL UPDATE générés à l'étape 1.

### 3️⃣ Démarrer tout
```bash
start-all.bat
```

**Accès:**
- Backend: http://localhost:8060
- Frontend: http://localhost:5173
- Login: `admin@univ.mg` / `AdminPass123!`

---

## Option 2: Démarrage Manuel

### Backend
```bash
cd WS_ETU003103_ETU003248
start.bat
```
Attendre 30 secondes que Docker démarre.

### Frontend
```bash
cd vue-project
npm run dev
```

---

## 🔧 Configuration Actuelle

### Backend
- **Port:** 8060
- **Base:** MySQL (notes_db)
- **Auth:** JWT avec BCrypt

### Frontend
- **Port:** 5173
- **API:** http://localhost:8060
- **Mode:** Production (pas de mock)

---

## ✅ Vérification Rapide

### Backend OK ?
```bash
curl http://localhost:8060/actuator/health
```
**Attendu:** `{"status":"UP"}`

### Frontend OK ?
Ouvrir: http://localhost:5173
**Attendu:** Page de login s'affiche

### Connexion OK ?
1. Login avec `admin@univ.mg` / `AdminPass123!`
2. Console navigateur (F12): **pas de message CORS**
3. Redirection vers `/students`

---

## 🐛 Problèmes Fréquents

### "CORS error"
→ Redémarrer le backend

### "401 Unauthorized"
→ Vérifier que les utilisateurs admin existent dans la table `users`

### "Cannot connect to MySQL"
→ Vérifier Docker: `docker ps`

---

## 📖 Documentation Complète

Voir: `BACKEND_FRONTEND_CONNECTION.md`
