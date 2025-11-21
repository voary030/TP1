package mg.itu.notesapi.repository;

import mg.itu.notesapi.entity.Parcours;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ParcoursRepository extends JpaRepository<Parcours, Long> {
    List<Parcours> findBySemestre_IdSemestre(Long semestreId);
}
