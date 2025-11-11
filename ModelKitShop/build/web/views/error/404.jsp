<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found | ModelKitShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="row justify-content-center align-items-center" style="min-height: 100vh;">
            <div class="col-md-6 text-center">
                <i class="bi bi-exclamation-triangle text-warning" style="font-size: 8rem;"></i>
                <h1 class="display-1 fw-bold">404</h1>
                <h2 class="mb-4">Page Not Found</h2>
                <p class="lead mb-4">
                    Oops! The page you are looking for doesn't exist or has been moved.
                </p>
                
                <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg px-4">
                        <i class="bi bi-house-door"></i> Go to Homepage
                    </a>
                    <button onclick="history.back()" class="btn btn-outline-secondary btn-lg px-4">
                        <i class="bi bi-arrow-left"></i> Go Back
                    </button>
                </div>
                
                <div class="mt-5">
                    <h5>Popular Pages:</h5>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/products">Browse Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/cart">View Cart</a></li>
                        <li><a href="${pageContext.request.contextPath}/profile">My Profile</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
