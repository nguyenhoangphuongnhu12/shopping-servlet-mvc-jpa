<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập Vào Hệ Thống</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #ffffff; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .login-box { max-width: 480px; margin: 60px auto; padding: 30px; border: 1px solid #e0e0e0; background: #fff; }
        .login-title { font-size: 24px; color: #666; text-align: center; margin-bottom: 25px; font-weight: 300; }
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

<div class="login-box">
    <h3 class="login-title">Đăng Nhập Vào Hệ Thống</h3>

    <c:if test="${not empty alert}">
        <div class="alert alert-danger py-2" style="font-size: 13px;">${alert}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="input-group mb-3">
            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
            <input type="text" name="username" class="form-control py-2" placeholder="Tài khoản" required>
        </div>

        <div class="input-group mb-3">
            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
            <input type="password" name="password" class="form-control py-2" placeholder="Mật khẩu" required>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4" style="font-size: 13px;">
            <div class="form-check mb-0">
                <input type="checkbox" name="remember" class="form-check-input" id="remember">
                <label class="form-check-label text-secondary" for="remember">Nhớ tôi</label>
            </div>
            <a href="#" class="link-text">Quên mật khẩu?</a>
        </div>

        <button type="submit" class="btn btn-custom w-100 mb-4">Đăng nhập</button>

        <div class="text-center text-secondary" style="font-size: 13px;">
            Nếu bạn chưa có tài khoản trên hệ thống, thì hãy <a href="${pageContext.request.contextPath}/register" class="link-text">Đăng ký</a>
        </div>
    </form>
</div>

</body>
</html>