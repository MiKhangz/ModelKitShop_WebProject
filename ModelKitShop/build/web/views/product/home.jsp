<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Home - ModelKitShop" />
</jsp:include>

<!-- The Big Bad Banner Section -->
<div class="tw-relative tw-overflow-hidden tw-rounded-3xl tw-mb-12 tw-shadow-2xl" 
     style="background: #668586;">
    <div class="container tw-py-20 tw-relative tw-z-10">
        <div class="tw-text-center tw-text-white">
            <div class="tw-mb-6">
                <i class="bi bi-gift tw-text-7xl tw-opacity-90"></i>
            </div>
            <h1 class="tw-text-5xl tw-font-bold tw-mb-4 tw-bg-clip-text tw-text-transparent tw-bg-gradient-to-r tw-from-white tw-to-purple-200">
                Welcome to ModelKitShop
            </h1>
            <p class="tw-text-2xl tw-mb-6 tw-text-white/90">Discover premium model kits from top brands worldwide</p>
            <hr class="tw-border-white/30 tw-my-8 tw-w-1/3 tw-mx-auto">
            <p class="tw-text-lg tw-mb-8 tw-text-white/80">Browse our extensive collection of aircraft, ships, cars, and military vehicle models</p>
            <a class="btn btn-light btn-lg tw-px-8 tw-py-3 tw-rounded-full tw-shadow-xl hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105" 
               href="${pageContext.request.contextPath}/products" role="button">
                <i class="bi bi-grid"></i> Browse All Products
            </a>
        </div>
    </div>
    <!-- Decorative Background Pattern -->
    <div class="tw-absolute tw-top-0 tw-left-0 tw-w-full tw-h-full tw-opacity-10" 
         style="background-image: repeating-linear-gradient(45deg, transparent, transparent 35px, rgba(255,255,255,.1) 35px, rgba(255,255,255,.1) 70px);"></div>
</div>

<!-- Categories Section -->
<div class="tw-mb-16">
    <h2 class="tw-text-3xl tw-font-bold tw-mb-8 tw-text-gray-800">
        <i class="bi bi-tag tw-text-green-800"></i> Shop by Category
    </h2>
    <div class="row g-4">
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/products?categoryId=1" class="text-decoration-none">
                <div class="card h-100 tw-border-0 tw-shadow-lg hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105 tw-rounded-2xl tw-overflow-hidden">
                    <div class="card-body text-center tw-py-8">
                        <div class="tw-w-20 tw-h-20 tw-rounded-full tw-mx-auto tw-flex tw-items-center tw-justify-center tw-mb-4 tw-shadow-lg" style="background: linear-gradient(135deg, #82AEB1 0%, #93C6D6 100%);">
                            <i class="bi bi-send tw-text-4xl tw-text-white"></i>
                        </div>
                        <h5 class="card-title tw-text-xl tw-font-bold tw-mb-2 tw-text-gray-800">Aircraft Models</h5>
                        <p class="card-text tw-text-gray-600">Fighter jets, bombers, and more</p>
                    </div>
                </div>
            </a>
        </div>
        
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/products?categoryId=2" class="text-decoration-none">
                <div class="card h-100 tw-border-0 tw-shadow-lg hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105 tw-rounded-2xl tw-overflow-hidden">
                    <div class="card-body text-center tw-py-8">
                        <div class="tw-w-20 tw-h-20 tw-rounded-full tw-mx-auto tw-flex tw-items-center tw-justify-center tw-mb-4 tw-shadow-lg" style="background: linear-gradient(135deg, #82AEB1 0%, #93C6D6 100%);">
                            <i class="bi bi-truck tw-text-4xl tw-text-white"></i>
                        </div>
                        <h5 class="card-title tw-text-xl tw-font-bold tw-mb-2 tw-text-gray-800">Military Vehicles</h5>
                        <p class="card-text tw-text-gray-600">Tanks, APCs, and artillery</p>
                    </div>
                </div>
            </a>
        </div>
        
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/products?categoryId=3" class="text-decoration-none">
                <div class="card h-100 tw-border-0 tw-shadow-lg hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105 tw-rounded-2xl tw-overflow-hidden">
                    <div class="card-body text-center tw-py-8">
                        <div class="tw-w-20 tw-h-20 tw-rounded-full tw-mx-auto tw-flex tw-items-center tw-justify-center tw-mb-4 tw-shadow-lg" style="background: linear-gradient(135deg, #82AEB1 0%, #93C6D6 100%);">
                            <i class="bi bi-water tw-text-4xl tw-text-white"></i>
                        </div>
                        <h5 class="card-title tw-text-xl tw-font-bold tw-mb-2 tw-text-gray-800">Ships & Boats</h5>
                        <p class="card-text tw-text-gray-600">Warships, submarines, and yachts</p>
                    </div>
                </div>
            </a>
        </div>
        
        <div class="col-md-3">
            <a href="${pageContext.request.contextPath}/products?categoryId=4" class="text-decoration-none">
                <div class="card h-100 tw-border-0 tw-shadow-lg hover:tw-shadow-2xl tw-transition-all hover:tw-scale-105 tw-rounded-2xl tw-overflow-hidden">
                    <div class="card-body text-center tw-py-8">
                        <div class="tw-w-20 tw-h-20 tw-rounded-full tw-mx-auto tw-flex tw-items-center tw-justify-center tw-mb-4 tw-shadow-lg" style="background: linear-gradient(135deg, #82AEB1 0%, #93C6D6 100%);">
                            <i class="bi bi-speedometer2 tw-text-4xl tw-text-white"></i>
                        </div>
                        <h5 class="card-title tw-text-xl tw-font-bold tw-mb-2 tw-text-gray-800">Cars & Motorcycles</h5>
                        <p class="card-text tw-text-gray-600">Classic and modern vehicles</p>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<!-- Featured Brands -->
<div class="tw-mb-16">
    <h2 class="tw-text-3xl tw-font-bold tw-mb-8 tw-text-gray-800">
        <i class="bi bi-star tw-text-yellow-500"></i> Featured Brands
    </h2>
    <div class="row text-center">
        <div class="col-md-2 col-4 mb-4">
            <a href="${pageContext.request.contextPath}/products?brand=Tamiya" class="text-decoration-none">
                <div class="tw-p-6 tw-bg-white tw-rounded-xl tw-shadow-md hover:tw-shadow-xl tw-transition-all hover:tw-scale-105 tw-border-2 tw-border-transparent hover:tw-border-purple-400">
                    <h5 class="mb-0 tw-text-gray-800 tw-font-bold tw-text-lg">Tamiya</h5>
                </div>
            </a>
        </div>
        <div class="col-md-2 col-4 mb-4">
            <a href="${pageContext.request.contextPath}/products?brand=Revell" class="text-decoration-none">
                <div class="tw-p-6 tw-bg-white tw-rounded-xl tw-shadow-md hover:tw-shadow-xl tw-transition-all hover:tw-scale-105 tw-border-2 tw-border-transparent hover:tw-border-purple-400">
                    <h5 class="mb-0 tw-text-gray-800 tw-font-bold tw-text-lg">Bandai</h5>
                </div>
            </a>
        </div>
        <div class="col-md-2 col-4 mb-4">
            <a href="${pageContext.request.contextPath}/products?brand=Hasegawa" class="text-decoration-none">
                <div class="tw-p-6 tw-bg-white tw-rounded-xl tw-shadow-md hover:tw-shadow-xl tw-transition-all hover:tw-scale-105 tw-border-2 tw-border-transparent hover:tw-border-purple-400">
                    <h5 class="mb-0 tw-text-gray-800 tw-font-bold tw-text-lg">Kotobukiya</h5>
                </div>
            </a>
        </div>
        <div class="col-md-2 col-4 mb-4">
            <a href="${pageContext.request.contextPath}/products?brand=Italeri" class="text-decoration-none">
                <div class="tw-p-6 tw-bg-white tw-rounded-xl tw-shadow-md hover:tw-shadow-xl tw-transition-all hover:tw-scale-105 tw-border-2 tw-border-transparent hover:tw-border-purple-400">
                    <h5 class="mb-0 tw-text-gray-800 tw-font-bold tw-text-lg">Takara-Tomy</h5>
                </div>
            </a>
        </div>
        <div class="col-md-2 col-4 mb-4">
            <a href="${pageContext.request.contextPath}/products?brand=Airfix" class="text-decoration-none">
                <div class="tw-p-6 tw-bg-white tw-rounded-xl tw-shadow-md hover:tw-shadow-xl tw-transition-all hover:tw-scale-105 tw-border-2 tw-border-transparent hover:tw-border-purple-400">
                    <h5 class="mb-0 tw-text-gray-800 tw-font-bold tw-text-lg">I don't know</h5>
                </div>
            </a>
        </div>
        <div class="col-md-2 col-4 mb-4">
            <a href="${pageContext.request.contextPath}/products?brand=Academy" class="text-decoration-none">
                <div class="tw-p-6 tw-bg-white tw-rounded-xl tw-shadow-md hover:tw-shadow-xl tw-transition-all hover:tw-scale-105 tw-border-2 tw-border-transparent hover:tw-border-purple-400">
                    <h5 class="mb-0 tw-text-gray-800 tw-font-bold tw-text-lg">Somethingbrand</h5>
                </div>
            </a>
        </div>
    </div>
</div>

<!-- Why Choose Us -->
<div class="tw-mb-16">
    <h2 class="tw-text-3xl tw-font-bold tw-mb-8 tw-text-gray-800">
        <i class="bi bi-check-circle tw-text-green-600"></i> Why Choose us, The ModelKitShop?
    </h2>
    <div class="row g-4">
        <div class="col-md-4">
            <div class="tw-flex tw-p-6 tw-bg-white tw-rounded-2xl tw-shadow-lg hover:tw-shadow-xl tw-transition-all">
                <div class="flex-shrink-0">
                    <div class="tw-w-16 tw-h-16 tw-rounded-full tw-bg-gradient-to-br tw-from-purple-400 tw-to-purple-600 tw-flex tw-items-center tw-justify-center tw-shadow-lg">
                        <i class="bi bi-box-seam tw-text-3xl tw-text-white"></i>
                    </div>
                </div>
                <div class="flex-grow-1 ms-4">
                    <h5 class="tw-text-xl tw-font-bold tw-mb-2 tw-text-gray-800">Authentic Products</h5>
                    <p class="tw-text-gray-600">We only sell genuine model kits from official manufacturers, you can count on us when speaking about quality</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="tw-flex tw-p-6 tw-bg-white tw-rounded-2xl tw-shadow-lg hover:tw-shadow-xl tw-transition-all">
                <div class="flex-shrink-0">
                    <div class="tw-w-16 tw-h-16 tw-rounded-full tw-bg-gradient-to-br tw-from-green-400 tw-to-green-600 tw-flex tw-items-center tw-justify-center tw-shadow-lg">
                        <i class="bi bi-truck tw-text-3xl tw-text-white"></i>
                    </div>
                </div>
                <div class="flex-grow-1 ms-4">
                    <h5 class="tw-text-xl tw-font-bold tw-mb-2 tw-text-gray-800">Fast Delivery</h5>
                    <p class="tw-text-gray-600">Quick and reliable shipping to your doorstep, we even have high-speed shipping(MAY CAUSE TRAFFIC VIOLATION), give us a call when you need to use the service</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="tw-flex tw-p-6 tw-bg-white tw-rounded-2xl tw-shadow-lg hover:tw-shadow-xl tw-transition-all">
                <div class="flex-shrink-0">
                    <div class="tw-w-16 tw-h-16 tw-rounded-full tw-bg-gradient-to-br tw-from-cyan-400 tw-to-cyan-600 tw-flex tw-items-center tw-justify-center tw-shadow-lg">
                        <i class="bi bi-headset tw-text-3xl tw-text-white"></i>
                    </div>
                </div>
                <div class="flex-grow-1 ms-4">
                    <h5 class="tw-text-xl tw-font-bold tw-mb-2 tw-text-gray-800">Expert Support</h5>
                    <p class="tw-text-gray-600">Our team is here to help with any questions, even if its about your Ex, we even provide stalking services</p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
