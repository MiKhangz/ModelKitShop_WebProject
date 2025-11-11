package Controller;

import Models.Order;
import Models.Cart;
import Models.Product;
import Models.User;
import DAO.CartDAO;
import DAO.OrderDAO;
import DAO.ProductDAO;
import java.util.*;
import java.sql.Timestamp;
import java.sql.SQLException;
import java.math.BigDecimal;

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
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    
    private CartDAO cartDAO = new CartDAO();
    private OrderDAO orderDAO = new OrderDAO();
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get current user
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + 
                request.getContextPath() + "/checkout");
            return;
        }
        
        try {
            // Get cart items
            List<Cart> cartItems = cartDAO.getCartByUserId(user.getId());
            
            if (cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart?error=emptyCart");
                return;
            }
            
            // Calculate total
            BigDecimal total = BigDecimal.ZERO;
            for (Cart item : cartItems) {
                total = total.add(item.getSubtotal());
            }
            
            // Set attributes
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", total);
            request.setAttribute("user", user);
            
            // Forward to checkout page
            request.getRequestDispatcher("/views/order/checkout.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading checkout page.");
            request.getRequestDispatcher("/views/order/checkout.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get current user
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            // Get cart items
            List<Cart> cartItems = cartDAO.getCartByUserId(user.getId());
            
            if (cartItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart?error=emptyCart");
                return;
            }
            
            // Get shipping information
            String shippingAddress = request.getParameter("shippingAddress");
            String phone = request.getParameter("phone");
            String notes = request.getParameter("notes");
            
            // Validate shipping address
            if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
                request.setAttribute("error", "Shipping address is required");
                request.setAttribute("cartItems", cartItems);
                request.setAttribute("user", user);
                request.getRequestDispatcher("/views/order/checkout.jsp").forward(request, response);
                return;
            }
            
            // Check stock availability for all items
            for (Cart item : cartItems) {
                Product product = productDAO.getProductById(item.getProductId());
                if (product == null || !product.hasStock(item.getQuantity())) {
                    request.setAttribute("error", "Some items are out of stock. Please update your cart.");
                    request.setAttribute("cartItems", cartItems);
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/views/order/checkout.jsp").forward(request, response);
                    return;
                }
            }
            
            // Calculate total
            BigDecimal total = BigDecimal.ZERO;
            for (Cart item : cartItems) {
                total = total.add(item.getSubtotal());
            }
            
            // Create order
            Order order = new Order();
            order.setUserId(user.getId());
            order.setTotalAmount(total);
            order.setStatus("PENDING");
            order.setShippingAddress(shippingAddress.trim());
            order.setOrderDate(java.time.LocalDateTime.now());
            
            // Create order and get generated ID
            int orderId = orderDAO.createOrder(order);
            
            if (orderId > 0) {
                // Add order details
                for (Cart item : cartItems) {
                    Product product = productDAO.getProductById(item.getProductId());
                    orderDAO.addOrderDetail(orderId, item.getProductId(), 
                        item.getQuantity(), product.getPrice());
                    
                    // Update product stock
                    productDAO.updateStock(item.getProductId(), 
                        product.getStockQuantity() - item.getQuantity());
                }
                
                // Clear cart
                cartDAO.clearCart(user.getId());
                
                // Redirect to order confirmation
                response.sendRedirect(request.getContextPath() + "/orders?action=detail&id=" + orderId);
            } else {
                request.setAttribute("error", "Failed to create order. Please try again.");
                request.setAttribute("cartItems", cartItems);
                request.setAttribute("total", total);
                request.setAttribute("user", user);
                request.getRequestDispatcher("/views/order/checkout.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your order.");
            request.getRequestDispatcher("/views/order/checkout.jsp").forward(request, response);
        }
    }
}
