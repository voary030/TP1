# Guide de test Frontend avec Mock Data

## 📋 Vue d'ensemble

Ce projet Vue.js est maintenant configuré pour fonctionner en mode **STANDALONE** sans backend requis. Tous les tests frontend peuvent être exécutés avec des données mock.

## 🚀 Démarrage rapide

### 1. Installation des dépendances

```bash
cd vue-project
npm install
```

### 2. Démarrer le serveur de développement

```bash
npm run dev
```

L'application sera accessible sur `http://localhost:5173`

### 3. Se connecter

Utilisez l'une de ces trois comptes de test :

| Email | Mot de passe | Nom |
|-------|-------------|------|
| jean.rakoto@univ.mg | ETU003103 | Jean Rakoto |
| marie.rasoa@univ.mg | ETU003248 | Marie Rasoa |
| paul.rabe@univ.mg | ETU003103 | Paul Rabe |

## 🔷 Mode Mock API

### Comment ça marche ?

- En mode **développement** (`npm run dev`), l'API mock est automatiquement utilisée
- Un message `🔷 Using MOCK API for ...` s'affiche dans la console à chaque appel
- Les requêtes simulent un délai réseau (300-500ms) pour plus de réalisme
- Les structures de données correspondent exactement à celles du vrai backend

### Structure des fichiers mock

```
src/services/
├── api.js          # Point d'entrée (auto-détecte mock/réel)
├── mockApi.js      # Implémentation du service mock
└── mockData.js     # Données de test
```

## 📊 Données disponibles

### Utilisateurs

3 profils d'étudiants avec historique complet :
- Jean Rakoto
- Marie Rasoa  
- Paul Rabe

### Semesters

- S1 (Semestre 1, L1)
- S2 (Semestre 2, L1)
- S3 (Semestre 3, L2)
- S4 (Semestre 4, L2)

### Parcours (S4 uniquement)

- Développement
- Web et Design
- Bases de Données et Réseaux

### Notes

Données complètes pour :
- S1 et S2 par étudiant
- S3 et S4 par étudiant
- Moyennes pour tous les semestres

## 🧪 Plan de test

### 1. Test de connexion

✅ Connectez-vous avec `jean.rakoto@univ.mg` / `ETU003103`  
✅ Vérifiez que le nom s'affiche en haut à droite  
✅ Testez la déconnexion (bouton logout)  
❌ Essayez avec mauvaises credentials (doit afficher une erreur)

### 2. Navigation semesters

✅ Cliquez sur chaque semestre (S1, S2, S3, S4)  
✅ Vérifiez l'affichage du titre et des infos du semestre

### 3. Liste des étudiants

✅ Consultez la table avec les 3 étudiants  
✅ Vérifiez les moyennes par semestre  
✅ Cliquez sur un étudiant pour voir les détails

### 4. Détails étudiant

✅ Voir les informations personnelles  
✅ Voir les moyennes par semestre  
✅ Accéder à la page de notes L1 via bouton

### 5. Notes de semestre (L1)

✅ Affichage du format ITU avec :
- En-tête avec infos étudiant
- Table des matières avec codes, crédits, notes
- Résumé (total crédits, moyenne, mention)

### 6. Notes année (L1 ou L2)

✅ Affichage des deux semestres côte à côte  
✅ Totaux cumulés correctement calculés  
✅ Format ITU complet pour chaque semestre

## 🛠️ Commandes utiles

```bash
# Démarrer le dev
npm run dev

# Builder pour production
npm run build

# Prévisualiser la build
npm run preview

# Voir les fichiers du projet
npm list
```

## 🔄 Basculer vers l'API réelle

Quand le backend est prêt :

1. Arrêtez le serveur de dev (`Ctrl+C`)
2. Démarrez-le en mode production (build + deploy)
3. Assurez-vous que l'API backend est accessible sur `http://localhost:3000`
4. Le code basculera automatiquement vers l'API réelle

**Alternative rapide :** Modifiez le fichier `src/services/api.js` ligne :
```javascript
const USE_MOCK_API = false  // Changez à false
```

## 📱 Responsive Design

L'application est responsive et fonctionne sur :
- 💻 Desktop (1920px+)
- 📱 Tablet (768px-1024px)
- 📱 Mobile (< 768px)

## 🐛 Debug

### Console du navigateur

Des messages 🔷 s'affichent dans la console pour chaque appel mock :
- `🔷 Using MOCK API for login`
- `🔷 Using MOCK API for getSemesters`
- etc.

Cela vous aide à vérifier :
- Quel endpoint est appelé
- À quel moment de la navigation

### Données temporelles

Les délais simulent le réseau :
- Login : 500ms
- Autres appels : 300-400ms

## ✨ Caractéristiques implémentées

- ✅ Authentification avec mock login
- ✅ Gestion d'état (Pinia store)
- ✅ Navigation protégée (guards)
- ✅ API service avec intercepteurs
- ✅ Gestion des erreurs
- ✅ Format ITU pour les relevés
- ✅ Responsive design
- ✅ Données de test réalistes

## 📝 Notes

- Les données mock sont **statiques** (pas de modification persistante)
- Les tokens sont **simulés** (contiennent juste un timestamp)
- Parfait pour développer et tester l'UI indépendamment du backend

Bon développement ! 🚀
