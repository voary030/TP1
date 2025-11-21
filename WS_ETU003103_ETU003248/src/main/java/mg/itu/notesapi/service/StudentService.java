package mg.itu.notesapi.service;

import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.dto.*;
import mg.itu.notesapi.entity.Etudiant;
import mg.itu.notesapi.entity.Note;
import mg.itu.notesapi.entity.Parcours;
import mg.itu.notesapi.entity.Semestre;
import mg.itu.notesapi.exception.ApiException;
import mg.itu.notesapi.exception.ErrorCodes;
import mg.itu.notesapi.repository.EtudiantRepository;
import mg.itu.notesapi.repository.NoteRepository;
import mg.itu.notesapi.repository.ParcoursRepository;
import mg.itu.notesapi.repository.SemestreRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class StudentService {
    
    private final EtudiantRepository etudiantRepository;
    private final NoteRepository noteRepository;
    private final SemestreRepository semestreRepository;
    private final ParcoursRepository parcoursRepository;
    
    @Transactional(readOnly = true)
    public List<SemesterDto> getAllSemesters() {
        List<Semestre> semestres = semestreRepository.findAll();
        return semestres.stream()
                .map(s -> SemesterDto.builder()
                        .id(s.getIdSemestre())
                        .name(s.getLibelle())
                        .build())
                .collect(Collectors.toList());
    }
    
    @Transactional(readOnly = true)
    public List<ParcoursDto> getParcoursBySemester(Long semesterId) {
        List<Parcours> parcours = parcoursRepository.findBySemestre_IdSemestre(semesterId);
        return parcours.stream()
                .map(p -> ParcoursDto.builder()
                        .id(p.getIdParcours())
                        .name(p.getLibelle())
                        .semesterId(p.getSemestre().getIdSemestre())
                        .build())
                .collect(Collectors.toList());
    }
    
    @Transactional(readOnly = true)
    public List<StudentAveragesDto> getAllStudentsWithAverages() {
        List<Etudiant> etudiants = etudiantRepository.findAll();
        
        return etudiants.stream()
                .map(etudiant -> {
                    StudentAveragesDto dto = StudentAveragesDto.builder()
                            .id(etudiant.getIdEtudiant())
                            .firstName(etudiant.getPrenom())
                            .lastName(etudiant.getNom())
                            .email(etudiant.getEmail())
                            .build();
                    
                    // Calculer les moyennes pour chaque semestre
                    for (long semesterId = 1; semesterId <= 4; semesterId++) {
                        BigDecimal average = calculateSemesterAverage(etudiant.getIdEtudiant(), semesterId);
                        switch ((int) semesterId) {
                            case 1 -> dto.setS1Average(average);
                            case 2 -> dto.setS2Average(average);
                            case 3 -> dto.setS3Average(average);
                            case 4 -> dto.setS4Average(average);
                        }
                    }
                    
                    return dto;
                })
                .collect(Collectors.toList());
    }
    
    @Transactional(readOnly = true)
    public StudentDetailDto getStudentById(Long studentId) {
        Etudiant etudiant = etudiantRepository.findById(studentId)
                .orElseThrow(() -> new ApiException(
                        ErrorCodes.STU_001,
                        "Étudiant non trouvé avec l'ID: " + studentId
                ));
        
        Map<String, BigDecimal> semesterAverages = new LinkedHashMap<>();
        for (long semesterId = 1; semesterId <= 4; semesterId++) {
            BigDecimal average = calculateSemesterAverage(studentId, semesterId);
            semesterAverages.put("S" + semesterId, average);
        }
        
        return StudentDetailDto.builder()
                .id(etudiant.getIdEtudiant())
                .firstName(etudiant.getPrenom())
                .lastName(etudiant.getNom())
                .email(etudiant.getEmail())
                .birthDate(etudiant.getDateNaissance())
                .semesterAverages(semesterAverages)
                .build();
    }
    
    private BigDecimal calculateSemesterAverage(Long studentId, Long semesterId) {
        List<Note> notes = noteRepository.findByStudentAndSemester(studentId, semesterId);
        
        if (notes.isEmpty()) {
            return null;
        }
        
        BigDecimal totalCredits = notes.stream()
                .map(n -> n.getMatiere().getCredit())
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        if (totalCredits.compareTo(BigDecimal.ZERO) == 0) {
            return BigDecimal.ZERO;
        }
        
        BigDecimal weightedSum = notes.stream()
                .map(n -> n.getNote().multiply(n.getMatiere().getCredit()))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        return weightedSum.divide(totalCredits, 2, RoundingMode.HALF_UP);
    }
}
