<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><decorator:title default="Admin Control Panel" /></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <decorator:head />
</head>
<body>
    <div class="d-flex">
        <!-- Sidebar Admin -->
        <div class="bg-dark text-white p-3 vh-100" style="width: 250px;">
            <h4 class="text-warning mb-4">ADMIN PANEL</h4>
            <ul class="nav nav-pills flex-column mb-auto">
                <li class="nav-item"><a href="${pageContext.request.contextPath}/admin/category/list" class="nav-link text-white active">📁 Quản lý Danh mục</a></li>
            </ul>
            <hr>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger w-100">Đăng xuất</a>
        </div>

        <div class="flex-grow-1 p-4 bg-light">
            <decorator:body />
        </div>
    </div>
</body>
</html>