package mg.itu.notesapi.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.ZonedDateTime;
import java.util.HashMap;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ApiResponse<T> {
    
    private String status;
    private T data;
    private ErrorDetail error;
    private Meta meta;
    
    public static <T> ApiResponse<T> success(T data) {
        ApiResponse<T> response = new ApiResponse<>();
        response.setStatus("success");
        response.setData(data);
        response.setMeta(new Meta());
        return response;
    }
    
    public static <T> ApiResponse<T> success(T data, Map<String, Object> additionalMeta) {
        ApiResponse<T> response = new ApiResponse<>();
        response.setStatus("success");
        response.setData(data);
        Meta meta = new Meta();
        if (additionalMeta != null) {
            additionalMeta.forEach(meta::addProperty);
        }
        response.setMeta(meta);
        return response;
    }
    
    public static <T> ApiResponse<T> error(String code, String message) {
        return error(code, message, (Object) null);
    }
    
    public static <T> ApiResponse<T> error(String code, String message, Object details) {
        ApiResponse<T> response = new ApiResponse<>();
        response.setStatus("error");
        response.setError(new ErrorDetail(code, message, details));
        response.setMeta(new Meta());
        return response;
    }
    
    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class ErrorDetail {
        private String code;
        private String message;
        private Object details;
    }
    
    @Data
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class Meta {
        private String timestamp;
        private String version = "1.0";
        private Map<String, Object> additionalProperties;
        
        public Meta() {
            this.timestamp = ZonedDateTime.now().toString();
        }
        
        public void addProperty(String key, Object value) {
            if (additionalProperties == null) {
                additionalProperties = new HashMap<>();
            }
            additionalProperties.put(key, value);
        }
    }
}
