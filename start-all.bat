@echo off
REM Script pour préparer et démarrer le système complet (Backend + Frontend)

echo.
echo ========================================
echo  Démarrage Backend + Frontend
echo ========================================
echo.

REM Étape 1: Vérifier que le backend est prêt
echo [1/3] Vérification du backend...
cd WS_ETU003103_ETU003248

if not exist "target" (
    echo Compilation du backend...
    call mvn clean package -DskipTests
)

echo.
echo [2/3] Démarrage du backend Docker...
call start.bat

echo Attente du démarrage du backend (30 secondes)...
timeout /t 30 /nobreak

echo.
echo [3/3] Démarrage du frontend...
cd ..\vue-project

if not exist "node_modules" (
    echo Installation des dépendances npm...
    call npm install
)

echo.
echo Démarrage du serveur de développement Vue.js...
echo.
echo Backend: http://localhost:8060
echo Frontend: http://localhost:5173
echo.
echo Comptes de test:
echo   - admin@univ.mg / AdminPass123!
echo   - secretaire@univ.mg / SecPass123!
echo.

call npm run dev

pause
