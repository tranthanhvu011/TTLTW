<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-21
  Time: 5:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quên Mật Khẩu</title>
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
<%@include file="/common/header.jsp" %>
<div class="container">
    <div class="card card-4" style="width: 550px">
        <div class="card-body">
            <h2 class="title" style="background-color: white">Quên Mật Khẩu</h2>
            <form method="POST" action="/forgot-password">
                <div class="row row-space">
                    <c:if test="${not empty requestScope.errorEmail}">
                        <div class="error error-message" style="color: red">${requestScope.errorEmail}</div>
                    </c:if>
                    <div class="input-group" style="width: 100%">
                        <input placeholder="Nhập Email Vào Đây" class="input--style-4" type="email" name="email" style="width: 100%" required>
                    </div>
                </div>
                    <button class="btn btn--radius-2 btn--blue" type="submit" value="Send Reset Code" style="width: 100%">Quên Mật Khẩu</button>
            </form>
        </div>
    </div>
</div>
<%@include file="/common/footer.jsp" %>
<%@include file="/common/libraries_js.jsp" %>
</body>
</html>
