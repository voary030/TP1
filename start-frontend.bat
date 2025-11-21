@echo off
REM Script pour démarrer l'application Vue.js en mode développement avec mock data

echo.
echo ========================================
echo  Vue.js Notes App - Mode Développement
echo  (Mock API - Pas de backend requis!)
echo ========================================
echo.

cd vue-project

REM Vérifier si node_modules existe
if not exist node_modules (
    echo Installation des dépendances...
    call npm install
    echo.
)

echo Démarrage du serveur de développement...
echo.
echo L'application sera accessible sur: http://localhost:5173
echo.
echo Comptes de test:
echo   - jean.rakoto@univ.mg / ETU003103
echo   - marie.rasoa@univ.mg / ETU003248
echo   - paul.rabe@univ.mg / ETU003103
echo.
echo Appuyez sur Ctrl+C pour arrêter le serveur
echo.

call npm run dev

pause
