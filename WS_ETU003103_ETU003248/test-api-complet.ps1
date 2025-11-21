# Script de test de l'API

$baseUrl = "http://localhost:3000"
$email = "jean.rakoto@univ.mg"
$password = "ETU003103"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Test de l'API - Gestion des Notes" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test 1: Login
Write-Host "[TEST 1] Connexion..." -ForegroundColor Yellow
$loginBody = @{
    email = $email
    password = $password
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri "$baseUrl/api/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
    $token = $loginResponse.data.token
    
    if ($token) {
        Write-Host "[OK] Connexion reussie! Token recu." -ForegroundColor Green
        Write-Host "Token: $($token.Substring(0, 20))..." -ForegroundColor Gray
    } else {
        Write-Host "[ERREUR] Pas de token recu" -ForegroundColor Red
        exit
    }
} catch {
    Write-Host "[ERREUR] Echec de connexion: $($_.Exception.Message)" -ForegroundColor Red
    exit
}

Write-Host ""

# Créer les headers avec le token
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

# Test 2: Liste des semestres
Write-Host "[TEST 2] Recuperation des semestres..." -ForegroundColor Yellow
try {
    $semestres = Invoke-RestMethod -Uri "$baseUrl/api/semesters" -Headers $headers
    Write-Host "[OK] $($semestres.data.Count) semestres trouves:" -ForegroundColor Green
    foreach ($sem in $semestres.data) {
        Write-Host "  - $($sem.name)" -ForegroundColor Gray
    }
} catch {
    Write-Host "[ERREUR] $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Test 3: Liste des étudiants
Write-Host "[TEST 3] Recuperation des etudiants..." -ForegroundColor Yellow
try {
    $students = Invoke-RestMethod -Uri "$baseUrl/api/students" -Headers $headers
    Write-Host "[OK] $($students.data.Count) etudiants trouves:" -ForegroundColor Green
    foreach ($student in $students.data) {
        Write-Host "  - $($student.firstName) $($student.lastName)" -ForegroundColor Gray
        Write-Host "    S1: $($student.s1Average) | S2: $($student.s2Average) | S3: $($student.s3Average) | S4: $($student.s4Average)" -ForegroundColor Gray
    }
} catch {
    Write-Host "[ERREUR] $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Test 4: Détails d'un étudiant
Write-Host "[TEST 4] Details de l'etudiant (ID: 1)..." -ForegroundColor Yellow
try {
    $studentDetail = Invoke-RestMethod -Uri "$baseUrl/api/students/1" -Headers $headers
    Write-Host "[OK] Details recus:" -ForegroundColor Green
    Write-Host "  Nom: $($studentDetail.data.firstName) $($studentDetail.data.lastName)" -ForegroundColor Gray
    Write-Host "  Email: $($studentDetail.data.email)" -ForegroundColor Gray
    Write-Host "  Moyennes:" -ForegroundColor Gray
    foreach ($avg in $studentDetail.data.semesterAverages.GetEnumerator()) {
        Write-Host "    $($avg.Key): $($avg.Value)" -ForegroundColor Gray
    }
} catch {
    Write-Host "[ERREUR] $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Test 5: Notes d'un semestre
Write-Host "[TEST 5] Notes du semestre 1 pour etudiant 1..." -ForegroundColor Yellow
try {
    $semesterGrades = Invoke-RestMethod -Uri "$baseUrl/api/students/1/semesters/1/grades" -Headers $headers
    Write-Host "[OK] Notes du semestre recuperees:" -ForegroundColor Green
    Write-Host "  Moyenne: $($semesterGrades.data.summary.average)" -ForegroundColor Gray
    Write-Host "  Credits: $($semesterGrades.data.summary.totalCredits)" -ForegroundColor Gray
    Write-Host "  Admis: $($semesterGrades.data.summary.passed)" -ForegroundColor Gray
} catch {
    Write-Host "[ERREUR] $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Test 6: Notes d'une année
Write-Host "[TEST 6] Notes de l'annee L1 (S1+S2) pour etudiant 1..." -ForegroundColor Yellow
try {
    $yearGrades = Invoke-RestMethod -Uri "$baseUrl/api/students/1/years/1/grades" -Headers $headers
    Write-Host "[OK] Notes de l'annee recuperees:" -ForegroundColor Green
    Write-Host "  Moyenne annuelle: $($yearGrades.data.summary.average)" -ForegroundColor Gray
    Write-Host "  Credits totaux: $($yearGrades.data.summary.totalCredits)" -ForegroundColor Gray
    Write-Host "  Nombre de semestres: $($yearGrades.data.semesters.Count)" -ForegroundColor Gray
} catch {
    Write-Host "[ERREUR] $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Tests termines!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pour tester via le frontend:" -ForegroundColor Yellow
Write-Host "  1. Ouvrir http://localhost:8060" -ForegroundColor White
Write-Host "  2. Se connecter avec:" -ForegroundColor White
Write-Host "     Email: $email" -ForegroundColor White
Write-Host "     Password: $password" -ForegroundColor White
Write-Host ""
