<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        :root {
            --primary-blue: #0077b6;
            --secondary-blue: #0096c7;
            --light-blue-bg: #f0f7ff;
            --border-blue: #d0e6f7;
        }
        body {
            background-color: var(--light-blue-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #1e293b;
        }
        .navbar-custom {
            background: linear-gradient(90deg, var(--primary-blue), var(--secondary-blue));
            border-bottom: 2px solid #023e8a;
        }
        .navbar-custom .navbar-brand {
            letter-spacing: 0.3px;
            font-size: 1.25rem;
        }
        .btn-blue-primary {
            background-color: var(--primary-blue);
            border-color: var(--primary-blue);
            color: #ffffff;
        }
        .btn-blue-primary:hover {
            background-color: #023e8a;
            border-color: #023e8a;
            color: #ffffff;
        }
        .card {
            border: 1px solid var(--border-blue);
            border-radius: 12px;
        }
        .footer-custom {
            background-color: #ffffff;
            border-top: 1px solid var(--border-blue);
            color: #64748b;
        }
    </style>
    <sitemesh:write property="head" />
</head>
<body class="d-flex flex-column min-vh-100">
    <!-- Navbar xanh trắng dùng chung -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm py-2">
        <div class="container">
            <a class="navbar-brand fw-bold d-flex align-items-center" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-cart-shopping me-2"></i>
                <span>ShoppingService</span>
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="mainNavbar">
                <div class="ms-auto d-flex flex-wrap align-items-center gap-2 mt-2 mt-lg-0">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm px-3">
                        <i class="fa-solid fa-house me-1"></i> Trang chủ
                    </a>

                    <c:if test="${not empty sessionScope.account}">
                        <a href="${pageContext.request.contextPath}/video" class="btn btn-light btn-sm text-primary fw-semibold px-3 shadow-sm">
                            <i class="fa-solid fa-film me-1"></i> Video của tôi
                        </a>
                        <span class="text-white small mx-2">
                            Xin chào, <strong>${not empty sessionScope.account.fullName ? sessionScope.account.fullName : sessionScope.account.username}</strong>
                        </span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm px-3">
                            <i class="fa-solid fa-right-from-bracket me-1"></i> Đăng xuất
                        </a>
                    </c:if>

                    <c:if test="${empty sessionScope.account}">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-light btn-sm text-primary fw-semibold px-3 shadow-sm">
                            <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng nhập
                        </a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-light btn-sm px-3">
                            <i class="fa-solid fa-user-plus me-1"></i> Đăng ký
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </nav>

    <!-- Thân trang động tự động nhận nội dung từ các trang con -->
    <main class="container my-4 flex-grow-1">
        <sitemesh:write property="body" />
    </main>

    <!-- Footer trắng xanh dùng chung -->
    <footer class="footer-custom text-center py-3 mt-auto shadow-sm">
        <div class="container">
            <small>&copy; 2026 <strong class="text-primary">ShoppingServiceMVC</strong> - Hệ thống quản lý dịch vụ &amp; video.</small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>