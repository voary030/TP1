# 🎓 Application de Gestion des Notes - IT University

> Projet de développement web Full Stack avec Vue.js 3 et Spring Boot  
> **IT University Madagascar - Novembre 2025**

## 📝 Description

Application complète de gestion des notes étudiantes permettant :
- Consultation des relevés de notes par semestre
- Consultation des relevés annuels (L1 et L2)
- Gestion des parcours optionnels pour le S4
- Authentification sécurisée par JWT
- Interface inspirée des relevés officiels ITU

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Docker Compose                        │
├──────────────┬──────────────────┬──────────────────────┤
│   Frontend   │    Backend API   │   Base de Données    │
│   Vue.js 3   │   Spring Boot    │      MySQL 8.0       │
│   + Nginx    │   + Spring       │                      │
│   Port 8080  │   Security       │      Port 3306       │
│              │   Port 3000      │                      │
└──────────────┴──────────────────┴──────────────────────┘
```

## ✨ Fonctionnalités

### Pour les Étudiants
- ✅ Connexion sécurisée avec email et mot de passe
- ✅ Consultation des moyennes par semestre (S1 à S4)
- ✅ Téléchargement des relevés de notes
- ✅ Relevés annuels (L1 = S1+S2, L2 = S3+S4)
- ✅ Visualisation des résultats (Admis/Ajourné)
- ✅ Calcul automatique des mentions

### Gestion des Parcours
- 🎯 Développement
- 🎨 Web et Design
- 💾 Bases de Données et Réseaux

## 🚀 Démarrage Rapide

### Prérequis
- Docker Desktop
- 4GB RAM disponible
- Ports 3000, 3306, 8080 libres

### Installation en 3 étapes

1. **Cloner le projet**
   ```bash
   git clone <votre-repo>
   cd TP1
   ```

2. **Configurer l'environnement**
   ```bash
   cd WS_ETU003103_ETU003248
   copy .env.example .env
   ```

3. **Démarrer l'application**
   ```bash
   start.bat
   ```
   Ou sur Mac/Linux :
   ```bash
   docker-compose up --build
   ```

### Accès à l'application

🌐 **Frontend:** http://localhost:8080  
🔧 **API:** http://localhost:3000  
💾 **Base de données:** localhost:3306

### Comptes de test

| Email | Mot de passe | Parcours |
|-------|-------------|----------|
| jean.rakoto@univ.mg | ETU003103 | Développement |
| marie.rasoa@univ.mg | ETU003248 | Web et Design |
| paul.rabe@univ.mg | ETU003103 | BDD et Réseaux |

## 📱 Utilisation

1. **Connexion**  
   Entrez vos identifiants sur la page de login

2. **Navigation**  
   - Accueil → Liste des semestres
   - Clic sur semestre → Liste des étudiants
   - Clic sur nom → Détails de l'étudiant
   - Clic sur moyenne → Relevé du semestre

3. **Relevés de notes**  
   - Relevés par semestre (S1, S2, S3, S4)
   - Relevés annuels (L1, L2)
   - Format inspiré des relevés ITU officiels

## 🛠️ Technologies

### Frontend
- **Vue.js 3.5** - Framework JavaScript progressif
- **Vue Router 4** - Routage SPA
- **Pinia 2** - State management
- **Axios** - Client HTTP
- **Vite 7** - Build tool ultra-rapide

### Backend
- **Spring Boot 3** - Framework Java enterprise
- **Spring Security** - Authentification et autorisation
- **Spring Data JPA** - Accès aux données
- **JWT** - Tokens d'authentification
- **MySQL 8.0** - Base de données relationnelle

### DevOps
- **Docker** - Containerisation
- **Docker Compose** - Orchestration multi-conteneurs
- **Nginx** - Serveur web et reverse proxy

## 📚 Documentation

- 📖 [Guide d'Installation Complet](INSTALLATION.md)
- 🔌 [Documentation API](API_DOCUMENTATION.md)
- 💻 [Commandes Utiles](COMMANDES_UTILES.md)
- ✅ [Checklist de Test](CHECKLIST.md)
- 📊 [Résumé du Projet](PROJET_RESUME.md)

## 📂 Structure du Projet

```
TP1/
├── WS_ETU003103_ETU003248/         # Backend Spring Boot
│   ├── src/
│   │   └── main/
│   │       ├── java/               # Code source Java
│   │       └── resources/          # Configuration
│   ├── script/                     # Scripts SQL
│   ├── docker-compose.yml          # Orchestration Docker
│   ├── Dockerfile                  # Image Docker API
│   ├── start.bat                   # Script démarrage Windows
│   └── .env                        # Variables d'environnement
│
├── vue-project/                    # Frontend Vue.js
│   ├── src/
│   │   ├── views/                  # Pages de l'application
│   │   ├── router/                 # Configuration des routes
│   │   ├── stores/                 # State management Pinia
│   │   ├── services/               # Services API
│   │   └── assets/                 # CSS et ressources
│   ├── Dockerfile                  # Image Docker Frontend
│   ├── nginx.conf                  # Configuration Nginx
│   └── package.json                # Dépendances npm
│
├── postman/                        # Collection Postman
├── INSTALLATION.md                 # Guide d'installation
├── API_DOCUMENTATION.md            # Doc API REST
└── README.md                       # Ce fichier
```

## 🎯 Points Forts

✅ **Architecture moderne** - Séparation frontend/backend  
✅ **Sécurité renforcée** - Authentification JWT  
✅ **Design professionnel** - Interface inspirée ITU  
✅ **Docker ready** - Déploiement en un clic  
✅ **Code propre** - Bonnes pratiques respectées  
✅ **Documentation complète** - Guides détaillés  

## 🧪 Tests

### Tester l'API
```bash
cd WS_ETU003103_ETU003248
.\test-api-complet.ps1
```

### Tester le Frontend
```bash
cd vue-project
npm run dev
```

## 🐛 Résolution de Problèmes

### L'application ne démarre pas
```bash
# Nettoyer et redémarrer
docker-compose down -v
docker-compose up --build
```

### Erreur de port déjà utilisé
Modifier les ports dans `.env` ou `docker-compose.yml`

### Plus de détails
Consulter [COMMANDES_UTILES.md](COMMANDES_UTILES.md)

## 📊 Données

### Base de données
- 4 semestres (S1, S2, S3, S4)
- 3 parcours (Développement, Web, BDD)
- 3 étudiants de test avec notes complètes
- Matières obligatoires et optionnelles

### Calculs
- Moyennes pondérées par crédits
- Mentions automatiques (TB, B, AB, P, AR)
- Résultats par semestre et par année

## 🎓 Conformité Académique

Ce projet répond à tous les critères du sujet :

- ✅ Web Services REST complets
- ✅ Application Vue.js fonctionnelle
- ✅ Liste des semestres avec navigation
- ✅ Liste des étudiants avec moyennes S1-S4
- ✅ Relevés de notes par semestre
- ✅ Détails étudiants avec liens L1/L2
- ✅ Gestion des options/parcours
- ✅ Format inspiré des relevés ITU
- ✅ Docker opérationnel

## 👥 Équipe

**Étudiants:**
- ETU003103
- ETU003248

**Établissement:**  
IT University Madagascar

**Projet:**  
TP Vue.js - Gestion des Notes

**Date:**  
Novembre 2025

## 📄 Licence

Projet académique - IT University Madagascar

## 🙏 Remerciements

- IT University pour l'encadrement
- Spring Boot et Vue.js communities
- Docker pour la containerisation

---

## 📞 Support

Pour toute question ou problème :
1. Consulter la [documentation](INSTALLATION.md)
2. Vérifier la [checklist](CHECKLIST.md)
3. Voir les [commandes utiles](COMMANDES_UTILES.md)

---

<div align="center">

**🎉 Projet complet et opérationnel ! 🎉**

Made with ❤️ by ETU003103 & ETU003248

[Documentation](INSTALLATION.md) • [API](API_DOCUMENTATION.md) • [Tests](CHECKLIST.md)

</div>
