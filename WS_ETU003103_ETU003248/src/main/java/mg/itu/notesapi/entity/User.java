package mg.itu.notesapi.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "user")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_user")
    private Integer idUser;
    
    @Column(name = "nom", length = 50)
    private String nom;
    
    @Column(name = "prenom", length = 50)
    private String prenom;
    
    @Column(name = "email", length = 100, unique = true, nullable = false)
    private String email;
    
    @Column(name = "mot_de_passe", nullable = false)
    private String motDePasse;
    
    @Column(name = "role", length = 20)
    private String role = "ADMIN";
    
    @Column(name = "est_actif")
    private Boolean estActif = true;
    
    @Column(name = "date_creation")
    private LocalDateTime dateCreation = LocalDateTime.now();
}
