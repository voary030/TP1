package mg.itu.notesapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Immutable;

import java.math.BigDecimal;

/**
 * Entité JPA pour la vue vue_moyennes_semestre
 * Vue en lecture seule (immutable)
 */
@Entity
@Table(name = "vue_moyennes_semestre")
@Immutable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class VueMoyennesSemestre {
    
    @Id
    @Column(name = "id_etudiant")
    private Integer idEtudiant;
    
    @Column(name = "nom_etudiant")
    private String nomEtudiant;
    
    @Column(name = "prenom_etudiant")
    private String prenomEtudiant;
    
    @Column(name = "id_semestre")
    private Integer idSemestre;
    
    @Column(name = "libelle_semestre")
    private String libelleSemestre;
    
    @Column(name = "annee_universitaire")
    private String anneeUniversitaire;
    
    @Column(name = "parcours")
    private String parcours;
    
    @Column(name = "nombre_notes")
    private Long nombreNotes;
    
    @Column(name = "moyenne_semestre")
    private BigDecimal moyenneSemestre;
    
    @Column(name = "total_credits")
    private BigDecimal totalCredits;
    
    @Column(name = "credits_obtenus")
    private BigDecimal creditsObtenus;
}
