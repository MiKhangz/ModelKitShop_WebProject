package Controller;

import DAO.ProductDAO;
import DAO.CategoryDAO;
import Models.Product;
import Models.Category;
import java.util.*;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.io.IOException;
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
@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            showAddForm(request, response);
        } else if ("edit".equals(action)) {
            showEditForm(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        } else {
            showProductList(request, response);
        }
    }
    
    private void showProductList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get all products with pagination
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            
            int pageSize = 20;
            List<Product> products = productDAO.getAllProducts(page, pageSize);
            int totalProducts = productDAO.getTotalProductCount();
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            
            // Set attributes
            request.setAttribute("products", products);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalProducts", totalProducts);
            
            // Forward to JSP
            request.getRequestDispatcher("/views/admin/manage-products.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading products.");
            request.getRequestDispatcher("/views/admin/manage-products.jsp").forward(request, response);
        }
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/views/admin/product-form.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products?error=loadFailed");
        }
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(productId);
            
            if (product != null) {
                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("product", product);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/views/admin/product-form.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=notFound");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/products?error=invalidId");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("update".equals(action)) {
            updateProduct(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }
    
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get form parameters
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String imageUrl = request.getParameter("imageUrl");
            String brand = request.getParameter("brand");
            String scale = request.getParameter("scale");
            
            // Validate input
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("error", "Product name is required");
                showAddForm(request, response);
                return;
            }
            
            if (price.compareTo(BigDecimal.ZERO) <= 0) {
                request.setAttribute("error", "Price must be greater than 0");
                showAddForm(request, response);
                return;
            }
            
            if (stockQuantity < 0) {
                request.setAttribute("error", "Stock quantity cannot be negative");
                showAddForm(request, response);
                return;
            }
            
            // Create product
            Product product = new Product();
            product.setName(name.trim());
            product.setDescription(description != null ? description.trim() : null);
            product.setPrice(price);
            product.setStockQuantity(stockQuantity);
            product.setCategoryId(categoryId);
            product.setImageUrl(imageUrl != null ? imageUrl.trim() : null);
            product.setBrand(brand != null ? brand.trim() : null);
            product.setScale(scale != null ? scale.trim() : null);
          //  product.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            
            // Insert product
            boolean success = productDAO.insertProduct(product);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/products?added=true");
            } else {
                request.setAttribute("error", "Failed to add product");
                showAddForm(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format");
            showAddForm(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred");
            showAddForm(request, response);
        }
    }
    
    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get form parameters
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String imageUrl = request.getParameter("imageUrl");
            String brand = request.getParameter("brand");
            String scale = request.getParameter("scale");
            
            // Validate input
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("error", "Product name is required");
                showEditForm(request, response);
                return;
            }
            
            if (price.compareTo(BigDecimal.ZERO) <= 0) {
                request.setAttribute("error", "Price must be greater than 0");
                showEditForm(request, response);
                return;
            }
            
            // Get existing product
            Product product = productDAO.getProductById(id);
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=notFound");
                return;
            }
            
            // Update product
            product.setName(name.trim());
            product.setDescription(description != null ? description.trim() : null);
            product.setPrice(price);
            product.setStockQuantity(stockQuantity);
            product.setCategoryId(categoryId);
            product.setImageUrl(imageUrl != null ? imageUrl.trim() : null);
            product.setBrand(brand != null ? brand.trim() : null);
            product.setScale(scale != null ? scale.trim() : null);
            
            // Update in database
            boolean success = productDAO.updateProduct(product);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/products?updated=true");
            } else {
                request.setAttribute("error", "Failed to update product");
                showEditForm(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format");
            showEditForm(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred");
            showEditForm(request, response);
        }
    }
    
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        try {
            int productId = Integer.parseInt(request.getParameter("id"));
            boolean success = productDAO.deleteProduct(productId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/products?deleted=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=deleteFailed");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/products?error=invalidId");
        }
    }
}
