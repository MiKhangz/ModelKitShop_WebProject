package Controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    /*
Ghi chú:
+Mấy ông thủ xài doPost để chạy nha, giống hướng dẫn processRequest của Thầy
+Kiểu này tách nhỏ ra dễ fix hơn
+Để lúc tui ghép code tụi mình lại, tui đỡ phải mò
+Ví dụ như LoginServlet tui viết
   
From Khang
*/
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Invalidate session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        // Remove remember me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberedUser".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    break;
                }
            }
        }
        
        // Redirect to home page
        response.sendRedirect(request.getContextPath() + "/views/product/home.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
