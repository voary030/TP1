@echo off
echo ========================================
echo    TEST DE DEPLOIEMENT - VERIFICATION
echo ========================================
echo.

echo [1/5] Verification des conteneurs Docker...
docker ps --format "table {{.Names}}\t{{.Status}}" | findstr notes_
echo.

echo [2/5] Verification de la base de donnees...
docker exec -it notes_db mysql -uroot -proot_password_123 notes_db -e "SELECT COUNT(*) as total_notes FROM note;" 2>nul
echo.

echo [3/5] Repartition des notes par semestre...
docker exec -it notes_db mysql -uroot -proot_password_123 notes_db -e "SELECT s.libelle, COUNT(n.id_note) as notes FROM note n JOIN Matiere m ON n.id_matiere = m.id_matiere JOIN semestre s ON m.id_semestre = s.id_semestre GROUP BY s.id_semestre ORDER BY s.id_semestre;" 2>nul
echo.

echo [4/5] Verification des parcours S4...
docker exec -it notes_db mysql -uroot -proot_password_123 notes_db -e "SELECT id_parcours, libelle FROM parcours;" 2>nul
echo.

echo [5/5] Test de l'API (Login)...
curl -s -X POST http://localhost:8060/api/auth/admin/login -H "Content-Type: application/json" -d "{\"email\":\"admin@univ.mg\",\"mot_de_passe\":\"AdminPass123!\"}" | findstr "success"
echo.

echo ========================================
echo    TESTS TERMINES
echo ========================================
echo.
echo Application disponible sur :
echo   - Frontend: http://localhost:5173
echo   - API:      http://localhost:8060
echo.
echo Identifiants :
echo   - Email:       admin@univ.mg
echo   - Mot de passe: AdminPass123!
echo.
pause
