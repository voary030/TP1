package mg.itu.notesapi.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AdminLoginRequest {
    @JsonProperty("email")
    private String email;

    @JsonProperty("mot_de_passe")
    private String motDePasse;

    // Constructors
    public AdminLoginRequest() {}

    public AdminLoginRequest(String email, String motDePasse) {
        this.email = email;
        this.motDePasse = motDePasse;
    }

    // Getters and Setters
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }
}
