package mg.itu.notesapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "auth_token")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AuthToken {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_token")
    private Long idToken;
    
    @Column(name = "token", length = 255, unique = true)
    private String token;
    
    @ManyToOne
    @JoinColumn(name = "id_etudiant")
    private Etudiant etudiant;
    
    @Column(name = "date_creation")
    private LocalDateTime dateCreation;
    
    @Column(name = "date_expiration")
    private LocalDateTime dateExpiration;
    
    @Column(name = "est_actif")
    private Boolean estActif = true;
}
