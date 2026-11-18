<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video Của Tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7fb; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .navbar-custom { background: linear-gradient(90deg, #0077b6, #0096c7); }
        .section-title { color: #023e8a; font-weight: 700; border-left: 4px solid #0096c7; padding-left: 12px; }
        .my-video-card { border: 1px solid #e0ecf8; border-radius: 10px; background: #fff; overflow: hidden; transition: 0.25s; height: 100%; }
        .my-video-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0, 119, 182, 0.15); }
        .thumb-box { position: relative; width: 100%; padding-top: 56.25%; background: #0f172a; display: block; }
        .thumb-box img { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; }
        .status-badge { position: absolute; top: 10px; left: 10px; font-size: 0.75rem; padding: 4px 10px; border-radius: 20px; font-weight: 600; }
        .video-title { color: #023e8a; text-decoration: none; font-weight: 600; font-size: 1rem; display: -webkit-box; -webkit-line-clamp: 2; line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
        .video-title:hover { color: #0096c7; }
        .pagination .page-item.active .page-link { background-color: #0077b6; border-color: #0077b6; color: #fff; }
        .pagination .page-link { color: #0077b6; }
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

    <div class="container pb-5">
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-2">
            <h4 class="section-title m-0">Video Của Tôi</h4>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm px-3">&larr; Về trang chủ</a>
                <a href="${pageContext.request.contextPath}/video/add" class="btn btn-primary btn-sm px-3 shadow-sm">+ Thêm Video Mới</a>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty videos}">
                <div class="text-center py-5 bg-white rounded-3 border shadow-sm">
                    <h5 class="text-secondary mb-2">Bạn chưa có video nào</h5>
                    <p class="text-muted small mb-3">Hãy tải lên video đầu tiên để chia sẻ với mọi người.</p>
                    <a href="${pageContext.request.contextPath}/video/add" class="btn btn-primary px-4">+ Thêm Video Ngay</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach items="${videos}" var="v">
                        <div class="col-12 col-md-6 col-lg-4">
                            <div class="my-video-card d-flex flex-column shadow-sm">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="thumb-box">
                                    <img src="${pageContext.request.contextPath}/image?fname=${v.poster}" 
                                         onerror="this.src='https://placehold.co/640x360/0077b6/ffffff?text=Video'" 
                                         alt="${v.title}">
                                    <c:choose>
                                        <c:when test="${v.active}">
                                            <span class="status-badge bg-success text-white shadow-sm">Hiển thị</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge bg-secondary text-white shadow-sm">Đang ẩn</span>
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                                <div class="p-3 d-flex flex-column flex-grow-1">
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-title mb-2" title="${v.title}">
                                        ${v.title}
                                    </a>
                                    <p class="text-muted small mb-3">Lượt xem: <strong>${v.views}</strong></p>

                                    <div class="mt-auto pt-2 border-top d-flex justify-content-between gap-2">
                                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" 
                                           class="btn btn-outline-primary btn-sm flex-fill">Xem</a>
                                        <a href="${pageContext.request.contextPath}/video/edit?id=${v.videoId}" 
                                           class="btn btn-outline-warning btn-sm flex-fill">Sửa</a>
                                        <a href="${pageContext.request.contextPath}/video/delete?id=${v.videoId}" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa video này không?')" 
                                           class="btn btn-outline-danger btn-sm flex-fill">Xóa</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <c:if test="${totalPages > 1}">
            <nav class="mt-4 pt-2">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/video?page=${currentPage - 1}">Trước</a>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/video?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/video?page=${currentPage + 1}">Sau</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
</body>
</html>