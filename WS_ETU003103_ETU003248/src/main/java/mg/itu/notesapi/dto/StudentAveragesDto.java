package mg.itu.notesapi.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class StudentAveragesDto {
    private Long id;
    private String firstName;
    private String lastName;
    private String email;
    private BigDecimal s1Average;
    private BigDecimal s2Average;
    private BigDecimal s3Average;
    private BigDecimal s4Average;
}
