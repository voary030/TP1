package mg.itu.notesapi.repository;

import mg.itu.notesapi.entity.VueMoyennesSemestre;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VueMoyennesSemestreRepository extends JpaRepository<VueMoyennesSemestre, Integer> {
    
    /**
     * Récupère les moyennes de tous les semestres d'un étudiant
     */
    @Query("SELECT v FROM VueMoyennesSemestre v WHERE v.idEtudiant = :idEtudiant")
    List<VueMoyennesSemestre> findByIdEtudiant(@Param("idEtudiant") Integer idEtudiant);
    
    /**
     * Récupère la moyenne d'un étudiant pour un semestre spécifique
     */
    @Query("SELECT v FROM VueMoyennesSemestre v WHERE v.idEtudiant = :idEtudiant AND v.idSemestre = :idSemestre")
    Optional<VueMoyennesSemestre> findByIdEtudiantAndIdSemestre(
        @Param("idEtudiant") Integer idEtudiant,
        @Param("idSemestre") Integer idSemestre
    );
    
    /**
     * Récupère les moyennes d'un étudiant pour une année universitaire
     */
    @Query("SELECT v FROM VueMoyennesSemestre v WHERE v.idEtudiant = :idEtudiant AND v.anneeUniversitaire = :annee")
    List<VueMoyennesSemestre> findByIdEtudiantAndAnneeUniversitaire(
        @Param("idEtudiant") Integer idEtudiant,
        @Param("annee") String annee
    );
    
    /**
     * Récupère toutes les moyennes pour un semestre (pour admin)
     */
    @Query("SELECT v FROM VueMoyennesSemestre v WHERE v.idSemestre = :idSemestre")
    List<VueMoyennesSemestre> findByIdSemestre(@Param("idSemestre") Integer idSemestre);
    
    /**
     * Récupère toutes les moyennes pour une année universitaire (pour admin)
     */
    @Query("SELECT v FROM VueMoyennesSemestre v WHERE v.anneeUniversitaire = :annee")
    List<VueMoyennesSemestre> findByAnneeUniversitaire(@Param("annee") String annee);
    
    /**
     * Récupère toutes les moyennes (pour admin)
     */
    @Query("SELECT v FROM VueMoyennesSemestre v")
    List<VueMoyennesSemestre> findAllMoyennes();
}
