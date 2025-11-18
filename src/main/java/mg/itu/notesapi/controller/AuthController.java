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
    public ResponseEntity<ApiResponse<LoginResponse>> login(@Valid @RequestBody LoginRequest request) {
        LoginResponse response = authService.login(request);
        return ResponseEntity.ok(ApiResponse.success(response));
    }
}
