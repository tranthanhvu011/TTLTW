<%@ page import="java.util.List" %>
<%@ page import="model.Account" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-20
  Time: 11:59 PM
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
    <title>Thông tin cá nhân</title>
    <link rel="stylesheet" href="../resources/css/user/main.css">
    <link href="../resources/libs/datepicker/css/bootstrap/zebra_datepicker.min.css" rel="stylesheet" media="all">
    <%@include file="/common/libraries.jsp" %>
    <%--    <link rel="stylesheet" href="../resources/css/user/trangchu.css">--%>
    <link rel="stylesheet" href="../resources/css/user/profile.css">
</head>
<style>
    body {
        background-color: #F5F5FA;
    }

    * {
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
                                <a href="${pageContext.request.contextPath}/user/your_order">
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
            <form action="/profile" method="post">
                <div class="card h-100">
                    <div class="card-body border_10px_bgcl_white" style="border-radius: 50px;border: none">
                        <div class="row gutters">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div style="font-size: 30px;margin-bottom: 40px;text-align: center">Thông tin tài khoản
                                </div>
                                <c:if test="${not empty requestScope.thanhCongProfile}">
                                    <div class="error error-message text-center" style="color: red">${requestScope.thanhCongProfile}</div>
                                </c:if>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="firstname">Họ</label>
                                    <input type="text" name="firstName" class="form-control" id="firstname" placeholder="Họ"
                                           value="<%= loggedInUser.getFirst_name() %>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="lastname">Tên</label>
                                    <input type="text" name="lastName" class="form-control" id="lastname" placeholder="Tên"
                                           value="<%= loggedInUser.getLast_name() %>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="phone">Số điện thoại</label>
                                    <input name="phoneNumber" type="text" class="form-control" id="phone" placeholder="Số điện thoại"
                                           value="<%= loggedInUser.getPhone_number() %>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
                                <div class="form-group">
                                    <label for="email">Email</label>
                                    <input type="email" class="form-control" id="email" placeholder="Email" value="<%= loggedInUser.getEmail() %>" readonly>
                                </div>
                            </div>
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="form-group">
                                    <label for="address">Địa chỉ</label>
                                    <input name="address" type="text" class="form-control" id="address" placeholder="Địa chỉ"
                                           value="<%= loggedInUser.getAddress() %>">
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
                                <div class="input-group" style="display: unset">
                                    <label class="label">Ngày sinh</label>
                                    <div class="input-group-icon">
                                        <input class="input--style-4"
                                               style="background: white;border: solid 1px gainsboro;height: 40px; width: 100%"
                                               type="date" name="dob" placeholder="Ngày sinh"
                                               value="<%= loggedInUser.getDob() %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
                                <div class="input-group" style="display: unset">
                                    <label class="label">Giới tính</label>
                                    <div style="text-align: start; padding-top: 5px">
                                        <label class="radio-container m-r-45">
                                            Nam
                                            <input type="radio" name="gender" value="1" <%= (loggedInUser.getGender() == 1) ? "checked" : "" %>>
                                            <span class="checkmark"></span>
                                        </label>
                                        <label class="radio-container">
                                            Nữ
                                            <input type="radio" name="gender" value="0" <%= (loggedInUser.getGender() == 0) ? "checked" : "" %>>
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row gutters" style="margin-top: 50px">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                                <div class="text-right">
                                    <button type="submit" value="cancel" id="cancel" name="action" class="btn btn-secondary">Hủy
                                    </button>
                                    <button type="submit" value="submit" id="submit" name="action" class="btn btn-primary">Cập nhật
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="/common/footer.jsp" %>
<%@include file="/common/libraries_js.jsp" %>
<script src="../resources/js/user/auth/register.js"></script>
<script src="../resources/libs/datepicker/zebra_datepicker.min.js"></script>
<script src="../resources/libs/datepicker/zebra_datepicker.src.js"></script>
<script src="../resources/js/user/datepicker.js"></script>
</body>
</html>
