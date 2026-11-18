<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${video.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7fb; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar-custom { background: linear-gradient(90deg, #0077b6, #0096c7); }
        .player-box { background: #000; border-radius: 12px; overflow: hidden; box-shadow: 0 8px 24px rgba(0,0,0,0.18); }
        .info-card { background: #fff; border: 1px solid #e0ecf8; border-radius: 12px; }
        .avatar-circle { width: 44px; height: 44px; border-radius: 50%; background: #0077b6; color: #fff; font-weight: 700; display: flex; align-items: center; justify-content: center; }
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
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-light btn-sm text-primary fw-semibold">&larr; Về trang chủ</a>
                    <a href="${pageContext.request.contextPath}/video" class="btn btn-outline-light btn-sm">Video của tôi</a>
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

    <div class="container pb-5" style="max-width: 960px;">
        <div class="player-box mb-3">
            <div class="ratio ratio-16x9">
                <video controls autoplay playsinline poster="${pageContext.request.contextPath}/image?fname=${video.poster}">
                    <source src="${pageContext.request.contextPath}/image?fname=${video.videoUrl}" type="video/mp4">
                    Trình duyệt không hỗ trợ phát video.
                </video>
            </div>
        </div>

        <div class="info-card p-4 shadow-sm">
            <h4 class="fw-bold text-dark mb-3">${video.title}</h4>
            <div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
                <div class="d-flex align-items-center gap-3">
                    <div class="avatar-circle">
                        ${not empty video.user.fullName ? video.user.fullName.substring(0, 1).toUpperCase() : 'U'}
                    </div>
                    <div>
                        <div class="fw-bold text-primary">${video.user.fullName}</div>
                        <div class="text-muted small">Người đăng tải</div>
                    </div>
                </div>
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 fs-6">
                    ${video.views} lượt xem
                </span>
            </div>
            <h6 class="fw-bold text-secondary">Mô tả video</h6>
            <p class="bg-light p-3 rounded-2 mb-0" style="white-space: pre-line;">${video.description}</p>
        </div>
    </div>
</body>
</html>