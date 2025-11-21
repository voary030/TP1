package mg.itu.notesapi.service;

import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.dto.SemesterGradesResponse;
import mg.itu.notesapi.entity.Etudiant;
import mg.itu.notesapi.entity.Note;
import mg.itu.notesapi.exception.ApiException;
import mg.itu.notesapi.exception.ErrorCodes;
import mg.itu.notesapi.repository.EtudiantRepository;
import mg.itu.notesapi.repository.NoteRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class GradeService {
    
    private final EtudiantRepository etudiantRepository;
    private final NoteRepository noteRepository;
    
    @Transactional(readOnly = true)
    public SemesterGradesResponse getSemesterGrades(Long studentId, Long semesterId) {
        // Vérifier que l'étudiant existe
        Etudiant etudiant = etudiantRepository.findById(studentId)
                .orElseThrow(() -> new ApiException(
                        ErrorCodes.STU_001,
                        "Étudiant non trouvé avec l'ID: " + studentId
                ));
        
        // Récupérer les notes du semestre
        List<Note> notes = noteRepository.findByStudentAndSemester(studentId, semesterId);
        
        if (notes.isEmpty()) {
            throw new ApiException(
                    ErrorCodes.SEM_001,
                    "Aucune note trouvée pour ce semestre"
            );
        }
        
        // Construire les informations de l'étudiant
        SemesterGradesResponse.StudentInfo studentInfo = SemesterGradesResponse.StudentInfo.builder()
                .id(etudiant.getIdEtudiant())
                .firstName(etudiant.getPrenom())
                .lastName(etudiant.getNom())
                .email(etudiant.getEmail())
                .build();
        
        // Construire les informations du semestre (depuis la première note)
        Note firstNote = notes.get(0);
        SemesterGradesResponse.SemesterInfo semesterInfo = SemesterGradesResponse.SemesterInfo.builder()
                .id(firstNote.getMatiere().getSemestre().getIdSemestre())
                .name(firstNote.getMatiere().getSemestre().getLibelle())
                .build();
        
        // Construire les informations du parcours (si disponible)
        SemesterGradesResponse.TrackInfo trackInfo = null;
        if (firstNote.getMatiere().getParcours() != null) {
            trackInfo = SemesterGradesResponse.TrackInfo.builder()
                    .id(firstNote.getMatiere().getParcours().getIdParcours())
                    .name(firstNote.getMatiere().getParcours().getLibelle())
                    .build();
        }
        
        // Construire la liste des notes
        List<SemesterGradesResponse.GradeInfo> gradeInfos = notes.stream()
                .map(note -> {
                    SemesterGradesResponse.SubjectInfo subjectInfo = SemesterGradesResponse.SubjectInfo.builder()
                            .id(note.getMatiere().getIdMatiere())
                            .code(note.getMatiere().getCodeMatiere())
                            .name(note.getMatiere().getLibelle())
                            .credits(note.getMatiere().getCredit())
                            .type(note.getMatiere().getTypeMatiere() != null ? 
                                  note.getMatiere().getTypeMatiere().getLibelle() : "N/A")
                            .build();
                    
                    return SemesterGradesResponse.GradeInfo.builder()
                            .subject(subjectInfo)
                            .grade(note.getNote())
                            .build();
                })
                .collect(Collectors.toList());
        
        // Calculer le résumé
        BigDecimal totalCredits = notes.stream()
                .map(n -> n.getMatiere().getCredit())
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal weightedSum = notes.stream()
                .map(n -> n.getNote().multiply(n.getMatiere().getCredit()))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal average = totalCredits.compareTo(BigDecimal.ZERO) > 0
                ? weightedSum.divide(totalCredits, 2, RoundingMode.HALF_UP)
                : BigDecimal.ZERO;
        
        SemesterGradesResponse.SummaryInfo summaryInfo = SemesterGradesResponse.SummaryInfo.builder()
                .totalCredits(totalCredits)
                .average(average)
                .passed(average.compareTo(new BigDecimal("10")) >= 0)
                .build();
        
        return SemesterGradesResponse.builder()
                .student(studentInfo)
                .semester(semesterInfo)
                .track(trackInfo)
                .grades(gradeInfos)
                .summary(summaryInfo)
                .build();
    }
    
    @Transactional(readOnly = true)
    public SemesterGradesResponse getYearGrades(Long studentId, Integer yearLevel) {
        // Vérifier que l'étudiant existe
        Etudiant etudiant = etudiantRepository.findById(studentId)
                .orElseThrow(() -> new ApiException(
                        ErrorCodes.STU_001,
                        "Étudiant non trouvé avec l'ID: " + studentId
                ));
        
        // Déterminer les semestres de l'année
        Long semester1Id = (long) (yearLevel * 2 - 1);
        Long semester2Id = (long) (yearLevel * 2);
        List<Long> semesterIds = List.of(semester1Id, semester2Id);
        
        // Récupérer les notes de l'année
        List<Note> notes = noteRepository.findByStudentAndSemesters(studentId, semesterIds);
        
        if (notes.isEmpty()) {
            throw new ApiException(
                    ErrorCodes.YEAR_001,
                    "Aucune note trouvée pour cette année"
            );
        }
        
        // Construire les informations de l'étudiant
        SemesterGradesResponse.StudentInfo studentInfo = SemesterGradesResponse.StudentInfo.builder()
                .id(etudiant.getIdEtudiant())
                .firstName(etudiant.getPrenom())
                .lastName(etudiant.getNom())
                .email(etudiant.getEmail())
                .build();
        
        // Pour l'année, on utilise une représentation combinée
        String yearName = String.format("Année %d (S%d + S%d)", yearLevel, semester1Id, semester2Id);
        SemesterGradesResponse.SemesterInfo semesterInfo = SemesterGradesResponse.SemesterInfo.builder()
                .id(yearLevel.longValue())
                .name(yearName)
                .build();
        
        // Construire les informations du parcours (si disponible)
        SemesterGradesResponse.TrackInfo trackInfo = null;
        if (!notes.isEmpty() && notes.get(0).getMatiere().getParcours() != null) {
            trackInfo = SemesterGradesResponse.TrackInfo.builder()
                    .id(notes.get(0).getMatiere().getParcours().getIdParcours())
                    .name(notes.get(0).getMatiere().getParcours().getLibelle())
                    .build();
        }
        
        // Construire la liste des notes
        List<SemesterGradesResponse.GradeInfo> gradeInfos = notes.stream()
                .map(note -> {
                    SemesterGradesResponse.SubjectInfo subjectInfo = SemesterGradesResponse.SubjectInfo.builder()
                            .id(note.getMatiere().getIdMatiere())
                            .code(note.getMatiere().getCodeMatiere())
                            .name(note.getMatiere().getLibelle())
                            .credits(note.getMatiere().getCredit())
                            .type(note.getMatiere().getTypeMatiere() != null ? 
                                  note.getMatiere().getTypeMatiere().getLibelle() : "N/A")
                            .build();
                    
                    return SemesterGradesResponse.GradeInfo.builder()
                            .subject(subjectInfo)
                            .grade(note.getNote())
                            .build();
                })
                .collect(Collectors.toList());
        
        // Calculer le résumé pour l'année
        BigDecimal totalCredits = notes.stream()
                .map(n -> n.getMatiere().getCredit())
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal weightedSum = notes.stream()
                .map(n -> n.getNote().multiply(n.getMatiere().getCredit()))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal average = totalCredits.compareTo(BigDecimal.ZERO) > 0
                ? weightedSum.divide(totalCredits, 2, RoundingMode.HALF_UP)
                : BigDecimal.ZERO;
        
        SemesterGradesResponse.SummaryInfo summaryInfo = SemesterGradesResponse.SummaryInfo.builder()
                .totalCredits(totalCredits)
                .average(average)
                .passed(average.compareTo(new BigDecimal("10")) >= 0)
                .build();
        
        return SemesterGradesResponse.builder()
                .student(studentInfo)
                .semester(semesterInfo)
                .track(trackInfo)
                .grades(gradeInfos)
                .summary(summaryInfo)
                .build();
    }
}
