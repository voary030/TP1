package mg.itu.notesapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "type_matiere")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TypeMatiere {
    
    @Id
    @Column(name = "id_type_matiere")
    private Long idTypeMatiere;
    
    @Column(name = "libelle", length = 50)
    private String libelle;
}
