@echo off
REM Script pour générer les mots de passe hashés BCrypt

echo.
echo ========================================
echo  Générateur de Hash BCrypt
echo ========================================
echo.
echo Ce script génère les hashs BCrypt pour les mots de passe admin
echo.

cd WS_ETU003103_ETU003248

echo Compilation et exécution...
echo.

mvn exec:java -Dexec.mainClass="mg.itu.notesapi.PasswordHashGenerator"

echo.
echo ========================================
echo Copiez les hashs générés ci-dessus
echo et utilisez-les dans votre base MySQL
echo ========================================
echo.

pause
