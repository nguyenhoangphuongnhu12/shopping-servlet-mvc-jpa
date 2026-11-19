<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .preview-img-circle {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="/common/admin_header.jsp" />

<div class="d-flex">
    <jsp:include page="/common/admin_sidebar.jsp" />

    <div class="flex-grow-1 p-4">
        <div class="bg-white border rounded shadow-sm p-4" style="max-width: 850px;">
            <h3 class="fw-light mb-4">Danh mục:</h3>

            <c:if test="${not empty alert}">
                <div class="alert alert-danger py-2">${alert}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/category/update" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                <input type="hidden" name="categoryid" value="${cate.categoryid}" />
                <input type="hidden" name="status" value="${empty cate.status ? 1 : cate.status}" />
                <input type="hidden" name="images" value="${cate.images}" />

                <div class="mb-4">
                    <label class="form-label fw-bold text-secondary">Tên danh mục:</label>
                    <input type="text" name="categoryname" minlength="2" maxlength="100" value="${cate.categoryname}" class="form-control" required>
                    <div class="invalid-feedback">Tên danh mục không được để trống (2 - 100 ký tự)!</div>
                </div>

                <div class="mb-4">
                    <div class="mb-3">
                        <c:choose>
                            <c:when test="${not empty cate.images && cate.images.startsWith('http')}">
                                <img id="imagePreview" src="${cate.images}" class="preview-img-circle shadow-sm border" />
                            </c:when>
                            <c:when test="${not empty cate.images}">
                                <img id="imagePreview" src="${pageContext.request.contextPath}/image?fname=${cate.images}" class="preview-img-circle shadow-sm border" />
                            </c:when>
                            <c:otherwise>
                                <img id="imagePreview" src="https://via.placeholder.com/120" class="preview-img-circle shadow-sm border" />
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <label class="form-label fw-bold text-secondary d-block">Ảnh đại diện</label>
                    <input type="file" id="imageInput" name="images1" class="form-control w-auto d-inline-block" accept="image/jpeg,image/png,image/webp" onchange="previewImage(event)">
                    <div class="invalid-feedback">Chỉ chấp nhận ảnh định dạng JPG, PNG hoặc WEBP!</div>
                </div>

                <div class="mt-4">
                    <button type="submit" class="btn btn-primary px-4 me-2">Cập nhật</button>
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary px-4">Hủy</a>
                </div>
            </form>
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
                return;
            }
            input.setCustomValidity('');
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        } else {
            input.setCustomValidity('');
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