<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><decorator:title default="Shopping Web" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <decorator:head />
</head>
<body class="bg-light d-flex flex-column min-vh-100">
    <!-- Navbar chung -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/home">🛒 ShoppingService</a>
            <div class="d-flex align-items-center gap-2">
                <c:if test="${not empty sessionScope.account}">
                    <a href="${pageContext.request.contextPath}/video" class="btn btn-warning btn-sm fw-semibold">
                        <i class="fa-solid fa-film me-1"></i> Video của tôi
                    </a>
                    <span class="text-white mx-2">Xin chào, <b>${sessionScope.account.fullName}</b></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">Đăng xuất</a>
                </c:if>
                <c:if test="${empty sessionScope.account}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-warning btn-sm">Đăng ký</a>
                </c:if>
            </div>
        </div>
    </nav>

    <!-- Thân trang động -->
    <div class="container my-4 flex-grow-1">
        <decorator:body />
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <small>© 2026 ShoppingServiceMVC - All rights reserved.</small>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>