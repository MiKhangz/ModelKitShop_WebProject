<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Products - ModelKitShop" />
</jsp:include>

<!-- Page Header -->
<div class="tw-flex tw-justify-between tw-items-center tw-mb-8 tw-p-6 tw-rounded-2xl" style="background: linear-gradient(to right, #668586, #82AEB1);">
    <h2 class="tw-text-3xl tw-font-bold tw-text-white tw-mb-0">
        <i class="bi bi-grid tw-text-white"></i> Browse Products
    </h2>
    <span class="tw-px-4 tw-py-2 tw-bg-white tw-rounded-full tw-shadow-md tw-text-gray-700 tw-font-semibold">
        ${totalProducts} products found
    </span>
</div>

<div class="row">
    <!-- Sidebar Filters -->
    <div class="col-md-3 mb-4">
        <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl tw-overflow-hidden tw-sticky" style="top: 100px;">
            <div class="card-header tw-border-0 tw-text-white" style="background: linear-gradient(to right, #668586, #82AEB1);">
                <h5 class="mb-0 tw-text-lg tw-font-bold"><i class="bi bi-funnel"></i> Filters</h5>
            </div>
            <div class="card-body tw-bg-gray-50">
                <!-- Search -->
                <form method="get" action="${pageContext.request.contextPath}/products" class="mb-4">
                    <label class="form-label tw-font-semibold tw-text-gray-700">
                        <i class="bi bi-search" style="color: #668586;"></i> Search
                    </label>
                    <div class="input-group">
                        <input type="text" class="form-control tw-border-2 tw-border-gray-200 tw-rounded-l-lg" 
                               name="keyword" placeholder="Search products..." value="${keyword}"
                               style="transition: border-color 0.3s;"
                               onfocus="this.style.borderColor='#668586'"
                               onblur="this.style.borderColor='#e5e7eb'">
                        <button class="btn tw-rounded-r-lg tw-transition-colors" type="submit"
                                style="background-color: #668586; color: white; border-color: #668586;"
                                onmouseover="this.style.backgroundColor='#527070'"
                                onmouseout="this.style.backgroundColor='#668586'">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>
                
                <!-- Categories -->
                <div class="mb-4">
                    <label class="form-label tw-font-semibold tw-text-gray-700">
                        <i class="bi bi-tag category-icon"></i> Categories
                    </label>
                    <div class="list-group tw-rounded-lg tw-overflow-hidden">
                        <a href="${pageContext.request.contextPath}/products" 
                           class="list-group-item list-group-item-action tw-border-l-4 tw-transition-colors ${empty selectedCategoryId ? 'active' : 'tw-border-l-transparent'}">
                            All Categories
                        </a>
                        <c:forEach var="category" items="${categories}">
                            <a href="${pageContext.request.contextPath}/products?categoryId=${category.id}" 
                               class="list-group-item list-group-item-action tw-border-l-4 tw-transition-colors ${selectedCategoryId == category.id ? 'active' : 'tw-border-l-transparent'}">
                                ${category.name}
                            </a>
                        </c:forEach>
                    </div>
                </div>
                
                <!-- Brands -->
                <div class="mb-4">
                    <label class="form-label tw-font-semibold tw-text-gray-700">
                        <i class="bi bi-star" style="color: #668586;"></i> Brands
                    </label>
                    <select class="form-select tw-border-2 tw-border-gray-200 tw-rounded-lg" 
                            onchange="location = '${pageContext.request.contextPath}/products?brand=' + this.value;"
                            style="transition: border-color 0.3s;"
                            onfocus="this.style.borderColor='#668586'"
                            onblur="this.style.borderColor='#e5e7eb'">
                        <option value="">All Brands</option>
                        <c:forEach var="brand" items="${brands}">
                            <option value="${brand}" ${selectedBrand == brand ? 'selected' : ''}>${brand}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <!-- Scales -->
                <div class="mb-4">
                    <label class="form-label tw-font-semibold tw-text-gray-700">
                        <i class="bi bi-rulers" style="color: #668586;"></i> Scale
                    </label>
                    <select class="form-select tw-border-2 tw-border-gray-200 tw-rounded-lg" 
                            onchange="location = '${pageContext.request.contextPath}/products?scale=' + this.value;"
                            style="transition: border-color 0.3s;"
                            onfocus="this.style.borderColor='#668586'"
                            onblur="this.style.borderColor='#e5e7eb'">
                        <option value="">All Scales</option>
                        <c:forEach var="scale" items="${scales}">
                            <option value="${scale}" ${selectedScale == scale ? 'selected' : ''}>${scale}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <!-- Reset Button -->
                <a href="${pageContext.request.contextPath}/products" 
                   class="btn btn-outline-secondary w-100 tw-rounded-lg hover:tw-bg-gray-700 hover:tw-text-white tw-transition-all">
                    <i class="bi bi-arrow-clockwise"></i> Reset Filters
                </a>
            </div>
        </div>
    </div>
    
    <!-- Products Grid -->
    <div class="col-md-9">
        <!-- Error Message -->
        <c:if test="${error != null}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${empty products}">
                <!-- No Products Found -->
                <div class="text-center tw-py-16">
                    <div class="tw-inline-block tw-p-8 tw-rounded-full tw-mb-6" style="background: linear-gradient(to bottom right, #d8e5e5, #e8f0f0);">
                        <i class="bi bi-inbox tw-text-7xl" style="color: #668586;"></i>
                    </div>
                    <h3 class="tw-text-2xl tw-font-bold tw-text-gray-800 tw-mb-3">No products found</h3>
                    <p class="tw-text-gray-600 tw-mb-6">Try adjusting your filters or search terms</p>
                    <a href="${pageContext.request.contextPath}/products" 
                       class="btn btn-primary tw-px-8 tw-py-3 tw-rounded-full tw-shadow-lg hover:tw-shadow-xl tw-transition-all hover:tw-scale-105"
                       style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%); border: none;">
                        Browse All Products
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Products Grid -->
                <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
                    <c:forEach var="product" items="${products}">
                        <div class="col">
                            <div class="card h-100 tw-border-0 tw-shadow-lg hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105 tw-rounded-2xl tw-overflow-hidden">
                                <div class="tw-relative tw-overflow-hidden tw-group">
                                    <c:choose>
                                        <c:when test="${not empty product.imageUrl && (fn:startsWith(product.imageUrl, 'http://') || fn:startsWith(product.imageUrl, 'https://'))}">
                                            <img 
                                                src="${product.imageUrl}"
                                                class="card-img-top tw-transition-transform tw-duration-500 group-hover:tw-scale-110" 
                                                alt="${product.name}"
                                                style="height: 250px; object-fit: cover;"
                                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/image/product?id=${product.id}&name=${fn:escapeXml(product.name)}&brand=${fn:escapeXml(product.brand)}&scale=${fn:escapeXml(product.scale)}&w=600&h=400'" />
                                        </c:when>
                                        <c:when test="${not empty product.imageUrl}">
                                            <img 
                                                src="${pageContext.request.contextPath}/images/products/${product.imageUrl}"
                                                class="card-img-top tw-transition-transform tw-duration-500 group-hover:tw-scale-110" 
                                                alt="${product.name}"
                                                style="height: 250px; object-fit: cover;"
                                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/image/product?id=${product.id}&name=${fn:escapeXml(product.name)}&brand=${fn:escapeXml(product.brand)}&scale=${fn:escapeXml(product.scale)}&w=600&h=400'" />
                                        </c:when>
                                        <c:otherwise>
                                            <img 
                                                src="${pageContext.request.contextPath}/images/no-image.jpg"
                                                class="card-img-top" alt="No image"
                                                style="height: 250px; object-fit: cover;" />
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${product.stockQuantity > 0}">
                                            <span class="tw-absolute tw-top-3 tw-right-3 tw-px-3 tw-py-1 tw-bg-green-500 tw-text-white tw-rounded-full tw-text-sm tw-font-bold tw-shadow-lg">
                                                <i class="bi bi-check-circle"></i> In Stock
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="tw-absolute tw-top-3 tw-right-3 tw-px-3 tw-py-1 tw-bg-red-500 tw-text-white tw-rounded-full tw-text-sm tw-font-bold tw-shadow-lg">
                                                <i class="bi bi-x-circle"></i> Out of Stock
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="card-body tw-p-4">
                                    <h5 class="card-title tw-font-bold tw-text-gray-800 tw-mb-3 tw-line-clamp-2" 
                                        title="${product.name}" style="min-height: 3rem;">
                                        ${product.name}
                                    </h5>
                                    <div class="tw-flex tw-gap-2 tw-mb-3 tw-flex-wrap">
                                        <c:if test="${product.brand != null}">
                                            <span class="badge tw-px-3 tw-py-1" style="background: linear-gradient(to right, #668586, #82AEB1);">
                                                <i class="bi bi-star"></i> ${product.brand}
                                            </span>
                                        </c:if>
                                        <c:if test="${product.scale != null}">
                                            <span class="badge tw-px-3 tw-py-1" style="background: linear-gradient(to right, #82AEB1, #93C6D6);">
                                                <i class="bi bi-rulers"></i> ${product.scale}
                                            </span>
                                        </c:if>
                                    </div>
                                    
                                    <div class="tw-flex tw-justify-between tw-items-center">
                                        <h4 class="tw-text-2xl tw-font-bold tw-mb-0" style="color: #668586;">
                                            <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
                                        </h4>
                                    </div>
                                </div>
                                
                                <div class="card-footer tw-bg-white tw-border-0 tw-p-4">
                                    <a href="${pageContext.request.contextPath}/products?action=detail&id=${product.id}" 
                                       class="btn btn-primary w-100 tw-py-3 tw-rounded-xl tw-font-semibold tw-shadow-md hover:tw-shadow-xl tw-transition-all hover:tw-scale-105"
                                       style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%); border: none;">
                                        <i class="bi bi-eye"></i> View Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav class="tw-mt-8">
                        <ul class="pagination justify-content-center tw-gap-2">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link tw-rounded-lg tw-border-2 tw-px-4 tw-py-2 tw-transition-colors" 
                                   style="border-color: #668586; color: #668586;"
                                   onmouseover="if(${currentPage != 1}) {this.style.backgroundColor='#668586'; this.style.color='white';}"
                                   onmouseout="if(${currentPage != 1}) {this.style.backgroundColor=''; this.style.color='#668586';}"
                                   href="${pageContext.request.contextPath}/products?page=${currentPage - 1}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}">
                                    <i class="bi bi-chevron-left"></i> Previous
                                </a>
                            </li>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                    <a class="page-link tw-rounded-lg tw-border-2 tw-transition-all" 
                                       style="${currentPage == i ? 'background-color: #668586; border-color: #668586; color: white;' : 'border-color: #e5e7eb; color: #4b5563;'}"
                                       onmouseover="if(${currentPage != i}) {this.style.borderColor='#668586'; this.style.color='#668586';}"
                                       onmouseout="if(${currentPage != i}) {this.style.borderColor='#e5e7eb'; this.style.color='#4b5563';}"
                                       href="${pageContext.request.contextPath}/products?page=${i}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}">
                                        ${i}
                                    </a>
                                </li>
                            </c:forEach>
                            
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link tw-rounded-lg tw-border-2 tw-px-4 tw-py-2 tw-transition-colors" 
                                   style="border-color: #668586; color: #668586;"
                                   onmouseover="if(${currentPage != totalPages}) {this.style.backgroundColor='#668586'; this.style.color='white';}"
                                   onmouseout="if(${currentPage != totalPages}) {this.style.backgroundColor=''; this.style.color='#668586';}"
                                   href="${pageContext.request.contextPath}/products?page=${currentPage + 1}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty selectedCategoryId ? '&categoryId='.concat(selectedCategoryId) : ''}">
                                    Next <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />