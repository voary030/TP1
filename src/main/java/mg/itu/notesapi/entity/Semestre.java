package mg.itu.notesapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "semestre")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Semestre {
    
    @Id
    @Column(name = "id_semestre")
    private Long idSemestre;
    
    @Column(name = "libelle", length = 50)
    private String libelle;
}
