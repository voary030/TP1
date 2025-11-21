package mg.itu.notesapi.service;

import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.dto.SemesterGradesResponse;
import mg.itu.notesapi.dto.YearGradesResponse;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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
    public YearGradesResponse getYearGrades(Long studentId, Integer yearLevel) {
        // Vérifier que l'étudiant existe
        Etudiant etudiant = etudiantRepository.findById(studentId)
                .orElseThrow(() -> new ApiException(
                        ErrorCodes.STU_001,
                        "Étudiant non trouvé avec l'ID: " + studentId
                ));
        
        // Déterminer les semestres de l'année (L1 = S1+S2, L2 = S3+S4)
        Long semester1Id = (long) (yearLevel * 2 - 1);
        Long semester2Id = (long) (yearLevel * 2);
        List<Long> semesterIds = List.of(semester1Id, semester2Id);
        
        // Récupérer toutes les notes de l'année
        List<Note> allNotes = noteRepository.findByStudentAndSemesters(studentId, semesterIds);
        
        if (allNotes.isEmpty()) {
            throw new ApiException(
                    ErrorCodes.YEAR_001,
                    "Aucune note trouvée pour cette année"
            );
        }
        
        // Grouper les notes par semestre
        Map<Long, List<Note>> notesBySemester = allNotes.stream()
                .collect(Collectors.groupingBy(n -> n.getMatiere().getSemestre().getIdSemestre()));
        
        // Construire les informations de l'étudiant
        YearGradesResponse.StudentInfo studentInfo = YearGradesResponse.StudentInfo.builder()
                .id(etudiant.getIdEtudiant())
                .firstName(etudiant.getPrenom())
                .lastName(etudiant.getNom())
                .email(etudiant.getEmail())
                .birthDate(etudiant.getDateNaissance())
                .build();
        
        // Construire les données pour chaque semestre
        List<YearGradesResponse.SemesterData> semesterDataList = new ArrayList<>();
        BigDecimal totalYearCredits = BigDecimal.ZERO;
        BigDecimal totalWeightedSum = BigDecimal.ZERO;
        
        for (Long semesterId : semesterIds) {
            List<Note> semesterNotes = notesBySemester.getOrDefault(semesterId, new ArrayList<>());
            
            if (!semesterNotes.isEmpty()) {
                // Construire la liste des notes
                List<YearGradesResponse.GradeInfo> gradeInfos = semesterNotes.stream()
                        .map(note -> {
                            YearGradesResponse.SubjectInfo subjectInfo = YearGradesResponse.SubjectInfo.builder()
                                    .id(note.getMatiere().getIdMatiere())
                                    .code(note.getMatiere().getCodeMatiere())
                                    .name(note.getMatiere().getLibelle())
                                    .credits(note.getMatiere().getCredit())
                                    .type(note.getMatiere().getTypeMatiere() != null ? 
                                          note.getMatiere().getTypeMatiere().getLibelle() : "N/A")
                                    .build();
                            
                            return YearGradesResponse.GradeInfo.builder()
                                    .subject(subjectInfo)
                                    .grade(note.getNote())
                                    .build();
                        })
                        .collect(Collectors.toList());
                
                // Calculer les statistiques du semestre
                BigDecimal semesterCredits = semesterNotes.stream()
                        .map(n -> n.getMatiere().getCredit())
                        .reduce(BigDecimal.ZERO, BigDecimal::add);
                
                BigDecimal semesterWeightedSum = semesterNotes.stream()
                        .map(n -> n.getNote().multiply(n.getMatiere().getCredit()))
                        .reduce(BigDecimal.ZERO, BigDecimal::add);
                
                BigDecimal semesterAverage = semesterCredits.compareTo(BigDecimal.ZERO) > 0
                        ? semesterWeightedSum.divide(semesterCredits, 2, RoundingMode.HALF_UP)
                        : BigDecimal.ZERO;
                
                // Récupérer le parcours si disponible
                String trackName = null;
                if (!semesterNotes.isEmpty() && semesterNotes.get(0).getMatiere().getParcours() != null) {
                    trackName = semesterNotes.get(0).getMatiere().getParcours().getLibelle();
                }
                
                // Ajouter les données du semestre
                semesterDataList.add(YearGradesResponse.SemesterData.builder()
                        .semesterId(semesterId)
                        .semesterName("SEMESTRE " + semesterId)
                        .track(trackName)
                        .totalCredits(semesterCredits)
                        .average(semesterAverage)
                        .passed(semesterAverage.compareTo(new BigDecimal("10")) >= 0)
                        .grades(gradeInfos)
                        .build());
                
                // Accumuler pour le total de l'année
                totalYearCredits = totalYearCredits.add(semesterCredits);
                totalWeightedSum = totalWeightedSum.add(semesterWeightedSum);
            }
        }
        
        // Calculer la moyenne générale de l'année
        BigDecimal yearAverage = totalYearCredits.compareTo(BigDecimal.ZERO) > 0
                ? totalWeightedSum.divide(totalYearCredits, 2, RoundingMode.HALF_UP)
                : BigDecimal.ZERO;
        
        YearGradesResponse.SummaryInfo summaryInfo = YearGradesResponse.SummaryInfo.builder()
                .totalCredits(totalYearCredits)
                .average(yearAverage)
                .passed(yearAverage.compareTo(new BigDecimal("10")) >= 0)
                .build();
        
        return YearGradesResponse.builder()
                .student(studentInfo)
                .semesters(semesterDataList)
                .summary(summaryInfo)
                .build();
    }
    
    @Transactional(readOnly = true)
    public List<SemesterGradesResponse> getGradesByStudentId(Integer studentId) {
        // Récupérer toutes les notes d'un étudiant
        List<Note> notes = noteRepository.findAll().stream()
                .filter(note -> note.getEtudiant().getIdEtudiant().equals(studentId))
                .collect(Collectors.toList());
        
        if (notes.isEmpty()) {
            throw new ApiException(
                    ErrorCodes.STU_001,
                    "Aucune note trouvée pour cet étudiant"
            );
        }
        
        // Grouper par semestre
        return notes.stream()
                .collect(Collectors.groupingBy(note -> note.getMatiere().getSemestre().getIdSemestre()))
                .entrySet().stream()
                .map(entry -> buildSemesterResponse(entry.getValue()))
                .collect(Collectors.toList());
    }
    
    @Transactional(readOnly = true)
    public List<SemesterGradesResponse> getAllGrades(Integer semestre, Integer annee) {
        List<Note> notes;
        
        if (semestre != null) {
            // Filtrer par semestre
            notes = noteRepository.findAll().stream()
                    .filter(note -> note.getMatiere().getSemestre().getIdSemestre().equals(semestre.longValue()))
                    .collect(Collectors.toList());
        } else if (annee != null) {
            // Filtrer par année
            Long semester1Id = (long) (annee * 2 - 1);
            Long semester2Id = (long) (annee * 2);
            notes = noteRepository.findAll().stream()
                    .filter(note -> {
                        Long semId = note.getMatiere().getSemestre().getIdSemestre();
                        return semId.equals(semester1Id) || semId.equals(semester2Id);
                    })
                    .collect(Collectors.toList());
        } else {
            // Toutes les notes
            notes = noteRepository.findAll();
        }
        
        if (notes.isEmpty()) {
            throw new ApiException(
                    ErrorCodes.STU_001,
                    "Aucune note trouvée"
            );
        }
        
        // Grouper par étudiant et semestre
        return notes.stream()
                .collect(Collectors.groupingBy(note -> 
                    note.getEtudiant().getIdEtudiant() + "-" + 
                    note.getMatiere().getSemestre().getIdSemestre()
                ))
                .values().stream()
                .map(this::buildSemesterResponse)
                .collect(Collectors.toList());
    }
    
    private SemesterGradesResponse buildSemesterResponse(List<Note> notes) {
        if (notes.isEmpty()) {
            return null;
        }
        
        Note firstNote = notes.get(0);
        
        // Construire les informations de l'étudiant
        SemesterGradesResponse.StudentInfo studentInfo = SemesterGradesResponse.StudentInfo.builder()
                .id(firstNote.getEtudiant().getIdEtudiant())
                .firstName(firstNote.getEtudiant().getPrenom())
                .lastName(firstNote.getEtudiant().getNom())
                .email(firstNote.getEtudiant().getEmail())
                .build();
        
        // Construire les informations du semestre
        SemesterGradesResponse.SemesterInfo semesterInfo = SemesterGradesResponse.SemesterInfo.builder()
                .id(firstNote.getMatiere().getSemestre().getIdSemestre())
                .name(firstNote.getMatiere().getSemestre().getLibelle())
                .build();
        
        // Construire les informations du parcours
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
}
