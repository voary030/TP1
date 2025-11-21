# 🚀 DÉMARRAGE RAPIDE

## Sur un nouveau PC :

```bash
git clone https://github.com/voary030/TP1.git
cd TP1
docker-compose up -d
```

**✅ C'EST TOUT !**

Attendez 1-2 minutes que tout démarre, puis :

👉 **Ouvrez** http://localhost:5173

🔐 **Connectez-vous** avec :
- Email : `admin@univ.mg`
- Mot de passe : `AdminPass123!`

---

## Tester que tout fonctionne :

### Windows
```bash
test-deploiement.bat
```

### Arrêter l'application :
```bash
docker-compose down
```

### Redémarrer :
```bash
docker-compose up -d
```

---

## ✨ Fonctionnalités

1. **Liste des étudiants** avec moyennes S1 à S4
2. **Cliquer sur "Moyenne S4"** d'un étudiant
3. **Choisir un parcours** :
   - 📚 Développement
   - 🎨 Web et Design
   - 💾 Bases de Données et Réseaux
4. **Voir les notes** filtrées pour ce parcours

---

## 📊 Données incluses

- ✅ 3 étudiants complets
- ✅ 69 notes (S1=18, S2=18, S3=18, S4=15)
- ✅ 3 parcours S4
- ✅ Tous les semestres (S1, S2, S3, S4)

---

**Documentation complète** : voir `README.md`
