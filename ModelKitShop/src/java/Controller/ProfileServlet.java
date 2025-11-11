package Controller;

import DAO.UserDAO;
import Models.User;
import Utils.PasswordUtil;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
/*
Ghi chú:
+Mấy ông thủ xài doPost để chạy nha, giống hướng dẫn processRequest của Thầy
+Kiểu này tách nhỏ ra dễ fix hơn
+Để lúc tui ghép code tụi mình lại, tui đỡ phải mò
+Ví dụ như LoginServlet tui viết
   
From Khang
*/
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get current user from session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Refresh user data from database
        User refreshedUser = userDAO.getUserById(user.getId());
        if (refreshedUser != null) {
            session.setAttribute("user", refreshedUser);
            request.setAttribute("user", refreshedUser);
        }
        
        // Show profile page
        request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("updateProfile".equals(action)) {
            updateProfile(request, response);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get form parameters
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Validate input
        StringBuilder errors = new StringBuilder();
        
        if (email == null || email.trim().isEmpty()) {
            errors.append("Email is required. ");
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.append("Invalid email format. ");
        }
        
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.append("Full name is required. ");
        }
        
        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
            return;
        }
        
        try {
            // Update user information
            user.setEmail(email.trim());
            user.setFullName(fullName.trim());
            user.setPhone(phone != null ? phone.trim() : null);
            user.setAddress(address != null ? address.trim() : null);
            
            boolean success = userDAO.updateUser(user);
            
            if (success) {
                // Update session
                User updatedUser = userDAO.getUserById(user.getId());
                session.setAttribute("user", updatedUser);
                
                request.setAttribute("success", "Profile updated successfully!");
                request.setAttribute("user", updatedUser);
                request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to update profile. Please try again.");
                request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
        }
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get form parameters
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        StringBuilder errors = new StringBuilder();
        
        if (currentPassword == null || currentPassword.isEmpty()) {
            errors.append("Current password is required. ");
        }
        
        if (newPassword == null || newPassword.isEmpty()) {
            errors.append("New password is required. ");
        } else if (newPassword.length() < 6) {
            errors.append("New password must be at least 6 characters. ");
        }
        
        if (!newPassword.equals(confirmPassword)) {
            errors.append("New passwords do not match. ");
        }
        
        if (errors.length() > 0) {
            request.setAttribute("passwordError", errors.toString());
            request.setAttribute("user", user);
            request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
            return;
        }
        
        try {
            // Verify current password
            User dbUser = userDAO.getUserById(user.getId());
            if (!PasswordUtil.verifyPassword(currentPassword, dbUser.getPassword())) {
                request.setAttribute("passwordError", "Current password is incorrect.");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
                return;
            }
            
            // Update password
            String hashedPassword = PasswordUtil.hashPassword(newPassword);
            boolean success = userDAO.updatePassword(user.getId(), hashedPassword);
            
            if (success) {
                request.setAttribute("passwordSuccess", "Password changed successfully!");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
            } else {
                request.setAttribute("passwordError", "Failed to change password. Please try again.");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("passwordError", "An error occurred. Please try again.");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
        }
    }
}
