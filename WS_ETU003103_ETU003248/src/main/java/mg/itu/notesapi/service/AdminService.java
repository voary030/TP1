package mg.itu.notesapi.service;

import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.dto.CreateStudentRequest;
import mg.itu.notesapi.entity.Etudiant;
import mg.itu.notesapi.entity.Parcours;
import mg.itu.notesapi.entity.User;
import mg.itu.notesapi.exception.ApiException;
import mg.itu.notesapi.exception.ErrorCodes;
import mg.itu.notesapi.repository.EtudiantRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class AdminService {
    
    private final EtudiantRepository etudiantRepository;
    
    @Transactional
    public Etudiant createStudent(CreateStudentRequest request, User admin) {
        // Vérifier si l'email existe déjà
        if (etudiantRepository.findByEmail(request.getEmail()).isPresent()) {
            throw new ApiException(
                    ErrorCodes.VAL_001,
                    "Un étudiant avec cet email existe déjà"
            );
        }
        
        // Créer le nouvel étudiant
        Etudiant etudiant = new Etudiant();
        etudiant.setNom(request.getNom());
        etudiant.setPrenom(request.getPrenom());
        etudiant.setEmail(request.getEmail());
        etudiant.setMotDePasse(request.getMotDePasse());
        
        // Associer l'admin créateur
        etudiant.setUserCreateur(admin);
        etudiant.setDateInscription(LocalDateTime.now());
        
        return etudiantRepository.save(etudiant);
    }
}
