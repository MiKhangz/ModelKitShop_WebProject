package Models;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

/**
 * Order model - Represents a customer order
 * Member 3 responsibility
 */
public class Order implements Serializable {
    private int id;
    private int userId;
    private LocalDateTime orderDate;
    private BigDecimal totalAmount;
    // PENDING, PROCESSING, SHIPPED, DELIVERED, CANCELLED
    private String status; 
    private String shippingAddress;
    
    // For display purposes (not in database)
    private User user;
    private List<OrderDetail> orderDetails;
    
    // Constructors
    public Order() {
    }
    
    public Order(int id, int userId, LocalDateTime orderDate, BigDecimal totalAmount, 
                 String status, String shippingAddress) {
        this.id = id;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.shippingAddress = shippingAddress;
    }
    
    public Order(int userId, BigDecimal totalAmount, String status, String shippingAddress) {
        this.userId = userId;
        this.totalAmount = totalAmount;
        this.status = status;
        this.shippingAddress = shippingAddress;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public LocalDateTime getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }
    
    // Helper for JSP fmt:formatDate (expects java.util.Date)
    public Date getOrderDateAsDate() {
        if (this.orderDate == null) return null;
        return Date.from(this.orderDate.atZone(ZoneId.systemDefault()).toInstant());
    }
    
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getShippingAddress() {
        return shippingAddress;
    }
    
    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }
    
    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }
    
    // Utility methods
    public boolean isPending() {
        return "PENDING".equalsIgnoreCase(this.status);
    }
    
    public boolean isProcessing() {
        return "PROCESSING".equalsIgnoreCase(this.status);
    }
    
    public boolean isShipped() {
        return "SHIPPED".equalsIgnoreCase(this.status);
    }
    
    public boolean isDelivered() {
        return "DELIVERED".equalsIgnoreCase(this.status);
    }
    
    public boolean isCancelled() {
        return "CANCELLED".equalsIgnoreCase(this.status);
    }
    
    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", userId=" + userId +
                ", orderDate=" + orderDate +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                '}';
    }
}
