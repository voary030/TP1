package mg.itu.notesapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;

@Entity
@Table(name = "Etudiant")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Etudiant {
    
    @Id
    @Column(name = "id_etudiant")
    private Long idEtudiant;
    
    @Column(name = "nom", length = 50)
    private String nom;
    
    @Column(name = "prenom", length = 50)
    private String prenom;
    
    @Column(name = "date_naissance")
    private LocalDate dateNaissance;
    
    @Column(name = "email", length = 100, unique = true)
    private String email;
    
    @Column(name = "mot_de_passe", length = 255)
    private String motDePasse;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_user_createur")
    private User userCreateur;
    
    @Column(name = "date_inscription")
    private java.time.LocalDateTime dateInscription;
}
