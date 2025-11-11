<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Shopping Cart - ModelKitShop" />
</jsp:include>

<h2 class="tw-text-4xl tw-font-bold tw-text-gray-800 tw-mb-8">
    <i class="bi bi-cart3" style="color: #668586;"></i> Shopping Cart
</h2>

<!-- Success Message -->
<c:if test="${param.added == 'true'}">
    <div class="alert alert-success alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg" role="alert">
        <i class="bi bi-check-circle tw-text-xl"></i> Product added to cart successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Error Messages -->
<c:if test="${param.error == 'outOfStock'}">
    <div class="alert alert-danger alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg" role="alert">
        <i class="bi bi-exclamation-triangle tw-text-xl"></i> Sorry, some items are out of stock.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:choose>
    <c:when test="${empty cartItems}">
        <!-- Empty Cart -->
        <div class="text-center tw-py-20">
            <div class="tw-inline-block tw-p-8 tw-rounded-full tw-mb-6" style="background: linear-gradient(to bottom right, #d8e5e5, #e8f0f0);">
                <i class="bi bi-cart-x tw-text-8xl" style="color: #668586;"></i>
            </div>
            <h3 class="tw-text-3xl tw-font-bold tw-text-gray-800 tw-mb-4">Your cart is empty</h3>
            <p class="tw-text-gray-600 tw-mb-8 tw-text-lg">Start shopping to add items to your cart</p>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary tw-px-8 tw-py-4 tw-rounded-full tw-font-bold tw-text-lg tw-shadow-xl hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105"
               style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%); border: none;">
                <i class="bi bi-grid"></i> Browse Products
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <!-- Cart Items -->
        <div class="row">
            <div class="col-md-8">
                <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl mb-4">
                    <div class="card-body tw-p-6">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="row mb-4 pb-4 tw-border-b-2 tw-border-gray-100 tw-rounded-xl tw-p-3 tw-transition-colors"
                                 onmouseover="this.style.backgroundColor='#f9fafb'"
                                 onmouseout="this.style.backgroundColor=''">
                                <div class="col-md-2">
                                    <div class="tw-rounded-xl tw-overflow-hidden tw-shadow-md">
                                        <c:choose>
                                            <c:when test="${not empty item.product.imageUrl && (fn:startsWith(item.product.imageUrl, 'http://') || fn:startsWith(item.product.imageUrl, 'https://'))}">
                                                <img src="${item.product.imageUrl}" class="img-fluid" alt="${item.product.name}">
                                            </c:when>
                                            <c:when test="${not empty item.product.imageUrl}">
                                                <img src="${pageContext.request.contextPath}/images/products/${item.product.imageUrl}" class="img-fluid" alt="${item.product.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/images/no-image.jpg" class="img-fluid" alt="No image">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                
                                <div class="col-md-4">
                                    <h5 class="tw-font-bold tw-text-gray-800 tw-mb-2">${item.product.name}</h5>
                                    <div class="tw-flex tw-gap-2 tw-mb-2">
                                        <c:if test="${item.product.brand != null}">
                                            <span class="badge tw-px-2 tw-py-1" style="background-color: #d8e5e5; color: #668586;">
                                                ${item.product.brand}
                                            </span>
                                        </c:if>
                                        <c:if test="${item.product.scale != null}">
                                            <span class="badge tw-px-2 tw-py-1" style="background-color: #e0eff2; color: #82AEB1;">
                                                ${item.product.scale}
                                            </span>
                                        </c:if>
                                    </div>
                                    <p class="tw-text-lg tw-font-semibold tw-mb-0" style="color: #668586;">
                                        <fmt:formatNumber value="${item.product.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
                                    </p>
                                </div>
                                
                                <div class="col-md-3">
                                    <form method="post" action="${pageContext.request.contextPath}/cart" class="d-inline">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="productId" value="${item.productId}">
                                        <div class="input-group">
                                            <input type="number" class="form-control tw-border-2 tw-border-gray-200 tw-rounded-l-lg tw-text-center tw-font-bold" 
                                                   name="quantity" value="${item.quantity}" min="1" max="${item.product.stockQuantity}"
                                                   style="transition: border-color 0.3s;"
                                                   onfocus="this.style.borderColor='#668586'"
                                                   onblur="this.style.borderColor='#e5e7eb'">
                                            <button type="submit" class="btn tw-rounded-r-lg tw-transition-colors"
                                                    style="border: 2px solid #668586; color: #668586;"
                                                    onmouseover="this.style.backgroundColor='#668586'; this.style.color='white';"
                                                    onmouseout="this.style.backgroundColor=''; this.style.color='#668586';">
                                                <i class="bi bi-arrow-clockwise"></i>
                                            </button>
                                        </div>
                                    </form>
                                    <small class="tw-text-gray-500 tw-mt-1 tw-block">Max: ${item.product.stockQuantity}</small>
                                </div>
                                
                                <div class="col-md-2 text-end">
                                    <h5 class="tw-text-2xl tw-font-bold tw-mb-0" style="color: #668586;">
                                        <fmt:formatNumber value="${item.subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
                                    </h5>
                                </div>
                                
                                <div class="col-md-1 text-end">
                                    <form method="post" action="${pageContext.request.contextPath}/cart">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="productId" value="${item.productId}">
                                        <button type="submit" class="btn btn-sm btn-outline-danger tw-rounded-lg hover:tw-bg-red-600 hover:tw-text-white tw-transition-colors" 
                                                onclick="return confirm('Remove this item from cart?')">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <!-- Clear Cart Button -->
                        <div class="text-end mt-4">
                            <form method="post" action="${pageContext.request.contextPath}/cart" class="d-inline">
                                <input type="hidden" name="action" value="clear">
                                <button type="submit" class="btn btn-outline-danger tw-rounded-xl tw-px-6 tw-py-2 hover:tw-bg-red-600 hover:tw-text-white tw-transition-all" 
                                        onclick="return confirm('Clear all items from cart?')">
                                    <i class="bi bi-trash"></i> Clear Cart
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Order Summary -->
            <div class="col-md-4">
                <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl tw-sticky" style="top: 100px;">
                    <div class="card-header tw-border-0 tw-text-white tw-py-4" style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%);">
                        <h5 class="mb-0 tw-font-bold tw-text-lg">
                            <i class="bi bi-receipt"></i> Order Summary
                        </h5>
                    </div>
                    <div class="card-body tw-p-6 tw-bg-gradient-to-br tw-from-gray-50 tw-to-white">
                        <div class="tw-flex tw-justify-between tw-mb-4 tw-text-lg">
                            <span class="tw-text-gray-700">Items (${itemCount}):</span>
                            <span class="tw-font-semibold tw-text-gray-800">
                                <fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
                            </span>
                        </div>
                        
                        <div class="tw-flex tw-justify-between tw-mb-4 tw-text-lg">
                            <span class="tw-text-gray-700">Shipping:</span>
                            <span class="tw-font-bold tw-text-green-600">FREE</span>
                        </div>
                        
                        <hr class="tw-border-gray-300 tw-my-4">
                        
                        <div class="tw-flex tw-justify-between tw-mb-6 tw-items-center">
                            <strong class="tw-text-xl tw-text-gray-800">Total:</strong>
                            <strong class="tw-text-3xl tw-font-bold" style="color: #668586;">
                                <fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
                            </strong>
                        </div>
                        
                        <div class="d-grid gap-3">
                            <a href="${pageContext.request.contextPath}/checkout" 
                               class="btn btn-primary btn-lg tw-py-4 tw-rounded-xl tw-font-bold tw-shadow-xl hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105"
                               style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%); border: none;">
                                <i class="bi bi-credit-card tw-text-xl"></i> Proceed to Checkout
                            </a>
                            <a href="${pageContext.request.contextPath}/products" 
                               class="btn btn-outline-secondary tw-py-3 tw-rounded-xl tw-font-semibold hover:tw-bg-gray-700 hover:tw-text-white tw-transition-all">
                                <i class="bi bi-arrow-left"></i> Continue Shopping
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Info Box -->
                <div class="card tw-border-0 tw-shadow-lg tw-rounded-2xl mt-4">
                    <div class="card-body tw-p-6" style="background: linear-gradient(to bottom right, #d8e5e5, #e8f0f0);">
                        <h6 class="tw-font-bold tw-text-lg tw-text-gray-800 tw-mb-4">
                            <i class="bi bi-info-circle" style="color: #668586;"></i> Shopping Benefits
                        </h6>
                        <ul class="list-unstyled mb-0 tw-space-y-2">
                            <li class="tw-flex tw-items-center tw-gap-2">
                                <i class="bi bi-check-circle tw-text-green-600 tw-text-xl"></i>
                                <span class="tw-text-gray-700">Free shipping on orders over $50</span>
                            </li>
                            <li class="tw-flex tw-items-center tw-gap-2">
                                <i class="bi bi-check-circle tw-text-green-600 tw-text-xl"></i>
                                <span class="tw-text-gray-700">30-day return policy</span>
                            </li>
                            <li class="tw-flex tw-items-center tw-gap-2">
                                <i class="bi bi-check-circle tw-text-green-600 tw-text-xl"></i>
                                <span class="tw-text-gray-700">Secure payment processing</span>
                            </li>
                            <li class="tw-flex tw-items-center tw-gap-2">
                                <i class="bi bi-check-circle tw-text-green-600 tw-text-xl"></i>
                                <span class="tw-text-gray-700">Authentic products guaranteed</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

<script src="${pageContext.request.contextPath}/js/cart.js"></script>
<jsp:include page="../common/footer.jsp" />