# Guide d'Installation et de Démarrage

## 📋 Prérequis

1. **Docker Desktop** - [Télécharger](https://www.docker.com/products/docker-desktop/)
2. **Git** (optionnel) - Pour cloner le repository

## 🚀 Installation Rapide (Méthode Recommandée)

### Étape 1 : Préparer le projet

1. Ouvrir un terminal dans le dossier `WS_ETU003103_ETU003248`
2. Créer le fichier `.env` si il n'existe pas :
   ```bash
   copy .env.example .env
   ```

### Étape 2 : Démarrer l'application

**Sur Windows :**
```bash
start.bat
```

**Sur Mac/Linux :**
```bash
docker-compose up --build
```

### Étape 3 : Accéder à l'application

Ouvrir votre navigateur et aller sur :
- **Frontend :** http://localhost:8060
- **API :** http://localhost:3000

### Étape 4 : Se connecter

Utiliser un des comptes de test :
- **Email :** jean.rakoto@univ.mg  
  **Mot de passe :** ETU003103

- **Email :** marie.rasoa@univ.mg  
  **Mot de passe :** ETU003248

## 🛑 Arrêter l'application

**Sur Windows :**
```bash
stop.bat
```

**Sur Mac/Linux :**
```bash
docker-compose down
```

## 🔧 Installation Développement (Sans Docker)

### Backend (Spring Boot)

1. **Prérequis :**
   - JDK 17 ou supérieur
   - Maven
   - MySQL installé et démarré

2. **Configuration :**
   - Créer la base de données `notes_db`
   - Exécuter les scripts SQL dans `script/`
   - Configurer `application.properties`

3. **Démarrer :**
   ```bash
   cd WS_ETU003103_ETU003248
   mvn spring-boot:run
   ```

### Frontend (Vue.js)

1. **Prérequis :**
   - Node.js 20+ 
   - npm

2. **Installation :**
   ```bash
   cd vue-project
   npm install
   ```

3. **Configuration :**
   Créer `.env` :
   ```env
   VITE_API_URL=http://localhost:3000
   ```

4. **Démarrer :**
   ```bash
   npm run dev
   ```
   
   Ouvrir http://localhost:5173

## 📱 Utilisation de l'Application

### Navigation

1. **Page de connexion**
   - Entrer email et mot de passe
   - Cliquer sur "Se connecter"

2. **Liste des semestres**
   - Voir S1, S2, S3, S4
   - Cliquer sur un semestre pour voir les étudiants

3. **Liste des étudiants**
   - Tableau avec nom, prénom, email
   - Colonnes moyennes S1-S4 (cliquables)
   - Cliquer sur un nom → détails de l'étudiant
   - Cliquer sur une moyenne → relevé du semestre

4. **Détails de l'étudiant**
   - Informations personnelles
   - Tableau des moyennes par semestre
   - Boutons "Relevé L1" et "Relevé L2"

5. **Relevé de notes (semestre)**
   - Format inspiré des relevés ITU
   - Liste des matières avec crédits et notes
   - Moyenne générale et résultat
   - Gestion des parcours pour S4

6. **Relevé annuel (L1/L2)**
   - L1 = Semestre 1 + Semestre 2
   - L2 = Semestre 3 + Semestre 4
   - Affichage séparé par semestre
   - Moyenne générale de l'année

### Fonctionnalités Spéciales

#### Parcours S4
Pour le semestre 4, trois parcours sont disponibles :
- **Développement**
- **Web et Design**
- **Bases de Données et Réseaux**

Chaque parcours a des matières obligatoires et optionnelles.

#### Clics sur les moyennes
Les moyennes dans le tableau des étudiants sont cliquables et affichent directement le relevé du semestre correspondant.

## 🐛 Résolution de Problèmes

### Erreur : Port déjà utilisé

**Port 8060 (Frontend) :**
```bash
# Modifier dans docker-compose.yml
ports:
  - "8081:80"  # Utiliser 8081 au lieu de 8060
```

**Port 3000 (API) :**
Modifier dans `.env` :
```env
API_PORT=3001
```

### Erreur : Docker not found

1. Installer Docker Desktop
2. S'assurer que Docker Desktop est démarré
3. Redémarrer le terminal

### Erreur : Base de données ne démarre pas

```bash
# Supprimer les volumes
docker-compose down -v
docker-compose up --build
```

### Frontend ne se connecte pas à l'API

Vérifier que l'URL de l'API est correcte dans `vue-project/.env` :
```env
VITE_API_URL=http://localhost:3000
```

### Erreur 401 (Unauthorized)

Le token JWT a peut-être expiré :
1. Se déconnecter
2. Se reconnecter

## 📊 Données de Test

### Étudiants
| ID | Nom | Prénom | Email | Parcours S4 |
|----|-----|--------|-------|-------------|
| 1 | Rakoto | Jean | jean.rakoto@univ.mg | Développement |
| 2 | Rasoa | Marie | marie.rasoa@univ.mg | Web et Design |
| 3 | Rabe | Paul | paul.rabe@univ.mg | BDD et Réseaux |

### Semestres
- **S1** : Tronc commun (6 matières)
- **S2** : Tronc commun (6 matières)
- **S3** : Tronc commun (6 matières)
- **S4** : Parcours spécialisés (matières obligatoires + optionnelles)

## 🔒 Sécurité

- Authentification par JWT
- Token valide 24 heures
- Routes protégées (redirection automatique vers login si non authentifié)

## 📝 Commandes Docker Utiles

```bash
# Voir les conteneurs en cours
docker ps

# Voir les logs
docker-compose logs -f

# Voir les logs d'un service spécifique
docker-compose logs -f frontend
docker-compose logs -f api
docker-compose logs -f db

# Redémarrer un service
docker-compose restart frontend

# Reconstruire sans cache
docker-compose build --no-cache
docker-compose up

# Supprimer tout et recommencer
docker-compose down -v
docker-compose up --build
```

## 📞 Support

Pour toute question ou problème :
- Vérifier ce guide
- Consulter les logs Docker
- Vérifier les fichiers de configuration (.env)

## ✅ Checklist de Vérification

Avant de signaler un problème, vérifier :

- [ ] Docker Desktop est installé et démarré
- [ ] Le fichier `.env` existe et est correctement configuré
- [ ] Les ports 3000, 3306 et 8060 sont libres
- [ ] Les conteneurs sont tous démarrés (`docker ps`)
- [ ] Aucune erreur dans les logs (`docker-compose logs`)

## 🎓 Projet Académique

**IT University Madagascar**  
Projet de gestion des notes étudiantes  
Novembre 2025

**Auteurs :**  
- ETU003103
- ETU003248
