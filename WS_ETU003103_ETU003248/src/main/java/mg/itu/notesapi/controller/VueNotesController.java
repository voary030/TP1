package mg.itu.notesapi.controller;

import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.dto.ApiResponse;
import mg.itu.notesapi.entity.AuthToken;
import mg.itu.notesapi.entity.VueMoyennesSemestre;
import mg.itu.notesapi.entity.VueNotesDetaillees;
import mg.itu.notesapi.exception.ApiException;
import mg.itu.notesapi.exception.ErrorCodes;
import mg.itu.notesapi.repository.AuthTokenRepository;
import mg.itu.notesapi.service.VueNotesService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Controller utilisant les vues SQL optimisées
 * Fournit des endpoints pour accéder rapidement aux notes détaillées et moyennes
 */
@RestController
@RequestMapping("/api/vue-notes")
@RequiredArgsConstructor
public class VueNotesController {
    
    private final VueNotesService vueNotesService;
    private final AuthTokenRepository authTokenRepository;
    
    // ===== ENDPOINTS ÉTUDIANTS =====
    
    /**
     * Récupère toutes les notes détaillées de l'étudiant connecté
     */
    @GetMapping("/mes-notes")
    public ResponseEntity<ApiResponse<List<VueNotesDetaillees>>> getMesNotes(
            @RequestHeader("Authorization") String authHeader) {
        
        Integer idEtudiant = validateStudentToken(authHeader);
        List<VueNotesDetaillees> notes = vueNotesService.getNotesDetailleesEtudiant(idEtudiant);
        
        return ResponseEntity.ok(ApiResponse.success(notes));
    }
    
    /**
     * Récupère les notes détaillées d'un semestre pour l'étudiant connecté
     */
    @GetMapping("/mes-notes/semestre/{idSemestre}")
    public ResponseEntity<ApiResponse<List<VueNotesDetaillees>>> getMesNotesSemestre(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Integer idSemestre) {
        
        Integer idEtudiant = validateStudentToken(authHeader);
        List<VueNotesDetaillees> notes = vueNotesService.getNotesDetailleesEtudiantSemestre(idEtudiant, idSemestre);
        
        return ResponseEntity.ok(ApiResponse.success(notes));
    }
    
    /**
     * Récupère les notes détaillées d'une année universitaire pour l'étudiant connecté
     */
    @GetMapping("/mes-notes/annee/{annee}")
    public ResponseEntity<ApiResponse<List<VueNotesDetaillees>>> getMesNotesAnnee(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable String annee) {
        
        Integer idEtudiant = validateStudentToken(authHeader);
        List<VueNotesDetaillees> notes = vueNotesService.getNotesDetailleesEtudiantAnnee(idEtudiant, annee);
        
        return ResponseEntity.ok(ApiResponse.success(notes));
    }
    
    /**
     * Récupère les moyennes de tous les semestres de l'étudiant connecté
     */
    @GetMapping("/mes-moyennes")
    public ResponseEntity<ApiResponse<List<VueMoyennesSemestre>>> getMesMoyennes(
            @RequestHeader("Authorization") String authHeader) {
        
        Integer idEtudiant = validateStudentToken(authHeader);
        List<VueMoyennesSemestre> moyennes = vueNotesService.getMoyennesEtudiant(idEtudiant);
        
        return ResponseEntity.ok(ApiResponse.success(moyennes));
    }
    
    /**
     * Récupère la moyenne d'un semestre pour l'étudiant connecté
     */
    @GetMapping("/mes-moyennes/semestre/{idSemestre}")
    public ResponseEntity<ApiResponse<VueMoyennesSemestre>> getMaMoyenneSemestre(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Integer idSemestre) {
        
        Integer idEtudiant = validateStudentToken(authHeader);
        Optional<VueMoyennesSemestre> moyenne = vueNotesService.getMoyenneEtudiantSemestre(idEtudiant, idSemestre);
        
        return moyenne
                .map(m -> ResponseEntity.ok(ApiResponse.success(m)))
                .orElseGet(() -> ResponseEntity.ok(ApiResponse.success(null)));
    }
    
    // ===== ENDPOINTS ADMIN =====
    
    /**
     * Récupère toutes les notes détaillées (admin)
     */
    @GetMapping("/admin/notes")
    public ResponseEntity<ApiResponse<List<VueNotesDetaillees>>> getAllNotesAdmin(
            @RequestHeader("Authorization") String authHeader) {
        
        validateAdminToken(authHeader);
        List<VueNotesDetaillees> notes = vueNotesService.getAllNotesDetaillees();
        
        return ResponseEntity.ok(ApiResponse.success(notes));
    }
    
    /**
     * Récupère les notes d'un étudiant spécifique (admin)
     */
    @GetMapping("/admin/notes/etudiant/{idEtudiant}")
    public ResponseEntity<ApiResponse<List<VueNotesDetaillees>>> getNotesEtudiantAdmin(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Integer idEtudiant) {
        
        validateAdminToken(authHeader);
        List<VueNotesDetaillees> notes = vueNotesService.getNotesDetailleesEtudiant(idEtudiant);
        
        return ResponseEntity.ok(ApiResponse.success(notes));
    }
    
    /**
     * Récupère les notes par semestre (admin)
     */
    @GetMapping("/admin/notes/semestre/{idSemestre}")
    public ResponseEntity<ApiResponse<List<VueNotesDetaillees>>> getNotesSemestreAdmin(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Integer idSemestre) {
        
        validateAdminToken(authHeader);
        List<VueNotesDetaillees> notes = vueNotesService.getNotesDetailleesParSemestre(idSemestre);
        
        return ResponseEntity.ok(ApiResponse.success(notes));
    }
    
    /**
     * Récupère les notes par année universitaire (admin)
     */
    @GetMapping("/admin/notes/annee/{annee}")
    public ResponseEntity<ApiResponse<List<VueNotesDetaillees>>> getNotesAnneeAdmin(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable String annee) {
        
        validateAdminToken(authHeader);
        List<VueNotesDetaillees> notes = vueNotesService.getNotesDetailleesParAnnee(annee);
        
        return ResponseEntity.ok(ApiResponse.success(notes));
    }
    
    /**
     * Récupère toutes les moyennes (admin)
     */
    @GetMapping("/admin/moyennes")
    public ResponseEntity<ApiResponse<List<VueMoyennesSemestre>>> getAllMoyennesAdmin(
            @RequestHeader("Authorization") String authHeader) {
        
        validateAdminToken(authHeader);
        List<VueMoyennesSemestre> moyennes = vueNotesService.getAllMoyennes();
        
        return ResponseEntity.ok(ApiResponse.success(moyennes));
    }
    
    /**
     * Récupère les moyennes par semestre (admin)
     */
    @GetMapping("/admin/moyennes/semestre/{idSemestre}")
    public ResponseEntity<ApiResponse<List<VueMoyennesSemestre>>> getMoyennesSemestreAdmin(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Integer idSemestre) {
        
        validateAdminToken(authHeader);
        List<VueMoyennesSemestre> moyennes = vueNotesService.getMoyennesParSemestre(idSemestre);
        
        return ResponseEntity.ok(ApiResponse.success(moyennes));
    }
    
    /**
     * Récupère les moyennes par année universitaire (admin)
     */
    @GetMapping("/admin/moyennes/annee/{annee}")
    public ResponseEntity<ApiResponse<List<VueMoyennesSemestre>>> getMoyennesAnneeAdmin(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable String annee) {
        
        validateAdminToken(authHeader);
        List<VueMoyennesSemestre> moyennes = vueNotesService.getMoyennesParAnnee(annee);
        
        return ResponseEntity.ok(ApiResponse.success(moyennes));
    }
    
    // ===== MÉTHODES DE VALIDATION =====
    
    private Integer validateStudentToken(String authHeader) {
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new ApiException(
                    ErrorCodes.AUTH_002,
                    "Token d'authentification requis"
            );
        }
        
        String token = authHeader.substring(7);
        AuthToken authToken = authTokenRepository
                .findByTokenAndEstActifTrueAndDateExpirationAfter(token, LocalDateTime.now())
                .orElseThrow(() -> new ApiException(
                        ErrorCodes.AUTH_002,
                        "Token invalide ou expiré"
                ));
        
        if (!"ETUDIANT".equals(authToken.getUserType()) || authToken.getEtudiant() == null) {
            throw new ApiException(
                    ErrorCodes.AUTH_003,
                    "Accès non autorisé"
            );
        }
        
        return authToken.getEtudiant().getIdEtudiant();
    }
    
    private void validateAdminToken(String authHeader) {
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new ApiException(
                    ErrorCodes.AUTH_002,
                    "Token d'authentification requis"
            );
        }
        
        String token = authHeader.substring(7);
        AuthToken authToken = authTokenRepository
                .findByTokenAndEstActifTrueAndDateExpirationAfter(token, LocalDateTime.now())
                .orElseThrow(() -> new ApiException(
                        ErrorCodes.AUTH_002,
                        "Token invalide ou expiré"
                ));
        
        if (!"ADMIN".equals(authToken.getUserType()) || authToken.getUser() == null) {
            throw new ApiException(
                    ErrorCodes.AUTH_003,
                    "Accès non autorisé - privilèges admin requis"
            );
        }
    }
}
