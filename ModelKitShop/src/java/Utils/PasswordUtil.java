package Utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Password hashing and verification utility
 * Member 2 responsibility
 * 
 * This class provides methods to hash passwords securely using SHA-256 with salt.
 * Note: For production, consider using BCrypt instead.
 */
public class PasswordUtil {
    
    private static final String ALGORITHM = "SHA-256";
    private static final int SALT_LENGTH = 16;
    
    /**
     * Generate a random salt
     * @return Base64 encoded salt string
     */
    private static String generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[SALT_LENGTH];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }
    
    /**
       Hash a password with a given salt
       password Plain text password
       salt Salt string
       return Hashed password
     */
    private static String hashWithSalt(String password, String salt) {
        try {
            MessageDigest md = MessageDigest.getInstance(ALGORITHM);
            md.update(Base64.getDecoder().decode(salt));
            byte[] hashedPassword = md.digest(password.getBytes());
            return Base64.getEncoder().encodeToString(hashedPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
    
    /**
     * Hash a password for storage
     * Format: salt:hashedPassword
     * @param password Plain text password
     * @return Hashed password with salt (format: salt:hash)
     */
    public static String hashPassword(String password) {
        String salt = generateSalt();
        String hashedPassword = hashWithSalt(password, salt);
        return salt + ":" + hashedPassword;
    }
    
    /**
     * Verify a password against a stored hash
     * @param password Plain text password to verify
     * @param storedHash Stored hash (format: salt:hash)
     * @return true if password matches, false otherwise
     */
    public static boolean verifyPassword(String password, String storedHash) {
        try {
            String[] parts = storedHash.split(":");
            if (parts.length != 2) {
                return false;
            }
            String salt = parts[0];
            String hash = parts[1];
            String computedHash = hashWithSalt(password, salt);
            return hash.equals(computedHash);
        } catch (Exception e) {
            return false;
        }
    }
    
    /**
     * Simple password strength check
     * @param password Password to check
     * @return true if password is strong enough
     */
    public static boolean isPasswordStrong(String password) {
        if (password == null || password.length() < 6) {
            return false;
        }
        // Add more checks as needed:
        // - Contains uppercase
        // - Contains lowercase
        // - Contains digit
        // - Contains special character
        return true;
    }
    
    // Main method for testing
    public static void main(String[] args) {
        String password = "myPassword123";
        
        // Hash password
        String hashed = hashPassword(password);
        System.out.println("Original password: " + password);
        System.out.println("Hashed password: " + hashed);
        
        // Verify correct password
        boolean isCorrect = verifyPassword(password, hashed);
        System.out.println("Verification (correct): " + isCorrect);
        
        // Verify incorrect password
        boolean isIncorrect = verifyPassword("wrongPassword", hashed);
        System.out.println("Verification (incorrect): " + isIncorrect);
    }
}
