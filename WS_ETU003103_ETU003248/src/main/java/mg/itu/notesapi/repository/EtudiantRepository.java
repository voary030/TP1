package mg.itu.notesapi.repository;

import mg.itu.notesapi.entity.Etudiant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface EtudiantRepository extends JpaRepository<Etudiant, Long> {
    
    Optional<Etudiant> findByEmail(String email);
    
    boolean existsByEmail(String email);
}
