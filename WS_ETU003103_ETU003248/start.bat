@echo off
echo ========================================
echo  Demarrage de l'application Notes ITU
echo ========================================
echo.

REM Verifier si Docker est installe
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERREUR] Docker n'est pas installe ou n'est pas dans le PATH
    echo Veuillez installer Docker Desktop
    pause
    exit /b 1
)

echo [INFO] Docker est installe
echo.

REM Verifier si le fichier .env existe
if not exist ".env" (
    echo [ATTENTION] Fichier .env non trouve
    echo Creation du fichier .env depuis .env.example...
    copy .env.example .env
    echo.
    echo [INFO] Fichier .env cree. Vous pouvez le modifier si necessaire.
    echo.
)

echo [INFO] Demarrage des conteneurs Docker...
echo.

docker-compose down
docker-compose up --build -d

if %errorlevel% neq 0 (
    echo.
    echo [ERREUR] Echec du demarrage des conteneurs
    pause
    exit /b 1
)

echo.
echo ========================================
echo  Application demarree avec succes!
echo ========================================
echo.
echo Frontend Vue.js : http://localhost:8080
echo API Spring Boot : http://localhost:3000
echo Base de donnees  : localhost:3306
echo.
echo Comptes de test:
echo   - jean.rakoto@univ.mg / ETU003103
echo   - marie.rasoa@univ.mg / ETU003248
echo.
echo Pour arreter l'application: docker-compose down
echo Pour voir les logs: docker-compose logs -f
echo.
pause
