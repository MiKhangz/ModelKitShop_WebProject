<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title != null ? param.title : 'ModelKitShop - Premium Model Kits'}</title>
    
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            prefix: 'tw-',
            corePlugins: {
                preflight: false,
            },
            theme: {
                extend: {
                    colors: {
                        primary: '#667eea',
                        secondary: '#764ba2',
                        accent: '#f093fb',
                    }
                }
            }
        }
    </script>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="tw-font-['Inter'] tw-bg-gray-50">
    <!-- Navigation Bar with Gradient -->
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top tw-shadow-xl" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center tw-text-white tw-font-bold tw-text-2xl" href="${pageContext.request.contextPath}/">
                <i class="bi bi-box-seam me-2 tw-text-3xl"></i>
                <span class="tw-bg-clip-text tw-text-transparent tw-bg-gradient-to-r tw-from-white tw-to-purple-200">ModelKitShop</span>
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto tw-items-center tw-gap-2">
                    <li class="nav-item">
                        <a class="nav-link tw-px-4 tw-py-2 tw-rounded-lg tw-transition-all hover:tw-bg-white/20" href="${pageContext.request.contextPath}/views/product/home.jsp">
                            <i class="bi bi-house-door-fill tw-mr-2"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link tw-px-4 tw-py-2 tw-rounded-lg tw-transition-all hover:tw-bg-white/20" href="${pageContext.request.contextPath}/products">
                            <i class="bi bi-grid-fill tw-mr-2"></i>Products
                        </a>
                    </li>
                    
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <!-- Logged in user menu -->
                            <li class="nav-item">
                                <a class="nav-link position-relative tw-px-4 tw-py-2 tw-rounded-lg tw-transition-all hover:tw-bg-white/20" href="${pageContext.request.contextPath}/cart">
                                    <i class="bi bi-cart3 tw-mr-2 tw-text-xl"></i>Cart
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link tw-px-4 tw-py-2 tw-rounded-lg tw-transition-all hover:tw-bg-white/20" href="${pageContext.request.contextPath}/orders">
                                    <i class="bi bi-receipt tw-mr-2"></i>My Orders
                                </a>
                            </li>
                            
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle tw-px-4 tw-py-2 tw-rounded-lg tw-transition-all hover:tw-bg-white/20 tw-flex tw-items-center tw-gap-2" href="javascript:void(0)" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <div class="tw-w-8 tw-h-8 tw-rounded-full tw-bg-white/30 tw-flex tw-items-center tw-justify-center">
                                        <i class="bi bi-person-fill"></i>
                                    </div>
                                    <span class="tw-font-semibold">${not empty sessionScope.user.fullName ? sessionScope.user.fullName : sessionScope.user.username}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end tw-shadow-2xl tw-border-0 tw-mt-2" aria-labelledby="userDropdown">
                                    <li><a class="dropdown-item tw-px-4 tw-py-3 hover:tw-bg-purple-50 tw-transition-colors" href="${pageContext.request.contextPath}/profile">
                                        <i class="bi bi-person-circle tw-mr-2 tw-text-purple-600"></i>My Profile
                                    </a></li>
                                    
                                    <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                        <li><hr class="dropdown-divider"></li>
                                        <li><h6 class="dropdown-header tw-font-bold tw-text-purple-700">Admin Panel</h6></li>
                                        <li><a class="dropdown-item tw-px-4 tw-py-3 hover:tw-bg-purple-50 tw-transition-colors" href="${pageContext.request.contextPath}/admin/products">
                                            <i class="bi bi-box-seam tw-mr-2 tw-text-purple-600"></i>Manage Products
                                        </a></li>
                                        <li><a class="dropdown-item tw-px-4 tw-py-3 hover:tw-bg-purple-50 tw-transition-colors" href="${pageContext.request.contextPath}/admin/orders">
                                            <i class="bi bi-list-check tw-mr-2 tw-text-purple-600"></i>Manage Orders
                                        </a></li>
                                    </c:if>
                                    
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger tw-px-4 tw-py-3 hover:tw-bg-red-50 tw-transition-colors" href="${pageContext.request.contextPath}/logout">
                                        <i class="bi bi-box-arrow-right tw-mr-2"></i>Logout
                                    </a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <!-- Guest user menu -->
                            <li class="nav-item">
                                <a class="nav-link tw-px-4 tw-py-2 tw-rounded-lg tw-transition-all hover:tw-bg-white/20" href="${pageContext.request.contextPath}/login">
                                    <i class="bi bi-box-arrow-in-right tw-mr-2"></i>Login
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-light tw-rounded-full tw-px-6 tw-py-2 tw-font-semibold tw-shadow-lg hover:tw-shadow-xl tw-transition-all" href="${pageContext.request.contextPath}/register">
                                    <i class="bi bi-person-plus tw-mr-2"></i>Register
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    
    <!-- Main Content Container -->
    <main class="container my-4">
