<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Order Details - ModelKitShop" />
</jsp:include>

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="tw-mb-6 tw-p-4 tw-rounded-xl" style="background: linear-gradient(to right, #d8e5e5, #e8f0f0);">
    <ol class="breadcrumb tw-mb-0">
        <li class="breadcrumb-item">
            <a href="${pageContext.request.contextPath}/" style="color: #668586;"
               onmouseover="this.style.color='#527070'"
               onmouseout="this.style.color='#668586'"
               class="tw-transition-colors">
                <i class="bi bi-house-door"></i> Home
            </a>
        </li>
        <li class="breadcrumb-item">
            <a href="${pageContext.request.contextPath}/orders" style="color: #668586;"
               onmouseover="this.style.color='#527070'"
               onmouseout="this.style.color='#668586'"
               class="tw-transition-colors">
                <i class="bi bi-clock-history"></i> Orders
            </a>
        </li>
        <li class="breadcrumb-item active tw-font-bold">Order #${order.id}</li>
    </ol>
</nav>

<div class="tw-flex tw-justify-between tw-items-center tw-mb-6">
    <h2 class="tw-text-4xl tw-font-bold tw-text-gray-800 tw-mb-0">
        <i class="bi bi-receipt" style="color: #668586;"></i> Order #${order.id}
    </h2>
    <c:choose>
        <c:when test="${order.status == 'PENDING'}">
           
        </c:when>
        <c:when test="${order.status == 'PROCESSING'}">
            <span class="badge tw-bg-blue-100 tw-text-blue-800 tw-px-6 tw-py-3 tw-text-lg tw-font-bold tw-rounded-full">
                <i class="bi bi-arrow-repeat"></i> Processing
            </span>
        </c:when>
        <c:when test="${order.status == 'SHIPPED'}">
            <span class="badge tw-px-6 tw-py-3 tw-text-lg tw-font-bold tw-rounded-full" style="background-color: #d8e5e5; color: #668586;">
                <i class="bi bi-truck"></i> Shipped
            </span>
        </c:when>
        <c:when test="${order.status == 'DELIVERED'}">
            <span class="badge tw-bg-green-100 tw-text-green-800 tw-px-6 tw-py-3 tw-text-lg tw-font-bold tw-rounded-full">
                <i class="bi bi-check-circle"></i> Delivered
            </span>
        </c:when>
        <c:when test="${order.status == 'CANCELLED'}">
            <span class="badge tw-bg-red-100 tw-text-red-800 tw-px-6 tw-py-3 tw-text-lg tw-font-bold tw-rounded-full">
                <i class="bi bi-x-circle"></i> Cancelled
            </span>
        </c:when>
    </c:choose>
</div>

<div class="row">
    <!-- Order Information -->
    <div class="col-md-8">
        <!-- Order Details Card -->
        <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl tw-mb-6">
            <div class="card-header tw-border-0 tw-text-white tw-py-4" 
                 style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%);">
                <h5 class="tw-mb-0 tw-font-bold tw-text-lg">
                    <i class="bi bi-info-circle"></i> Order Information
                </h5>
            </div>
            <div class="card-body tw-p-6">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="tw-p-4 tw-rounded-xl" style="background-color: #d8e5e5;">
                            <strong class="tw-text-lg" style="color: #668586;">
                                <i class="bi bi-calendar"></i> Order Date
                            </strong>
                            <p class="tw-mt-2 tw-mb-0 tw-font-semibold tw-text-gray-800">
                                <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="tw-p-4 tw-rounded-xl" style="background-color: #e0eff2;">
                            <strong class="tw-text-lg" style="color: #82AEB1;">
                                <i class="bi bi-flag"></i> Status
                            </strong>
                            <div class="tw-mt-2">
                                <c:choose>
                                    <c:when test="${order.status == 'PENDING'}">
                                        <span class="badge tw-bg-yellow-100 tw-text-yellow-800 tw-px-4 tw-py-2 tw-text-sm tw-font-bold tw-rounded-full">
                                            <i class="bi bi-clock"></i> Pending
                                        </span>
                                    </c:when>
                                    <c:when test="${order.status == 'PROCESSING'}">
                                        <span class="badge tw-bg-blue-100 tw-text-blue-800 tw-px-4 tw-py-2 tw-text-sm tw-font-bold tw-rounded-full">
                                            <i class="bi bi-arrow-repeat"></i> Processing
                                        </span>
                                    </c:when>
                                    <c:when test="${order.status == 'SHIPPED'}">
                                        <span class="badge tw-px-4 tw-py-2 tw-text-sm tw-font-bold tw-rounded-full" style="background-color: #d8e5e5; color: #668586;">
                                            <i class="bi bi-truck"></i> Shipped
                                        </span>
                                    </c:when>
                                    <c:when test="${order.status == 'DELIVERED'}">
                                        <span class="badge tw-bg-green-100 tw-text-green-800 tw-px-4 tw-py-2 tw-text-sm tw-font-bold tw-rounded-full">
                                            <i class="bi bi-check-circle"></i> Delivered
                                        </span>
                                    </c:when>
                                    <c:when test="${order.status == 'CANCELLED'}">
                                        <span class="badge tw-bg-red-100 tw-text-red-800 tw-px-4 tw-py-2 tw-text-sm tw-font-bold tw-rounded-full">
                                            <i class="bi bi-x-circle"></i> Cancelled
                                        </span>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="mb-0">
                    <div class="tw-p-4 tw-bg-green-50 tw-rounded-xl">
                        <strong class="tw-text-green-700 tw-text-lg">
                            <i class="bi bi-geo-alt"></i> Shipping Address
                        </strong>
                        <p class="tw-mt-2 tw-mb-0 tw-text-gray-800">${order.shippingAddress}</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Order Items Card -->
        <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl tw-mb-4">
            <div class="card-header tw-border-0 tw-text-white tw-py-4" 
                 style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
                <h5 class="tw-mb-0 tw-font-bold tw-text-lg">
                    <i class="bi bi-box-seam"></i> Order Items
                </h5>
            </div>
            <div class="card-body tw-p-6">
                <div class="table-responsive">
                    <table class="table table-hover tw-rounded-xl">
                        <thead class="tw-bg-gray-100">
                            <tr>
                                <th class="tw-py-3 tw-font-bold tw-text-gray-700">Product</th>
                                <th class="tw-py-3 tw-font-bold tw-text-gray-700">Price</th>
                                <th class="tw-py-3 tw-font-bold tw-text-gray-700">Quantity</th>
                                <th class="text-end tw-py-3 tw-font-bold tw-text-gray-700">Subtotal</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${orderDetails}">
                                <tr class="tw-transition-colors"
                                    onmouseover="this.style.backgroundColor='#f9fafb'"
                                    onmouseout="this.style.backgroundColor=''">
                                    <td class="tw-py-4">
                                        <div class="d-flex align-items-center">
                                           <c:choose>
    <c:when test="${not empty detail.product.imageUrl && (fn:startsWith(detail.product.imageUrl, 'http://') || fn:startsWith(detail.product.imageUrl, 'https://'))}">
        <img src="${detail.product.imageUrl}" 
             class="tw-rounded-lg tw-shadow-md" 
             style="width: 60px; height: 60px; object-fit: cover; margin-right: 15px;" 
             alt="${detail.product.name}">
    </c:when>
    <c:when test="${not empty detail.product.imageUrl}">
        <img src="${pageContext.request.contextPath}/images/products/${detail.product.imageUrl}" 
             class="tw-rounded-lg tw-shadow-md" 
             style="width: 60px; height: 60px; object-fit: cover; margin-right: 15px;" 
             alt="${detail.product.name}">
    </c:when>
    <c:otherwise>
        <img src="${pageContext.request.contextPath}/images/no-image.jpg" 
             class="tw-rounded-lg tw-shadow-md" 
             style="width: 60px; height: 60px; object-fit: cover; margin-right: 15px;" 
             alt="${detail.product.name}">
    </c:otherwise>
</c:choose>
                                            <div>
                                                <strong class="tw-text-gray-800 tw-text-lg">${detail.product.name}</strong>
                                                <c:if test="${detail.product.brand != null}">
                                                    <br><small class="text-muted tw-text-gray-600">${detail.product.brand}</small>
                                                </c:if>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="tw-py-4 tw-font-semibold" style="color: #668586;">
                                        <fmt:formatNumber value="${detail.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
                                    </td>
                                    <td class="tw-py-4">
                                        <span class="badge tw-px-3 tw-py-2 tw-font-bold" style="background-color: #d8e5e5; color: #668586;">
                                            ${detail.quantity}
                                        </span>
                                    </td>
                                    <td class="text-end tw-py-4">
                                        <strong class="tw-text-green-600 tw-text-lg">
                                            <fmt:formatNumber value="${detail.subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
                                        </strong>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot style="background: linear-gradient(to right, #d8e5e5, #e8f0f0);">
                            <tr>
                                <td colspan="3" class="text-end tw-py-4">
                                    <strong class="tw-text-xl tw-text-gray-800">Total:</strong>
                                </td>
                                <td class="text-end tw-py-4">
                                    <h4 class="tw-mb-0 tw-font-bold tw-text-green-600">
                                        <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
                                    </h4>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Actions Sidebar -->
    <div class="col-md-4">
        <!-- Actions Card -->
        <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl tw-mb-4">
            <div class="card-header tw-border-0 tw-text-white tw-py-4" 
                 style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%);">
                <h5 class="tw-mb-0 tw-font-bold">
                    <i class="bi bi-arrow-bar-left"></i> Back to store 
                </h5>
            </div>
            <div class="card-body tw-p-6">
                <div class="d-grid gap-3">
                    <a href="${pageContext.request.contextPath}/orders" 
                       class="btn tw-py-3 tw-rounded-xl tw-font-bold hover:tw-shadow-lg tw-transition-all"
                       style="border: 2px solid #668586; color: #668586;"
                       onmouseover="this.style.backgroundColor='#668586'; this.style.color='white';"
                       onmouseout="this.style.backgroundColor=''; this.style.color='#668586';">
                        <i class="bi bi-arrow-left"></i> Back to Orders
                    </a>
                    
                    <c:if test="${order.status == 'PENDING' || order.status == 'PROCESSING'}">
                        <form method="post" action="${pageContext.request.contextPath}/orders">
                            <input type="hidden" name="action" value="cancel">
                            <input type="hidden" name="orderId" value="${order.id}">
                            <button type="submit" class="btn btn-danger w-100 tw-py-3 tw-rounded-xl tw-font-bold hover:tw-shadow-lg tw-transition-all" 
                                    onclick="return confirm('Are you sure you want to cancel this order?')">
                                <i class="bi bi-x-circle"></i> Cancel Order
                            </button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />