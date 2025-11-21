package mg.itu.notesapi.service;

import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.dto.LoginRequest;
import mg.itu.notesapi.dto.LoginResponse;
import mg.itu.notesapi.entity.AuthToken;
import mg.itu.notesapi.entity.Etudiant;
import mg.itu.notesapi.exception.ApiException;
import mg.itu.notesapi.exception.ErrorCodes;
import mg.itu.notesapi.repository.AuthTokenRepository;
import mg.itu.notesapi.repository.EtudiantRepository;
import mg.itu.notesapi.util.JwtUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class AuthService {
    
    private final EtudiantRepository etudiantRepository;
    private final AuthTokenRepository authTokenRepository;
    private final JwtUtil jwtUtil;
    private final PasswordEncoder passwordEncoder;
    
    @Value("${jwt.expiration}")
    private Long jwtExpiration;
    
    @Transactional
    public LoginResponse login(LoginRequest request) {
        // Trouver l'étudiant par email
        Etudiant etudiant = etudiantRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new ApiException(
                        ErrorCodes.AUTH_001,
                        "Identifiants invalides"
                ));
        
        // Vérifier le mot de passe
        if (!passwordEncoder.matches(request.getPassword(), etudiant.getMotDePasse())) {
            throw new ApiException(
                    ErrorCodes.AUTH_001,
                    "Identifiants invalides"
            );
        }
        
        // Générer le token JWT
        String token = jwtUtil.generateToken(etudiant.getIdEtudiant(), etudiant.getEmail());
        
        // Sauvegarder le token dans la base
        AuthToken authToken = new AuthToken();
        authToken.setToken(token);
        authToken.setEtudiant(etudiant);
        authToken.setDateCreation(LocalDateTime.now());
        authToken.setDateExpiration(LocalDateTime.now().plusSeconds(jwtExpiration / 1000));
        authToken.setEstActif(true);
        authTokenRepository.save(authToken);
        
        // Construire la réponse
        LoginResponse.StudentInfo studentInfo = LoginResponse.StudentInfo.builder()
                .id(etudiant.getIdEtudiant())
                .firstName(etudiant.getPrenom())
                .lastName(etudiant.getNom())
                .email(etudiant.getEmail())
                .build();
        
        return LoginResponse.builder()
                .token(token)
                .expiresIn("24h")
                .student(studentInfo)
                .build();
    }
    
    public Etudiant validateToken(String token) {
        // Vérifier si le token existe et est actif dans la base
        AuthToken authToken = authTokenRepository
                .findByTokenAndEstActifTrueAndDateExpirationAfter(token, LocalDateTime.now())
                .orElseThrow(() -> new ApiException(
                        ErrorCodes.AUTH_002,
                        "Token invalide ou expiré"
                ));
        
        return authToken.getEtudiant();
    }
}
