package Models;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Product model - Represents a model kit product
 * Member 1 responsibility
 */
public class Product implements Serializable {
    private int id;
    private String name;
    private int categoryId;
    private BigDecimal price;
    private String description;
    private String imageUrl;
    private int stockQuantity;
    private String scale;
    private String brand;
    
    // For display purposes (not in database)
    private String categoryName;
    
    // Constructors
    public Product() {
    }
    
    public Product(int id, String name, int categoryId, BigDecimal price, String description, 
                   String imageUrl, int stockQuantity, String scale, String brand) {
        this.id = id;
        this.name = name;
        this.categoryId = categoryId;
        this.price = price;
        this.description = description;
        this.imageUrl = imageUrl;
        this.stockQuantity = stockQuantity;
        this.scale = scale;
        this.brand = brand;
    }
    
    public Product(String name, int categoryId, BigDecimal price, String description, 
                   String imageUrl, int stockQuantity, String scale, String brand) {
        this.name = name;
        this.categoryId = categoryId;
        this.price = price;
        this.description = description;
        this.imageUrl = imageUrl;
        this.stockQuantity = stockQuantity;
        this.scale = scale;
        this.brand = brand;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public int getCategoryId() {
        return categoryId;
    }
    
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    
    public BigDecimal getPrice() {
        return price;
    }
    
    public void setPrice(BigDecimal price) {
        this.price = price;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public int getStockQuantity() {
        return stockQuantity;
    }
    
    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
    
    public String getScale() {
        return scale;
    }
    
    public void setScale(String scale) {
        this.scale = scale;
    }
    
    public String getBrand() {
        return brand;
    }
    
    public void setBrand(String brand) {
        this.brand = brand;
    }
    
    public String getCategoryName() {
        return categoryName;
    }
    
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
    // Utility methods
    public boolean isInStock() {
        return stockQuantity > 0;
    }
    
    public boolean hasStock(int quantity) {
        return stockQuantity >= quantity;
    }
    
    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", categoryId=" + categoryId +
                ", price=" + price +
                ", stockQuantity=" + stockQuantity +
                ", scale='" + scale + '\'' +
                ", brand='" + brand + '\'' +
                '}';
    }

 //   public void setCreatedAt(Timestamp timestamp) {
         //
  //  }
}
