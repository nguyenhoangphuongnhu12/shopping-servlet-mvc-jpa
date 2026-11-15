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

            <form action="${pageContext.request.contextPath}/admin/category/update" method="post" enctype="multipart/form-data">
                
                <!-- Khớp với CategoryController: cate, categoryid, status, images -->
                <input type="hidden" name="categoryid" value="${cate.categoryid}" />
                <input type="hidden" name="status" value="${empty cate.status ? 1 : cate.status}" />
                <input type="hidden" name="images" value="${cate.images}" />

                <div class="mb-4">
                    <label class="form-label fw-bold text-secondary">Tên danh sách:</label>
                    <input type="text" name="categoryname" value="${cate.categoryname}" class="form-control" required>
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
                    <input type="file" id="imageInput" name="images1" class="form-control w-auto d-inline-block" accept="image/*" onchange="previewImage(event)">
                </div>

                <div class="mt-4">
                    <button type="submit" class="btn btn-primary px-4 me-2">Edit</button>
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
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.src = e.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
</body>
</html>