# 🚀 Guide de Déploiement Rapide - Application Gestion des Notes

## ✅ CE QU'IL FAUT SAVOIR

Cette application fonctionne **100% avec Docker** sur n'importe quel PC.
Tout est automatisé : **base de données + API + frontend**.

---

## 📦 Prérequis

- **Docker Desktop** installé et démarré
- **Git** (pour cloner le projet)
- Ports disponibles : **3306** (MySQL), **8060** (API), **5173** (Frontend)

---

## 🎯 Installation sur un nouveau PC - 3 étapes

### 1️⃣ Cloner le projet

```bash
git clone https://github.com/voary030/TP1.git
cd TP1/WS_ETU003103_ETU003248
```

### 2️⃣ Configurer l'environnement

```bash
# Copier le fichier .env.example vers .env
cp .env.example .env

# Ou sur Windows CMD
copy .env.example .env
```

Le fichier `.env` contient déjà les bonnes valeurs par défaut.

### 3️⃣ Démarrer l'application

```bash
docker-compose up -d
```

**C'EST TOUT !** 🎉

L'application va :
- ✅ Télécharger les images Docker nécessaires
- ✅ Créer la base de données MySQL avec **TOUTES les données** (69 notes, 3 étudiants, 4 semestres)
- ✅ Compiler et démarrer l'API Spring Boot
- ✅ Compiler et démarrer le frontend Vue.js

**⏱️ Temps d'attente** : 2-3 minutes la première fois (téléchargement des images)

---

## 🌐 Accès à l'application

Une fois démarré, l'application est accessible sur :

| Service | URL | Description |
|---------|-----|-------------|
| **Frontend** | http://localhost:5173 | Interface utilisateur Vue.js |
| **API** | http://localhost:8060 | API REST Spring Boot |
| **Base de données** | localhost:3306 | MySQL (accès direct si besoin) |

---

## 🔐 Connexion

### Comptes disponibles :

**Administrateur :**
- Email : `admin@univ.mg`
- Mot de passe : `AdminPass123!`

**Secrétaire :**
- Email : `secretaire@univ.mg`
- Mot de passe : `SecPass123!`

---

## 📊 Données pré-chargées

L'application démarre avec :
- ✅ **3 étudiants** : Jean Rakoto, Marie Rasoa, Paul Rabe
- ✅ **4 semestres** : S1, S2, S3, S4
- ✅ **31 matières** réparties sur les 4 semestres
- ✅ **69 notes** complètes pour les 3 étudiants
- ✅ **3 parcours S4** : Développement, Web et Design, Bases de Données et Réseaux
- ✅ **25 relations matière-parcours** pour S4

---

## 🧪 Tester l'application

### Via l'interface web :

1. Ouvrir http://localhost:5173
2. Se connecter avec `admin@univ.mg` / `AdminPass123!`
3. Cliquer sur la **moyenne S4** d'un étudiant
4. **Choisir un parcours** (Développement / Web et Design / BDD et Réseaux)
5. Voir les notes filtrées pour ce parcours

### Via Postman :

Collections Postman disponibles dans le dossier `postman/` :
- `notes-api-complete-avec-vues.postman_collection.json`
- `notes-api.postman_environment.json`

---

## 🛠️ Commandes utiles

### Arrêter l'application :
```bash
docker-compose down
```

### Redémarrer l'application :
```bash
docker-compose restart
```

### Voir les logs :
```bash
# Logs de tous les services
docker-compose logs -f

# Logs de l'API seulement
docker logs notes_api -f

# Logs du frontend seulement
docker logs notes_frontend -f
```

### Reconstruire après modifications du code :
```bash
# Reconstruire tout
docker-compose down
docker-compose build --no-cache
docker-compose up -d

# Reconstruire seulement l'API
docker-compose build --no-cache api
docker-compose up -d

# Reconstruire seulement le frontend
docker-compose build --no-cache frontend
docker-compose up -d
```

### Réinitialiser complètement (efface les données) :
```bash
docker-compose down -v
docker-compose up -d
```

---

## 🔍 Vérifier que tout fonctionne

### 1. Vérifier que les conteneurs tournent :
```bash
docker ps
```

Vous devriez voir 3 conteneurs :
- `notes_db` (MySQL)
- `notes_api` (Spring Boot)
- `notes_frontend` (Vue.js + Nginx)

### 2. Tester l'API :

**Login :**
```bash
curl -X POST http://localhost:8060/api/auth/admin/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@univ.mg","mot_de_passe":"AdminPass123!"}'
```

**Récupérer les parcours S4 :**
```bash
curl http://localhost:8060/api/semesters/4/parcours \
  -H "Authorization: Bearer VOTRE_TOKEN_ICI"
```

### 3. Vérifier la base de données :
```bash
docker exec -it notes_db mysql -uroot -proot_password_123 notes_db -e "SELECT COUNT(*) FROM note;"
```

Résultat attendu : **69 notes**

---

## 🐛 Résolution de problèmes

### Port déjà utilisé
```
Error: Bind for 0.0.0.0:8060 failed: port is already allocated
```

**Solution :** Changer le port dans `.env` :
```env
API_PORT=8061
```

Puis redémarrer : `docker-compose down && docker-compose up -d`

### L'API ne démarre pas
```bash
# Voir les logs d'erreur
docker logs notes_api

# Vérifier que MySQL est démarré
docker exec -it notes_db mysql -uroot -proot_password_123 -e "SELECT 1"
```

### Le frontend affiche une page blanche
```bash
# Reconstruire le frontend
docker-compose down
docker-compose build --no-cache frontend
docker-compose up -d
```

### Les données ne sont pas présentes
```bash
# Supprimer le volume et recréer
docker-compose down -v
docker-compose up -d
```

---

## 📁 Structure du projet

```
WS_ETU003103_ETU003248/
├── docker-compose.yml          # Configuration Docker
├── Dockerfile                  # Image Docker de l'API
├── .env                        # Variables d'environnement
├── .env.example               # Template de configuration
├── pom.xml                    # Dépendances Maven
├── src/                       # Code source Spring Boot
│   └── main/
│       ├── java/mg/itu/notesapi/
│       └── resources/
├── script/
│   └── init.sql              # Script d'initialisation BDD
├── postman/                  # Collections Postman
└── README.md                 # Documentation

../vue-project/               # Frontend Vue.js
├── Dockerfile
├── package.json
├── nginx.conf
└── src/
```

---

## 🎓 Fonctionnalités

### ✅ Gestion des notes
- Voir les notes par semestre (S1, S2, S3, S4)
- Voir les notes par année (L1 = S1+S2, L2 = S3+S4)
- Calcul automatique des moyennes

### ✅ Parcours S4 (Nouveauté !)
- **3 parcours disponibles** : Développement, Web et Design, BDD et Réseaux
- Chaque parcours a ses **matières obligatoires** et **optionnelles**
- **Filtrage automatique** des notes selon le parcours choisi

### ✅ Authentification JWT
- Login sécurisé avec email/mot de passe
- Token JWT valide 24h
- Protection de tous les endpoints

### ✅ API REST complète
- Format JSON standardisé
- Codes d'erreur explicites
- Documentation Postman

---

## 👥 Équipe

- ETU003103
- ETU003248

---

## 📝 Licence

Projet académique - IT University

---

## 🆘 Support

En cas de problème :
1. Vérifier les logs : `docker-compose logs -f`
2. Vérifier que Docker Desktop est démarré
3. Vérifier que les ports ne sont pas déjà utilisés
4. Réinitialiser complètement : `docker-compose down -v && docker-compose up -d`

**Tout fonctionne ? Profitez de l'application ! 🚀**
