<%@ page import="model.Account" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-21
  Time: 5:20 PM
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
    <title>Website bán hàng đơn giản</title>
    <link rel="stylesheet" href="../resources/css/user/trangchu.css">
    <%@include file="/common/libraries.jsp" %>
    <link rel="stylesheet" href="../resources/css/user/app.css" type="text/css">
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
    Account loggedInUser = (Account)session.getAttribute("account");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
    }
%>
<%@include file="/common/header.jsp" %>
<div class="container">
    <main role="main">
        <div class="container mt-2">
            <h1 class="text-center" style="margin-bottom: 20px;margin-top: 10px;font-size: 30px">Liên hệ với chúng tôi
                !</h1>
            <c:if test="${not empty requestScope.thanhCongContacts}">
                <div class="error error-message text-center" style="color: red">${requestScope.thanhCongContacts}</div>
            </c:if>
            <c:if test="${not empty requestScope.thatBaiContacts}">
                <div class="error error-message text-center" style="color: red">${requestScope.thatBaiContacts}</div>
            </c:if>
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                    <img style="border-radius: 10px;"
                         src="../resources/assets/images/rodzaje-typy-aplikacji-mobilnych.jpg">
                </div>
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                    <form action="/contacts" method="POST" role="form">
                        <div class="row">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <input style="border: 1px solid grey" type="text" name="name" id="full_name"
                                       class="form-control" placeholder="Họ và Tên">
                                <br>
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
                                <input style="border: 1px solid grey;" type="email" name="email_address" id="email"
                                       class="form-control" placeholder="Địa chỉ mail">

                                <br>
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
                                <input style="border: 1px solid grey;" type="text" name="phone_number" id="phone"
                                       class="form-control" placeholder="Số điện thoại">
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                <input style="border: 1px solid grey;" type="text" name="title" id="title"
                                       class="form-control" placeholder="Tiêu đề">
                                <br>
                            </div>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <textarea style="border: 1px solid grey;" name="content" id="content" cols="30" rows="7"
                                              class="form-control">
                                    </textarea>
                            </div>
                        </div>
                        <button style="border-radius: 5px; width: 100px; height: 30px;border: 1px solid grey;margin-top: 7px"
                                type="submit" class="">Liên hệ ngay
                        </button>

                    </form>
                </div>
                <br>
                <div class="col col-md-12" style="margin-top: 50px">
                    <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3928.7235485722294!2d105.78061631523369!3d10.039656175103817!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a062a768a8090b%3A0x4756d383949cafbb!2zMTMwIFjDtCBWaeG6v3QgTmdo4buHIFTEqW5oLCBBbiBI4buZaSwgTmluaCBLaeG7gXUsIEPhuqduIFRoxqEsIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1556697525436!5m2!1svi!2s"
                            width="100%" height="450" frameborder="0" style="border:0;" allowfullscreen=""></iframe>
                </div>
            </div>
        </div>
    </main>
</div>
<%@include file="/common/footer.jsp" %>
<%@include file="/common/libraries_js.jsp" %>
<script src="../resources/js/user/main.js"></script>
</body>
</html>
