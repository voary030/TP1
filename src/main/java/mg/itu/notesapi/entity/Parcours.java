package mg.itu.notesapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "parcours")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Parcours {
    
    @Id
    @Column(name = "id_parcours")
    private Long idParcours;
    
    @Column(name = "libelle", length = 100)
    private String libelle;
    
    @ManyToOne
    @JoinColumn(name = "id_semestre")
    private Semestre semestre;
}
