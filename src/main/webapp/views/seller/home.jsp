<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kênh Người Bán - Seller Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

    <!-- Nhúng Header dùng chung -->
    <jsp:include page="/common/header.jsp" />

    <!-- Thân trang Seller -->
    <div class="container my-5">
        <div class="card p-4 shadow-sm border-0">
            <h2 class="text-success">🏪 Kênh Quản Lý Cửa Hàng (Seller)</h2>
            <p class="lead">Chào mừng chủ cửa hàng <b>${sessionScope.account.fullName}</b> quay trở lại!</p>
            <hr>
            <div class="row mt-3">
                <div class="col-md-4">
                    <div class="card bg-primary text-white p-3 mb-3">
                        <h5>📦 Sản phẩm của shop</h5>
                        <p class="mb-0">Quản lý kho hàng và niêm yết sản phẩm mới.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card bg-success text-white p-3 mb-3">
                        <h5>📑 Đơn hàng mới</h5>
                        <p class="mb-0">Xem và xử lý các đơn đặt hàng từ khách.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card bg-info text-white p-3 mb-3">
                        <h5>📊 Doanh thu</h5>
                        <p class="mb-0">Theo dõi báo cáo bán hàng theo tháng.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Nhúng Footer dùng chung -->
    <jsp:include page="/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>