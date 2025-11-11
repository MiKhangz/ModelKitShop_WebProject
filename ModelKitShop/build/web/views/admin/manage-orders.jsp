<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Manage Orders - Admin" />
</jsp:include>

<h2 class="tw-text-4xl tw-font-bold tw-text-gray-800 tw-mb-8">
    <i class="bi bi-list-check" style="color: #668586;"></i> Manage Orders
</h2>

<!-- Success Message -->
<c:if test="${param.updated == 'true'}">
    <div class="alert alert-success alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg" role="alert">
        <i class="bi bi-check-circle tw-text-xl"></i> Order status updated successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Filter by Status -->
<div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl mb-4">
    <div class="card-body tw-p-6" style="background: linear-gradient(to right, #d8e5e5, #e8f0f0);">
        <div class="row align-items-center">
            <div class="col-md-3">
                <label for="statusFilter" class="form-label tw-font-bold tw-text-gray-700 tw-text-lg">
                    <i class="bi bi-funnel" style="color: #668586;"></i> Filter by Status:
                </label>
            </div>
            <div class="col-md-6">
                <select class="form-select tw-border-2 tw-border-gray-200 tw-rounded-xl tw-py-3 tw-text-lg tw-font-semibold" 
                        id="statusFilter" 
                        style="transition: border-color 0.3s;"
                        onfocus="this.style.borderColor='#668586'"
                        onblur="this.style.borderColor='#e5e7eb'"
                        onchange="location = '${pageContext.request.contextPath}/admin/orders?status=' + this.value;">
                    <option value="">All Orders</option>
                    <option value="PENDING" ${selectedStatus == 'PENDING' ? 'selected' : ''}>Pending</option>
                    <option value="PROCESSING" ${selectedStatus == 'PROCESSING' ? 'selected' : ''}>Processing</option>
                    <option value="SHIPPED" ${selectedStatus == 'SHIPPED' ? 'selected' : ''}>Shipped</option>
                    <option value="DELIVERED" ${selectedStatus == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                    <option value="CANCELLED" ${selectedStatus == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                </select>
            </div>
        </div>
    </div>
</div>

<!-- Orders Table -->
<div class="card tw-border-0 tw-shadow-2xl tw-rounded-2xl">
    <div class="card-body tw-p-6">
        <c:choose>
            <c:when test="${empty orders}">
                <div class="text-center tw-py-20">
                    <div class="tw-inline-block tw-p-8 tw-rounded-full tw-mb-6" style="background: linear-gradient(to bottom right, #d8e5e5, #e8f0f0);">
                        <i class="bi bi-inbox tw-text-8xl" style="color: #668586;"></i>
                    </div>
                    <h3 class="tw-text-3xl tw-font-bold tw-text-gray-800">No orders found</h3>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover tw-rounded-xl tw-overflow-hidden">
                        <thead style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%);">
                            <tr class="tw-text-white">
                                <th class="tw-py-4 tw-font-bold">Order ID</th>
                                <th class="tw-py-4 tw-font-bold">Customer</th>
                                <th class="tw-py-4 tw-font-bold">Order Date</th>
                                <th class="tw-py-4 tw-font-bold">Total Amount</th>
                                <th class="tw-py-4 tw-font-bold">Status</th>
                                <th class="text-center tw-py-4 tw-font-bold">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr class="tw-transition-colors"
                                    onmouseover="this.style.backgroundColor='#e8f0f0'"
                                    onmouseout="this.style.backgroundColor=''">
                                    <td><strong>#${order.id}</strong></td>
                                    <td>${order.user.fullName}</td>
                                    <td>
                                        <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>
                                        <span style="color: #668586; font-weight: 600;">
                                            <fmt:formatNumber value="${order.totalAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">
                                                <span class="badge bg-warning">Pending</span>
                                            </c:when>
                                            <c:when test="${order.status == 'PROCESSING'}">
                                                <span class="badge bg-info">Processing</span>
                                            </c:when>
                                            <c:when test="${order.status == 'SHIPPED'}">
                                                <span class="badge" style="background-color: #668586;">Shipped</span>
                                            </c:when>
                                            <c:when test="${order.status == 'DELIVERED'}">
                                                <span class="badge bg-success">Delivered</span>
                                            </c:when>
                                            <c:when test="${order.status == 'CANCELLED'}">
                                                <span class="badge bg-danger">Cancelled</span>
                                            </c:when>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${order.id}" 
                                               class="btn btn-sm tw-rounded-l-lg tw-transition-all"
                                               style="border: 1.5px solid #668586; color: #668586;"
                                               onmouseover="this.style.backgroundColor='#668586'; this.style.color='white'; this.style.boxShadow='0 4px 6px rgba(0,0,0,0.1)';"
                                               onmouseout="this.style.backgroundColor=''; this.style.color='#668586'; this.style.boxShadow='';"
                                               title="View Details">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <button type="button" 
                                                    class="btn btn-sm btn-outline-danger tw-rounded-r-lg hover:tw-shadow-lg tw-transition-all" 
                                                    onclick="if(confirm('Are you sure you want to delete this order?')) { window.location.href='${pageContext.request.contextPath}/admin/orders?action=delete&id=${order.id}'; }"
                                                    title="Delete Order">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />