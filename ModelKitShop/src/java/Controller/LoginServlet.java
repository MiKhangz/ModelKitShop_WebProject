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
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
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
        
        // Show login form
        request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        // Validate input
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
            return;
        }
        
        try {
            // Check credentials
            User user = userDAO.getUserByUsername(username.trim());
            
            if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
                // Login successful
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                
                // Set session timeout (30 minutes)
                session.setMaxInactiveInterval(30 * 60);
                
                // Remember me functionality
                if ("on".equals(remember)) {
                    Cookie userCookie = new Cookie("rememberedUser", username);
                    userCookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
                    response.addCookie(userCookie);
                }
                
                // Redirect to original page or home
                String redirectUrl = request.getParameter("redirect");
                if (redirectUrl != null && !redirectUrl.isEmpty()) {
                    response.sendRedirect(redirectUrl);
                } else {
                    response.sendRedirect(request.getContextPath() + "/views/product/home.jsp");
                }
            } else {
                // Login failed
                request.setAttribute("error", "Invalid username or password");
                request.setAttribute("username", username);
                request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred. Please try again.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/views/user/login.jsp").forward(request, response);
        }
    }
}
