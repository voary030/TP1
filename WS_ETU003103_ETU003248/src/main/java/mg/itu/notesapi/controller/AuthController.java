package mg.itu.notesapi.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import mg.itu.notesapi.dto.ApiResponse;
import mg.itu.notesapi.dto.LoginRequest;
import mg.itu.notesapi.dto.LoginResponse;
import mg.itu.notesapi.service.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {
    
    private final AuthService authService;
    
    @PostMapping("/login")
    public ResponseEntity<ApiResponse<LoginResponse>> login(
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String password,
            @RequestBody(required = false) LoginRequest request) {
        
        // Accepter les credentials soit dans l'URL (query params) soit dans le body
        LoginRequest loginRequest;
        if (email != null && password != null) {
            // Credentials dans l'URL
            loginRequest = new LoginRequest(email, password);
        } else if (request != null) {
            // Credentials dans le body
            loginRequest = request;
        } else {
            throw new IllegalArgumentException("Email et mot de passe requis");
        }
        
        LoginResponse response = authService.login(loginRequest);
        return ResponseEntity.ok(ApiResponse.success(response));
    }
}
