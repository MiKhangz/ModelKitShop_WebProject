<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Order Details - Admin" />
</jsp:include>

<!-- Breadcrumb -->
<nav aria-label="breadcrumb" class="tw-mb-6 tw-p-4 tw-bg-gradient-to-r tw-from-purple-50 tw-to-blue-50 tw-rounded-xl">
    <ol class="breadcrumb tw-mb-0">
        <li class="breadcrumb-item">
            <a href="${pageContext.request.contextPath}/admin/orders" class="tw-text-purple-600 hover:tw-text-purple-800">
                <i class="bi bi-list-check"></i> Orders
            </a>
        </li>
        <li class="breadcrumb-item active tw-font-bold">Order #${order.id}</li>
    </ol>
</nav>

<h2 class="tw-text-4xl tw-font-bold tw-text-gray-800 tw-mb-6">
    <i class="bi bi-receipt tw-text-purple-600"></i> Order #${order.id}
</h2>

<!-- Success Message -->
<c:if test="${param.updated == 'true'}">
    <div class="alert alert-success alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg tw-mb-6" role="alert">
        <i class="bi bi-check-circle tw-text-xl"></i> Order status updated successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="row">
    <!-- Order Information -->
    <div class="col-md-8">
        <!-- Customer & Order Info -->
        <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl tw-mb-6">
            <div class="card-header tw-border-0 tw-text-white tw-py-4" 
                 style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <h5 class="tw-mb-0 tw-font-bold tw-text-lg">
                    <i class="bi bi-info-circle"></i> Order Information
                </h5>
            </div>
            <div class="card-body tw-p-6">
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="tw-p-4 tw-bg-purple-50 tw-rounded-xl">
                            <strong class="tw-text-purple-700 tw-text-lg">
                                <i class="bi bi-person"></i> Customer
                            </strong>
                            <div class="tw-mt-2">
                                <p class="tw-mb-1 tw-font-semibold tw-text-gray-800">${order.user.fullName}</p>
                                <small class="text-muted"><i class="bi bi-envelope"></i> ${order.user.email}</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="tw-p-4 tw-bg-blue-50 tw-rounded-xl">
                            <strong class="tw-text-blue-700 tw-text-lg">
                                <i class="bi bi-calendar"></i> Order Date
                            </strong>
                            <div class="tw-mt-2">
                                <p class="tw-mb-0 tw-font-semibold tw-text-gray-800">
                                    <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="mb-4">
                    <div class="tw-p-4 tw-bg-green-50 tw-rounded-xl">
                        <strong class="tw-text-green-700 tw-text-lg">
                            <i class="bi bi-geo-alt"></i> Shipping Address
                        </strong>
                        <p class="tw-mt-2 tw-mb-0 tw-text-gray-800">${order.shippingAddress}</p>
                    </div>
                </div>
                
                <div>
                    <strong class="tw-text-gray-700 tw-text-lg">
                        <i class="bi bi-flag"></i> Current Status
                    </strong>
                    <div class="tw-mt-2">
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
                                <span class="badge tw-bg-purple-100 tw-text-purple-800 tw-px-4 tw-py-2 tw-text-sm tw-font-bold tw-rounded-full">
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
        
        <!-- Order Items -->
        <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl">
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
                                <tr class="hover:tw-bg-gray-50 tw-transition-colors">
                                    <td class="tw-py-4">
                                        <div class="d-flex align-items-center">
                                           <c:choose>
    <c:when test="${not empty detail.product.imageUrl && (fn:startsWith(detail.product.imageUrl, 'http://') || fn:startsWith(detail.product.imageUrl, 'https://'))}">
        <img src="${detail.product.imageUrl}" 
             class="tw-rounded-lg tw-me-3 tw-shadow-md" 
             style="width: 60px; height: 60px; object-fit: cover;" 
             alt="${detail.product.name}">
    </c:when>
    <c:when test="${not empty detail.product.imageUrl}">
        <img src="${pageContext.request.contextPath}/images/products/${detail.product.imageUrl}" 
             class="tw-rounded-lg tw-me-3 tw-shadow-md" 
             style="width: 60px; height: 60px; object-fit: cover;" 
             alt="${detail.product.name}">
    </c:when>
    <c:otherwise>
        <img src="${pageContext.request.contextPath}/images/no-image.jpg" 
             class="tw-rounded-lg tw-me-3 tw-shadow-md" 
             style="width: 60px; height: 60px; object-fit: cover;" 
             alt="${detail.product.name}">
    </c:otherwise>
</c:choose>
                                            <strong class="tw-text-gray-800">${detail.product.name}</strong>
                                        </div>
                                    </td>
                                    <td class="tw-py-4 tw-text-gray-700">
                                        <fmt:formatNumber value="${detail.price}" type="currency" currencySymbol="$"/>
                                    </td>
                                    <td class="tw-py-4">
                                        <span class="badge tw-bg-purple-100 tw-text-purple-800 tw-px-3 tw-py-2 tw-font-bold">
                                            ${detail.quantity}
                                        </span>
                                    </td>
                                    <td class="text-end tw-py-4">
                                        <strong class="tw-text-green-600 tw-text-lg">
                                            <fmt:formatNumber value="${detail.subtotal}" type="currency" currencySymbol="$"/>
                                        </strong>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot class="tw-bg-gradient-to-r tw-from-purple-50 tw-to-blue-50">
                            <tr>
                                <td colspan="3" class="text-end tw-py-4">
                                    <strong class="tw-text-xl tw-text-gray-800">Total:</strong>
                                </td>
                                <td class="text-end tw-py-4">
                                    <h4 class="tw-mb-0 tw-font-bold" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/>
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
        <!-- Update Status Card -->
        <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl tw-mb-4">
            <div class="card-header tw-border-0 tw-text-white tw-py-4" 
                 style="background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);">
                <h5 class="tw-mb-0 tw-font-bold">
                    <i class="bi bi-pencil"></i> Update Status
                </h5>
            </div>
            <div class="card-body tw-p-6">
                <form method="post" action="${pageContext.request.contextPath}/admin/orders">
                    <input type="hidden" name="action" value="updateStatus">
                    <input type="hidden" name="orderId" value="${order.id}">
                    
                    <div class="mb-4">
                        <label for="status" class="form-label tw-font-bold tw-text-gray-700">
                            <i class="bi bi-flag"></i> New Status:
                        </label>
                        <select class="form-select tw-border-2 tw-border-gray-200 focus:tw-border-orange-500 tw-rounded-xl tw-py-3 tw-text-lg" 
                                id="status" name="status" required>
                            <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>⏱️ Pending</option>
                            <option value="PROCESSING" ${order.status == 'PROCESSING' ? 'selected' : ''}>🔄 Processing</option>
                            <option value="SHIPPED" ${order.status == 'SHIPPED' ? 'selected' : ''}>🚚 Shipped</option>
                            <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>✅ Delivered</option>
                            <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>❌ Cancelled</option>
                        </select>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn tw-py-3 tw-rounded-xl tw-font-bold tw-text-white tw-shadow-lg hover:tw-shadow-xl tw-transition-all hover:tw-scale-105"
                                style="background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);">
                            <i class="bi bi-check-circle"></i> Update Status
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Actions Card -->
        <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl">
            <div class="card-body tw-p-6">
                <div class="d-grid gap-3">
                    <a href="${pageContext.request.contextPath}/admin/orders" 
                       class="btn btn-outline-primary tw-py-3 tw-rounded-xl tw-font-bold hover:tw-shadow-lg tw-transition-all">
                        <i class="bi bi-arrow-left"></i> Back to Orders
                    </a>
                    
                    <button type="button" 
                            class="btn btn-outline-danger tw-py-3 tw-rounded-xl tw-font-bold hover:tw-shadow-lg tw-transition-all"
                            onclick="if(confirm('Are you sure you want to delete this order?')) { window.location.href='${pageContext.request.contextPath}/admin/orders?action=delete&id=${order.id}'; }">
                        <i class="bi bi-trash"></i> Delete Order
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
