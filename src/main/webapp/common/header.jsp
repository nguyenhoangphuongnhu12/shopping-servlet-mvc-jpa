<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="d-flex justify-content-between align-items-center px-4 py-2" style="background-color: #0088cc; color: white;">
    <h3 class="m-0 fw-normal">Dashboard</h3>
    <div>
        <span class="me-3">Xin chào <b>${sessionScope.account.fullName}</b></span>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">Đăng xuất</a>
    </div>
</div>