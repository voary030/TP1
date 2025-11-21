package mg.itu.notesapi.controller;

import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.dto.ApiResponse;
import mg.itu.notesapi.dto.CreateStudentRequest;
import mg.itu.notesapi.dto.SemesterGradesResponse;
import mg.itu.notesapi.entity.AuthToken;
import mg.itu.notesapi.entity.Etudiant;
import mg.itu.notesapi.entity.User;
import mg.itu.notesapi.exception.ApiException;
import mg.itu.notesapi.exception.ErrorCodes;
import mg.itu.notesapi.repository.AuthTokenRepository;
import mg.itu.notesapi.service.AdminService;
import mg.itu.notesapi.service.GradeService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminController {
    
    private final AdminService adminService;
    private final GradeService gradeService;
    private final AuthTokenRepository authTokenRepository;
    
    @PostMapping("/students")
    public ResponseEntity<ApiResponse<Etudiant>> createStudent(
            @RequestHeader("Authorization") String authHeader,
            @RequestBody CreateStudentRequest request) {
        
        // Extraire et valider le token admin
        User admin = validateAdminToken(authHeader);
        
        // Créer l'étudiant
        Etudiant student = adminService.createStudent(request, admin);
        
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(ApiResponse.success(student));
    }
    
    @GetMapping("/students/{studentId}/grades")
    public ResponseEntity<ApiResponse<List<SemesterGradesResponse>>> getStudentGrades(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Integer studentId) {
        
        // Valider le token admin
        validateAdminToken(authHeader);
        
        // Récupérer les notes de l'étudiant
        List<SemesterGradesResponse> grades = gradeService.getGradesByStudentId(studentId);
        
        return ResponseEntity.ok(ApiResponse.success(grades));
    }
    
    @GetMapping("/students/all-grades")
    public ResponseEntity<ApiResponse<List<SemesterGradesResponse>>> getAllStudentsGrades(
            @RequestHeader("Authorization") String authHeader,
            @RequestParam(required = false) Integer semestre,
            @RequestParam(required = false) Integer annee) {
        
        // Valider le token admin
        validateAdminToken(authHeader);
        
        // Récupérer toutes les notes
        List<SemesterGradesResponse> grades = gradeService.getAllGrades(semestre, annee);
        
        return ResponseEntity.ok(ApiResponse.success(grades));
    }
    
    private User validateAdminToken(String authHeader) {
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new ApiException(
                    ErrorCodes.AUTH_002,
                    "Token d'authentification requis"
            );
        }
        
        String token = authHeader.substring(7);
        
        // Vérifier le token dans la base
        AuthToken authToken = authTokenRepository
                .findByTokenAndEstActifTrueAndDateExpirationAfter(token, LocalDateTime.now())
                .orElseThrow(() -> new ApiException(
                        ErrorCodes.AUTH_002,
                        "Token invalide ou expiré"
                ));
        
        // Vérifier que c'est un token admin
        if (!"ADMIN".equals(authToken.getUserType()) || authToken.getUser() == null) {
            throw new ApiException(
                    ErrorCodes.AUTH_003,
                    "Accès non autorisé - privilèges admin requis"
            );
        }
        
        return authToken.getUser();
    }
}
