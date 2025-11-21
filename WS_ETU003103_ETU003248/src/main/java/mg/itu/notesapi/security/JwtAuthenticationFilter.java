package mg.itu.notesapi.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.entity.AuthToken;
import mg.itu.notesapi.entity.Etudiant;
import mg.itu.notesapi.repository.AuthTokenRepository;
import mg.itu.notesapi.util.JwtUtil;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Collections;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    
    private final JwtUtil jwtUtil;
    private final AuthTokenRepository authTokenRepository;
    
    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain
    ) throws ServletException, IOException {
        
        String authHeader = request.getHeader("Authorization");
        
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            
            try {
                // Valider le token JWT
                if (!jwtUtil.isTokenExpired(token)) {
                    // Vérifier si le token existe dans la base et est actif
                    AuthToken authToken = authTokenRepository
                            .findByTokenAndEstActifTrueAndDateExpirationAfter(token, LocalDateTime.now())
                            .orElse(null);
                    
                    if (authToken != null) {
                        Etudiant etudiant = authToken.getEtudiant();
                        
                        UsernamePasswordAuthenticationToken authentication = 
                                new UsernamePasswordAuthenticationToken(
                                        etudiant,
                                        null,
                                        Collections.emptyList()
                                );
                        
                        authentication.setDetails(
                                new WebAuthenticationDetailsSource().buildDetails(request)
                        );
                        
                        SecurityContextHolder.getContext().setAuthentication(authentication);
                    }
                }
            } catch (Exception e) {
                // Token invalide, on laisse passer sans authentification
                // L'exception sera gérée par le GlobalExceptionHandler
            }
        }
        
        filterChain.doFilter(request, response);
    }
}
