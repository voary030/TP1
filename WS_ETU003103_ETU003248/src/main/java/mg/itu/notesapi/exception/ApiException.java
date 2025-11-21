package mg.itu.notesapi.exception;

public class ApiException extends RuntimeException {
    
    private final String errorCode;
    private final String details;
    
    public ApiException(String errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
        this.details = null;
    }
    
    public ApiException(String errorCode, String message, String details) {
        super(message);
        this.errorCode = errorCode;
        this.details = details;
    }
    
    public String getErrorCode() {
        return errorCode;
    }
    
    public String getDetails() {
        return details;
    }
}
