<%@ page import="java.util.Properties" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.io.*" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-21
  Time: 5:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gioi thieu</title>
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
<div class="conteiner">
    <div id="wallpaper">
        <div class="GioiThieu">
            <div class="container">
                <fmt:setLocale value="${lang}" scope="session" />
                <fmt:bundle basename="messages">
                <img style="width: 30%;" src="../resources/assets/images/THANHVU.png" alt="">
                <div class="page-info">
                    <p style="font-weight: 500;"><fmt:message key="thanhvu"/>
                    </p>
                    <img style="display: block; margin-left: auto; margin-right: auto; width: 30%;"
                         src="../resources/assets/images/NHUTOAN.png"
                         alt="Nguyễn Như Toàn">
                    <p style="font-weight: 500;">
                        <fmt:message key="tranloc"/>
                    </p>
                    <img style="display: block; margin-left: auto; margin-right: 0; width: 33%;"
                         src="../resources/assets/images/trung.png"
                         alt="Nguyễn Quốc Trung">
                    <p><fmt:message key="quoctrung"/>
                    </p>
                    </fmt:bundle>

                </div>
            </div>
        </div>
    </div>
</div>
<div id="fb-root"></div>
<%@include file="/common/footer.jsp"%>
<script async defer crossorigin="anonymous"
        src="https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v6.0"></script>
<script src="../resources/js/user/main.js"></script>
<%@include file="/common/libraries_js.jsp"%>
</body>
</html>
