<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><decorator:title default="Shopping Web" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <decorator:head />
</head>
<body class="bg-light">
    <!-- Navbar chung -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/home">🛒 ShoppingService</a>
            <div class="d-flex align-items-center">
                <c:if test="${not empty sessionScope.account}">
                    <span class="text-white me-3">Xin chào, <b>${sessionScope.account.fullName}</b></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">Đăng xuất</a>
                </c:if>
                <c:if test="${empty sessionScope.account}">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm me-2">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-warning btn-sm">Đăng ký</a>
                </c:if>
            </div>
        </div>
    </nav>

    <!-- Thân trang động -->
    <div class="container my-4" style="min-height: 80vh;">
        <decorator:body />
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <small>© 2026 ShoppingServiceMVC - All rights reserved.</small>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>