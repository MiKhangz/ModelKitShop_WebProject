package Controller;

import DAO.OrderDAO;
import Models.User;
import Models.Order;
import Models.OrderDetail;
import java.util.*;

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
@WebServlet("/orders")
public class OrderServlet extends HttpServlet {
    
    private OrderDAO orderDAO = new OrderDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get current user
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login?redirect=" + 
                request.getContextPath() + "/orders");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("detail".equals(action)) {
            showOrderDetail(request, response, user);
        } else {
            showOrderHistory(request, response, user);
        }
    }
    
    private void showOrderHistory(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        
        try {
            // Get user's orders
            List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
            
            // Set attributes
            request.setAttribute("orders", orders);
            
            // Forward to JSP
            request.getRequestDispatcher("/views/order/order-history.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading your orders.");
            request.getRequestDispatcher("/views/order/order-history.jsp").forward(request, response);
        }
    }
    
    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        
        try {
            String orderIdStr = request.getParameter("id");
            
            if (orderIdStr == null || orderIdStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/orders");
                return;
            }
            
            int orderId = Integer.parseInt(orderIdStr);
            
            // Get order
            Order order = orderDAO.getOrderById(orderId);
            
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/orders?error=notFound");
                return;
            }
            
            // Check if order belongs to current user (security check)
            if (order.getUserId() != user.getId()) {
                response.sendRedirect(request.getContextPath() + "/orders?error=unauthorized");
                return;
            }
            
            // Get order details
            List<OrderDetail> orderDetails = orderDAO.getOrderDetailsByOrderId(orderId);
            
            // Set attributes
            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);
            
            // Forward to JSP
            request.getRequestDispatcher("/views/order/order-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/orders?error=invalidId");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading order details.");
            request.getRequestDispatcher("/views/order/order-detail.jsp").forward(request, response);
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
        
        String action = request.getParameter("action");
        
        if ("cancel".equals(action)) {
            cancelOrder(request, response, user);
        } else {
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }
    
    private void cancelOrder(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            
            // Get order
            Order order = orderDAO.getOrderById(orderId);
            
            if (order == null || order.getUserId() != user.getId()) {
                response.sendRedirect(request.getContextPath() + "/orders?error=unauthorized");
                return;
            }
            
            // Only allow cancellation of PENDING or PROCESSING orders
            if ("PENDING".equals(order.getStatus()) || "PROCESSING".equals(order.getStatus())) {
                boolean success = orderDAO.updateOrderStatus(orderId, "CANCELLED");
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/orders?cancelled=true");
                } else {
                    response.sendRedirect(request.getContextPath() + "/orders?error=cancelFailed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/orders?error=cannotCancel");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/orders?error=invalidId");
        }
    }
}
