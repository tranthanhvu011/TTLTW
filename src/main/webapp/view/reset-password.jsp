<%--
  Created by IntelliJ IDEA.
  User: Thanh Vu Tap Code
  Date: 12/17/2023
  Time: 12:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Nhập Mật Khẩu Mới</title>
    <link rel="stylesheet" href="../resources/css/user/main.css">
    <%@include file="/common/libraries.jsp" %>
</head>
<style>
    body {
        background-color: #F5F5FA;
    }

    * {
        font-size: 14px;
        font-family: Inter, Helvetica, Arial, sans-serif;
    }
</style>
<body>
<%
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("/forgot-password");
    }
%>
<div class="container">
    <div class="card card-4" style="width: 550px">
        <input type="hidden" name="userEmail" value="<%= userEmail %>">
        <input type="hidden" name="resetCode" value="<%= session.getAttribute("resetCode") %>" />
        <div class="card-body">
            <h2 class="title" style="background-color: white">Nhập Mật Khẩu Mới</h2>
            <form method="POST" action="/reset-password">
                <div class="row row-space">

                    <c:if test="${not empty requestScope.errorSession}">
                        <div class="error error-message" style="color: red">${requestScope.errorSession}</div>
                    </c:if>

                    <c:if test="${not empty requestScope.errorconfirm}">
                        <div class="error error-message" style="color: red">${requestScope.errorconfirm}</div>
                    </c:if>

                    <c:if test="${not empty requestScope.errorResetPassword}">
                        <div class="error error-message" style="color: red">${requestScope.errorResetPassword}</div>
                    </c:if>
                    <div class="input-group" style="width: 100%">
                        <input placeholder="Nhập Mật Khẩu" class="input--style-4" type="password" id="newPassword" name="newPassword" style="width: 100%" required>
                        <input placeholder="Nhập Lại Mật Khẩu" class="input--style-4" type="password" id="confirmPassword" name="confirmPassword" style="width: 100%" required>
                    </div>
                </div>
                <button class="btn btn--radius-2 btn--blue" type="submit" value="Verify Code" style="width: 100%">Xác Nhận</button>
            </form>
        </div>
    </div>
</div>
<%@include file="/common/footer.jsp" %>
<%@include file="/common/libraries_js.jsp" %>
</body>
</html>
