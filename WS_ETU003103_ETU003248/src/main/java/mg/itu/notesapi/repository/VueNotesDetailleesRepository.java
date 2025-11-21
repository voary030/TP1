package mg.itu.notesapi.repository;

import mg.itu.notesapi.entity.VueNotesDetaillees;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VueNotesDetailleesRepository extends JpaRepository<VueNotesDetaillees, Integer> {
    
    /**
     * Récupère toutes les notes détaillées d'un étudiant
     */
    @Query("SELECT v FROM VueNotesDetaillees v WHERE v.idEtudiant = :idEtudiant")
    List<VueNotesDetaillees> findByIdEtudiant(@Param("idEtudiant") Integer idEtudiant);
    
    /**
     * Récupère les notes d'un étudiant pour un semestre spécifique
     */
    @Query("SELECT v FROM VueNotesDetaillees v WHERE v.idEtudiant = :idEtudiant AND v.idSemestre = :idSemestre")
    List<VueNotesDetaillees> findByIdEtudiantAndIdSemestre(
        @Param("idEtudiant") Integer idEtudiant,
        @Param("idSemestre") Integer idSemestre
    );
    
    /**
     * Récupère les notes d'un étudiant pour une année universitaire
     */
    @Query("SELECT v FROM VueNotesDetaillees v WHERE v.idEtudiant = :idEtudiant AND v.anneeUniversitaire = :annee")
    List<VueNotesDetaillees> findByIdEtudiantAndAnneeUniversitaire(
        @Param("idEtudiant") Integer idEtudiant,
        @Param("annee") String annee
    );
    
    /**
     * Récupère toutes les notes pour un parcours
     */
    @Query("SELECT v FROM VueNotesDetaillees v WHERE v.idParcours = :idParcours")
    List<VueNotesDetaillees> findByIdParcours(@Param("idParcours") Integer idParcours);
    
    /**
     * Récupère toutes les notes (pour admin)
     */
    @Query("SELECT v FROM VueNotesDetaillees v")
    List<VueNotesDetaillees> findAllNotes();
    
    /**
     * Récupère les notes par semestre (pour admin)
     */
    @Query("SELECT v FROM VueNotesDetaillees v WHERE v.idSemestre = :idSemestre")
    List<VueNotesDetaillees> findByIdSemestre(@Param("idSemestre") Integer idSemestre);
    
    /**
     * Récupère les notes par année universitaire (pour admin)
     */
    @Query("SELECT v FROM VueNotesDetaillees v WHERE v.anneeUniversitaire = :annee")
    List<VueNotesDetaillees> findByAnneeUniversitaire(@Param("annee") String annee);
}
