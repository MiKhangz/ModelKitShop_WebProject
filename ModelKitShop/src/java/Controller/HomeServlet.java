package Controller;

import DAO.ProductDAO;
import Models.Product;

import java.io.IOException;
import java.util.List;
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
@WebServlet({"", "/home", "/index"})
public class HomeServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get featured products (latest 8 products)
            List<Product> featuredProducts = productDAO.getProducts(1, 8, null, null, null);
            //List<Product> featuredProducts = new java.util.ArrayList<>();
            // Set attributes
            request.setAttribute("featuredProducts", featuredProducts);
           // request.setAttribute("featuredProducts", featuredProducts);
            // Forward to home JSP
            request.getRequestDispatcher("/views/product/home.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading the homepage.");
            request.getRequestDispatcher("/views/product/home.jsp").forward(request, response);
        }
    }
}
