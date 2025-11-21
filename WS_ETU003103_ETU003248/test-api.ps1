# Script de test de l'API Notes

Write-Host "=== Test de l'API Notes ===" -ForegroundColor Cyan

# Test 1 : Health Check
Write-Host "`n1. Test Health Check..." -ForegroundColor Yellow
try {
    $health = Invoke-RestMethod -Uri "http://localhost:3000/actuator/health" -Method GET
    Write-Host "✓ Health Check OK" -ForegroundColor Green
    $health | ConvertTo-Json
} catch {
    Write-Host "✗ Health Check échoué: $_" -ForegroundColor Red
}

# Test 2 : Login
Write-Host "`n2. Test Login..." -ForegroundColor Yellow
$loginBody = @{
    email = "rakoto@ituniv.mg"
    password = "password123"
} | ConvertTo-Json

try {
    $loginResponse = Invoke-RestMethod -Uri "http://localhost:3000/api/auth/login" `
        -Method POST `
        -ContentType "application/json" `
        -Body $loginBody
    
    Write-Host "✓ Login réussi" -ForegroundColor Green
    $token = $loginResponse.data.token
    Write-Host "Token: $($token.Substring(0, 20))..." -ForegroundColor Cyan
    
    # Test 3 : Récupérer les notes du semestre 1
    Write-Host "`n3. Test Notes Semestre 1..." -ForegroundColor Yellow
    $headers = @{
        Authorization = "Bearer $token"
    }
    
    $gradesS1 = Invoke-RestMethod -Uri "http://localhost:3000/api/students/1/semesters/1/grades" `
        -Method GET `
        -Headers $headers
    
    Write-Host "✓ Notes S1 récupérées" -ForegroundColor Green
    Write-Host "Étudiant: $($gradesS1.data.student.firstName) $($gradesS1.data.student.lastName)" -ForegroundColor Cyan
    Write-Host "Semestre: $($gradesS1.data.semester.name)" -ForegroundColor Cyan
    Write-Host "Nombre de matières: $($gradesS1.data.grades.Count)" -ForegroundColor Cyan
    Write-Host "Moyenne: $($gradesS1.data.summary.average)/20" -ForegroundColor Cyan
    Write-Host "Crédits totaux: $($gradesS1.data.summary.totalCredits)" -ForegroundColor Cyan
    
    # Test 4 : Récupérer les notes de l'année 1 (L1)
    Write-Host "`n4. Test Notes Année 1 (L1)..." -ForegroundColor Yellow
    $gradesL1 = Invoke-RestMethod -Uri "http://localhost:3000/api/students/1/years/1/grades" `
        -Method GET `
        -Headers $headers
    
    Write-Host "✓ Notes L1 récupérées" -ForegroundColor Green
    Write-Host "Année: $($gradesL1.data.semester.name)" -ForegroundColor Cyan
    Write-Host "Nombre de matières: $($gradesL1.data.grades.Count)" -ForegroundColor Cyan
    Write-Host "Moyenne générale: $($gradesL1.data.summary.average)/20" -ForegroundColor Cyan
    
    # Test 5 : Récupérer les notes S4 avec parcours
    Write-Host "`n5. Test Notes Semestre 4 (avec parcours)..." -ForegroundColor Yellow
    $gradesS4 = Invoke-RestMethod -Uri "http://localhost:3000/api/students/1/semesters/4/grades" `
        -Method GET `
        -Headers $headers
    
    Write-Host "✓ Notes S4 récupérées" -ForegroundColor Green
    Write-Host "Semestre: $($gradesS4.data.semester.name)" -ForegroundColor Cyan
    Write-Host "Parcours: $($gradesS4.data.track.name)" -ForegroundColor Cyan
    Write-Host "Nombre de matières: $($gradesS4.data.grades.Count)" -ForegroundColor Cyan
    
    Write-Host "`n=== TOUS LES TESTS RÉUSSIS ===" -ForegroundColor Green
    
} catch {
    Write-Host "✗ Erreur: $_" -ForegroundColor Red
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "Réponse: $responseBody" -ForegroundColor Red
    }
}
