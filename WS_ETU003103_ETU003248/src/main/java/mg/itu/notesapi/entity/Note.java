package mg.itu.notesapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Entity
@Table(name = "note")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Note {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_note")
    private Long idNote;
    
    @Column(name = "note", precision = 5, scale = 2)
    private BigDecimal note;
    
    @ManyToOne
    @JoinColumn(name = "id_etudiant")
    private Etudiant etudiant;
    
    @ManyToOne
    @JoinColumn(name = "id_matiere")
    private Matiere matiere;
    
    @Column(name = "id_session", length = 50)
    private String idSession;
}
