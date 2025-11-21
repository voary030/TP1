package mg.itu.notesapi.repository;

import mg.itu.notesapi.entity.Note;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface NoteRepository extends JpaRepository<Note, Long> {
    
    @Query("SELECT n FROM Note n " +
           "JOIN FETCH n.etudiant e " +
           "JOIN FETCH n.matiere m " +
           "JOIN FETCH m.semestre s " +
           "WHERE e.idEtudiant = :studentId AND s.idSemestre = :semesterId")
    List<Note> findByStudentAndSemester(
        @Param("studentId") Long studentId, 
        @Param("semesterId") Long semesterId
    );
    
    @Query("SELECT n FROM Note n " +
           "JOIN FETCH n.etudiant e " +
           "JOIN FETCH n.matiere m " +
           "JOIN FETCH m.semestre s " +
           "WHERE e.idEtudiant = :studentId AND s.idSemestre IN :semesterIds")
    List<Note> findByStudentAndSemesters(
        @Param("studentId") Long studentId, 
        @Param("semesterIds") List<Long> semesterIds
    );
    
    @Query(value = "SELECT n.* FROM note n " +
           "JOIN Matiere m ON n.id_matiere = m.id_matiere " +
           "JOIN matiere_parcours mp ON m.id_matiere = mp.id_matiere " +
           "WHERE n.id_etudiant = :studentId " +
           "AND m.id_semestre = :semesterId " +
           "AND mp.id_parcours = :parcoursId " +
           "AND mp.est_active = TRUE", 
           nativeQuery = true)
    List<Note> findByStudentSemesterAndParcours(
        @Param("studentId") Long studentId,
        @Param("semesterId") Long semesterId,
        @Param("parcoursId") Long parcoursId
    );
}
