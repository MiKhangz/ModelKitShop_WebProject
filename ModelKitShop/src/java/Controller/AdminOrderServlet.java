package Controller;

import DAO.OrderDAO;
import Models.Order;
import Models.OrderDetail;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*
Ghi chú:
+Mấy ông thủ xài doPost để chạy nha, giống hướng dẫn processRequest của Thầy
+Kiểu này tách nhỏ ra dễ fix hơn
+Để lúc tui ghép code tụi mình lại, tui đỡ phải mò
+Ví dụ như LoginServlet tui viết
   
From Khang
*/
@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    
    private OrderDAO orderDAO = new OrderDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("detail".equals(action)) {
            showOrderDetail(request, response);
        } else {
            showOrderList(request, response);
        }
    }
    
    private void showOrderList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get filter parameters
            String status = request.getParameter("status");
            
            List<Order> orders;
            if (status != null && !status.isEmpty() && !"ALL".equals(status)) {
                orders = orderDAO.getOrdersByStatus(status);
            } else {
                orders = orderDAO.getAllOrders();
            }
            
            // Set attributes
            request.setAttribute("orders", orders);
            request.setAttribute("selectedStatus", status);
            
            // Forward to JSP
            request.getRequestDispatcher("/views/admin/manage-orders.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading orders.");
            request.getRequestDispatcher("/views/admin/manage-orders.jsp").forward(request, response);
        }
    }
    
    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            
            // Get order
            Order order = orderDAO.getOrderById(orderId);
            
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=notFound");
                return;
            }
            
            // Get order details
            List<OrderDetail> orderDetails = orderDAO.getOrderDetailsByOrderId(orderId);
            
            // Set attributes
            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);
            
            // Forward to JSP
            request.getRequestDispatcher("/views/admin/order-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalidId");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading order details.");
            request.getRequestDispatcher("/views/admin/order-detail.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            updateOrderStatus(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/orders");
        }
    }
    
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String newStatus = request.getParameter("status");
            
            // Validate status
            if (newStatus == null || newStatus.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalidStatus");
                return;
            }
            
            // Valid status values
            String[] validStatuses = {"PENDING", "PROCESSING", "SHIPPED", "DELIVERED", "CANCELLED"};
            boolean validStatus = false;
            for (String status : validStatuses) {
                if (status.equals(newStatus)) {
                    validStatus = true;
                    break;
                }
            }
            
            if (!validStatus) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalidStatus");
                return;
            }
            
            // Update status
            boolean success = orderDAO.updateOrderStatus(orderId, newStatus);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + 
                    orderId + "&updated=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/orders?action=detail&id=" + 
                    orderId + "&error=updateFailed");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/orders?error=invalidId");
        }
    }
}
