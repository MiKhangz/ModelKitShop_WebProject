<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="My Profile - ModelKitShop" />
</jsp:include>

<div class="row">
    <div class="col-md-3">
        <!-- Sidebar Menu -->
        <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl tw-sticky" style="top: 100px;">
            <div class="card-body tw-p-6">
                <h5 class="card-title tw-text-xl tw-font-bold tw-text-gray-800 tw-mb-4">
                    <i class="bi bi-person-circle tw-text-purple-600"></i> My Account
                </h5>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item tw-border-0 tw-bg-gradient-to-r tw-from-purple-100 tw-to-purple-50 tw-rounded-xl tw-mb-2 tw-font-semibold tw-text-purple-700">
                        <i class="bi bi-person"></i> Profile Information
                    </li>
                    <li class="list-group-item tw-border-0 hover:tw-bg-gray-100 tw-rounded-xl tw-transition-colors">
                        <a href="${pageContext.request.contextPath}/orders" class="text-decoration-none tw-text-gray-700 hover:tw-text-purple-600 tw-font-medium">
                            <i class="bi bi-receipt"></i> Order History
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="col-md-9">
        <!-- Profile Information Card -->
        <div class="card tw-border-0 tw-shadow-xl tw-rounded-2xl mb-4">
            <div class="card-header tw-border-0 tw-text-white tw-py-5" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                <h4 class="mb-0 tw-text-2xl tw-font-bold">
                    <i class="bi bi-person"></i> Profile Information
                </h4>
            </div>
            <div class="card-body tw-p-8 tw-bg-gradient-to-br tw-from-gray-50 tw-to-white">
                <!-- Success Message -->
                <c:if test="${success != null}">
                    <div class="alert alert-success alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-md" role="alert">
                        <i class="bi bi-check-circle tw-text-xl"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Error Message -->
                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-md" role="alert">
                        <i class="bi bi-exclamation-triangle tw-text-xl"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Profile Update Form -->
                <form method="post" action="${pageContext.request.contextPath}/profile">
                    <input type="hidden" name="action" value="updateProfile">
                    
                    <div class="mb-4">
                        <label class="form-label tw-font-semibold tw-text-gray-700">
                            <i class="bi bi-person tw-text-purple-600"></i> Username
                        </label>
                        <input type="text" class="form-control tw-border-2 tw-border-gray-200 tw-rounded-xl tw-py-3 tw-bg-gray-100" 
                               value="${user.username}" disabled>
                        <small class="tw-text-gray-500">Username cannot be changed</small>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label for="email" class="form-label tw-font-semibold tw-text-gray-700">
                                <i class="bi bi-envelope tw-text-purple-600"></i> Email <span class="text-danger">*</span>
                            </label>
                            <input type="email" class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-purple-500 tw-rounded-xl tw-py-3" 
                                   id="email" name="email" value="${user.email}" required>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <label for="fullName" class="form-label tw-font-semibold tw-text-gray-700">
                                <i class="bi bi-person-badge tw-text-purple-600"></i> Full Name <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-purple-500 tw-rounded-xl tw-py-3" 
                                   id="fullName" name="fullName" value="${user.fullName}" required>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label for="phone" class="form-label tw-font-semibold tw-text-gray-700">
                            <i class="bi bi-telephone tw-text-purple-600"></i> Phone Number
                        </label>
                        <input type="tel" class="form-control" id="phone" name="phone" 
                               value="${user.phone}">
                    </div>
                    
                    <div class="mb-3">
                        <label for="address" class="form-label">
                            <i class="bi bi-geo-alt"></i> Address
                        </label>
                        <textarea class="form-control" id="address" name="address" rows="2">${user.address}</textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label"><i class="bi bi-shield-check"></i> Role</label>
                        <input type="text" class="form-control" value="${user.role}" disabled>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle"></i> Update Profile
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Change Password Card -->
        <div class="card shadow-sm">
            <div class="card-header bg-warning">
                <h4 class="mb-0"><i class="bi bi-key"></i> Change Password</h4>
            </div>
            <div class="card-body p-4">
                <!-- Password Success Message -->
                <c:if test="${passwordSuccess != null}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="bi bi-check-circle"></i> ${passwordSuccess}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Password Error Message -->
                <c:if test="${passwordError != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="bi bi-exclamation-triangle"></i> ${passwordError}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Change Password Form -->
                <form method="post" action="${pageContext.request.contextPath}/profile">
                    <input type="hidden" name="action" value="changePassword">
                    
                    <div class="mb-3">
                        <label for="currentPassword" class="form-label">
                            <i class="bi bi-lock"></i> Current Password <span class="text-danger">*</span>
                        </label>
                        <input type="password" class="form-control" id="currentPassword" 
                               name="currentPassword" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="newPassword" class="form-label">
                            <i class="bi bi-lock-fill"></i> New Password <span class="text-danger">*</span>
                        </label>
                        <input type="password" class="form-control" id="newPassword" 
                               name="newPassword" minlength="6" required>
                        <small class="text-muted">Minimum 6 characters</small>
                    </div>
                    
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">
                            <i class="bi bi-lock-fill"></i> Confirm New Password <span class="text-danger">*</span>
                        </label>
                        <input type="password" class="form-control" id="confirmPassword" 
                               name="confirmPassword" required>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-warning">
                            <i class="bi bi-key"></i> Change Password
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
