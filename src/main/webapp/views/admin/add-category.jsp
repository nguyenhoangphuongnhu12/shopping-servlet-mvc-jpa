<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục mới</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .btn-custom { background-color: #0088cc; color: white; border: none; }
        .btn-custom:hover { background-color: #006699; color: white; }
        .preview-img-circle {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            background-color: #f8f9fa;
            display: none;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="/common/admin_header.jsp" />

<div class="d-flex">
    <jsp:include page="/common/admin_sidebar.jsp" />

    <div class="flex-grow-1 p-4">
        <div class="bg-white border rounded shadow-sm" style="max-width: 850px;">
            <div class="bg-light p-3 border-bottom text-secondary" style="font-size: 15px;">
                Thêm danh mục mới
            </div>

            <div class="p-4">
                <h2 class="fw-light mb-4" style="color: #444;">Danh mục mới:</h2>

                <c:if test="${not empty alert}">
                    <div class="alert alert-danger py-2">${alert}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/category/insert" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                    <input type="hidden" name="status" value="1" />
                    
                    <div class="mb-4">
                        <label class="form-label fw-bold text-secondary fs-5">Tên danh mục:</label>
                        <input type="text" name="categoryname" minlength="2" maxlength="100" class="form-control py-2" placeholder="Nhập tên danh mục" required style="border-color: #ccc;">
                        <div class="invalid-feedback">Tên danh mục không được để trống (2 - 100 ký tự)!</div>
                    </div>

                    <div class="mb-4">
                        <div class="mb-3">
                            <img id="imagePreview" src="#" alt="Xem trước ảnh" class="preview-img-circle shadow-sm border" />
                        </div>

                        <label class="form-label fw-bold text-secondary fs-5 d-block">Ảnh đại diện:</label>
                        <input type="file" id="imageInput" name="images1" class="form-control d-inline-block w-auto" accept="image/jpeg,image/png,image/webp" required onchange="previewImage(event)">
                        <div class="invalid-feedback">Vui lòng chọn ảnh đại diện định dạng JPG, PNG hoặc WEBP!</div>
                    </div>

                    <div class="mt-4 pt-2">
                        <button type="submit" class="btn btn-custom px-4 me-2">Thêm</button>
                        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary px-4">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function previewImage(event) {
        const input = event.target;
        const preview = document.getElementById('imagePreview');
        
        if (input.files && input.files[0]) {
            const file = input.files[0];
            const validExts = ['.jpg', '.jpeg', '.png', '.webp'];
            const isValid = validExts.some(ext => file.name.toLowerCase().endsWith(ext));
            if (!isValid) {
                input.setCustomValidity('Chỉ chấp nhận ảnh JPG, PNG, WEBP!');
                preview.src = '#';
                preview.style.display = 'none';
                return;
            }
            input.setCustomValidity('');
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            input.setCustomValidity('');
            preview.src = '#';
            preview.style.display = 'none';
        }
    }

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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>