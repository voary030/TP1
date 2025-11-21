package mg.itu.notesapi;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * Utilitaire pour générer des hashes BCrypt pour les mots de passe
 * Exécuter cette classe pour obtenir les hashes à insérer dans la base
 */
public class PasswordHashGenerator {
    
    public static void main(String[] args) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        // Générer les hashes pour les utilisateurs admin
        String[] passwords = {
            "AdminPass123!",
            "SecPass123!"
        };
        
        String[] emails = {
            "admin@univ.mg",
            "secretaire@univ.mg"
        };
        
        System.out.println("=== BCrypt Password Hash Generator ===\n");
        
        for (int i = 0; i < passwords.length; i++) {
            String hash = encoder.encode(passwords[i]);
            System.out.println("Email: " + emails[i]);
            System.out.println("Password: " + passwords[i]);
            System.out.println("BCrypt Hash: " + hash);
            System.out.println("---");
        }
        
        System.out.println("\n=== SQL Statements ===");
        for (int i = 0; i < passwords.length; i++) {
            String hash = encoder.encode(passwords[i]);
            System.out.println("-- Pour " + emails[i]);
            System.out.println("UPDATE users SET mot_de_passe = '" + hash + "' WHERE email = '" + emails[i] + "';");
            System.out.println();
        }
    }
}
