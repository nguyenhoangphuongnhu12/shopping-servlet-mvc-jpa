<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Result</title>
</head>
<body>
    <h2>${message}</h2>

    <c:if test="${not empty fileName}">
        <p>Xem thử file vừa upload:</p>
        <video width="640" height="360" controls>
            <source src="${pageContext.request.contextPath}/uploads/${fileName}" type="video/mp4">
        </video>
        <br /><br />
    </c:if>

    <a href="${pageContext.request.contextPath}/uploadFile">Quay lại upload</a>
</body>
</html>