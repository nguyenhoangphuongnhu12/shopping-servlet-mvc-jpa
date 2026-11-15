<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo tài khoản mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #ffffff; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .register-box { max-width: 480px; margin: 40px auto; padding: 20px; }
        .register-title { font-size: 22px; color: #555; margin-bottom: 20px; font-weight: 300; }
        .input-group-text { background-color: #fff; border-right: none; color: #888; width: 45px; justify-content: center; }
        .form-control { border-left: none; font-size: 14px; }
        .bg-blue-input { background-color: #f2f7fb; }
        .btn-custom { background-color: #0088cc; color: white; border: none; font-size: 15px; padding: 8px; border-radius: 2px; }
        .btn-custom:hover { background-color: #006699; color: white; }
        .link-text { color: #0088cc; text-decoration: none; }
    </style>
</head>
<body>

<div class="register-box">
    <h3 class="register-title">Tạo tài khoản mới</h3>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2" style="font-size: 13px;">${alert}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="input-group mb-3">
            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
            <input type="text" name="username" class="form-control bg-blue-input py-2" placeholder="trungnh" required>
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
            <input type="text" name="fullname" class="form-control py-2" placeholder="Họ tên" required>
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
            <input type="email" name="email" class="form-control py-2" placeholder="Nhập Email" required>
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
            <input type="tel" name="phone" class="form-control bg-blue-input py-2" placeholder="Số điện thoại" required>
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
            <input type="password" name="password" class="form-control py-2" placeholder="Mật khẩu" required>
        </div>

        <div class="input-group mb-4">
            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
            <input type="password" name="repassword" class="form-control py-2" placeholder="Nhập lại mật khẩu" required>
        </div>

        <button type="submit" class="btn btn-custom w-100 mb-4">Tạo tài khoản</button>

        <div class="text-center text-secondary" style="font-size: 13px;">
            Nếu bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="link-text">Đăng nhập</a>
        </div>
    </form>
</div>

</body>
</html>