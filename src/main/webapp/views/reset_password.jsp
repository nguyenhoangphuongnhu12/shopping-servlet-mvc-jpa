<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Lại Mật Khẩu</title>
    <style>
        .auth-box { max-width: 480px; margin: 40px auto; padding: 30px; border: 1px solid #e0e0e0; background: #fff; border-radius: 6px; }
        .auth-title { font-size: 24px; color: #666; text-align: center; margin-bottom: 12px; font-weight: 300; }
        .auth-subtitle { font-size: 13px; color: #777; text-align: center; margin-bottom: 25px; }
        .input-group-text { background-color: #fff; border-right: none; color: #999; width: 45px; justify-content: center; }
        .form-control { border-left: none; background-color: #f2f7fb; font-size: 14px; }
        .form-control:focus { background-color: #e8f0fe; box-shadow: none; border-color: #ced4da; }
        .btn-custom { background-color: #0088cc; color: white; border: none; font-size: 15px; padding: 8px; border-radius: 2px; }
        .btn-custom:hover { background-color: #006699; color: white; }
        .link-text { color: #0088cc; text-decoration: none; }
        .link-text:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="auth-box shadow-sm">
    <h3 class="auth-title">Đặt Lại Mật Khẩu</h3>
    <p class="auth-subtitle">
        Nhập mã OTP đã gửi tới <strong class="text-dark">${sessionScope.resetEmail}</strong> và mật khẩu mới.
    </p>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2" style="font-size: 13px;">${alert}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post" class="needs-validation" novalidate>
        <div class="input-group has-validation mb-3">
            <span class="input-group-text"><i class="fa-solid fa-key"></i></span>
            <input type="text" name="otp" maxlength="6" pattern="^[0-9]{6}$" class="form-control py-2" placeholder="Mã OTP 6 số" required>
            <div class="invalid-feedback">Mã OTP phải gồm đúng 6 chữ số!</div>
        </div>

        <div class="input-group has-validation mb-4">
            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
            <input type="password" name="newPassword" minlength="6" class="form-control py-2" placeholder="Mật khẩu mới (tối thiểu 6 ký tự)" required>
            <div class="invalid-feedback">Mật khẩu mới phải có ít nhất 6 ký tự!</div>
        </div>

        <button type="submit" class="btn btn-custom w-100 mb-4">Cập nhật mật khẩu</button>

        <div class="text-center text-secondary" style="font-size: 13px;">
            Chưa nhận được mã? <a href="${pageContext.request.contextPath}/forgot-password" class="link-text">Gửi lại OTP</a>
        </div>
    </form>
</div>

<script>
(() => {
    'use strict';
    document.querySelectorAll('.needs-validation').forEach(form => {
        form.addEventListener('submit', e => {
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