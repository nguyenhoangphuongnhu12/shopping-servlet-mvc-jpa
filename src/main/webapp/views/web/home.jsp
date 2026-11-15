<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Shopping</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

    <!-- Nhúng Header -->
    <jsp:include page="/common/header.jsp" />

    <!-- Thân trang -->
    <div class="container my-5">
        <div class="card p-4 shadow-sm border-0">
            <h2 class="text-primary">🛒 Chào mừng đến với Cửa hàng Shopping MVC!</h2>
            <p class="lead">Bạn có thể mua sắm thỏa thích ở đây.</p>
        </div>
    </div>

    <!-- Nhúng Footer -->
    <jsp:include page="/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>