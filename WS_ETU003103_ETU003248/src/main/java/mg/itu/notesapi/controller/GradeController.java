package mg.itu.notesapi.controller;

import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.dto.ApiResponse;
import mg.itu.notesapi.dto.SemesterGradesResponse;
import mg.itu.notesapi.dto.YearGradesResponse;
import mg.itu.notesapi.service.GradeService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/students")
@RequiredArgsConstructor
public class GradeController {
    
    private final GradeService gradeService;
    
    @GetMapping("/{studentId}/semesters/{semesterId}/grades")
    public ResponseEntity<ApiResponse<SemesterGradesResponse>> getSemesterGrades(
            @PathVariable Long studentId,
            @PathVariable Long semesterId
    ) {
        SemesterGradesResponse response = gradeService.getSemesterGrades(studentId, semesterId);
        return ResponseEntity.ok(ApiResponse.success(response));
    }
    
    @GetMapping("/{studentId}/years/{yearLevel}/grades")
    public ResponseEntity<ApiResponse<YearGradesResponse>> getYearGrades(
            @PathVariable Long studentId,
            @PathVariable Integer yearLevel
    ) {
        YearGradesResponse response = gradeService.getYearGrades(studentId, yearLevel);
        return ResponseEntity.ok(ApiResponse.success(response));
    }
}
