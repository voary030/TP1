package mg.itu.notesapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Entity
@Table(name = "Matiere")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Matiere {
    
    @Id
    @Column(name = "id_matiere")
    private Long idMatiere;
    
    @Column(name = "code_matiere", length = 20)
    private String codeMatiere;
    
    @Column(name = "libelle", length = 100)
    private String libelle;
    
    @Column(name = "credit", precision = 3, scale = 1)
    private BigDecimal credit;
    
    @ManyToOne
    @JoinColumn(name = "id_semestre")
    private Semestre semestre;
    
    @ManyToOne
    @JoinColumn(name = "id_parcours")
    private Parcours parcours;
    
    @ManyToOne
    @JoinColumn(name = "id_type_matiere")
    private TypeMatiere typeMatiere;
}


