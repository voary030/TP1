# 🎯 Guide Visuel - Connexion Backend-Frontend

Guide illustré de l'architecture et du flux de connexion.

---

## 📐 Architecture Système

```
┌─────────────────────────────────────────────────────────────────┐
│                     ENVIRONNEMENT LOCAL                          │
└─────────────────────────────────────────────────────────────────┘

┌──────────────────┐         ┌──────────────────┐         ┌──────────────────┐
│   NAVIGATEUR     │         │   BACKEND API    │         │   BASE DONNEES   │
│   localhost:5173 │ ◄─────► │  localhost:8060  │ ◄─────► │  MySQL:3306      │
│                  │  HTTP   │                  │  JDBC   │                  │
│  Vue.js 3 + Vite │  CORS   │  Spring Boot 3   │  SQL    │  Docker MySQL    │
│                  │  JWT    │  Spring Security │         │                  │
└──────────────────┘         └──────────────────┘         └──────────────────┘
        │                             │                            │
        │                             │                            │
    [axios]                      [RestAPI]                    [JPA/ORM]
        │                             │                            │
        └─────────── JSON ────────────┘                            │
                                                                   │
                                                              [données]
                                                              • users
                                                              • students  
                                                              • grades
                                                              • semesters
```

---

## 🔄 Flux d'Authentification

```
┌─────────────┐                                    ┌─────────────┐
│  FRONTEND   │                                    │   BACKEND   │
│  (Vue.js)   │                                    │ (Spring)    │
└─────────────┘                                    └─────────────┘

[1] USER clique "Se connecter"
     │
     ├─► email: admin@univ.mg
     └─► password: AdminPass123!
                │
                ▼
[2] api.login({ email, mot_de_passe })
                │
                │ POST /api/auth/admin/login
                └──────────────────────────────────────►
                                                         │
                                               [3] Recherche user
                                                    WHERE email=...
                                                         │
                                               [4] BCrypt.matches()
                                                    password vs hash
                                                         │
                                               [5] Si OK: générer JWT
                                                    token = jwtUtil.generate()
                                                         │
                ◄────────────────────────────────────────┘
                │
[6] { token, expiresIn, user: {...} }
                │
[7] localStorage.setItem('token', token)
    localStorage.setItem('user', JSON.stringify(user))
                │
[8] router.push('/students')
                │
                ▼
[9] Toutes les requêtes suivantes:
    headers: { Authorization: `Bearer ${token}` }
```

---

## 🔐 Sécurité JWT

```
┌────────────────────────────────────────────────────────────────┐
│                     JWT TOKEN LIFECYCLE                         │
└────────────────────────────────────────────────────────────────┘

[LOGIN]
    └─► Backend génère JWT
         │
         ├─► Header: { alg: "HS512", typ: "JWT" }
         ├─► Payload: { sub: "admin@univ.mg", exp: 1234567890 }
         └─► Signature: HMACSHA512(header + payload, SECRET_KEY)
                │
                ▼
         Token: eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1...
                │
                ▼
         Frontend stocke dans localStorage

[REQUETES SUIVANTES]
    └─► Frontend envoie:
         Authorization: Bearer eyJhbGciOiJIUzUxMiJ9...
                │
                ▼
         Backend vérifie:
         ├─► Token expiré? → 401 Unauthorized
         ├─► Signature valide? → Continue
         └─► User existe? → OK

[LOGOUT]
    └─► Frontend supprime localStorage
         Backend ne garde pas de session (stateless)
```

---

## 🌐 Flux des Requêtes API

```
┌──────────────────────────────────────────────────────────────────┐
│                   EXEMPLE: LISTE ETUDIANTS                        │
└──────────────────────────────────────────────────────────────────┘

[1] User clique "/students"
         │
         ▼
[2] Component: StudentsView.vue
         │
         └─► onMounted() → api.getAllStudentsAverages()
                    │
                    ▼
[3] axios.get('http://localhost:8060/api/students')
    headers: { Authorization: `Bearer ${token}` }
         │
         └──────────────────────────────────────►
                                                  │
                                        [4] JwtAuthFilter
                                             validateToken()
                                                  │
                                        [5] StudentController
                                             @GetMapping("/api/students")
                                                  │
                                        [6] StudentService
                                             findAllStudentsWithAverages()
                                                  │
                                        [7] StudentRepository
                                             JPA Query → MySQL
                                                  │
         ◄──────────────────────────────────────┘
         │
[8] Response: [
      { id: 1, firstName: "Jean", lastName: "RAKOTO",
        s1Average: 14.5, s2Average: 13.2, ... },
      ...
    ]
         │
         ▼
[9] Vue reactive: students.value = response.data
         │
         ▼
[10] Template affiche la liste
```

---

## 📊 Diagramme Base de Données

```
┌──────────────┐         ┌──────────────┐         ┌──────────────┐
│    USERS     │         │   STUDENTS   │         │   GRADES     │
├──────────────┤         ├──────────────┤         ├──────────────┤
│ id_user (PK) │         │ id (PK)      │         │ id (PK)      │
│ username     │         │ first_name   │         │ student_id───┼──┐
│ email        │         │ last_name    │         │ semester_id  │  │
│ mot_de_passe │         │ email        │         │ subject_id   │  │
│ role (ADMIN) │         │ birth_date   │         │ note         │  │
└──────────────┘         │ birth_place  │         │ credit       │  │
                         │ registration │         └──────────────┘  │
                         └──────────────┘                           │
                                │                                   │
                                └───────────────────────────────────┘
                                          1:N relationship

┌──────────────┐         ┌──────────────┐
│  SEMESTERS   │         │   SUBJECTS   │
├──────────────┤         ├──────────────┤
│ id (PK)      │         │ id (PK)      │
│ code (S1...)│         │ code         │
│ designation  │         │ designation  │
│ academic_year│         │ semester_id  │
└──────────────┘         │ credit       │
                         │ parcours     │
                         └──────────────┘
```

---

## 🎨 Hiérarchie Composants Frontend

```
App.vue
  │
  ├─► router-view
       │
       ├─► LoginView.vue
       │    │
       │    └─► [form login]
       │
       ├─► StudentsView.vue
       │    │
       │    ├─► LoadingSpinner (si chargement)
       │    └─► Liste étudiants
       │         └─► [click] → StudentDetailView
       │
       ├─► StudentDetailView.vue
       │    │
       │    ├─► BackButton (retour /students)
       │    ├─► StudentInfoSection (infos étudiant)
       │    └─► Liste semestres/années
       │         ├─► [S1-S4] → SemesterGradesView
       │         └─► [L1-L2] → YearGradesView
       │
       ├─► SemesterGradesView.vue
       │    │
       │    ├─► BackButton
       │    ├─► TranscriptHeader
       │    ├─► StudentInfoSection
       │    ├─► GradesTable
       │    ├─► TranscriptSummary
       │    └─► TranscriptFooter
       │
       └─► YearGradesView.vue
            │
            ├─► BackButton
            ├─► TranscriptHeader
            ├─► StudentInfoSection
            ├─► GradesTable (S1)
            ├─► GradesTable (S2)
            ├─► TranscriptSummary
            └─► TranscriptFooter
```

---

## 🔄 Cycle de Vie Requête

```
┌─────────────────────────────────────────────────────────────────┐
│          TIMELINE D'UNE REQUETE API COMPLETE                     │
└─────────────────────────────────────────────────────────────────┘

T=0ms     │ User clique
          │
T=5ms     │ Vue Router navigation
          │
T=10ms    │ Component onMounted()
          │
T=15ms    │ api.getStudentGrades(id, semesterId)
          │
T=20ms    │ Axios interceptor: ajout Authorization header
          │
T=25ms    ├──► HTTP GET localhost:8060/api/students/1/semesters/1/grades
          │
T=50ms    │    Backend: JwtAuthFilter → SecurityContext
          │
T=75ms    │    Backend: StudentController.getStudentGradesBySemester()
          │
T=100ms   │    Backend: GradeService.findGradesByStudentAndSemester()
          │
T=150ms   │    Backend: SQL Query → MySQL
          │
T=200ms   │    MySQL: Retourne résultats (JOIN students+grades+subjects)
          │
T=225ms   │    Backend: Map entities → DTOs
          │
T=250ms   │    Backend: return ResponseEntity.ok(dtos)
          │
T=275ms   ◄──┤ HTTP 200 + JSON response
          │
T=280ms   │ Axios interceptor: response handler
          │
T=285ms   │ Vue reactive: grades.value = response.data
          │
T=290ms   │ Vue re-render: template update
          │
T=300ms   │ Browser: DOM paint
          │
T=310ms   │ User voit les données 
          │
          ▼ COMPLETE (Total: ~310ms)
```

---

## 🛡️ Gestion Erreurs

```
┌─────────────────────────────────────────────────────────────────┐
│                    ERROR HANDLING FLOW                           │
└─────────────────────────────────────────────────────────────────┘

[FRONTEND SIDE]

try {
  const response = await api.login(credentials)
  → SUCCESS: store token, redirect
}
catch (error) {
  │
  ├─► error.response.status === 401
  │    → "Email ou mot de passe incorrect"
  │
  ├─► error.response.status === 403
  │    → "Accès refusé"
  │
  ├─► error.response.status === 500
  │    → "Erreur serveur"
  │
  └─► error.code === 'ERR_NETWORK'
       → "Backend non accessible"
}

[AXIOS INTERCEPTOR]

response.interceptor(error => {
  if (error.response.status === 401) {
    authStore.logout()           // Clear localStorage
    router.push('/login')        // Redirect
  }
  return Promise.reject(error)
})

[BACKEND SIDE]

@RestControllerAdvice
class GlobalExceptionHandler {
  
  @ExceptionHandler(BadCredentialsException)
  → 401 Unauthorized
  
  @ExceptionHandler(AccessDeniedException)
  → 403 Forbidden
  
  @ExceptionHandler(EntityNotFoundException)
  → 404 Not Found
  
  @ExceptionHandler(Exception)
  → 500 Internal Server Error
}
```

---

## 📦 Structure des Données

```
┌─────────────────────────────────────────────────────────────────┐
│                    DTO EXAMPLES (JSON)                           │
└─────────────────────────────────────────────────────────────────┘

[LoginResponse]
{
  "token": "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbi...",
  "expiresIn": 86400000,
  "user": {
    "id": 1,
    "email": "admin@univ.mg",
    "firstName": "Admin",
    "lastName": "Bureau",
    "role": "ADMIN"
  }
}

[StudentAveragesDto]
{
  "id": 1,
  "firstName": "Jean",
  "lastName": "RAKOTO",
  "email": "jean.rakoto@univ.mg",
  "s1Average": 14.50,
  "s2Average": 13.20,
  "s3Average": 15.10,
  "s4Average": 14.80
}

[GradeDto]
{
  "id": 1,
  "subjectCode": "INF101",
  "subjectName": "Programmation I",
  "note": 16.50,
  "credit": 5,
  "session": "Session Normale",
  "noteRecap": 16.50
}

[TranscriptDto]
{
  "student": { ... },
  "semester": { code: "S1", designation: "Semestre 1" },
  "grades": [ ... ],
  "totalCredits": 30,
  "obtainedCredits": 28,
  "average": 14.25,
  "result": "Admis",
  "mention": "Assez Bien"
}
```

---

## 🎯 Points de Configuration Critiques

```
┌─────────────────────────────────────────────────────────────────┐
│               CONFIGURATION CHECKLIST                            │
└─────────────────────────────────────────────────────────────────┘

[1] vue-project/.env
    ✓ VITE_API_URL=http://localhost:8060
    ✓ VITE_USE_MOCK_API=false

[2] WS_ETU003103_ETU003248/.env
    ✓ API_PORT=8060
    ✓ DB_HOST=localhost
    ✓ DB_PORT=3306
    ✓ DB_NAME=notes_db
    ✓ DB_USER=notes_user
    ✓ DB_PASSWORD=notes2024
    ✓ JWT_SECRET=<secret_key>

[3] SecurityConfig.java
    ✓ .requestMatchers("/api/auth/**").permitAll()
    ✓ cors.allowedOrigins("http://localhost:5173")
    ✓ cors.allowedMethods("GET", "POST", "PUT", "DELETE")

[4] application.properties
    ✓ server.port=${API_PORT:8060}
    ✓ spring.datasource.url=jdbc:mysql://${DB_HOST}...

[5] api.js (Frontend)
    ✓ baseURL: import.meta.env.VITE_API_URL
    ✓ USE_MOCK_API: import.meta.env.VITE_USE_MOCK_API === 'true'
    ✓ Authorization header avec Bearer token

[6] MySQL Docker
    ✓ Port: 3306:3306
    ✓ Volume: notes_db_data
    ✓ Init scripts: init.sql, data.sql
```

---

## 🚀 Séquence de Démarrage Optimale

```
┌─────────────────────────────────────────────────────────────────┐
│                  STARTUP SEQUENCE                                │
└─────────────────────────────────────────────────────────────────┘

[ETAPE 1: MySQL Container]
T=0s      docker-compose up -d
T=5s      MySQL initializing...
T=10s     ✓ MySQL ready on port 3306

[ETAPE 2: Spring Boot Backend]
T=10s     mvn spring-boot:run
T=15s     Loading application context...
T=20s     Connecting to MySQL...
T=25s     Initializing JPA entities...
T=30s     Starting embedded Tomcat...
T=35s     ✓ Backend ready on port 8060

[ETAPE 3: Vue.js Frontend]
T=35s     npm run dev
T=37s     Vite dev server starting...
T=40s     ✓ Frontend ready on port 5173

[ETAPE 4: Verification]
T=40s     Open http://localhost:5173
T=42s     ✓ Login page displayed

[TOTAL STARTUP TIME: ~45 seconds]
```

---

**📌 Gardez ce guide ouvert pour référence visuelle !**
