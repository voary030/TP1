@echo off
echo ========================================
echo  Installation des dependances Vue.js
echo ========================================
echo.

cd vue-project

if not exist "node_modules" (
    echo [INFO] Installation de npm...
    call npm install
    
    if %errorlevel% neq 0 (
        echo.
        echo [ERREUR] Echec de l'installation npm
        pause
        exit /b 1
    )
    
    echo.
    echo [OK] Dependencies installees avec succes!
) else (
    echo [INFO] node_modules existe deja
    echo Pour reinstaller: supprimez le dossier node_modules et relancez
)

echo.
echo ========================================
echo  Installation terminee!
echo ========================================
echo.
echo Pour demarrer en mode developpement:
echo   cd vue-project
echo   npm run dev
echo.
echo Pour demarrer avec Docker:
echo   cd ../WS_ETU003103_ETU003248
echo   start.bat
echo.
pause
