<%--
  Created by IntelliJ IDEA.
  User: Thanh Vu Tap Code
  Date: 12/17/2023
  Time: 11:59 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Nhập Code Xác Nhận</title>
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
<%
    String userEmail = (String) session.getAttribute("userEmail");

%>
<div class="container">
    <div class="card card-4" style="width: 550px">
        <div class="card-body">
            <h2 class="title" style="background-color: white">Nhập Mã Xác Nhận Đã Gửi Về Gmail</h2>
            <form method="POST" action="/verify-reset-code">
                <div class="row row-space">
                    <div class="input-group" style="width: 100%">
                            <%
                                String errorMessage = (String) session.getAttribute("errorEnterCode");
                                if (errorMessage != null && !errorMessage.isEmpty()) {
                                    out.println("<p style='color: red;'>" + errorMessage + "</p>");
                                }
                            %>
                        <input class="input--style-4" placeholder="Nhập Mã Xác Nhận Vào Đây" type="text" id="resetCode" name="resetCode" required style="width: 100%" required>
                    </div>
                </div>
                <% if (userEmail != null) { %>
                <!-- Ẩn email trong form để có thể truyền nó đi mà không hiển thị cho người dùng -->
                <input type="hidden" name="userEmail" value="<%= userEmail %>">
                <% } %>
                <button class="btn btn--radius-2 btn--blue" type="submit" value="Verify Code" style="width: 100%">Xác Nhận</button>
            </form>
        </div>
    </div>
</div>
<%@include file="/common/footer.jsp" %>
<%@include file="/common/libraries_js.jsp" %>
</body>
</html>
