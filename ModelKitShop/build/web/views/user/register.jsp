<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Register - ModelKitShop" />
</jsp:include>

<div class="row justify-content-center tw-py-12">
    <div class="col-md-7">
        <div class="card tw-border-0 tw-shadow-2xl tw-rounded-3xl tw-overflow-hidden">
            <div class="card-header tw-border-0 tw-text-white tw-py-6" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
                <h4 class="mb-0 tw-text-2xl tw-font-bold tw-text-center">
                    <i class="bi bi-person-plus tw-text-3xl"></i> Create New Account
                </h4>
            </div>
            <div class="card-body tw-p-8 tw-bg-gradient-to-br tw-from-gray-50 tw-to-white">
                <!-- Error Message -->
                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible fade show tw-rounded-xl tw-border-0 tw-shadow-md" role="alert">
                        <i class="bi bi-exclamation-triangle tw-text-xl"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <!-- Registration Form -->
                <form method="post" action="${pageContext.request.contextPath}/register" id="registerForm">
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label for="username" class="form-label tw-font-semibold tw-text-gray-700 tw-mb-2">
                                <i class="bi bi-person tw-text-green-600"></i> Username <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-green-500 tw-rounded-xl tw-py-3" 
                                   id="username" name="username" value="${username}" placeholder="Choose a username" 
                                   minlength="3" maxlength="50" required autofocus>
                            <small class="tw-text-gray-500">3-50 characters</small>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <label for="email" class="form-label tw-font-semibold tw-text-gray-700 tw-mb-2">
                                <i class="bi bi-envelope tw-text-green-600"></i> Email <span class="text-danger">*</span>
                            </label>
                            <input type="email" class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-green-500 tw-rounded-xl tw-py-3" 
                                   id="email" name="email" value="${email}" placeholder="your.email@example.com" required>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label for="password" class="form-label tw-font-semibold tw-text-gray-700 tw-mb-2">
                                <i class="bi bi-lock tw-text-green-600"></i> Password <span class="text-danger">*</span>
                            </label>
                            <input type="password" class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-green-500 tw-rounded-xl tw-py-3" 
                                   id="password" name="password" placeholder="Choose a strong password" minlength="6" required>
                            <small class="tw-text-gray-500">Minimum 6 characters</small>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <label for="confirmPassword" class="form-label tw-font-semibold tw-text-gray-700 tw-mb-2">
                                <i class="bi bi-lock-fill tw-text-green-600"></i> Confirm Password <span class="text-danger">*</span>
                            </label>
                            <input type="password" class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-green-500 tw-rounded-xl tw-py-3" 
                                   id="confirmPassword" name="confirmPassword" placeholder="Re-enter your password" required>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label for="fullName" class="form-label tw-font-semibold tw-text-gray-700 tw-mb-2">
                            <i class="bi bi-person-badge tw-text-green-600"></i> Full Name <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-green-500 tw-rounded-xl tw-py-3" 
                               id="fullName" name="fullName" value="${fullName}" placeholder="Your full name" required>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <label for="phone" class="form-label tw-font-semibold tw-text-gray-700 tw-mb-2">
                                <i class="bi bi-telephone tw-text-green-600"></i> Phone Number
                            </label>
                            <input type="tel" class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-green-500 tw-rounded-xl tw-py-3" 
                                   id="phone" name="phone" value="${phone}" placeholder="+84 123 456 789">
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label for="address" class="form-label tw-font-semibold tw-text-gray-700 tw-mb-2">
                            <i class="bi bi-geo-alt tw-text-green-600"></i> Address
                        </label>
                        <textarea class="form-control tw-border-2 tw-border-gray-200 focus:tw-border-green-500 tw-rounded-xl tw-py-3" 
                                  id="address" name="address" rows="2" placeholder="Your delivery address">${address}</textarea>
                    </div>
                    
                    <div class="mb-4 form-check tw-bg-green-50 tw-p-4 tw-rounded-xl">
                        <input type="checkbox" class="form-check-input tw-w-5 tw-h-5 tw-cursor-pointer" id="terms" required>
                        <label class="form-check-label tw-text-gray-700 tw-ml-2 tw-cursor-pointer" for="terms">
                            I agree to the <a href="#" class="text-decoration-none tw-text-green-600 hover:tw-text-green-800 tw-font-semibold">Terms of Service</a> 
                            and <a href="#" class="text-decoration-none tw-text-green-600 hover:tw-text-green-800 tw-font-semibold">Privacy Policy</a>
                        </label>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-success btn-lg tw-py-4 tw-rounded-xl tw-font-bold tw-text-lg tw-shadow-xl hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105"
                                style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
                            <i class="bi bi-person-plus tw-text-xl"></i> Create Account
                        </button>
                    </div>
                </form>
                
                <hr class="tw-my-8 tw-border-gray-300">
                
                <div class="text-center">
                    <p class="mb-0 tw-text-gray-700">Already have an account? 
                        <a href="${pageContext.request.contextPath}/login" class="text-decoration-none tw-text-green-600 hover:tw-text-green-800 tw-font-bold tw-transition-colors">
                            Login here
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/validation.js"></script>
<jsp:include page="../common/footer.jsp" />
