<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Login - ModelKitShop" />
</jsp:include>

<div class="row justify-content-center tw-py-12">
    <div class="col-md-5">
        <div class="card tw-border-0 tw-shadow-2xl tw-rounded-3xl tw-overflow-hidden">
            <div class="card-header tw-border-0 tw-text-white tw-py-6" style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%);">
                <h4 class="mb-0 tw-text-2xl tw-font-bold tw-text-center">
                    <i class="bi bi-box-arrow-in-right tw-text-3xl"></i> Login to Your Account
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
                
                <!-- Login Form -->
                <form method="post" action="${pageContext.request.contextPath}/login" id="loginForm">
                    <div class="mb-4">
                        <label for="username" class="form-label tw-font-semibold tw-text-gray-700 tw-mb-2">
                            <i class="bi bi-person" style="color: #668586;"></i> Username
                        </label>
                        <input type="text" class="form-control tw-border-2 tw-border-gray-200 tw-rounded-xl tw-py-3 tw-text-lg" 
                               id="username" name="username" value="${username}" placeholder="Enter your username" required autofocus
                               style="transition: all 0.3s;" 
                               onfocus="this.style.borderColor='#668586'" 
                               onblur="this.style.borderColor='#e5e7eb'">
                    </div>
                    
                    <div class="mb-4">
                        <label for="password" class="form-label tw-font-semibold tw-text-gray-700 tw-mb-2">
                            <i class="bi bi-lock" style="color: #668586;"></i> Password
                        </label>
                        <input type="password" class="form-control tw-border-2 tw-border-gray-200 tw-rounded-xl tw-py-3 tw-text-lg" 
                               id="password" name="password" placeholder="Enter your password" required
                               style="transition: all 0.3s;" 
                               onfocus="this.style.borderColor='#668586'" 
                               onblur="this.style.borderColor='#e5e7eb'">
                    </div>
                    
                    <div class="mb-4 form-check">
                        <input type="checkbox" class="form-check-input tw-w-5 tw-h-5 tw-cursor-pointer" id="remember" name="remember">
                        <label class="form-check-label tw-text-gray-700 tw-ml-2 tw-cursor-pointer" for="remember">
                            Remember me
                        </label>
                    </div>
                    
                    <input type="hidden" name="redirect" value="${param.redirect}">
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary btn-lg tw-py-4 tw-rounded-xl tw-font-bold tw-text-lg tw-shadow-xl hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105"
                                style="background: linear-gradient(135deg, #668586 0%, #82AEB1 100%); border: none;">
                            <i class="bi bi-box-arrow-in-right tw-text-xl"></i> Login
                        </button>
                    </div>
                </form>
                
                <hr class="tw-my-8 tw-border-gray-300">
                
                <div class="text-center">
                    <p class="mb-0 tw-text-gray-700">Don't have an account? 
                        <a href="${pageContext.request.contextPath}/register" class="text-decoration-none tw-font-bold tw-transition-colors"
                           style="color: #668586;"
                           onmouseover="this.style.color='#527070'"
                           onmouseout="this.style.color='#668586'">
                            Register here
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />