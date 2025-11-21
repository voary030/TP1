# 🚀 Guide Rapide - Test avec Postman

## ✅ Vérifications Complétées

- ✅ Docker démarré
- ✅ Application buildée avec succès
- ✅ Base de données créée
- ✅ Vues SQL créées : `vue_notes_detaillees` et `vue_moyennes_semestre`
- ✅ Données de test insérées
- ✅ Admin créé : admin@univ.mg / adminpass

## 📬 Tests Postman - Ordre à Suivre

### 1. Importer la Collection
Fichier : `postman/notes-api-complete-avec-vues.postman_collection.json`

### 2. Tester l'Authentification

#### A. Login Étudiant
```
POST http://localhost:8080/api/auth/login
Body:
{
    "email": "jean.rakoto@univ.mg",
    "password": "jeanpass"
}
```
✅ Le token sera automatiquement sauvegardé

#### B. Login Admin
```
POST http://localhost:8080/api/auth/admin/login
Body:
{
    "email": "admin@univ.mg",
    "mot_de_passe": "adminpass"
}
```
✅ Le token admin sera automatiquement sauvegardé

### 3. Tester les Vues - Étudiant

#### Mes Notes Détaillées
```
GET http://localhost:8080/api/vue-notes/mes-notes
Header: Authorization: Bearer {{studentToken}}
```

#### Mes Moyennes
```
GET http://localhost:8080/api/vue-notes/mes-moyennes
Header: Authorization: Bearer {{studentToken}}
```

#### Mes Notes par Semestre
```
GET http://localhost:8080/api/vue-notes/mes-notes/semestre/1
Header: Authorization: Bearer {{studentToken}}
```

### 4. Tester les Vues - Admin

#### Toutes les Notes
```
GET http://localhost:8080/api/vue-notes/admin/notes
Header: Authorization: Bearer {{adminToken}}
```

#### Toutes les Moyennes
```
GET http://localhost:8080/api/vue-notes/admin/moyennes
Header: Authorization: Bearer {{adminToken}}
```

#### Notes d'un Étudiant Spécifique
```
GET http://localhost:8080/api/vue-notes/admin/notes/etudiant/1
Header: Authorization: Bearer {{adminToken}}
```

### 5. Créer un Nouvel Étudiant (Admin)
```
POST http://localhost:8080/api/admin/students
Header: Authorization: Bearer {{adminToken}}
Body:
{
    "numero": "ETU004",
    "nom": "Nouveau",
    "prenom": "Étudiant",
    "email": "nouveau.etudiant@univ.mg",
    "mot_de_passe": "nouveaupass",
    "id_parcours": 1
}
```

## 🎯 Comptes de Test Disponibles

### Étudiants
- jean.rakoto@univ.mg / jeanpass (ID: 1)
- marie.rasoa@univ.mg / mariepass (ID: 2)
- paul.rabe@univ.mg / paulpass (ID: 3)

### Admins
- admin@univ.mg / adminpass (ID: 1)
- directeur@univ.mg / dirpass (ID: 2)

## ✨ Avantages des Vues

1. **Performance** : Jointures pré-calculées
2. **Simplicité** : Une seule requête pour toutes les infos
3. **Maintenance** : Logique SQL centralisée
4. **Données riches** : Notes + matières + semestres + parcours

## 🔍 Vérification MySQL

```powershell
# Voir les vues
docker exec notes_db mysql -uroot -proot_password_123 notes_db -e "SHOW FULL TABLES WHERE Table_type = 'VIEW';"

# Tester les vues
docker exec notes_db mysql -uroot -proot_password_123 notes_db -e "SELECT * FROM vue_notes_detaillees LIMIT 5;"
docker exec notes_db mysql -uroot -proot_password_123 notes_db -e "SELECT * FROM vue_moyennes_semestre;"
```

## 📊 Structure des Réponses

### Vue Notes Détaillées
```json
{
    "idEtudiant": 1,
    "nomEtudiant": "Rakoto",
    "prenomEtudiant": "Jean",
    "note": 15.50,
    "codeMatiere": "INF101",
    "libelleMatiere": "Programmation procédurale",
    "credit": 7.0,
    "libelleSemestre": "S1",
    "anneeUniversitaire": "2024-2025",
    "typeMatiere": "OBLIGATOIRE",
    "filiere": "Informatique"
}
```

### Vue Moyennes Semestre
```json
{
    "idEtudiant": 1,
    "nomEtudiant": "Rakoto",
    "prenomEtudiant": "Jean",
    "idSemestre": 4,
    "libelleSemestre": "S4",
    "anneeUniversitaire": "2024-2025",
    "nombreNotes": 5,
    "moyenneSemestre": 13.60,
    "totalCredits": 80.0,
    "creditsObtenus": 30.0
}
```

## 🎉 C'est Prêt !

Votre API est maintenant complète avec :
- ✅ Authentification JWT (étudiants + admins)
- ✅ Vues SQL optimisées
- ✅ Endpoints pour consulter les notes
- ✅ Endpoints pour gérer les étudiants
- ✅ Calcul automatique des moyennes
