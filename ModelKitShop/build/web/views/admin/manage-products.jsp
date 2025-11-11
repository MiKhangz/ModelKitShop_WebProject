<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Manage Products - Admin" />
</jsp:include>

<h2 class="tw-text-4xl tw-font-bold tw-text-gray-800 tw-mb-8">
    <i class="bi bi-box-seam" style="color: #668586;"></i> Manage Products
</h2>

<!-- Success/Error Messages -->
<c:if test="${param.added == 'true'}">
    <div class="alert alert-success alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg" role="alert">
        <i class="bi bi-check-circle tw-text-xl"></i> Product added successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${param.updated == 'true'}">
    <div class="alert alert-success alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg" role="alert">
        <i class="bi bi-check-circle tw-text-xl"></i> Product updated successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${param.deleted == 'true'}">
    <div class="alert alert-info alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-lg" role="alert">
        <i class="bi bi-info-circle tw-text-xl"></i> Product deleted successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<!-- Header with Add Button -->
<div class="tw-flex tw-justify-between tw-items-center tw-mb-6 tw-p-4 tw-rounded-xl" style="background: linear-gradient(to right, #d8e5e5, #e8f0f0);">
    <span class="tw-text-lg tw-font-semibold tw-text-gray-700">
        <i class="bi bi-database"></i> ${totalProducts} products total
    </span>
    <a href="${pageContext.request.contextPath}/admin/products?action=add" 
       class="btn btn-success tw-px-6 tw-py-3 tw-rounded-xl tw-font-bold tw-shadow-lg hover:tw-shadow-xl tw-transition-all hover:tw-scale-105"
       style="background: linear-gradient(135deg, #10b981 0%, #059669 100%); border: none;">
        <i class="bi bi-plus-circle tw-text-lg"></i> Add New Product
    </a>
</div>

<!-- Products Table -->
<div class="card tw-border-0 tw-shadow-2xl tw-rounded-2xl">
    <div class="card-body tw-p-6">
        <div class="table-responsive">
            <table class="table table-hover tw-rounded-xl tw-overflow-hidden">
                <thead style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%);">
                    <tr class="tw-text-white">
                        <th class="tw-py-4 tw-font-bold">ID</th>
                        <th class="tw-py-4 tw-font-bold">Image</th>
                        <th class="tw-py-4 tw-font-bold">Name</th>
                        <th class="tw-py-4 tw-font-bold">Brand</th>
                        <th class="tw-py-4 tw-font-bold">Scale</th>
                        <th class="tw-py-4 tw-font-bold">Price</th>
                        <th class="tw-py-4 tw-font-bold">Stock</th>
                        <th class="text-center tw-py-4 tw-font-bold">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${products}">
                        <tr class="tw-transition-colors" 
                            onmouseover="this.style.backgroundColor='#e8f0f0'" 
                            onmouseout="this.style.backgroundColor=''">
                            <td class="tw-py-4 tw-font-semibold tw-text-gray-700">${product.id}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty product.imageUrl && (fn:startsWith(product.imageUrl, 'http://') || fn:startsWith(product.imageUrl, 'https://'))}">
                                        <img src="${product.imageUrl}"
                                             class="rounded" style="width: 50px; height: 50px; object-fit: cover;" 
                                             alt="${product.name}" />
                                    </c:when>
                                    <c:when test="${not empty product.imageUrl}">
                                        <img src="${pageContext.request.contextPath}/images/products/${product.imageUrl}"
                                             class="rounded" style="width: 50px; height: 50px; object-fit: cover;" 
                                             alt="${product.name}" />
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/images/no-image.jpg"
                                             class="rounded" style="width: 50px; height: 50px; object-fit: cover;" 
                                             alt="No image" />
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${product.name}</td>
                            <td>${product.brand}</td>
                            <td>${product.scale}</td>
                            <td>
                                <span style="color: #668586; font-weight: 600;">
                                    <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/> VND
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${product.stockQuantity > 10}">
                                        <span class="badge bg-success">${product.stockQuantity}</span>
                                    </c:when>
                                    <c:when test="${product.stockQuantity > 0}">
                                        <span class="badge bg-warning">${product.stockQuantity}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Out of Stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <div class="btn-group" role="group">
                                    <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.id}" 
                                       class="btn btn-sm" 
                                       style="border: 1.5px solid #668586; color: #668586; transition: all 0.3s;"
                                       onmouseover="this.style.backgroundColor='#668586'; this.style.color='white';"
                                       onmouseout="this.style.backgroundColor=''; this.style.color='#668586';"
                                       title="Edit">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${product.id}" 
                                       class="btn btn-sm btn-outline-danger" 
                                       onclick="return confirm('Are you sure you want to delete this product?')" 
                                       title="Delete">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <!-- Pagination -->
        <c:if test="${totalPages > 1}">
            <nav class="mt-3">
                <ul class="pagination justify-content-center tw-gap-2">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link tw-rounded-lg tw-border-2 tw-px-4 tw-py-2 tw-transition-colors" 
                           style="border-color: #668586; color: #668586;"
                           onmouseover="if(${currentPage != 1}) {this.style.backgroundColor='#668586'; this.style.color='white';}"
                           onmouseout="if(${currentPage != 1}) {this.style.backgroundColor=''; this.style.color='#668586';}"
                           href="${pageContext.request.contextPath}/admin/products?page=${currentPage - 1}">
                            Previous
                        </a>
                    </li>
                    
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link tw-rounded-lg tw-border-2 tw-transition-all" 
                               style="${currentPage == i ? 'background-color: #668586; border-color: #668586; color: white;' : 'border-color: #e5e7eb; color: #4b5563;'}"
                               onmouseover="if(${currentPage != i}) {this.style.borderColor='#668586'; this.style.color='#668586';}"
                               onmouseout="if(${currentPage != i}) {this.style.borderColor='#e5e7eb'; this.style.color='#4b5563';}"
                               href="${pageContext.request.contextPath}/admin/products?page=${i}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>
                    
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link tw-rounded-lg tw-border-2 tw-px-4 tw-py-2 tw-transition-colors" 
                           style="border-color: #668586; color: #668586;"
                           onmouseover="if(${currentPage != totalPages}) {this.style.backgroundColor='#668586'; this.style.color='white';}"
                           onmouseout="if(${currentPage != totalPages}) {this.style.backgroundColor=''; this.style.color='#668586';}"
                           href="${pageContext.request.contextPath}/admin/products?page=${currentPage + 1}">
                            Next
                        </a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />