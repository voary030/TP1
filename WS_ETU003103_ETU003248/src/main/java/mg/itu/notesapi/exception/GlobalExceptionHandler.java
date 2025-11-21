package mg.itu.notesapi.exception;

import mg.itu.notesapi.dto.ApiResponse;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {
    
    @ExceptionHandler(ApiException.class)
    public ResponseEntity<ApiResponse<Object>> handleApiException(ApiException ex) {
        HttpStatus status = getHttpStatusForErrorCode(ex.getErrorCode());
        return ResponseEntity
                .status(status)
                .body(ApiResponse.error(ex.getErrorCode(), ex.getMessage(), ex.getDetails()));
    }
    
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiResponse<Object>> handleValidationException(
            MethodArgumentNotValidException ex
    ) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach(error -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        
        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(ApiResponse.error(
                        ErrorCodes.VAL_001,
                        "Erreur de validation des données",
                        errors
                ));
    }
    
    @ExceptionHandler(DataAccessException.class)
    public ResponseEntity<ApiResponse<Object>> handleDataAccessException(DataAccessException ex) {
        return ResponseEntity
                .status(HttpStatus.SERVICE_UNAVAILABLE)
                .body(ApiResponse.error(
                        ErrorCodes.DB_001,
                        "Erreur de connexion à la base de données",
                        ex.getMostSpecificCause().getMessage()
                ));
    }
    
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiResponse<Object>> handleGenericException(Exception ex) {
        return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(ApiResponse.error(
                        ErrorCodes.SYS_001,
                        "Une erreur inattendue s'est produite",
                        ex.getMessage()
                ));
    }
    
    private HttpStatus getHttpStatusForErrorCode(String errorCode) {
        if (errorCode.startsWith("AUTH_")) {
            return HttpStatus.UNAUTHORIZED;
        } else if (errorCode.startsWith("STU_") || errorCode.startsWith("SEM_") || errorCode.startsWith("YEAR_")) {
            return HttpStatus.NOT_FOUND;
        } else if (errorCode.startsWith("VAL_")) {
            return HttpStatus.BAD_REQUEST;
        } else if (errorCode.startsWith("DB_")) {
            return HttpStatus.SERVICE_UNAVAILABLE;
        }
        return HttpStatus.INTERNAL_SERVER_ERROR;
    }
}
