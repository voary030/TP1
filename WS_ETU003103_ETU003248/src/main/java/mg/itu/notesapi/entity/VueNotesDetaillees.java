package mg.itu.notesapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Entité JPA pour la vue vue_notes_detaillees
 * Vue en lecture seule (immutable)
 */
@Entity
@Table(name = "vue_notes_detaillees")
@Immutable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class VueNotesDetaillees {
    
    @Id
    @Column(name = "id_etudiant")
    private Integer idEtudiant;
    
    @Column(name = "nom_etudiant")
    private String nomEtudiant;
    
    @Column(name = "prenom_etudiant")
    private String prenomEtudiant;
    
    @Column(name = "note")
    private BigDecimal note;
    
    @Column(name = "id_matiere")
    private Integer idMatiere;
    
    @Column(name = "code_matiere")
    private String codeMatiere;
    
    @Column(name = "libelle_matiere")
    private String libelleMatiere;
    
    @Column(name = "credit")
    private BigDecimal credit;
    
    @Column(name = "id_semestre")
    private Integer idSemestre;
    
    @Column(name = "libelle_semestre")
    private String libelleSemestre;
    
    @Column(name = "id_parcours")
    private Integer idParcours;
    
    @Column(name = "libelle_parcours")
    private String libelleParcours;
    
    @Column(name = "id_session")
    private String idSession;
    
    @Column(name = "libelle_session")
    private String libelleSession;
    
    @Column(name = "date_session")
    private LocalDate dateSession;
    
    @Column(name = "annee_universitaire")
    private String anneeUniversitaire;
    
    @Column(name = "type_matiere")
    private String typeMatiere;
    
    @Column(name = "filiere")
    private String filiere;
}
