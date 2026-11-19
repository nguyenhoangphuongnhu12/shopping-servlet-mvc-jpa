<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo tài khoản mới</title>
    <style>
        .register-box { max-width: 480px; margin: 30px auto; padding: 25px; border: 1px solid #e0e0e0; background: #fff; border-radius: 6px; }
        .register-title { font-size: 22px; color: #555; margin-bottom: 20px; font-weight: 300; text-align: center; }
        .input-group-text { background-color: #fff; border-right: none; color: #888; width: 45px; justify-content: center; }
        .form-control { border-left: none; font-size: 14px; }
        .bg-blue-input { background-color: #f2f7fb; }
        .btn-custom { background-color: #0088cc; color: white; border: none; font-size: 15px; padding: 8px; border-radius: 2px; }
        .btn-custom:hover { background-color: #006699; color: white; }
        .link-text { color: #0088cc; text-decoration: none; }
    </style>
</head>
<body>

<div class="register-box shadow-sm">
    <h3 class="register-title">Tạo tài khoản mới</h3>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2" style="font-size: 13px;">${alert}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate>
        <div class="input-group has-validation mb-3">
            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
            <input type="text" name="username" value="${username}" pattern="^[a-zA-Z0-9_]{4,20}$" class="form-control bg-blue-input py-2" placeholder="Tên đăng nhập (4-20 ký tự)" required>
            <div class="invalid-feedback">Tên đăng nhập từ 4-20 ký tự (chỉ gồm chữ, số và dấu gạch dưới)!</div>
        </div>

        <div class="input-group has-validation mb-3">
            <span class="input-group-text"><i class="fa-solid fa-id-card"></i></span>
            <input type="text" name="fullname" value="${fullname}" class="form-control py-2" placeholder="Họ tên" required>
            <div class="invalid-feedback">Vui lòng nhập họ và tên!</div>
        </div>

        <div class="input-group has-validation mb-3">
            <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
            <input type="email" name="email" value="${email}" class="form-control py-2" placeholder="Nhập Email" required>
            <div class="invalid-feedback">Vui lòng nhập địa chỉ Email hợp lệ!</div>
        </div>

        <div class="input-group has-validation mb-3">
            <span class="input-group-text"><i class="fa-solid fa-phone"></i></span>
            <input type="tel" name="phone" value="${phone}" pattern="^(0|\+84)[0-9]{9}$" class="form-control bg-blue-input py-2" placeholder="Số điện thoại (10 số)" required>
            <div class="invalid-feedback">Số điện thoại phải gồm 10 chữ số (bắt đầu bằng 0 hoặc +84)!</div>
        </div>

        <div class="input-group has-validation mb-3">
            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
            <input type="password" id="password" name="password" minlength="6" class="form-control py-2" placeholder="Mật khẩu (tối thiểu 6 ký tự)" required>
            <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự!</div>
        </div>

        <div class="input-group has-validation mb-4">
            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
            <input type="password" id="repassword" name="repassword" minlength="6" class="form-control py-2" placeholder="Nhập lại mật khẩu" required>
            <div class="invalid-feedback">Mật khẩu nhập lại không khớp!</div>
        </div>

        <button type="submit" class="btn btn-custom w-100 mb-4">Tạo tài khoản</button>

        <div class="text-center text-secondary" style="font-size: 13px;">
            Nếu bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="link-text">Đăng nhập</a>
        </div>
    </form>
</div>

<script>
(() => {
    'use strict';
    const pw = document.getElementById('password');
    const repw = document.getElementById('repassword');
    const checkMatch = () => {
        if (repw.value !== pw.value) {
            repw.setCustomValidity('Mật khẩu nhập lại không khớp!');
        } else {
            repw.setCustomValidity('');
        }
    };
    pw.addEventListener('input', checkMatch);
    repw.addEventListener('input', checkMatch);

    document.querySelectorAll('.needs-validation').forEach(form => {
        form.addEventListener('submit', e => {
            checkMatch();
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
})();
</script>
</body>
</html>