<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div style="width: 220px; background-color: #0088cc; min-height: 100vh; color: white;" class="d-flex flex-column align-items-center pt-3">
    <!-- Avatar Admin -->
    <div class="text-center mb-3">
        <i class="fa-solid fa-user-gear fa-4x mb-2"></i>
        <div style="font-size: 13px;">Bạn là Admin</div>
    </div>

    <!-- Menu items -->
    <div class="w-100 mt-2">
        <!-- 1. Dashboard (Chưa làm - Khóa) -->
        <span class="d-flex align-items-center text-white-50 px-3 py-2 bg-secondary" style="cursor: not-allowed; opacity: 0.6;">
            <i class="fa-solid fa-gauge me-2"></i> Dashboard
        </span>
        
        <!-- 2. Quản lý Danh mục (ĐÃ LÀM) -->
        <div class="bg-black text-white px-3 py-2 mt-1">
            <i class="fa-solid fa-folder me-2"></i> Quản lý Danh mục
        </div>
        
        <!-- Đường dẫn Thêm danh mục mới -->
        <a href="${pageContext.request.contextPath}/admin/category/add" class="d-block ps-4 bg-primary text-white text-decoration-none py-1" style="font-size: 12px;">
            — Thêm danh mục mới
        </a>
        
        <!-- Đường dẫn Xem danh sách danh mục -->
        <a href="${pageContext.request.contextPath}/admin/categories" class="d-block ps-4 bg-primary text-white text-decoration-none py-1" style="font-size: 12px;">
            — Danh sách danh mục
        </a>

        <!-- 3. Quản lý sản phẩm (Chưa làm - Khóa) -->
        <span class="d-flex align-items-center text-white-50 px-3 py-2 mt-1" style="background-color: #005588; cursor: not-allowed; opacity: 0.6;">
            <i class="fa-solid fa-desktop me-2"></i> Quản lý sản phẩm
        </span>

        <!-- 4. Quản lý tài khoản (Chưa làm - Khóa) -->
        <span class="d-flex align-items-center text-white-50 px-3 py-2 mt-1" style="background-color: #005588; cursor: not-allowed; opacity: 0.6;">
            <i class="fa-solid fa-qrcode me-2"></i> Quản lý tài khoản
        </span>
    </div>
</div>