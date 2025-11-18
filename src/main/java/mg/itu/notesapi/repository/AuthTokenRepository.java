package mg.itu.notesapi.repository;

import mg.itu.notesapi.entity.AuthToken;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.Optional;

@Repository
public interface AuthTokenRepository extends JpaRepository<AuthToken, Long> {
    
    Optional<AuthToken> findByTokenAndEstActifTrueAndDateExpirationAfter(
        String token, 
        LocalDateTime currentDate
    );
    
    Optional<AuthToken> findByToken(String token);
}
