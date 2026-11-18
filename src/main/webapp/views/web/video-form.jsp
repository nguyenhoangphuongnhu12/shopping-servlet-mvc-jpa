<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${video != null ? 'Cập Nhật Video' : 'Thêm Video Mới'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7fb; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar-custom { background: linear-gradient(90deg, #0077b6, #0096c7); }
        .form-card { border: 1px solid #e0ecf8; border-radius: 12px; overflow: hidden; background: #fff; }
        .form-card-header { background: linear-gradient(90deg, #0077b6, #0096c7); color: #fff; padding: 16px 24px; }
        .poster-preview-box { width: 100%; max-height: 240px; border: 2px dashed #90e0ef; border-radius: 8px; background: #f8fafc; display: flex; align-items: center; justify-content: center; overflow: hidden; }
        .poster-preview-box img { max-height: 236px; width: 100%; object-fit: cover; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">SHOPPING VIDEO</a>
            <div class="ms-auto d-flex align-items-center gap-3">
                <c:if test="${not empty sessionScope.account}">
                    <span class="text-white small">
                        Xin chào, <strong>${not empty sessionScope.account.fullName ? sessionScope.account.fullName : sessionScope.account.username}</strong>
                    </span>
                </c:if>
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm">Trang chủ</a>
                    <a href="${pageContext.request.contextPath}/video" class="btn btn-light btn-sm text-primary fw-semibold">Video của tôi</a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">Đăng xuất</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-warning btn-sm">Đăng nhập</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <div class="container pb-5" style="max-width: 720px;">
        <c:if test="${not empty error}">
            <div class="alert alert-danger shadow-sm">${error}</div>
        </c:if>

        <div class="form-card shadow-sm">
            <div class="form-card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold">${video != null ? 'Cập Nhật Thông Tin Video' : 'Đăng Tải Video Mới'}</h5>
                <a href="${pageContext.request.contextPath}/video" class="btn btn-light btn-sm text-primary fw-semibold">Quay lại</a>
            </div>

            <div class="card-body p-4">
                <form method="post" action="${pageContext.request.contextPath}/video/add" enctype="multipart/form-data">
                    <input type="hidden" name="videoId" value="${video.videoId}" />

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tiêu đề Video <span class="text-danger">*</span></label>
                        <input type="text" name="title" class="form-control" placeholder="Nhập tiêu đề video..." value="${video.title}" required />
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Ảnh bìa (Poster)</label>
                            <input type="file" name="posterFile" id="posterInput" class="form-control" accept="image/*" onchange="previewPoster(event)" />
                            <div class="form-text">Định dạng: JPG, PNG, WEBP.</div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">File Video (.mp4) <c:if test="${video == null}"><span class="text-danger">*</span></c:if></label>
                            <input type="file" name="videoFile" class="form-control" accept="video/mp4" ${video == null ? 'required' : ''} />
                            <c:if test="${not empty video.videoUrl}">
                                <div class="form-text text-success text-truncate">File hiện tại: ${video.videoUrl}</div>
                            </c:if>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small text-muted">Xem trước ảnh bìa</label>
                        <div class="poster-preview-box">
                            <c:choose>
                                <c:when test="${not empty video.poster}">
                                    <img id="posterPreview" src="${pageContext.request.contextPath}/image?fname=${video.poster}" alt="Poster Preview" />
                                </c:when>
                                <c:otherwise>
                                    <img id="posterPreview" src="https://placehold.co/640x360/e0f2fe/0077b6?text=Chua+chon+anh+bia" alt="Poster Preview" />
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mô tả nội dung</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Nhập mô tả chi tiết cho video...">${video.description}</textarea>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold">Chế độ hiển thị</label>
                        <select name="active" class="form-select">
                            <option value="true" ${video == null || video.active ? 'selected' : ''}>Công khai (Hiển thị trên trang chủ)</option>
                            <option value="false" ${video != null && !video.active ? 'selected' : ''}>Riêng tư (Ẩn khỏi trang chủ)</option>
                        </select>
                    </div>

                    <div class="d-flex justify-content-end gap-2 pt-3 border-top">
                        <a href="${pageContext.request.contextPath}/video" class="btn btn-outline-secondary px-4">Hủy bỏ</a>
                        <button type="submit" class="btn btn-primary px-4 fw-semibold">Lưu Video</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function previewPoster(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('posterPreview').src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>