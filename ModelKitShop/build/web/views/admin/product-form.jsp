<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="${product != null ? 'Edit Product' : 'Add Product'} - Admin" />
</jsp:include>

<h2 class="mb-4">
    <i class="bi bi-box-seam"></i> 
    ${product != null ? 'Edit Product' : 'Add New Product'}
</h2>

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card shadow-sm">
            <div class="card-body p-4">
                <!-- Error Message -->
                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Product Form -->
                <form method="post" action="${pageContext.request.contextPath}/admin/products">
                    <input type="hidden" name="action" value="${product != null ? 'update' : 'add'}">
                    <c:if test="${product != null}">
                        <input type="hidden" name="id" value="${product.id}">
                    </c:if>
                    
                    <div class="mb-3">
                        <label for="name" class="form-label">
                            Product Name <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" id="name" name="name" 
                               value="${product.name}" placeholder="Enter product name" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea class="form-control" id="description" name="description" 
                                  rows="3" placeholder="Enter product description">${product.description}</textarea>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="price" class="form-label">
                                Price <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">VND</span>
                                <input type="number" class="form-control" id="price" name="price" 
                                       value="${product.price}" step="0.01" min="0" placeholder="0.00" required>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label for="stockQuantity" class="form-label">
                                Stock Quantity <span class="text-danger">*</span>
                            </label>
                            <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" 
                                   value="${product.stockQuantity}" min="0" placeholder="0" required>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="categoryId" class="form-label">
                                Category <span class="text-danger">*</span>
                            </label>
                            <select class="form-select" id="categoryId" name="categoryId" required>
                                <option value="">Select category</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}" ${product.categoryId == category.id ? 'selected' : ''}>
                                        ${category.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <label for="brand" class="form-label">Brand</label>
                            <input type="text" class="form-control" id="brand" name="brand" 
                                   value="${product.brand}" placeholder="e.g., Tamiya">
                        </div>
                        
                        <div class="col-md-4 mb-3">
                            <label for="scale" class="form-label">Scale</label>
                            <input type="text" class="form-control" id="scale" name="scale" 
                                   value="${product.scale}" placeholder="e.g., 1:35">
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="imageUrl" class="form-label">Image</label>
                        <input type="text" class="form-control" id="imageUrl" name="imageUrl" 
                               value="${product.imageUrl}" placeholder="tiger1.jpg or https://example.com/image.jpg">
                        <small class="text-muted">You can enter a filename (stored under /images/products) or a full URL (http/https)</small>
                    </div>
                    
                    <hr class="my-4">
                    
                    <div class="d-flex justify-content-between">
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle"></i> ${product != null ? 'Update Product' : 'Add Product'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
