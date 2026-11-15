<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .cate-img-circle {
            width: 110px;
            height: 110px;
            object-fit: cover;
            border-radius: 50%;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

<!-- Header dùng chung -->
<jsp:include page="/common/admin_header.jsp" />

<div class="d-flex">
    <!-- Sidebar dùng chung -->
    <jsp:include page="/common/admin_sidebar.jsp" />

    <!-- Nội dung chính -->
    <div class="flex-grow-1 p-4 bg-light">
        <div class="bg-white p-4 border rounded shadow-sm">
            <h3 class="text-danger mb-1">Quản lý danh mục</h3>
            <p class="text-secondary small mb-4">Nơi bạn có thể quản lý danh mục của mình</p>

            <div class="border rounded">
                <div class="bg-light p-3 border-bottom text-secondary font-monospace" style="font-size: 14px;">
                    Danh sách danh mục
                </div>
                
                <div class="p-3">
                    <table class="table table-bordered align-middle text-center mb-0">
                        <thead class="table-light text-secondary">
                            <tr>
                                <th width="70">STT</th>
                                <th width="200">Hình ảnh</th>
                                <th class="text-start">Tên danh mục</th>
                                <th width="150">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <%-- Khớp với req.setAttribute("listcate", list) trong CategoryController --%>
                                <c:when test="${not empty listcate}">
                                    <c:forEach items="${listcate}" var="cate" varStatus="STT">
                                        <tr>
                                            <td>${STT.index + 1}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty cate.images && cate.images.startsWith('http')}">
                                                        <img src="${cate.images}" class="cate-img-circle shadow-sm" alt="${cate.categoryname}"/>
                                                    </c:when>
                                                    <c:when test="${not empty cate.images}">
                                                        <img src="${pageContext.request.contextPath}/image?fname=${cate.images}" class="cate-img-circle shadow-sm" alt="${cate.categoryname}"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="https://via.placeholder.com/110" class="cate-img-circle shadow-sm" alt="Default Image"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-start ps-3 fw-normal text-secondary">${cate.categoryname}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.categoryid}" class="text-decoration-none" style="color: #0088cc;">Sửa</a> |
                                                <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.categoryid}" class="text-decoration-none" style="color: #0088cc;" onclick="return confirm('Bạn chắc chắn muốn xóa?')">Xóa</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                
                                <c:otherwise>
                                    <tr>
                                        <td colspan="4" class="text-center py-4 text-muted">
                                            Chưa có dữ liệu danh mục trong Database.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>