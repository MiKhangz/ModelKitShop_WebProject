package Controller;

import DAO.UserDAO;
import Models.User;
import Utils.PasswordUtil;

import java.io.IOException;
import java.sql.Timestamp;
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
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/views/product/home.jsp");
            return;
        }
        
        // Show registration form
        request.getRequestDispatcher("/views/user/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Validate input
        StringBuilder errors = new StringBuilder();
        
        if (username == null || username.trim().isEmpty()) {
            errors.append("Username is required. ");
        } else if (username.length() < 3 || username.length() > 50) {
            errors.append("Username must be between 3 and 50 characters. ");
        }
        
        if (password == null || password.isEmpty()) {
            errors.append("Password is required. ");
        } else if (password.length() < 6) {
            errors.append("Password must be at least 6 characters. ");
        }
        
        if (!password.equals(confirmPassword)) {
            errors.append("Passwords do not match. ");
        }
        
        if (email == null || email.trim().isEmpty()) {
            errors.append("Email is required. ");
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.append("Invalid email format. ");
        }
        
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.append("Full name is required. ");
        }
        
        // If validation fails, return to form
        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.getRequestDispatcher("/views/user/register.jsp").forward(request, response);
            return;
        }
        
        try {
            // Check if username already exists
            if (userDAO.getUserByUsername(username.trim()) != null) {
                request.setAttribute("error", "Username already exists");
                request.setAttribute("email", email);
                request.setAttribute("fullName", fullName);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.getRequestDispatcher("/views/user/register.jsp").forward(request, response);
                return;
            }
            // Check if email already exists
            if (userDAO.getUserByEmail(email.trim()) != null) {
                request.setAttribute("error", "Email already exists");
                request.setAttribute("username", username);
                request.setAttribute("fullName", fullName);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.getRequestDispatcher("/views/user/register.jsp").forward(request, response);
                return;
            }
            
            // Create new user
            User newUser = new User();
            newUser.setUsername(username.trim());
            newUser.setPassword(PasswordUtil.hashPassword(password));
            newUser.setEmail(email.trim());
            newUser.setFullName(fullName.trim());
            newUser.setPhone(phone != null ? phone.trim() : null);
            newUser.setAddress(address != null ? address.trim() : null);
            newUser.setRole("USER"); // Default role
            newUser.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            // Insert user
            boolean success = userDAO.insertUser(newUser);
            
            if (success) {
                // Registration successful, redirect to login
                request.setAttribute("success", "Registration successful! Please login.");
                request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("fullName", fullName);
                request.setAttribute("phone", phone);
                request.setAttribute("address", address);
                request.getRequestDispatcher("/views/user/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.getRequestDispatcher("/views/user/register.jsp").forward(request, response);
        }
    }
}
