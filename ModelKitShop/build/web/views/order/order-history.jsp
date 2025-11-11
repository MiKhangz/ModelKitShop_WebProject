<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Order History - ModelKitShop" />
</jsp:include>

<h2 class="tw-text-4xl tw-font-bold tw-text-gray-800 tw-mb-8">
    <i class="bi bi-receipt tw-text-purple-600"></i> Order History
</h2>

<!-- Success Messages -->
<c:if test="${param.cancelled == 'true'}">
    <div class="alert alert-info alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg" role="alert">
        <i class="bi bi-info-circle tw-text-xl"></i> Order cancelled successfully.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Error Messages -->
<c:if test="${param.error == 'notFound'}">
    <div class="alert alert-danger alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg" role="alert">
        <i class="bi bi-exclamation-triangle tw-text-xl"></i> Order not found.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${param.error == 'unauthorized'}">
    <div class="alert alert-danger alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg" role="alert">
        <i class="bi bi-exclamation-triangle tw-text-xl"></i> You are not authorized to view this order.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${param.error == 'cannotCancel'}">
    <div class="alert alert-danger alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg" role="alert">
        <i class="bi bi-exclamation-triangle tw-text-xl"></i> This order cannot be cancelled. Orders can only be cancelled when they are PENDING or PROCESSING.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:choose>
    <c:when test="${empty orders}">
        <!-- No Orders -->
        <div class="text-center tw-py-20">
            <div class="tw-inline-block tw-p-8 tw-bg-gradient-to-br tw-from-purple-100 tw-to-blue-100 tw-rounded-full tw-mb-6">
                <i class="bi bi-inbox tw-text-8xl tw-text-purple-600"></i>
            </div>
            <h3 class="tw-text-3xl tw-font-bold tw-text-gray-800 tw-mb-4">No orders yet</h3>
            <p class="tw-text-gray-600 tw-mb-8 tw-text-lg">Start shopping to create your first order</p>
            <a href="${pageContext.request.contextPath}/products" 
               class="btn btn-primary tw-px-8 tw-py-4 tw-rounded-full tw-font-bold tw-text-lg tw-shadow-xl hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105"
               style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <i class="bi bi-grid"></i> Browse Products
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <!-- Orders List -->
        <div class="row">
            <c:forEach var="order" items="${orders}">
                <div class="col-12 mb-4">
                    <div class="card tw-border-0 tw-shadow-lg hover:tw-shadow-xl tw-transition-shadow tw-rounded-2xl">
                        <div class="card-header tw-bg-gradient-to-r tw-from-gray-50 tw-to-white tw-border-0 tw-py-4 tw-flex tw-justify-between tw-items-center">
                            <div>
                                <strong class="tw-text-xl tw-text-gray-800">Order #${order.id}</strong>
                                <span class="tw-text-gray-500 tw-ml-3">
                                    <i class="bi bi-calendar"></i>
                                    <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </span>
                            </div>
                            <div>
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
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-8">
                                    <p class="mb-1">
                                        <i class="bi bi-geo-alt"></i> 
                                        <strong>Shipping Address:</strong> ${order.shippingAddress}
                                    </p>
                                    <p class="mb-0">
                                       
                                        <strong>Total:</strong> 
                                        <span class="text-primary">
                                            <fmt:formatNumber value="${order.totalAmount}" type="number" />VND
                                        </span>
                                    </p>
                                </div>
                                <div class="col-md-4 text-end">
                                    <a href="${pageContext.request.contextPath}/orders?action=detail&id=${order.id}" 
                                       class="btn btn-outline-primary btn-sm tw-rounded-lg tw-px-4 tw-py-2 hover:tw-shadow-lg tw-transition-all">
                                        <i class="bi bi-eye"></i> View Details
                                    </a>
                                    
                                    <c:if test="${order.status == 'PENDING' || order.status == 'PROCESSING'}">
                                        <form method="post" action="${pageContext.request.contextPath}/orders" class="d-inline">
                                            <input type="hidden" name="action" value="cancel">
                                            <input type="hidden" name="orderId" value="${order.id}">
                                            <button type="submit" class="btn btn-outline-danger btn-sm tw-rounded-lg tw-px-4 tw-py-2 hover:tw-shadow-lg tw-transition-all" 
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
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="../common/footer.jsp" />
