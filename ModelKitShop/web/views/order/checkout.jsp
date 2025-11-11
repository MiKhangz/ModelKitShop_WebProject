<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Checkout - ModelKitShop" />
</jsp:include>

<h2 class="tw-text-4xl tw-font-bold tw-text-gray-800 tw-mb-8">
    <i class="bi bi-credit-card tw-text-purple-600"></i> Checkout
</h2>

<!-- Progress Indicator -->
<div class="tw-flex tw-justify-center tw-mb-8">
    <div class="tw-flex tw-items-center tw-gap-4">
        <div class="tw-flex tw-items-center tw-gap-2">
            <div class="tw-w-10 tw-h-10 tw-rounded-full tw-bg-green-500 tw-flex tw-items-center tw-justify-center tw-text-white tw-font-bold tw-shadow-lg">
                <i class="bi bi-check"></i>
            </div>
            <span class="tw-font-semibold tw-text-gray-700">Cart</span>
        </div>
        <div class="tw-w-16 tw-h-1 tw-bg-purple-500"></div>
        <div class="tw-flex tw-items-center tw-gap-2">
            <div class="tw-w-10 tw-h-10 tw-rounded-full tw-bg-purple-600 tw-flex tw-items-center tw-justify-center tw-text-white tw-font-bold tw-shadow-lg">
                2
            </div>
            <span class="tw-font-bold tw-text-purple-600">Checkout</span>
        </div>
        <div class="tw-w-16 tw-h-1 tw-bg-gray-300"></div>
        <div class="tw-flex tw-items-center tw-gap-2">
            <div class="tw-w-10 tw-h-10 tw-rounded-full tw-bg-gray-300 tw-flex tw-items-center tw-justify-center tw-text-gray-600 tw-font-bold">
                3
            </div>
            <span class="tw-text-gray-500">Complete</span>
        </div>
    </div>
</div>

<!-- Error Messages -->
<c:if test="${error != null}">
    <div class="alert alert-danger alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg" role="alert">
        <i class="bi bi-exclamation-triangle tw-text-xl"></i> ${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="row">
    <!-- Checkout Form -->
    <div class="col-md-7">
        <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl mb-4">
            <div class="card-header tw-border-0 tw-text-white tw-py-4" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <h5 class="mb-0 tw-font-bold tw-text-lg">
                    <i class="bi bi-truck"></i> Shipping Information
                </h5>
            </div>
            <div class="card-body tw-p-6 tw-bg-gradient-to-br tw-from-gray-50 tw-to-white">
                <form method="post" action="${pageContext.request.contextPath}/checkout" id="checkoutForm">
                    <div class="mb-4">
                        <label for="fullName" class="form-label tw-font-semibold tw-text-gray-700">
                            <i class="bi bi-person tw-text-purple-600"></i> Full Name
                        </label>
                        <input type="text" class="form-control tw-border-2 tw-border-gray-200 tw-rounded-xl tw-py-3 tw-bg-gray-100" 
                               id="fullName" name="fullName" value="${user.fullName}" readonly>
                    </div>
                    
                    <div class="mb-4">
                        <label for="email" class="form-label tw-font-semibold tw-text-gray-700">
                            <i class="bi bi-envelope tw-text-purple-600"></i> Email
                        </label>
                        <input type="email" class="form-control tw-border-2 tw-border-gray-200 tw-rounded-xl tw-py-3 tw-bg-gray-100" 
                               id="email" name="email" value="${user.email}" readonly>
                    </div>
                    
                    <div class="mb-4">
                        <label for="phone" class="form-label tw-font-semibold tw-text-gray-700">
                            <i class="bi bi-telephone tw-text-purple-600"></i> Phone Number <span class="text-danger">*</span>
                        </label>
                        <input type="tel" class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-purple-500 tw-rounded-xl tw-py-3" 
                               id="phone" name="phone" value="${user.phone}" placeholder="+84 123 456 789" required>
                    </div>
                    
                    <div class="mb-4">
                        <label for="shippingAddress" class="form-label tw-font-semibold tw-text-gray-700">
                            <i class="bi bi-geo-alt tw-text-purple-600"></i> Shipping Address <span class="text-danger">*</span>
                        </label>
                        <textarea class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-purple-500 tw-rounded-xl tw-py-3" 
                                  id="shippingAddress" name="shippingAddress" rows="3" 
                                  placeholder="Enter your complete shipping address" required>${user.address}</textarea>
                        <small class="tw-text-gray-500">Please include street, city, and postal code</small>
                    </div>
                    
                    <div class="mb-4">
                        <label for="notes" class="form-label tw-font-semibold tw-text-gray-700">
                            <i class="bi bi-chat-left-text tw-text-purple-600"></i> Order Notes (Optional)
                        </label>
                        <textarea class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-purple-500 tw-rounded-xl tw-py-3" 
                                  id="notes" name="notes" rows="2" 
                                  placeholder="Any special instructions for delivery?"></textarea>
                    </div>
                    
                    <div class="alert alert-info tw-rounded-xl tw-border-0 tw-bg-blue-50 tw-border-l-4 tw-border-blue-500">
                        <i class="bi bi-info-circle tw-text-blue-600"></i> <strong>Payment Method:</strong> Cash on Delivery (COD)
                        <br><small class="tw-text-gray-600">You will pay when you receive your order</small>
                    </div>
                    
                    <div class="d-grid gap-3">
                        <button type="submit" class="btn btn-success btn-lg tw-py-4 tw-rounded-xl tw-font-bold tw-shadow-xl hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105"
                                style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
                            <i class="bi bi-check-circle tw-text-xl"></i> Place Order
                        </button>
                        <a href="${pageContext.request.contextPath}/cart" 
                           class="btn btn-outline-secondary tw-py-3 tw-rounded-xl tw-font-semibold hover:tw-bg-gray-700 hover:tw-text-white tw-transition-all">
                            <i class="bi bi-arrow-left"></i> Back to Cart
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Order Summary -->
    <div class="col-md-5">
        <div class="card shadow-sm">
            <div class="card-header bg-secondary text-white">
                <h5 class="mb-0"><i class="bi bi-receipt"></i> Order Summary</h5>
            </div>
            <div class="card-body">
                <!-- Cart Items List -->
                <c:forEach var="item" items="${cartItems}">
                        <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
                        <div class="d-flex align-items-center">
                            <c:choose>
                                <c:when test="${not empty item.product.imageUrl && (fn:startsWith(item.product.imageUrl, 'http://') || fn:startsWith(item.product.imageUrl, 'https://'))}">
                                    <img src="${item.product.imageUrl}" class="rounded me-2" style="width: 50px; height: 50px; object-fit: cover;" alt="${item.product.name}">
                                </c:when>
                                <c:when test="${not empty item.product.imageUrl}">
                                    <img src="${pageContext.request.contextPath}/images/products/${item.product.imageUrl}" class="rounded me-2" style="width: 50px; height: 50px; object-fit: cover;" alt="${item.product.name}">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/images/no-image.jpg" class="rounded me-2" style="width: 50px; height: 50px; object-fit: cover;" alt="No image">
                                </c:otherwise>
                            </c:choose>
                            <div>
                                <h6 class="mb-0 small">${item.product.name}</h6>
                                <small class="text-muted">Qty: ${item.quantity}</small>
                            </div>
                        </div>
                        <span>
                            <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="$"/>
                        </span>
                    </div>
                </c:forEach>
                
                <hr>
                
                <!-- Pricing Summary -->
                <div class="d-flex justify-content-between mb-2">
                    <span>Subtotal:</span>
                    <span><fmt:formatNumber value="${total}" type="currency" currencySymbol="$"/></span>
                </div>
                
                <div class="d-flex justify-content-between mb-2">
                    <span>Shipping:</span>
                    <span class="text-success">FREE</span>
                </div>
                
                <div class="d-flex justify-content-between mb-2">
                    <span>Tax:</span>
                    <span>$0.00</span>
                </div>
                
                <hr>
                
                <div class="d-flex justify-content-between mb-3">
                    <strong class="fs-5">Total:</strong>
                    <strong class="fs-5 text-success">
                        <fmt:formatNumber value="${total}" type="currency" currencySymbol="$"/>
                    </strong>
                </div>
            </div>
        </div>
        
        <!-- Security Info -->
        <div class="card shadow-sm mt-3">
            <div class="card-body">
                <h6><i class="bi bi-shield-check"></i> Your Order is Secure</h6>
                <ul class="list-unstyled mb-0 small">
                    <li><i class="bi bi-check-circle text-success"></i> 30-day return policy</li>
                    <li><i class="bi bi-check-circle text-success"></i> Money-back guarantee</li>
                    <li><i class="bi bi-check-circle text-success"></i> Secure checkout</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
