package Controller;

import DAO.CartDAO;
import DAO.ProductDAO;
import Models.User;
import Models.Cart;
import Models.Product;

import java.io.IOException;
import java.math.BigDecimal;
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
@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    
    private CartDAO cartDAO = new CartDAO();
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get current user
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + 
                request.getContextPath() + "/cart");
            return;
        }
        
        try {
            // Get cart items
            List<Cart> cartItems = cartDAO.getCartByUserId(user.getId());
            
            // Calculate total
            BigDecimal total = BigDecimal.ZERO;
            for (Cart item : cartItems) {
                total = total.add(item.getSubtotal());
            }
            
            // Set attributes
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", total);
            request.setAttribute("itemCount", cartItems.size());
            
            // Forward to JSP
            request.getRequestDispatcher("/views/order/cart.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading your cart.");
            request.getRequestDispatcher("/views/order/cart.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        // Get current user
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + 
                request.getContextPath() + "/cart");
            return;
        }
        
        try {
            if ("add".equals(action)) {
                addToCart(request, response, user);
            } else if ("update".equals(action)) {
                updateCart(request, response, user);
            } else if ("remove".equals(action)) {
                removeFromCart(request, response, user);
            } else if ("clear".equals(action)) {
                clearCart(request, response, user);
            } else {
                response.sendRedirect(request.getContextPath() + "/cart");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/cart?error=true");
        }
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            // Validate quantity
            if (quantity < 1) {
                response.sendRedirect(request.getContextPath() + "/products?action=detail&id=" + 
                    productId + "&error=invalidQuantity");
                return;
            }
            
            // Check product stock
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/products?error=productNotFound");
                return;
            }
            
            if (!product.hasStock(quantity)) {
                response.sendRedirect(request.getContextPath() + "/products?action=detail&id=" + 
                    productId + "&error=outOfStock");
                return;
            }
            
            // Add to cart
            boolean success = cartDAO.addToCart(user.getId(), productId, quantity);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/cart?added=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/products?action=detail&id=" + 
                    productId + "&error=addFailed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/products?error=invalidInput");
        }
    }
    
    private void updateCart(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (quantity < 1) {
                // If quantity is 0 or negative, remove item
                cartDAO.removeFromCart(user.getId(), productId);
            } else {
                // Check product stock
                Product product = productDAO.getProductById(productId);
                if (product != null && product.hasStock(quantity)) {
                    cartDAO.updateCartQuantity(user.getId(), productId, quantity);
                } else {
                    response.sendRedirect(request.getContextPath() + "/cart?error=outOfStock");
                    return;
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart?error=invalidInput");
        }
    }
    
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            cartDAO.removeFromCart(user.getId(), productId);
            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart?error=invalidInput");
        }
    }
    
    private void clearCart(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        
        cartDAO.clearCart(user.getId());
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
