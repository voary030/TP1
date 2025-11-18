# Notes API - Spring Boot - Guide de Démarrage Rapide

## 🚀 Démarrage Rapide avec Docker

### 1. Configuration de l'environnement

Copiez le fichier `.env.example` en `.env` et ajustez les valeurs si nécessaire :

```powershell
Copy-Item .env.example .env
```

### 2. Lancer l'application avec Docker Compose

```powershell
docker compose up -d
```

Cette commande va :
- ✅ Créer et démarrer la base de données MySQL
- ✅ Exécuter les scripts de migration (`script.sql` et `data.sql`)
- ✅ Builder l'application Spring Boot
- ✅ Démarrer l'API sur le port 3000

### 3. Vérifier que tout fonctionne

```powershell
# Vérifier les conteneurs
docker compose ps

# Vérifier les logs
docker compose logs -f app

# Tester le health check
curl http://localhost:3000/actuator/health
```

### 4. Mettre à jour les mots de passe

Les mots de passe doivent être hashés avec BCrypt. Connectez-vous à MySQL et exécutez :

```powershell
docker compose exec db mysql -u notes_user -p notes_db
```

Puis exécutez le contenu de `script/update_passwords.sql`.

### 5. Tester l'authentification

Utilisez Postman ou curl :

```powershell
# Login
curl -X POST http://localhost:3000/api/auth/login `
  -H "Content-Type: application/json" `
  -d '{\"email\":\"rakoto@ituniv.mg\",\"password\":\"password123\"}'
```

Réponse attendue :
```json
{
  "status": "success",
  "data": {
    "token": "eyJhbGciOiJIUzI1NiJ9...",
    "expiresIn": "24h",
    "student": {
      "id": 1,
      "firstName": "Jean",
      "lastName": "Rakoto",
      "email": "rakoto@ituniv.mg"
    }
  },
  "meta": {
    "timestamp": "2024-01-20T10:30:00Z",
    "version": "1.0"
  }
}
```

### 6. Récupérer les notes

```powershell
# Notes d'un semestre (S1)
curl -X GET http://localhost:3000/api/students/1/semesters/1/grades `
  -H "Authorization: Bearer YOUR_TOKEN_HERE"

# Notes d'une année (L1 = S1 + S2)
curl -X GET http://localhost:3000/api/students/1/years/1/grades `
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## 🛠️ Développement Local (sans Docker)

### Prérequis

- Java 17 ou supérieur
- Maven 3.9+
- MySQL 8.0+

### 1. Créer la base de données

```sql
CREATE DATABASE notes_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'notes_user'@'localhost' IDENTIFIED BY 'notes_pass_456';
GRANT ALL PRIVILEGES ON notes_db.* TO 'notes_user'@'localhost';
FLUSH PRIVILEGES;
```

### 2. Exécuter les scripts de migration

```bash
mysql -u notes_user -p notes_db < script/script.sql
mysql -u notes_user -p notes_db < script/data.sql
mysql -u notes_user -p notes_db < script/update_passwords.sql
```

### 3. Configurer les variables d'environnement

```powershell
$env:DB_HOST="localhost"
$env:DB_PORT="3306"
$env:DB_NAME="notes_db"
$env:DB_USER="notes_user"
$env:DB_PASSWORD="notes_pass_456"
$env:API_PORT="3000"
$env:JWT_SECRET="your_super_secret_key_change_this_in_production_123456789"
```

### 4. Builder et lancer l'application

```powershell
# Compiler le projet
mvn clean package -DskipTests

# Lancer l'application
java -jar target/notes-api-1.0.0.jar
```

Ou directement avec Maven :

```powershell
mvn spring-boot:run
```

## 📦 Structure du Projet

```
TP1/
├── src/main/java/mg/itu/notesapi/
│   ├── NotesApiApplication.java        # Point d'entrée
│   ├── config/
│   │   └── SecurityConfig.java         # Configuration Spring Security
│   ├── controller/
│   │   ├── AuthController.java         # POST /api/auth/login
│   │   └── GradeController.java        # GET /api/students/{id}/...
│   ├── dto/
│   │   ├── ApiResponse.java            # Wrapper générique
│   │   ├── LoginRequest.java           # DTO login
│   │   ├── LoginResponse.java          # DTO token
│   │   └── SemesterGradesResponse.java # DTO notes
│   ├── entity/
│   │   ├── Etudiant.java               # Table Etudiant
│   │   ├── Semestre.java               # Table semestre
│   │   ├── Parcours.java               # Table parcours
│   │   ├── Matiere.java                # Table Matiere
│   │   ├── Note.java                   # Table note
│   │   └── AuthToken.java              # Table auth_token
│   ├── exception/
│   │   ├── ApiException.java           # Exception custom
│   │   ├── ErrorCodes.java             # Codes d'erreur
│   │   └── GlobalExceptionHandler.java # Gestionnaire global
│   ├── repository/
│   │   ├── EtudiantRepository.java     # Requêtes étudiant
│   │   ├── NoteRepository.java         # Requêtes notes
│   │   └── AuthTokenRepository.java    # Requêtes tokens
│   ├── security/
│   │   └── JwtAuthenticationFilter.java # Filtre JWT
│   ├── service/
│   │   ├── AuthService.java            # Logique authentification
│   │   └── GradeService.java           # Logique notes
│   └── util/
│       └── JwtUtil.java                # Utilitaire JWT
├── src/main/resources/
│   └── application.properties          # Configuration Spring
├── script/
│   ├── script.sql                      # Schéma DB
│   ├── data.sql                        # Données initiales
│   └── update_passwords.sql            # Hashage BCrypt
├── postman/
│   ├── notes-api.postman_collection.json
│   └── notes-api.postman_environment.json
├── Dockerfile                          # Multi-stage build
├── docker-compose.yml                  # Orchestration
├── pom.xml                             # Configuration Maven
└── README.md                           # Documentation

```

## 🧪 Tests avec Postman

1. Importer la collection : `postman/notes-api.postman_collection.json`
2. Importer l'environnement : `postman/notes-api.postman_environment.json`
3. Exécuter la collection dans l'ordre :
   - **Authentication** → Login Success (enregistre le token automatiquement)
   - **Grades - Semester** → Tous les tests
   - **Grades - Year** → Tous les tests

## 🐛 Dépannage

### Erreur de connexion MySQL

```
Caused by: java.sql.SQLException: Access denied for user 'notes_user'@'172.x.x.x'
```

**Solution** : Vérifier les variables d'environnement dans `.env` et redémarrer :

```powershell
docker compose down
docker compose up -d
```

### Port déjà utilisé

```
Error starting ApplicationContext. To display the conditions report re-run your application with 'debug' enabled.
Binding to target failed: java.net.BindException: Address already in use
```

**Solution** : Changer le port dans `.env` :

```
API_PORT=3001
```

### Token invalide

```json
{
  "status": "error",
  "error": {
    "code": "AUTH_002",
    "message": "Token invalide ou expiré"
  }
}
```

**Solution** : Se reconnecter via `/api/auth/login` pour obtenir un nouveau token.

### Erreur de build Maven

```
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-compiler-plugin:3.11.0:compile
```

**Solution** : Vérifier que Java 17+ est installé :

```powershell
java -version
```

Si besoin, installer [OpenJDK 17](https://adoptium.net/).

## 📚 Documentation API

Voir `API_DOCUMENTATION.md` pour la documentation complète des endpoints avec :
- Format de requête/réponse
- Codes d'erreur
- Exemples curl
- Règles de validation

## 🔐 Sécurité

- ✅ JWT avec expiration 24h
- ✅ Mots de passe hashés avec BCrypt (cost 10)
- ✅ Tokens stockés en base avec statut actif/inactif
- ✅ HTTPS recommandé en production
- ✅ Variables sensibles dans `.env` (non versionnées)

## 📄 Licence

Projet académique - IT University Madagascar - S5 Web Services
