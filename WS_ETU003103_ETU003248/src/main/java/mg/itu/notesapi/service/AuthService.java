package mg.itu.notesapi.service;

import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.dto.AdminLoginRequest;
import mg.itu.notesapi.dto.LoginRequest;
import mg.itu.notesapi.dto.LoginResponse;
import mg.itu.notesapi.entity.AuthToken;
import mg.itu.notesapi.entity.Etudiant;
import mg.itu.notesapi.entity.User;
import mg.itu.notesapi.exception.ApiException;
import mg.itu.notesapi.exception.ErrorCodes;
import mg.itu.notesapi.repository.AuthTokenRepository;
import mg.itu.notesapi.repository.EtudiantRepository;
import mg.itu.notesapi.repository.UserRepository;
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
    private final UserRepository userRepository;
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
        
        // Vérification simple en clair (pour test uniquement)
        if (!request.getPassword().equals(etudiant.getMotDePasse())) {
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
        authToken.setUserType("ETUDIANT");
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
    
    @Transactional
    public LoginResponse adminLogin(AdminLoginRequest request) {
        // Trouver l'utilisateur admin par email
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new ApiException(
                        ErrorCodes.AUTH_001,
                        "Identifiants invalides"
                ));
        
        // Vérifier que le compte est actif
        if (!user.getEstActif()) {
            throw new ApiException(
                    ErrorCodes.AUTH_001,
                    "Compte désactivé"
            );
        }
        
        // Vérification simple en clair (pour test uniquement)
        if (!request.getMotDePasse().equals(user.getMotDePasse())) {
            throw new ApiException(
                    ErrorCodes.AUTH_001,
                    "Identifiants invalides"
            );
        }
        
        // Générer le token JWT pour admin
        String token = jwtUtil.generateToken(user.getIdUser().longValue(), user.getEmail());
        
        // Sauvegarder le token dans la base
        AuthToken authToken = new AuthToken();
        authToken.setToken(token);
        authToken.setUser(user);
        authToken.setUserType("ADMIN");
        authToken.setDateCreation(LocalDateTime.now());
        authToken.setDateExpiration(LocalDateTime.now().plusSeconds(jwtExpiration / 1000));
        authToken.setEstActif(true);
        authTokenRepository.save(authToken);
        
        // Construire la réponse (réutilise StudentInfo pour simplifier)
        LoginResponse.StudentInfo adminInfo = LoginResponse.StudentInfo.builder()
                .id(user.getIdUser().longValue())
                .firstName(user.getPrenom())
                .lastName(user.getNom())
                .email(user.getEmail())
                .build();
        
        return LoginResponse.builder()
                .token(token)
                .expiresIn("24h")
                .student(adminInfo)
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
