# 🛠️ Commandes Utiles - Projet Gestion des Notes

## 📦 Installation

### Installer les dépendances Vue.js
```bash
cd vue-project
npm install
```

Ou utiliser le script Windows:
```bash
install-vue.bat
```

## 🚀 Démarrage

### Avec Docker (Recommandé)
```bash
cd WS_ETU003103_ETU003248
start.bat                    # Windows
# ou
docker-compose up --build    # Mac/Linux
```

### Sans Docker - Backend
```bash
cd WS_ETU003103_ETU003248
mvn clean install
mvn spring-boot:run
```

### Sans Docker - Frontend
```bash
cd vue-project
npm run dev
```

## 🛑 Arrêt

### Docker
```bash
cd WS_ETU003103_ETU003248
stop.bat                     # Windows
# ou
docker-compose down          # Mac/Linux
```

## 🔍 Monitoring

### Voir les conteneurs en cours
```bash
docker ps
```

### Voir tous les conteneurs (y compris arrêtés)
```bash
docker ps -a
```

### Voir les logs
```bash
# Tous les services
docker-compose logs -f

# Service spécifique
docker-compose logs -f frontend
docker-compose logs -f api
docker-compose logs -f db
```

### Entrer dans un conteneur
```bash
# Base de données
docker exec -it notes_db mysql -u notes_user -p

# API
docker exec -it notes_api bash

# Frontend
docker exec -it notes_frontend sh
```

## 🔧 Maintenance

### Reconstruire sans cache
```bash
docker-compose build --no-cache
docker-compose up
```

### Supprimer tout et recommencer
```bash
docker-compose down -v
docker-compose up --build
```

### Redémarrer un service spécifique
```bash
docker-compose restart frontend
docker-compose restart api
docker-compose restart db
```

### Voir l'utilisation des ressources
```bash
docker stats
```

## 🗄️ Base de données

### Se connecter à MySQL
```bash
docker exec -it notes_db mysql -u notes_user -pnotes_pass_456 notes_db
```

### Exécuter un script SQL
```bash
docker exec -i notes_db mysql -u notes_user -pnotes_pass_456 notes_db < script/data.sql
```

### Backup de la base
```bash
docker exec notes_db mysqldump -u notes_user -pnotes_pass_456 notes_db > backup.sql
```

### Restore de la base
```bash
docker exec -i notes_db mysql -u notes_user -pnotes_pass_456 notes_db < backup.sql
```

## 🧪 Tests

### Tester l'API avec PowerShell
```bash
cd WS_ETU003103_ETU003248
.\test-api-complet.ps1
```

### Tester l'API avec curl
```bash
# Login
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"jean.rakoto@univ.mg","password":"ETU003103"}'

# Avec le token (remplacer YOUR_TOKEN)
curl http://localhost:3000/api/students \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### Tests frontend
```bash
cd vue-project
npm run build    # Tester le build
npm run preview  # Prévisualiser la prod
```

## 🔍 Diagnostic

### Vérifier les ports utilisés
```bash
# Windows
netstat -ano | findstr :3000
netstat -ano | findstr :3306
netstat -ano | findstr :8080

# Mac/Linux
lsof -i :3000
lsof -i :3306
lsof -i :8080
```

### Libérer un port (Windows)
```bash
# Trouver le PID
netstat -ano | findstr :3000

# Tuer le processus (remplacer PID)
taskkill /PID <PID> /F
```

### Vérifier Docker
```bash
docker --version
docker-compose --version
docker info
```

### Nettoyer Docker
```bash
# Supprimer les conteneurs arrêtés
docker container prune

# Supprimer les images non utilisées
docker image prune

# Supprimer les volumes non utilisés
docker volume prune

# Tout nettoyer (ATTENTION: supprime tout)
docker system prune -a --volumes
```

## 📝 Développement

### Hot reload frontend
```bash
cd vue-project
npm run dev
# Le serveur redémarre automatiquement à chaque modification
```

### Format du code
```bash
cd vue-project
npm run format    # Si configuré
```

### Build pour production
```bash
cd vue-project
npm run build
# Les fichiers sont générés dans dist/
```

### Backend avec hot reload (Spring Boot DevTools)
```bash
cd WS_ETU003103_ETU003248
mvn spring-boot:run
# Modifiez le code et sauvegardez pour recharger
```

## 🌐 URLs

### Développement
- Frontend: http://localhost:5173 (sans Docker)
- API: http://localhost:3000
- Base de données: localhost:3306

### Production (avec Docker)
- Frontend: http://localhost:8080
- API: http://localhost:3000
- Base de données: localhost:3306

## 📊 Comptes de test

```
Email: jean.rakoto@univ.mg
Password: ETU003103
Parcours: Développement

Email: marie.rasoa@univ.mg
Password: ETU003248
Parcours: Web et Design

Email: paul.rabe@univ.mg
Password: ETU003103
Parcours: BDD et Réseaux
```

## 🎨 Structure des fichiers

### Frontend important
```
vue-project/
├── src/
│   ├── views/           # Pages principales
│   ├── router/          # Configuration routes
│   ├── stores/          # State management
│   ├── services/        # Services API
│   └── assets/          # CSS, images
├── .env                 # Variables d'environnement
└── package.json         # Dépendances
```

### Backend important
```
WS_ETU003103_ETU003248/
├── src/main/java/
│   └── mg/itu/notesapi/
│       ├── controller/  # Endpoints REST
│       ├── service/     # Logique métier
│       ├── repository/  # Accès base
│       └── dto/         # DTOs
├── src/main/resources/
│   └── application.properties
├── script/              # Scripts SQL
└── .env                 # Configuration
```

## 🐛 Problèmes courants

### Le frontend ne démarre pas
```bash
cd vue-project
rm -rf node_modules package-lock.json
npm install
npm run dev
```

### L'API ne démarre pas
```bash
cd WS_ETU003103_ETU003248
mvn clean install -DskipTests
mvn spring-boot:run
```

### La base ne démarre pas
```bash
docker-compose down -v
docker volume rm ws_etu003103_etu003248_db_data
docker-compose up --build
```

### Erreur CORS
Vérifier que `SecurityConfig.java` contient la configuration CORS avec les bons origins.

### Token expiré
Se déconnecter et se reconnecter dans l'application.

## 📚 Documentation

- API Documentation: `API_DOCUMENTATION.md`
- Guide installation: `INSTALLATION.md`
- Résumé projet: `PROJET_RESUME.md`
- README Backend: `WS_ETU003103_ETU003248/README.md`
- README Frontend: `vue-project/README.md`

## 🎓 Auteurs

ETU003103 & ETU003248  
IT University Madagascar  
Novembre 2025
