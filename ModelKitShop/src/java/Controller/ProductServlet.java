package Controller;

import DAO.ProductDAO;
import DAO.CategoryDAO;
import Models.Product;
import Models.Category;

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
@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("detail".equals(action)) {
            showProductDetail(request, response);
        } else {
            showProductList(request, response);
        }
    }
    
    private void showProductList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get parameters
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
            
            int pageSize = 12;
            String keyword = request.getParameter("keyword");
            String categoryIdStr = request.getParameter("categoryId");
            String brand = request.getParameter("brand");
            String scale = request.getParameter("scale");
            String sortBy = request.getParameter("sortBy");
            
            List<Product> products;
            int totalProducts;
            
            // Get products based on filters
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Search products
                products = productDAO.searchProducts(keyword, page, pageSize);
                totalProducts = productDAO.getTotalSearchResults(keyword);
                request.setAttribute("keyword", keyword);
            } else if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                // Filter by category
                try {
                    int categoryId = Integer.parseInt(categoryIdStr);
                    products = productDAO.getProductsByCategory(categoryId, page, pageSize);
                    totalProducts = productDAO.getTotalProductsByCategory(categoryId);
                    request.setAttribute("selectedCategoryId", categoryId);
                } catch (NumberFormatException e) {
                    products = productDAO.getAllProducts(page, pageSize);
                    totalProducts = productDAO.getTotalProductCount();
                }
            } else if (brand != null && !brand.trim().isEmpty()) {
                // Filter by brand
                products = productDAO.getProductsByBrand(brand, page, pageSize);
                totalProducts = productDAO.getTotalProductsByBrand(brand);
                request.setAttribute("selectedBrand", brand);
            } else if (scale != null && !scale.trim().isEmpty()) {
                // Filter by scale
                products = productDAO.getProductsByScale(scale, page, pageSize);
                totalProducts = productDAO.getTotalProductsByScale(scale);
                request.setAttribute("selectedScale", scale);
            } else {
                // Get all products
                products = productDAO.getAllProducts(page, pageSize);
                totalProducts = productDAO.getTotalProductCount();
            }
            
            // Calculate pagination
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            
            // Get all categories for filter
            List<Category> categories = categoryDAO.getAllCategories();
            
            // Get all brands and scales for filter
            List<String> brands = productDAO.getAllBrands();
            List<String> scales = productDAO.getAllScales();
            
            // Set attributes
            request.setAttribute("products", products);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("categories", categories);
            request.setAttribute("brands", brands);
            request.setAttribute("scales", scales);
            request.setAttribute("sortBy", sortBy);
            
            // Forward to JSP
            request.getRequestDispatcher("/views/product/products.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading products.");
            request.getRequestDispatcher("/views/product/products.jsp").forward(request, response);
        }
    }
    
    private void showProductDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String productIdStr = request.getParameter("id");
            
            if (productIdStr == null || productIdStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is required");
                return;
            }
            
            int productId = Integer.parseInt(productIdStr);
            Product product = productDAO.getProductById(productId);
            
            if (product != null) {
                // Get related products (same category)
                List<Product> relatedProducts = productDAO.getProductsByCategory(
                    product.getCategoryId(), 1, 4);
                
                request.setAttribute("product", product);
                request.setAttribute("relatedProducts", relatedProducts);
                request.getRequestDispatcher("/views/product/product-detail.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while loading product details.");
            request.getRequestDispatcher("/views/product/product-detail.jsp").forward(request, response);
        }
    }
}
