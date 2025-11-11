package tools;

import Utils.PasswordUtil;

/**
 * Simple console tool to generate salted password hashes compatible with the app.
 * Usage: run main with one argument (the plain password). It prints the value to store in DB.
 */
public class HashPasswordTool {
 /*   public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Usage: HashPasswordTool <plainPassword>");
            return;
        }
        String plain = args[0];
        String hashed = PasswordUtil.hashPassword(plain);
        System.out.println("Hashed password (store this in users.password):\n" + hashed);
    }
*/
//----------------------------------------------------------------------    
    //Bị gặp vấn đề đăng nhập khi thêm hash thì xài tool này
    //lấy pass trong database bỏ vô "String[] passwords = {""};"
    //Rồi chạy code này lấy chuỗi đã hash vô DB update lại là được
    /*
    UPDATE [users] 
    SET password = 'bỏ pass đã hash vô đây'
    WHERE username = 'username cần hash';
    
    Ghi chú: Có vấn đề gì thì cứ hỏi, 22h00 tui không tiếp, 
    đi viện 1 lần rồi sợ lắm
    
    From: Khang
    */
    
    public static void main(String[] args) {
        // Temporarily hardcode passwords for testing
      String[] passwords = {"admin123"};
        
        System.out.println("=== Password Hashing Tool ===\n");
        
        for (String plain : passwords) {
            String hashed = PasswordUtil.hashPassword(plain);
            System.out.println("Plain: " + plain);
            System.out.println("Hashed: " + hashed);
            System.out.println("---\n");
        }
    }
    
    
}
