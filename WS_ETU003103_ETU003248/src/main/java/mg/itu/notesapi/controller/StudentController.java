package mg.itu.notesapi.controller;

import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.dto.*;
import mg.itu.notesapi.service.StudentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class StudentController {
    
    private final StudentService studentService;
    
    @GetMapping("/semesters")
    public ResponseEntity<ApiResponse<List<SemesterDto>>> getAllSemesters() {
        List<SemesterDto> semesters = studentService.getAllSemesters();
        return ResponseEntity.ok(ApiResponse.success(semesters));
    }
    
    @GetMapping("/semesters/{semesterId}/parcours")
    public ResponseEntity<ApiResponse<List<ParcoursDto>>> getParcoursBySemester(
            @PathVariable Long semesterId
    ) {
        List<ParcoursDto> parcours = studentService.getParcoursBySemester(semesterId);
        return ResponseEntity.ok(ApiResponse.success(parcours));
    }
    
    @GetMapping("/students")
    public ResponseEntity<ApiResponse<List<StudentAveragesDto>>> getAllStudentsWithAverages() {
        List<StudentAveragesDto> students = studentService.getAllStudentsWithAverages();
        return ResponseEntity.ok(ApiResponse.success(students));
    }
    
    @GetMapping("/students/{studentId}")
    public ResponseEntity<ApiResponse<StudentDetailDto>> getStudentById(
            @PathVariable Long studentId
    ) {
        StudentDetailDto student = studentService.getStudentById(studentId);
        return ResponseEntity.ok(ApiResponse.success(student));
    }
}
