package mg.itu.notesapi.exception;

public class ErrorCodes {
    
    // Authentication errors
    public static final String AUTH_001 = "AUTH_001";
    public static final String AUTH_002 = "AUTH_002";
    public static final String AUTH_003 = "AUTH_003";
    public static final String AUTH_004 = "AUTH_004";
    
    // Student errors
    public static final String STU_001 = "STU_001";
    public static final String STU_002 = "STU_002";
    
    // Semester errors
    public static final String SEM_001 = "SEM_001";
    
    // Year errors
    public static final String YEAR_001 = "YEAR_001";
    
    // Database errors
    public static final String DB_001 = "DB_001";
    public static final String DB_002 = "DB_002";
    
    // Validation errors
    public static final String VAL_001 = "VAL_001";
    public static final String VAL_002 = "VAL_002";
    
    // System errors
    public static final String SYS_001 = "SYS_001";
    
    private ErrorCodes() {
        // Utility class
    }
}
