<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang Chủ - Video Portal</title>
    <style>
        .section-title { color: #023e8a; font-weight: 700; border-left: 4px solid #0096c7; padding-left: 12px; }
        .video-card { border: 1px solid #e0ecf8; border-radius: 10px; background: #fff; overflow: hidden; transition: 0.25s; height: 100%; }
        .video-card:hover { transform: translateY(-4px); box-shadow: 0 8px 20px rgba(0, 119, 182, 0.15); }
        .thumb-box { position: relative; width: 100%; padding-top: 56.25%; background: #0f172a; display: block; }
        .thumb-box img { position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover; }
        .video-title { color: #023e8a; text-decoration: none; font-weight: 600; font-size: 1rem; display: -webkit-box; -webkit-line-clamp: 2; line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
        .video-title:hover { color: #0096c7; }
    </style>
</head>
<body>
    <div class="pb-4">
        <div class="mb-4">
            <h4 class="section-title m-0">10 Video Mới Nhất</h4>
        </div>

        <c:choose>
            <c:when test="${empty videos}">
                <div class="text-center py-5 bg-white rounded-3 border shadow-sm">
                    <p class="text-muted mb-0">Chưa có video nào được đăng tải.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach items="${videos}" var="v">
                        <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                            <div class="video-card d-flex flex-column shadow-sm">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="thumb-box">
                                    <img src="${pageContext.request.contextPath}/image?fname=${v.poster}" 
                                         onerror="this.src='https://placehold.co/640x360/0077b6/ffffff?text=Video'" alt="${v.title}">
                                </a>
                                <div class="p-3 d-flex flex-column flex-grow-1">
                                    <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-title mb-2" title="${v.title}">
                                        ${v.title}
                                    </a>
                                    <div class="mt-auto pt-2 border-top d-flex justify-content-between text-muted small">
                                        <span class="text-truncate" style="max-width: 60%;">${v.user.fullName}</span>
                                        <span>${v.views} lượt xem</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>