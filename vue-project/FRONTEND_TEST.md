# 🧪 Guide de Test Frontend avec Mock Data

## Pour les développeurs frontend

Tu es maintenant prêt à tester l'application **sans avoir le backend qui tourne** !

### Démarrage ultra-rapide (Windows)

```bash
# Option 1 : Double-cliquez sur start-frontend.bat
# Option 2 : Commande manuelle
cd vue-project
npm install
npm run dev
```

### Accès à l'app

Ouvre : **http://localhost:5173**

### Comptes de test disponibles

```
Email	Mot de passe	Rôle
admin@univ.mg	AdminPass123!	ADMIN
secretaire@univ.mg	SecPass123!	USER
```

### Comment testez l'app

1. **Connexion** → Essayez un compte de test
2. **Dashboard semesters** → Cliquez sur S1, S2, S3, S4
3. **Liste des étudiants** → Voir les 3 profils avec moyennes
4. **Détails étudiant** → Infos personnelles + moyennes
5. **Notes L1** → Voir les notes formatées ITU
6. **Notes L2** → Voir S3+S4 combinés
7. **Déconnexion** → Retour à la connexion

### Vérifier que ça marche

Ouvre la console du navigateur (F12) :
- Tu dois voir des messages `🔷 Using MOCK API for ...`
- Les délais simulent un vrai réseau (~300-500ms)
- Aucune erreur 401 (sauf si mauvais identifiant)

### Données dispo

- ✅ 4 semestres (S1, S2, S3, S4)
- ✅ 3 étudiants avec historique complet
- ✅ Notes pour chaque semestre (20+ matières)
- ✅ Parcours S4 (Développement, Web&Design, BDD&Réseaux)
- ✅ Calculs automatiques (moyennes, crédits, mentions)

### C'est tout !

**Aucun backend ne doit tourner.** Le mock API simule tout.

Quand tu auras besoin du vrai backend, on changera juste une ligne dans `src/services/api.js`

Bon développement ! 🚀
