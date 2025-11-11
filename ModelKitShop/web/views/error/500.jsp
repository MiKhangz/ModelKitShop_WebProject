<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Internal Server Error | ModelKitShop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="row justify-content-center align-items-center" style="min-height: 100vh;">
            <div class="col-md-6 text-center">
                <i class="bi bi-x-octagon text-danger" style="font-size: 8rem;"></i>
                <h1 class="display-1 fw-bold">500</h1>
                <h2 class="mb-4">Internal Server Error</h2>
                <p class="lead mb-4">
                    Sorry, something went wrong on our end. We're working to fix it!
                </p>
                
                <c:if test="${pageContext.errorData != null}">
                    <div class="alert alert-danger text-start">
                        <h5><i class="bi bi-bug"></i> Error Details:</h5>
                        <p class="mb-0"><strong>Status Code:</strong> ${pageContext.errorData.statusCode}</p>
                        <p class="mb-0"><strong>Request URI:</strong> ${pageContext.errorData.requestURI}</p>
                        <c:if test="${exception != null}">
                            <p class="mb-0"><strong>Exception:</strong> ${exception.class.name}</p>
                            <p class="mb-0"><strong>Message:</strong> ${exception.message}</p>
                        </c:if>
                    </div>
                </c:if>
                
                <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg px-4">
                        <i class="bi bi-house-door"></i> Go to Homepage
                    </a>
                    <button onclick="location.reload()" class="btn btn-outline-secondary btn-lg px-4">
                        <i class="bi bi-arrow-clockwise"></i> Try Again
                    </button>
                </div>
                
                <div class="mt-5">
                    <p class="text-muted">
                        If the problem persists, please contact our support team.
                    </p>
                    <p>
                        <a href="mailto:support@modelkitshop.com">
                            <i class="bi bi-envelope"></i> support@modelkitshop.com
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
