<%@ page import="model.Account" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-21
  Time: 1:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thay đổi mật khẩu</title>
    <link rel="stylesheet" href="../resources/css/user/profile.css">
    <link rel="stylesheet" href="../resources/css/user/main.css">
    <link href="../resources/libs/datepicker/daterangepicker.css" rel="stylesheet" media="all">
    <%@include file="/common/libraries.jsp"%>
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
<%@include file="/common/header.jsp"%>
<div class="container" style="margin-bottom: 100px">
    <div class="row gutters">
        <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="margin-top: 50px">
            <div class="h-100">
                <div class="card-body border_10px_bgcl_white" style="border: none;border-radius: 5px">
                    <div class="account-settings">
                        <div class="user-profile" style="display: flex;margin: 0;padding-bottom: 0">
                            <div class="user-avatar">
                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png">
                            </div>
                            <div class="i-user">
                                <div class="user-name" style="height: 100%;margin-top: 10px">
                                    <%= loggedInUser.getFirst_name() + " " +  loggedInUser.getLast_name()  %>
                                </div>
                            </div>
                        </div>
                        <div class="line"></div>
                        <div class="about">
                            <div class="my_account">
                                <i class="fa-regular fa-user"></i>
                                <a href="${pageContext.request.contextPath}/view/profile.jsp">
                                    <div class="name_item_in_profile">Tài khoản của tôi</div>
                                </a>
                            </div>
                            <div class="list_information">
                                <div class="item_lf">
                                    <a href="${pageContext.request.contextPath}/view/profile.jsp" style="color: #ee4d2d">Hồ sơ</a>
                                </div>
                                <div class="item_lf">
                                    <a href="${pageContext.request.contextPath}/view/change_pw.jsp">Đổi mật khẩu</a>
                                </div>
                            </div>
                            <div class="my_account">
                                <img src="https://down-vn.img.susercontent.com/file/f0049e9df4e536bc3e7f140d071e9078">
                                <a href="${pageContext.request.contextPath}/view/order.jsp">
                                    <div class="name_item_in_profile">Đơn mua</div>
                                </a>
                            </div>
                        </div>
                    </div>
                    <form action="<c:url value='/logout'/>" method="GET">
                        <input type="submit" value="Đăng Xuất" />
                    </form>
                </div>
            </div>
        </div>
        <div class="col-xl-9 col-lg-9 col-md-12 col-sm-12 col-12">
            <div class="card-body card" style="padding: 20px 80px 40px 80px;border-radius: 10px">
                <h2 class="title" style="background-color: white;font-size: 20px;margin-bottom: 20px">Đổi Mật Khẩu</h2>
                <form method="post" action="/change_password" id="form_change_pw" >
                    <c:if test="${not empty requestScope.nhapLaiMatKhauSai}">
                        <div class="error error-message text-center" style="color: red">${requestScope.nhapLaiMatKhauSai}</div>
                    </c:if>
                    <c:if test="${not empty requestScope.thanhCongChangePassword}">
                        <div class="error error-message text-center" style="color: red">${requestScope.thanhCongChangePassword}</div>
                    </c:if>
                    <c:if test="${not empty requestScope.thatBaiChangePassword}">
                        <div class="error error-message text-center" style="color: red">${requestScope.thatBaiChangePassword}</div>
                    </c:if>
                    <c:if test="${not empty requestScope.errorSessionLogin}">
                        <div class="error error-message text-center" style="color: red">${requestScope.errorSessionLogin}</div>
                    </c:if>
                    <div class="row row-space">
                        <div class="input-group" style="width: 100%;margin-bottom: 10px">
                            <label class="label black_14_400">Mật khẩu cũ</label>
                            <input id="old_pw" class="input_field" type="password" name="old_password">
                            <span id="er_opw" style="color: red;font-size: 13px"></span>
                        </div>
                    </div>
                    <div class="row row-space">
                        <div class="input-group" style="width: 100%">
                            <label class="label">Mật khẩu mới</label>
                            <input id="new_pw" class="input_field" type="password" name="new_password"
                                   style="width: 100%">
                            <span id="er_npw" style="color: red;font-size: 13px"></span>
                        </div>
                    </div>
                    <div class="row row-space">
                        <div class="input-group" style="width: 100%">
                            <label class="label">Nhập lại mật khẩu mới</label>
                            <input id="re_new_pw" class="input_field" type="password" name="verify_new_password"
                                   style="width: 100%">
                            <span id="er_re_npw" style="color: red;font-size: 13px"></span>
                        </div>
                    </div>
                    <div class="row row-space">
                        <div class="p-t-15" style="width: 100%">
                            <button class="" type="submit"
                                    style="width: 100%;background-color: #3868cd;border-radius: 5px;padding: 10px 0 10px 0">
                                Đổi Mật Khẩu
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="/common/footer.jsp"%>
<script src="../resources/js/user/auth/chang_pw.js"></script>
<%@include file="/common/libraries_js.jsp"%>
</body>
</html>
