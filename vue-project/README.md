# Application de Gestion des Notes - IT University (Frontend Vue.js)

Application complète de gestion des notes étudiantes avec frontend Vue.js 3 et backend Spring Boot.

## 🎯 Fonctionnalités

### Frontend Vue.js
- ✅ Authentification JWT
- ✅ Liste des semestres (S1 à S4)
- ✅ Liste des étudiants avec moyennes S1-S4
- ✅ Détails de l'étudiant
- ✅ Relevés de notes par semestre (inspiré ITU)
- ✅ Relevés annuels L1 (S1+S2) et L2 (S3+S4)
- ✅ Gestion des parcours pour S4 (Développement, Web et Design, BDD et Réseaux)

## 🚀 Démarrage rapide

### Installation des dépendances
```bash
npm install
```

### Développement
```bash
npm run dev
```

### Build pour production
```bash
npm run build
```

### Preview production
```bash
npm run preview
```

## 🐳 Démarrage avec Docker

Depuis le dossier racine du projet :
```bash
cd ../WS_ETU003103_ETU003248
docker-compose up --build
```

L'application sera accessible sur :
- Frontend: http://localhost:8080
- API: http://localhost:3000

## 👤 Comptes de test

| Email | Mot de passe |
|-------|-------------|
| jean.rakoto@univ.mg | ETU003103 |
| marie.rasoa@univ.mg | ETU003248 |

## 📱 Navigation

1. **Login** → Connexion avec email/password
2. **Semestres** → Liste S1-S4
3. **Étudiants** → Tableau avec moyennes (cliquables)
4. **Détails étudiant** → Infos + liens L1/L2
5. **Relevés** → Notes par semestre ou année

## 🛠️ Technologies

- Vue.js 3 (Composition API)
- Vue Router 4
- Pinia (state management)
- Axios (HTTP client)
- Vite
- Docker + Nginx

## 📝 Configuration

Créer un fichier `.env` :
```env
VITE_API_URL=http://localhost:3000
```

## 👥 Auteurs

ETU003103 & ETU003248 - IT University Madagascar

npm run dev
```

### Compile and Minify for Production

```sh
npm run build
```
