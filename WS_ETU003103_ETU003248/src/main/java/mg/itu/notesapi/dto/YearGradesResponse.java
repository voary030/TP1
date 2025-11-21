package mg.itu.notesapi.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class YearGradesResponse {
    
    private StudentInfo student;
    private List<SemesterData> semesters;
    private SummaryInfo summary;
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class StudentInfo {
        private Long id;
        private String firstName;
        private String lastName;
        private String email;
        private LocalDate birthDate;
    }
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class SemesterData {
        private Long semesterId;
        private String semesterName;
        private String track;
        private BigDecimal totalCredits;
        private BigDecimal average;
        private Boolean passed;
        private List<GradeInfo> grades;
    }
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class GradeInfo {
        private SubjectInfo subject;
        private BigDecimal grade;
    }
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class SubjectInfo {
        private Long id;
        private String code;
        private String name;
        private BigDecimal credits;
        private String type;
    }
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class SummaryInfo {
        private BigDecimal totalCredits;
        private BigDecimal average;
        private Boolean passed;
    }
}
