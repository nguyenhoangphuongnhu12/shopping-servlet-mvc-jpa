<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Tự động chuyển hướng về trang Login (hoặc trang danh sách Category: /categories)
    response.sendRedirect(request.getContextPath() + "/login");
%>