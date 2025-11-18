package mg.itu.notesapi;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * Utilitaire pour générer des hashes BCrypt pour les mots de passe
 * Exécuter cette classe pour obtenir les hashes à insérer dans la base
 */
public class PasswordHashGenerator {
    
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        String password = "password123";
        String hash = encoder.encode(password);
        
        System.out.println("=== BCrypt Password Hash Generator ===");
        System.out.println("Original Password: " + password);
        System.out.println("BCrypt Hash: " + hash);
        System.out.println("\nSQL Update Statement:");
        System.out.println("UPDATE Etudiant SET mot_de_passe = '" + hash + "' WHERE email = 'YOUR_EMAIL@ituniv.mg';");
    }
}
