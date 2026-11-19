<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác Thực Mã OTP</title>
    <style>
        .auth-box { max-width: 480px; margin: 40px auto; padding: 30px; border: 1px solid #e0e0e0; background: #fff; border-radius: 6px; }
        .auth-title { font-size: 24px; color: #666; text-align: center; margin-bottom: 12px; font-weight: 300; }
        .auth-subtitle { font-size: 13px; color: #777; text-align: center; margin-bottom: 25px; }
        .input-group-text { background-color: #fff; border-right: none; color: #999; width: 45px; justify-content: center; }
        .form-control { border-left: none; background-color: #f2f7fb; font-size: 14px; letter-spacing: 3px; font-weight: 600; }
        .form-control:focus { background-color: #e8f0fe; box-shadow: none; border-color: #ced4da; }
        .btn-custom { background-color: #0088cc; color: white; border: none; font-size: 15px; padding: 8px; border-radius: 2px; }
        .btn-custom:hover { background-color: #006699; color: white; }
        .link-text { color: #0088cc; text-decoration: none; }
        .link-text:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="auth-box shadow-sm">
    <h3 class="auth-title">Xác Thực Tài Khoản</h3>
    <p class="auth-subtitle">
        Mã xác thực OTP gồm 6 chữ số đã được gửi tới email:<br>
        <strong class="text-dark">${sessionScope.pendingEmail}</strong>
    </p>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2" style="font-size: 13px;">${alert}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/verify-otp" method="post" class="needs-validation" novalidate>
        <div class="input-group has-validation mb-4">
            <span class="input-group-text"><i class="fa-solid fa-shield-halved"></i></span>
            <input type="text" name="otp" maxlength="6" pattern="^[0-9]{6}$" class="form-control py-2 text-center" placeholder="Nhập mã OTP" required>
            <div class="invalid-feedback text-center" style="letter-spacing: normal; font-weight: normal;">Vui lòng nhập đúng mã OTP gồm 6 chữ số!</div>
        </div>

        <button type="submit" class="btn btn-custom w-100 mb-4">Xác nhận kích hoạt</button>

        <div class="text-center text-secondary" style="font-size: 13px;">
            Quay lại trang <a href="${pageContext.request.contextPath}/login" class="link-text">Đăng nhập</a>
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