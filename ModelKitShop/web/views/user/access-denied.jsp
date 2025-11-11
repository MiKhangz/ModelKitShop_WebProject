<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Access Denied - ModelKitShop" />
</jsp:include>

<div class="row justify-content-center tw-py-20">
    <div class="col-md-6 text-center">
        <div class="card tw-border-0 tw-shadow-2xl tw-rounded-3xl">
            <div class="card-body tw-p-12 tw-bg-gradient-to-br tw-from-red-50 tw-to-orange-50">
                <div class="tw-inline-block tw-p-8 tw-bg-gradient-to-br tw-from-red-100 tw-to-red-200 tw-rounded-full tw-mb-6">
                    <i class="bi bi-shield-x tw-text-8xl tw-text-red-600"></i>
                </div>
                <h1 class="tw-text-4xl tw-font-bold tw-text-gray-800 tw-mb-4">Access Denied</h1>
                <p class="tw-text-xl tw-text-gray-700 tw-mb-3">You don't have permission to access this page.</p>
                <p class="tw-text-gray-600 tw-mb-8">This area is restricted to administrators only.</p>
                
                <hr class="tw-my-8 tw-border-gray-300">
                
                <div class="d-grid gap-3 tw-max-w-md tw-mx-auto">
                    <a href="${pageContext.request.contextPath}/views/product/home.jsp" 
                       class="btn btn-primary tw-py-4 tw-rounded-xl tw-font-bold tw-text-lg tw-shadow-xl hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105"
                       style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                        <i class="bi bi-house-door tw-text-xl"></i> Go to Home
                    </a>
                    <a href="${pageContext.request.contextPath}/profile" 
                       class="btn btn-outline-secondary tw-py-3 tw-rounded-xl tw-font-semibold hover:tw-bg-gray-700 hover:tw-text-white tw-transition-all">
                        <i class="bi bi-person"></i> My Profile
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
