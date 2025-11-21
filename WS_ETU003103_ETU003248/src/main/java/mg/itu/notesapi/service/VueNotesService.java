package mg.itu.notesapi.service;

import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.entity.VueMoyennesSemestre;
import mg.itu.notesapi.entity.VueNotesDetaillees;
import mg.itu.notesapi.repository.VueMoyennesSemestreRepository;
import mg.itu.notesapi.repository.VueNotesDetailleesRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

/**
 * Service pour accéder aux vues SQL optimisées
 * Utilise les vues vue_notes_detaillees et vue_moyennes_semestre
 */
@Service
@RequiredArgsConstructor
public class VueNotesService {
    
    private final VueNotesDetailleesRepository vueNotesDetailleesRepository;
    private final VueMoyennesSemestreRepository vueMoyennesSemestreRepository;
    
    // ===== NOTES DÉTAILLÉES =====
    
    /**
     * Récupère toutes les notes détaillées d'un étudiant
     */
    @Transactional(readOnly = true)
    public List<VueNotesDetaillees> getNotesDetailleesEtudiant(Integer idEtudiant) {
        return vueNotesDetailleesRepository.findByIdEtudiant(idEtudiant);
    }
    
    /**
     * Récupère les notes d'un étudiant pour un semestre
     */
    @Transactional(readOnly = true)
    public List<VueNotesDetaillees> getNotesDetailleesEtudiantSemestre(Integer idEtudiant, Integer idSemestre) {
        return vueNotesDetailleesRepository.findByIdEtudiantAndIdSemestre(idEtudiant, idSemestre);
    }
    
    /**
     * Récupère les notes d'un étudiant pour une année universitaire
     */
    @Transactional(readOnly = true)
    public List<VueNotesDetaillees> getNotesDetailleesEtudiantAnnee(Integer idEtudiant, String annee) {
        return vueNotesDetailleesRepository.findByIdEtudiantAndAnneeUniversitaire(idEtudiant, annee);
    }
    
    /**
     * Récupère toutes les notes pour un parcours (admin)
     */
    @Transactional(readOnly = true)
    public List<VueNotesDetaillees> getNotesDetailleesParParcours(Integer idParcours) {
        return vueNotesDetailleesRepository.findByIdParcours(idParcours);
    }
    
    /**
     * Récupère toutes les notes détaillées (admin)
     */
    @Transactional(readOnly = true)
    public List<VueNotesDetaillees> getAllNotesDetaillees() {
        return vueNotesDetailleesRepository.findAllNotes();
    }
    
    /**
     * Récupère toutes les notes pour un semestre (admin)
     */
    @Transactional(readOnly = true)
    public List<VueNotesDetaillees> getNotesDetailleesParSemestre(Integer idSemestre) {
        return vueNotesDetailleesRepository.findByIdSemestre(idSemestre);
    }
    
    /**
     * Récupère toutes les notes pour une année universitaire (admin)
     */
    @Transactional(readOnly = true)
    public List<VueNotesDetaillees> getNotesDetailleesParAnnee(String annee) {
        return vueNotesDetailleesRepository.findByAnneeUniversitaire(annee);
    }
    
    // ===== MOYENNES SEMESTRE =====
    
    /**
     * Récupère les moyennes de tous les semestres d'un étudiant
     */
    @Transactional(readOnly = true)
    public List<VueMoyennesSemestre> getMoyennesEtudiant(Integer idEtudiant) {
        return vueMoyennesSemestreRepository.findByIdEtudiant(idEtudiant);
    }
    
    /**
     * Récupère la moyenne d'un étudiant pour un semestre
     */
    @Transactional(readOnly = true)
    public Optional<VueMoyennesSemestre> getMoyenneEtudiantSemestre(Integer idEtudiant, Integer idSemestre) {
        return vueMoyennesSemestreRepository.findByIdEtudiantAndIdSemestre(idEtudiant, idSemestre);
    }
    
    /**
     * Récupère les moyennes d'un étudiant pour une année universitaire
     */
    @Transactional(readOnly = true)
    public List<VueMoyennesSemestre> getMoyennesEtudiantAnnee(Integer idEtudiant, String annee) {
        return vueMoyennesSemestreRepository.findByIdEtudiantAndAnneeUniversitaire(idEtudiant, annee);
    }
    
    /**
     * Récupère toutes les moyennes pour un semestre (admin)
     */
    @Transactional(readOnly = true)
    public List<VueMoyennesSemestre> getMoyennesParSemestre(Integer idSemestre) {
        return vueMoyennesSemestreRepository.findByIdSemestre(idSemestre);
    }
    
    /**
     * Récupère toutes les moyennes pour une année universitaire (admin)
     */
    @Transactional(readOnly = true)
    public List<VueMoyennesSemestre> getMoyennesParAnnee(String annee) {
        return vueMoyennesSemestreRepository.findByAnneeUniversitaire(annee);
    }
    
    /**
     * Récupère toutes les moyennes (admin)
     */
    @Transactional(readOnly = true)
    public List<VueMoyennesSemestre> getAllMoyennes() {
        return vueMoyennesSemestreRepository.findAllMoyennes();
    }
}
