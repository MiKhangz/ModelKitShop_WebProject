<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="${product.name} - ModelKitShop" />
</jsp:include>

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb tw-p-4 tw-rounded-xl" style="background: linear-gradient(to right, #d8e5e5, #e8f0f0);">
        <li class="breadcrumb-item">
            <a href="${pageContext.request.contextPath}/" style="color: #668586;" 
               onmouseover="this.style.color='#527070'" 
               onmouseout="this.style.color='#668586'"
               class="tw-transition-colors">
                <i class="bi bi-house"></i> Home
            </a>
        </li>
        <li class="breadcrumb-item">
            <a href="${pageContext.request.contextPath}/products" style="color: #668586;"
               onmouseover="this.style.color='#527070'" 
               onmouseout="this.style.color='#668586'"
               class="tw-transition-colors">
                Products
            </a>
        </li>
        <li class="breadcrumb-item active tw-font-semibold">${product.name}</li>
    </ol>
</nav>

<!-- Error/Success Messages -->
<c:if test="${param.error == 'outOfStock'}">
    <div class="alert alert-danger alert-dismissible fade show tw-rounded-xl tw-shadow-lg" role="alert">
        <i class="bi bi-exclamation-triangle tw-text-xl"></i> Sorry, this product is out of stock.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${param.error == 'invalidQuantity'}">
    <div class="alert alert-danger alert-dismissible fade show tw-rounded-xl tw-shadow-lg" role="alert">
        <i class="bi bi-exclamation-triangle tw-text-xl"></i> Please enter a valid quantity.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Product Details -->
<div class="row mb-5 tw-gap-y-8">
    <div class="col-md-5">
        <div class="card tw-border-0 tw-shadow-2xl tw-rounded-2xl tw-overflow-hidden tw-sticky" style="top: 100px;">
            <c:choose>
                <c:when test="${not empty product.imageUrl && (fn:startsWith(product.imageUrl, 'http://') || fn:startsWith(product.imageUrl, 'https://'))}">
                    <img 
                        src="${product.imageUrl}"
                        class="card-img-top" alt="${product.name}"
                        onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/image/product?id=${product.id}&name=${fn:escapeXml(product.name)}&brand=${fn:escapeXml(product.brand)}&scale=${fn:escapeXml(product.scale)}&w=800&h=600'"/>
                </c:when>
                <c:when test="${not empty product.imageUrl}">
                    <img 
                        src="${pageContext.request.contextPath}/images/products/${product.imageUrl}"
                        class="card-img-top" alt="${product.name}"
                        onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/image/product?id=${product.id}&name=${fn:escapeXml(product.name)}&brand=${fn:escapeXml(product.brand)}&scale=${fn:escapeXml(product.scale)}&w=800&h=600'"/>
                </c:when>
                <c:otherwise>
                    <img 
                        src="${pageContext.request.contextPath}/images/no-image.jpg"
                        class="card-img-top" alt="No image"/>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="col-md-7">
        <h1 class="tw-text-4xl tw-font-bold tw-text-gray-800 tw-mb-4">${product.name}</h1>
        
        <div class="tw-flex tw-flex-wrap tw-gap-2 tw-mb-6">
            <c:if test="${product.brand != null}">
                <span class="badge tw-px-4 tw-py-2 tw-text-base" style="background: linear-gradient(to right, #668586, #82AEB1);">
                    <i class="bi bi-star"></i> ${product.brand}
                </span>
            </c:if>
            <c:if test="${product.scale != null}">
                <span class="badge tw-px-4 tw-py-2 tw-text-base" style="background: linear-gradient(to right, #82AEB1, #93C6D6);">
                    <i class="bi bi-rulers"></i> Scale: ${product.scale}
                </span>
            </c:if>
            <c:choose>
                <c:when test="${product.stockQuantity > 0}">
                    <span class="badge tw-bg-gradient-to-r tw-from-green-500 tw-to-green-600 tw-px-4 tw-py-2 tw-text-base">
                        <i class="bi bi-check-circle"></i> In Stock (${product.stockQuantity} available)
                    </span>
                </c:when>
                <c:otherwise>
                    <span class="badge tw-bg-gradient-to-r tw-from-red-500 tw-to-red-600 tw-px-4 tw-py-2 tw-text-base">
                        <i class="bi bi-x-circle"></i> Out of Stock
                    </span>
                </c:otherwise>
            </c:choose>
        </div>
        
        <h2 class="tw-text-5xl tw-font-bold tw-mb-6" style="color: #668586;">
            <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
        </h2>
        
        <div class="card tw-border-0 tw-shadow-lg tw-rounded-2xl tw-mb-6 tw-overflow-hidden">
            <div class="card-body tw-p-6 tw-bg-gradient-to-br tw-from-gray-50 tw-to-white">
                <h5 class="card-title tw-text-xl tw-font-bold tw-text-gray-800 tw-mb-4">
                    <i class="bi bi-info-circle" style="color: #668586;"></i> Description
                </h5>
                <p class="card-text tw-text-gray-700 tw-leading-relaxed">
                    ${product.description != null ? product.description : 'No description available.'}
                </p>
            </div>
        </div>
        
        <!-- Add to Cart Form -->
        <c:if test="${product.stockQuantity > 0}">
            <form method="post" action="${pageContext.request.contextPath}/cart" class="mb-4">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="${product.id}">
                
                <div class="tw-bg-white tw-p-6 tw-rounded-2xl tw-shadow-lg tw-border-2" style="border-color: #d8e5e5;">
                    <div class="row g-3 align-items-end">
                        <div class="col-auto">
                            <label for="quantity" class="form-label tw-font-semibold tw-text-gray-700">
                                <i class="bi bi-bag-plus" style="color: #668586;"></i> Quantity:
                            </label>
                            <input type="number" class="form-control tw-border-2 tw-border-gray-200 tw-rounded-lg tw-text-lg tw-font-bold" 
                                   id="quantity" name="quantity" value="1" min="1" max="${product.stockQuantity}" style="width: 120px; transition: border-color 0.3s;" 
                                   onfocus="this.style.borderColor='#668586'"
                                   onblur="this.style.borderColor='#e5e7eb'"
                                   required>
                        </div>
                        
                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary btn-lg tw-px-8 tw-py-3 tw-rounded-xl tw-font-bold tw-shadow-xl hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105"
                                    style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%); border: none;">
                                <i class="bi bi-cart-plus tw-text-xl"></i> Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </c:if>
        
        <div class="tw-border-t-2 tw-border-gray-200 tw-pt-6 tw-mt-6">
            <div class="tw-space-y-4">
                <div class="tw-flex tw-items-center tw-gap-3 tw-p-4 tw-rounded-xl" style="background-color: #e8f0f0;">
                    <div class="tw-w-12 tw-h-12 tw-rounded-full tw-flex tw-items-center tw-justify-center" style="background-color: #82AEB1;">
                        <i class="bi bi-truck tw-text-2xl tw-text-white"></i>
                    </div>
                    <p class="tw-text-gray-700 tw-mb-0 tw-font-semibold">Free shipping on orders over $50</p>
                </div>
                <div class="tw-flex tw-items-center tw-gap-3 tw-p-4 tw-rounded-xl" style="background-color: #e0eff2;">
                    <div class="tw-w-12 tw-h-12 tw-rounded-full tw-flex tw-items-center tw-justify-center" style="background-color: #93C6D6;">
                        <i class="bi bi-arrow-clockwise tw-text-2xl tw-text-white"></i>
                    </div>
                    <p class="tw-text-gray-700 tw-mb-0 tw-font-semibold">30-day return policy</p>
                </div>
                <div class="tw-flex tw-items-center tw-gap-3 tw-p-4 tw-rounded-xl" style="background-color: #d8e5e5;">
                    <div class="tw-w-12 tw-h-12 tw-rounded-full tw-flex tw-items-center tw-justify-center" style="background-color: #668586;">
                        <i class="bi bi-shield-check tw-text-2xl tw-text-white"></i>
                    </div>
                    <p class="tw-text-gray-700 tw-mb-0 tw-font-semibold">Authentic products guaranteed</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Related Products -->
<c:if test="${not empty relatedProducts}">
    <div class="tw-mb-16">
        <h3 class="tw-text-3xl tw-font-bold tw-text-gray-800 tw-mb-8">
            <i class="bi bi-grid" style="color: #668586;"></i> Related Products
        </h3>
        <div class="row row-cols-1 row-cols-md-4 g-4">
            <c:forEach var="relatedProduct" items="${relatedProducts}">
                <c:if test="${relatedProduct.id != product.id}">
                    <div class="col">
                        <div class="card h-100 tw-border-0 tw-shadow-lg hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105 tw-rounded-2xl tw-overflow-hidden">
                            <div class="tw-relative tw-overflow-hidden tw-group">
                                <c:choose>
                                    <c:when test="${not empty relatedProduct.imageUrl && (fn:startsWith(relatedProduct.imageUrl, 'http://') || fn:startsWith(relatedProduct.imageUrl, 'https://'))}">
                                        <img 
                                            src="${relatedProduct.imageUrl}"
                                            class="card-img-top tw-transition-transform tw-duration-500 group-hover:tw-scale-110" 
                                            alt="${relatedProduct.name}" 
                                            style="height: 180px; object-fit: cover;"
                                            onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/image/product?id=${relatedProduct.id}&name=${fn:escapeXml(relatedProduct.name)}&brand=${fn:escapeXml(relatedProduct.brand)}&scale=${fn:escapeXml(relatedProduct.scale)}&w=400&h=300'"/>
                                    </c:when>
                                    <c:when test="${not empty relatedProduct.imageUrl}">
                                        <img 
                                            src="${pageContext.request.contextPath}/images/products/${relatedProduct.imageUrl}"
                                            class="card-img-top tw-transition-transform tw-duration-500 group-hover:tw-scale-110" 
                                            alt="${relatedProduct.name}" 
                                            style="height: 180px; object-fit: cover;"
                                            onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/image/product?id=${relatedProduct.id}&name=${fn:escapeXml(relatedProduct.name)}&brand=${fn:escapeXml(relatedProduct.brand)}&scale=${fn:escapeXml(relatedProduct.scale)}&w=400&h=300'"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img 
                                            src="${pageContext.request.contextPath}/images/no-image.jpg}"
                                            class="card-img-top" 
                                            alt="No image" 
                                            style="height: 180px; object-fit: cover;"/>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="card-body tw-p-4">
                                <h6 class="card-title tw-font-bold tw-text-gray-800 tw-line-clamp-2 tw-mb-3" 
                                    title="${relatedProduct.name}" style="min-height: 2.5rem;">
                                    ${relatedProduct.name}
                                </h6>
                                <p class="tw-text-xl tw-font-bold tw-mb-0" style="color: #668586;">
                                    <fmt:formatNumber value="${relatedProduct.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
                                </p>
                            </div>
                            
                            <div class="card-footer tw-bg-white tw-border-0 tw-p-4">
                                <a href="${pageContext.request.contextPath}/products?action=detail&id=${relatedProduct.id}" 
                                   class="btn btn-sm w-100 tw-py-2 tw-rounded-lg tw-font-semibold tw-transition-all"
                                   style="border: 2px solid #668586; color: #668586;"
                                   onmouseover="this.style.backgroundColor='#668586'; this.style.color='white';"
                                   onmouseout="this.style.backgroundColor=''; this.style.color='#668586';">
                                    <i class="bi bi-eye"></i> View Details
                                </a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</c:if>

<jsp:include page="../common/footer.jsp" />