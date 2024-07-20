<%@ page import="java.util.List" %>
<%@ page import="model.Account" %>
<%@ page import="dao.UserDAO" %>
<%@include file="/common/taglib.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-29
  Time: 3:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Quản lý người dùng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--link den css-->
    <%@include file="/common/admin_library_css.jsp" %>
    <link href="${pageContext.request.contextPath}/resources/css/admin/model.css" rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath}/resources/libs/datepicker/css/bootstrap/zebra_datepicker.css"
          rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath}/resources/libs/datepicker/css/bootstrap/zebra_datepicker.min.css"
          rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath}/resources/css/user/toast.css" rel="stylesheet" media="all">
    <%@include file="/common/libraries.jsp" %>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/v/bs4-4.6.0/jq-3.7.0/dt-2.0.8/datatables.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/v/bs4-4.6.0/jq-3.7.0/dt-2.0.8/datatables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</head>
<style>
    body {
        background-color: #F5F5FA;
    }

    * {
        font-size: 14px;
        font-family: Inter, Helvetica, Arial, sans-serif;
    }

    .modal {
        display: block;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0);
    }

    .modal-content {
        background-color: #fff;
        margin: auto;
        padding: 10px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    }
     .search-container {
         display: flex;
         align-items: center;
     }

    /*.search-container input,*/
    /*.search-container button {*/
    /*    margin-right: 10px;*/
    /*}*/
</style>
<%
    List<Account> users = (List<Account>) request.getAttribute("users");
    Account userAlter = (Account) request.getAttribute("user");
    Boolean status = (Boolean) session.getAttribute("status");
    String message = (String) session.getAttribute("message");
    int numberPage = (int) request.getAttribute("numberPage");
    int currentIndex = (int) request.getAttribute("currentIndex");
    UserDAO userDAO = new UserDAO();

%>
<body>
<h1>${pageContext.request.contextPath}</h1>
<%if (userAlter == null) {%>
<div id="preloader">
    <div class="loader"></div>
</div>
<%}%>

<!-- Toast -->
<% if (status != null && status) {%>
<div class="toast">
    <div class="toast-content">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-circle"
             viewBox="0 0 20 20">
            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
            <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05"/>
        </svg>
        <div class="message">
            <span class="text text-1" style="color: greenyellow">Thành công</span>
            <span class="text text-2" style="color: greenyellow"><%=message%></span>
        </div>
    </div>
    <i class="fa-solid fa-xmark close"></i>
    <div class="progress"></div>
</div>
<%} else {%>
<div class="toast">
    <div class="toast-content">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
             class="bi bi-exclamation-circle-fill" viewBox="0 0 20 20">
            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4m.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2"/>
        </svg>
        <div class="message">
            <span class="text text-1 text-danger">Thất bại</span>
            <span class="text text-2 text-danger"><%=message%></span>
        </div>
    </div>
    <i class="fa-solid fa-xmark close"></i>
    <div class="progress"></div>
</div>
<%}%>
<script src="${pageContext.request.contextPath}/resources/js/user/toast.js"></script>
<%if (message != null) {%>
<script>
    showToast();
    setTimeout(() => document.querySelector(".toast").style.display = "none", 5000);
</script>
<%
    session.removeAttribute("message");
    session.removeAttribute("status");
%>
<%}%>
<div class="page-container">
    <%@include file="/common/admin_sidebar.jsp" %>
    <div class="col-md-6 col-sm-8 clearfix">
        <div class="nav-btn pull-left">
            <span></span> <span></span> <span></span>
        </div>
    </div>
    <div class="main-content">
        <div class="page-title-area">
            <div class="row align-items-center">
                <div class="col-sm-6">
                    <div class="breadcrumbs-area clearfix">
                        <h4 class="page-title pull-left">Home</h4>
                        <ul class="breadcrumbs pull-left">
                            <li><a href="${pageContext.request.contextPath}/admin/revenue-statistics">Home</a></li>
                            <li><span>Home</span></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-6 clearfix">
                    <div class="user-profile pull-right">
                        <img class="avatar user-thumb"
                             src="${pageContext.request.contextPath}/resources/assets/images/batman.png"
                             alt="avatar">
                        <h4 class="user-name dropdown-toggle" data-toggle="dropdown">
                            NHÓM 41 <i class="fa fa-angle-down"></i>
                        </h4>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Message</a> <a
                                class="dropdown-item" href="${pageContext.request.contextPath}/login?action=logout">Log
                            Out</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- taskbar -->
        <div class="main-content-inner">
                    <button type="button" class="btn btn-primary" style="background-color: lawngreen"
                            data-toggle="modal" data-target="#modalRegisterUser" onclick="openModalRegister()">
                        Thêm Mới
                    </button>
        </div>

        <!-- Modal to register -->
        <div class="modal" id="modalRegisterUser" style="display: none" role="dialog" data-backdrop="false"
             aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Thêm User</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="formAddUser" method="post" action="/admin/user/manage_user?action=add">
                            <div class="row1 row-space1">
                                <div class="col-6">
                                    <div class="input-group1">
                                        <label class="label1">Họ</label>
                                        <input class="input--style-41" type="text" name="first_name" id="f_name">
                                        <span class="error" id="er-f-name"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group1">
                                        <label class="label1">Tên</label>
                                        <input class="input--style-41" type="text" name="last_name" id="l-name">
                                        <span class="error" id="er-l-name"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-6">
                                    <div class="input-group1">
                                        <label class="label">Ngày sinh</label>
                                        <div class="input-group-icon1" style="width: 100%">
                                            <input class="input--style-41 js-datepicker" type="text" name="dob"
                                                   id="dob" style="width: 100%;">
                                        </div>
                                        <span class="error" id="er-dob" style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group1">
                                        <label class="label1">Giới tính</label>
                                        <div class="input-group-icon1" style="width: 100%;display: flex">
                                            <input id="nam"
                                                   style="width: 50px;margin-right: 20px;border: greenyellow solid 1px;border-radius: 5px"
                                                   class="btn" type="button" value="Nam"
                                                   onclick="setValueToGender(1)">
                                            <input id="nu"
                                                   style="width: 50px;border: greenyellow solid 1px;border-radius: 5px"
                                                   class="btn" type="button" value="Nữ"
                                                   onclick="setValueToGender(0)">
                                            <input id="selectedButton" type="hidden" name="selectedButton">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row1 row-space1">
                                <div class="col-6">
                                    <div class="input-group1">
                                        <label class="label1">Email</label>
                                        <input class="input--style-41" id="email" name="email">
                                        <span class="error" id="er-email" style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group1">
                                        <label class="label1">Số điện thoại</label>
                                        <input class="input--style-41" id="phone" name="phone_number">
                                        <span class="error" id="er-phone" style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row1 row-space1">
                                <div class="col-61">
                                    <div class="input-group1">
                                        <label class="label1">Role</label>
                                        <input class="input--style-41" id="role" name="role" type="number" max="3"
                                               min="0">
                                        <span class="error" id="er-role" style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group1">
                                        <label class="label1">Kích hoạt</label>
                                        <input class="input--style-41" id="is_active" type="number" name="is_active"
                                               max="1" min="0">
                                        <span class="error" id="er-active"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row1 row-space1">
                                <div class="col-6">
                                    <div class="input-group1">
                                        <label class="label1">Password</label>
                                        <input class="input--style-41" id="pass" name="pass" type="password">
                                        <span class="error" id="er-pass" style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6" style="display: none">
                                    <div class="input-group1">
                                        <label class="label1">Kích hoạt</label>
                                        <input class="input--style-41">
                                        <span class="error" style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row1 row-space1">
                                <label class="label1" style="margin-left: 15px">Địa chỉ</label>
                                <input class="input--style-41" type="text" name="address"
                                       style="width: 100%;margin-left: 15px;margin-right: 15px" id="address">
                                <span class="error" id="er-address"
                                      style="color: red;font-size: 10px;margin-top: 5px;padding-left: 10px"></span>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" id="onSubmitAdd" name="submit" class="btn btn-primary"
                                onclick="submitAddUser()">
                            Thêm
                        </button>
                    </div>
                </div>
            </div>
        </div>
<%--        <div class="search-container">--%>
<%--            <select id="month-dropdown" onchange="filterByMonth()">--%>
<%--                <option value="">Select Month</option>--%>
<%--                <option value="01">January</option>--%>
<%--                <option value="02">February</option>--%>
<%--                <option value="03">March</option>--%>
<%--                <option value="04">April</option>--%>
<%--                <option value="05">May</option>--%>
<%--                <option value="06">June</option>--%>
<%--                <option value="07">July</option>--%>
<%--                <option value="08">August</option>--%>
<%--                <option value="09">September</option>--%>
<%--                <option value="10">October</option>--%>
<%--                <option value="11">November</option>--%>
<%--                <option value="12">December</option>--%>
<%--            </select>--%>
<%--        </div>--%>
        <div class="single-table" style="width: 95%; margin: 0 auto">
                <table id="example" class="table table-striped table-bordered" style="width: 100%">
                    <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Email</th>
                        <th scope="col">Tên</th>
                        <th scope="col">Năm Sinh</th>
                        <th scope="col">Địa Chỉ</th>
                        <th scope="col">Giới Tính</th>
                        <th scope="col">Active</th>
                        <th scope="col">Số Điện Thoại</th>
                        <th scope="col">Lần Cuối Đăng Nhập</th>
                        <th scope="col">HÀNH ĐỘNG</th>
                    </tr>
                    </thead>
                    <tbody class="tableBody">

                    <% for (Account user : users) {%>
                    <tr>
                        <th scope="row"><%=user.getId()%>
                        </th>
                        <td><%=user.getEmail()%>
                        </td>
                        <td><%=user.getFirst_name()%> <%=user.getLast_name()%>
                        </td>
                        <td>
                            <%=user.getDob()%>
<%--                            <script>--%>
<%--                                if (<%= user.getDob() != null %>) {--%>
<%--                                    console.log(new Date("<%= user.getDob().toString() %>").getMonth() + 1);--%>
<%--                                } else {--%>
<%--                                    console.log('null');--%>
<%--                                }--%>
<%--                            </script>--%>
                        </td>
                        <td><%=user.getAddress()%>
                        </td>
                        <%if (user.getGender() == 1) {%>
                        <td>Nam</td>
                        <%} else if (user.getGender() == 0) {%>
                        <td>Nữ</td>
                        <%} else {%>
                        <td>Khong xac dinh</td>
                        <%}%>
                        <%if (user.getIs_active() == 0) {%>
                        <td>
                            <a href="/admin/user/manage_user?action=active&id=<%=user.getId()%>">
                                <button class="btn btn-primary" style="background-color: lawngreen">
                                    Active
                                </button>
                            </a>
                        </td>
                        <%} else {%>
                        <td>
                            <a href="/admin/user/manage_user?action=block&id=<%=user.getId()%>">
                                <button class="btn btn-primary" style="background-color: darkred">
                                    Block
                                </button>
                            </a>
                        </td>
                        <%}%>
                        <td><%=user.getPhone_number()%>
                        </td>
                        <td>
                            <%=user.getLast_login()%>
                        </td>
                        <td>
                            <a class="btn btn-primary" href="/admin/user/manage_user?id=<%=user.getId()%>&action=alter">
                                Sửa
                            </a>
                            <% if (userDAO.countUserInOrders(user.getId()) > 0) {%>
                            <button class="btn btn-warning">
                                Xóa
                            </button>
                            <% }else{%>
                            <button class="btn btn-danger" onclick="openModalDeleteUser(<%=user.getId()%>)">
                                Xóa
                            </button>
                            <%}%>
                        </td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
    </div>
<script>
    new DataTable('#example');
</script>

        <!-- Modal to alter user -->
        <% if (userAlter != null) {%>
        <div class="modal" id="modalAlterUser" role="dialog" data-backdrop="false"
             aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModal">Sửa thông tin người dùng</h5>
                    </div>
                    <div class="modal-body">
                        <form method="post" id="formAlterUser">
                            <div class="row row-space">
                                <div class="col-6">
                                    <div class="input-group">
                                        <label class="label">Họ</label>
                                        <input class="input--style-4" type="text" name="first_name" id="f_name"
                                               value="<%=userAlter.getFirst_name()%>">
                                        <span class="error" id="er-f-name"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group">
                                        <label class="label">Tên</label>
                                        <input class="input--style-4" type="text" name="last_name" id="l-name"
                                               value="<%=userAlter.getLast_name()%>">
                                        <span class="error" id="er-l-name"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-6">
                                    <div class="input-group">
                                        <label class="label">Ngày sinh</label>
                                        <div class="input-group-icon" style="width: 100%">
                                            <input class="input--style-4 js-datepicker" type="text" name="dob"
                                                   id="dob" style="width: 100%;" value="<%=userAlter.getDob()%>">
                                        </div>
                                        <span class="error" id="er-dob" style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group">
                                        <label class="label">Giới tính</label>
                                        <div class="input-group-icon" style="width: 100%;display: flex">
                                            <input id="nam"
                                                   style="width: 50px;margin-right: 20px;border: greenyellow solid 1px;border-radius: 5px"
                                                   class="btn" type="button" value="Nam"
                                                   onclick="setValueToGender(1)">
                                            <input id="nu"
                                                   style="width: 50px;border: greenyellow solid 1px;border-radius: 5px"
                                                   class="btn" type="button" value="Nữ"
                                                   onclick="setValueToGender(0)">
                                            <input id="selectedButton" type="hidden" name="selectedButton">
                                        </div>
                                        <%if (userAlter.getGender() == 1) {%>
                                        <script>
                                            document.getElementById("nam").style.backgroundColor = "greenyellow";
                                            document.getElementById("nu").style.backgroundColor = "white";
                                        </script>
                                        <%} else { %>
                                        <script>
                                            document.getElementById("nu").style.backgroundColor = "greenyellow";
                                            document.getElementById("nam").style.backgroundColor = "white";
                                        </script>
                                        <%}%>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-6">
                                    <div class="input-group">
                                        <label class="label">Email</label>
                                        <input class="input--style-4" id="email" name="email"
                                               value="<%=userAlter.getEmail()%>">
                                        <span class="error" id="er-email" style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group">
                                        <label class="label">Số điện thoại</label>
                                        <input class="input--style-4" id="phone" name="phone_number"
                                               value="<%=userAlter.getPhone_number()%>">
                                        <span class="error" id="er-phone" style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-6">
                                    <div class="input-group">
                                        <label class="label">Role</label>
                                        <input value="<%=userAlter.getRole()%>" class="input--style-4" id="role"
                                               name="role" type="number" max="3" min="0">
                                        <span class="error" id="er-role" style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group">
                                        <label class="label">Kích hoạt</label>
                                        <input value="<%=userAlter.getIs_active()%>" class="input--style-4"
                                               id="is_active" type="number" name="is_active" min="0" max="1">
                                        <span class="error" id="er-active"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <label class="label" style="margin-left: 15px">Địa chỉ</label>
                                <input class="input--style-4" type="text" name="address"
                                       style="width: 100%;margin-left: 15px;margin-right: 15px" id="address"
                                       value="<%=userAlter.getAddress()%>">
                                <span class="error" id="er-address"
                                      style="color: red;font-size: 10px;margin-top: 5px;padding-left: 10px"></span>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal"
                                onclick="closeModalAlter()">Close
                        </button>
                        <button type="button" name="submit" class="btn btn-primary" onclick="submitFormAlterUser()">
                            Cập nhật
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <%}%>

        <!-- Modal to notify delete user -->
        <form id="formDeleteUser" method="post">
            <div id="modalDeleteUser" class="modal" style="margin: auto;width: 300px;display: none;align-items: center">
                <div class="modal-content" style="padding: 20px">
                <span style="color: darkred;font-size: 16px">
                    Bạn có chắc chắn muốn xóa người dùng này không?
                </span>
                    <div class="row gutters" style="margin-top: 20px;justify-content: space-between">
                        <button type="button" class="btn btn-secondary" onclick="closeModalDeleteUser()">
                            Hủy
                        </button>
                        <input name="inputSaveIdUser" id="inputSaveIdUser" type="hidden">
                        <button type="submit" class="btn btn-danger" onclick="submitFormDelete()">
                            Xóa
                        </button>
                    </div>
                </div>
            </div>
        </form>
        <!-- Paging -->
<%--        <%if (numberPage > 1) {%>--%>
<%--        <div class="row">--%>
<%--            <div class="col-12 d-flex justify-content-center">--%>
<%--                <nav aria-label="Page navigation example">--%>
<%--                    <ul class="pagination">--%>
<%--                        <li class="page-item">--%>
<%--                            <button id="previousPage" class="page-link"--%>
<%--                                    style="<%=currentIndex == 1 ? "pointer-events: none" : ""%>"--%>
<%--                                    onclick="pPage(<%=currentIndex%>)">Previous--%>
<%--                            </button>--%>
<%--                        </li>--%>
<%--                        <%--%>
<%--                            for (int i = 1; i <= numberPage; i++) {--%>
<%--                        %>--%>
<%--                        <li class="page-item"><a class="page-link"--%>
<%--                                                 style="<%=i == currentIndex ? "background-color: blue; color: black" : ""%>"--%>
<%--                                                 href="${pageContext.request.contextPath}/admin/user/manage_user?index=<%=i%>"><%=i%>--%>
<%--                        </a></li>--%>
<%--                        <%}%>--%>
<%--                        <li class="page-item">--%>
<%--                            <button id="nextPage" class="page-link"--%>
<%--                                    style="<%=currentIndex == numberPage ? "pointer-events: none" : ""%>"--%>
<%--                                    onclick="nPage(<%=currentIndex%>)">Next--%>
<%--                            </button>--%>
<%--                        </li>--%>
<%--                    </ul>--%>
<%--                </nav>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <%}%>--%>
<%--    </div>--%>
    <%@include file="/common/admin_footer.jsp" %>
</div>
<script>
    let f_name = document.getElementById("f_name");
    let l_name = document.getElementById("l-name");
    let dob = document.getElementById("dob");
    let email = document.getElementById("email");
    let phone = document.getElementById("phone");
    let pass = document.getElementById("pass");
    let repass = document.getElementById("re-pass");
    let address = document.getElementById("address");
    let active = document.getElementById("is_active");
    let role = document.getElementById("role");
    let er_f_name = document.getElementById("er-f-name");
    let er_l_name = document.getElementById("er-l-name")
    let er_dob = document.getElementById("er-dob");
    let er_email = document.getElementById("er-email");
    let er_phone = document.getElementById("er-phone");
    let er_pass = document.getElementById("er-pass");
    let er_repass = document.getElementById("er-re-pass");
    let er_address = document.getElementById("er-address");
    let er_active = document.getElementById("er-active");
    let er_role = document.getElementById("er-role");
    const elements = [f_name, l_name, address, role, active];
    const er_elements = [er_f_name, er_l_name, er_address, er_role, er_active];


    var modalAlterUser = document.getElementById("modalAlterUser");
    var selectedButton = document.getElementById("selectedButton");
    var nam = document.getElementById("nam");
    var nu = document.getElementById("nu");
    var modalDeleteUser = document.getElementById("modalDeleteUser");
    var modalRegisterUser = document.getElementById("modalRegisterUser");

    function pPage(currentIndex) {
        if (currentIndex > 1) {
            var link = $('#previousPage');
            link.attr('onclick', 'pPage(' + (currentIndex - 1) + ')');
            link.click();
        }
    }

    function nPage(currentIndex) {
        if (currentIndex < <%=numberPage%>) {
            var link = $('#nextPage');
            link.attr('onclick', 'nPage(' + (currentIndex + 1) + ')');
            link.click();
        }
    }

    function submitAddUser() {
        let isHaveEr = validateRegister();
        if (!isHaveEr) {
            var form = document.getElementById("formAddUser");
            form.submit();
        }
    }

    function onSubmitSearch() {
        var page = document.getElementById('formSearch');
        page.action = '/admin/user/manage_user?action=search&keyword=' + document.getElementById('keyword').value;
        page.submit();
    }

    function submitFormAlterUser() {
        var formAlterUser = document.getElementById("formAlterUser");
        formAlterUser.action = "/admin/user/update_user?id=" + <%= userAlter!= null ? userAlter.getId() : 0 %>;
        formAlterUser.submit();
    }


    function openModalRegister() {
        modalRegisterUser.style.display = "block";
    }


    function submitFormDelete() {
        var formDeleteUser = document.getElementById("formDeleteUser");
        formDeleteUser.action = "/admin/user/manage_user?action=delete&id=" + document.getElementById("inputSaveIdUser").value;
        formDeleteUser.submit();
    }


    function openModalDeleteUser(x) {
        modalDeleteUser.style.display = "flex";
        document.getElementById("inputSaveIdUser").value = x;
        console.log(document.getElementById("inputSaveIdUser").value);
    }

    function closeModalDeleteUser() {
        modalDeleteUser.style.display = "none";
    }

    function openModalAlter() {
        modalAlterUser.style.display = "block";
    }

    function closeModalAlter() {
        modalAlterUser.style.display = "none";
    }

    function setValueToGender(x) {
        selectedButton.value = x;
        if (x === 1) {
            nam.style.backgroundColor = "greenyellow";
            nu.style.backgroundColor = "white";
        } else {
            nu.style.backgroundColor = "greenyellow";
            nam.style.backgroundColor = "white";
        }
        console.log(selectedButton.value)
    }


    function validateRegister() {
        var countError = 0;
        for (var i = 0; i < elements.length; i++) {
            if (validateTextEmpty(elements[i])) {
                showError(er_elements[i], "Vui lòng không để trống thông tin!");
                countError++;
            } else {
                er_elements[i].innerHTML = "";
            }
        }

        if (validateEmail(email) === null) {
            showError(er_email, "Email không hợp lệ!");
        } else {
            er_email.innerHTML = "";
        }

        if (validatePassword(pass) === null) {
            showError(er_pass, "Mật khẩu phải có ít nhất 8 ký tự, 1 chữ hoa, 1 chữ thường và 1 số và 1 ký tự đặc biệt!");
        } else {
            er_pass.innerHTML = "";
        }

        if (validatePhoneNumberVN(phone) === null) {
            showError(er_phone, "Số điện thoại không hợp lệ!");
        } else {
            er_phone.innerHTML = "";
        }

        return countError > 0;
    }

    // create function validate text empty
    function validateTextEmpty(element) {
        return element.value === "";

    }

    // create function show error
    function showError(element, mess) {
        element.innerHTML = mess;
    }

    //create function validate email
    function validateEmail(email) {
        const rew = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g;
        return String(email.value).toLowerCase().match(rew);
    }

    // create minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
    function validatePassword(pass) {
        const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
        return String(pass.value).match(re);
    }

    // create function validate phone number in vietnam include start with 84 or 0
    function validatePhoneNumberVN(phone) {
        const re = /^(84|0[3|5|7|8|9])+([0-9]{8})$/;
        return String(phone.value).match(re);
    }
    function searchByBirthdate() {
        // Get the input value
        const birthdate = document.getElementById('search-birthdate').value;

        // Get the table rows
        const table = document.getElementById('example');
        const rows = table.getElementsByTagName('tr');

        // Loop through the rows and hide those that don't match the search query
        for (let i = 1; i < rows.length; i++) { // Skip the header row
        const cells = rows[i].getElementsByTagName('td');
        const birthdateCell = cells[3]; // Assuming the birthdate is in the 4th column (index 3)

        if (birthdateCell) {
        const cellText = birthdateCell.textContent || birthdateCell.innerText;
        const regex = new RegExp(`\\b${birthdate}\\b`, 'i'); // Case-insensitive search

        if (regex.test(cellText)) {
        rows[i].style.display = ''; // Show the row
    } else {
            rows[i].style.display = 'none'; // Hide the row
                }
            }
        }
    }
    function filterByMonth() {
        <%--    // Get the selected month value--%>
            const selectedMonth = document.getElementById('month-dropdown').value;
            const tableBody = document.querySelector('.tableBody');
            <%--tableBody.innerHTML = ` <% for (Account user : users) { %>--%>
            <%--    if (selectedMonth === <%=user.getDob().getMonth()%>){--%>
            <%--<tr>--%>
            <%--    <th scope="row"><%=user.getId()%>--%>
            <%--    </th>--%>
            <%--    <td><%=user.getEmail()%>--%>
            <%--    </td>--%>
            <%--    <td><%=user.getFirst_name()%> <%=user.getLast_name()%>--%>
            <%--    </td>--%>
            <%--    <td>--%>
            <%--        <%=user.getDob()%>--%>
            <%--    </td>--%>
            <%--    <td><%=user.getAddress()%>--%>
            <%--    </td>--%>
            <%--    <%if (user.getGender() == 1) {%>--%>
            <%--    <td>Nam</td>--%>
            <%--    <%} else if (user.getGender() == 0) {%>--%>
            <%--    <td>Nữ</td>--%>
            <%--    <%} else {%>--%>
            <%--    <td>Khong xac dinh</td>--%>
            <%--    <%}%>--%>
            <%--    <%if (user.getIs_active() == 0) {%>--%>
            <%--    <td>--%>
            <%--        <a href="/admin/user/manage_user?action=active&id=<%=user.getId()%>">--%>
            <%--            <button class="btn btn-primary" style="background-color: lawngreen">--%>
            <%--                Active--%>
            <%--            </button>--%>
            <%--        </a>--%>
            <%--    </td>--%>
            <%--    <%} else {%>--%>
            <%--    <td>--%>
            <%--        <a href="/admin/user/manage_user?action=block&id=<%=user.getId()%>">--%>
            <%--            <button class="btn btn-primary" style="background-color: darkred">--%>
            <%--                Block--%>
            <%--            </button>--%>
            <%--        </a>--%>
            <%--    </td>--%>
            <%--    <%}%>--%>
            <%--    <td><%=user.getPhone_number()%>--%>
            <%--    </td>--%>
            <%--    <td>--%>
            <%--        <%=user.getLast_login()%>--%>
            <%--    </td>--%>
            <%--    <td>--%>
            <%--        <a class="btn btn-primary" href="/admin/user/manage_user?id=<%=user.getId()%>&action=alter">--%>
            <%--            Sửa--%>
            <%--        </a>--%>
            <%--        <% if (userDAO.countUserInOrders(user.getId()) > 0) {%>--%>
            <%--        <button class="btn btn-warning">--%>
            <%--            Xóa--%>
            <%--        </button>--%>
            <%--        <% }else{%>--%>
            <%--        <button class="btn btn-danger" onclick="openModalDeleteUser(<%=user.getId()%>)">--%>
            <%--            Xóa--%>
            <%--        </button>--%>
            <%--        <%}%>--%>
            <%--    </td>--%>
            <%--</tr>--%>
            <%--    }--%>
            <%--<%}%>`;--%>
        // Get the table rows
        const table = document.getElementById('example');
        const rows = table.getElementsByTagName('tr');

        // Loop through the rows and hide those that don't match the selected month
        for (let i = 1; i < rows.length; i++) { // Skip the header row
            const cells = rows[i].getElementsByTagName('td');
            const birthdateCell = cells[2]; // Assuming the birthdate is in the 4th column (index 3)

            if (birthdateCell) {
                const cellText = birthdateCell.textContent || birthdateCell.innerText;

                // Extract the month part from the birthdate (assuming format is YYYY-MM-DD)
                const cellMonth = cellText.split('-')[1];
                console.log("cellmonth", cellMonth);
                console.log("celltext", cellText);
                console.log("selected", selectedMonth);
                // Check if the selected month matches the month part of the birthdate
                if (selectedMonth === "" || cellMonth === selectedMonth) {
                    rows[i].style.display = ''; // Show the row
                } else {
                    rows[i].style.display = 'none'; // Hide the row
                }
            }
        }
    }
    <%--}--%>
    // $(document).ready(function() {
    //     // Ensure DataTable is initialized
    //     var table = $('#example').DataTable();
    //
    //     // Search by Name Function
    //     window.searchByName = function() {
    //         var name = $('#search-name').val();
    //         table.search(name).draw();
    //     };
    //
    //     // Filter by Month Function
    //     window.filterByMonth = function() {
    //         var selectedMonth = $('#month-dropdown').val();
    //
    //         // Use DataTables API to filter
    //         $.fn.dataTable.ext.search.push(
    //             function(settings, data, dataIndex) {
    //                 var birthdate = data[3]; // Assuming the birthdate is in the 4th column (index 3)
    //                 var birthMonth = birthdate.split('-')[1]; // Extract month from birthdate
    //
    //                 if (selectedMonth === "" || birthMonth === selectedMonth) {
    //                     return true;
    //                 }
    //                 return false;
    //             }
    //         );
    //         table.draw();
    //         $.fn.dataTable.ext.search.pop();
    //     };
    // });
</script>
        <%@include file="/common/admin_library_js.jsp" %>
        <script src="${pageContext.request.contextPath}/resources/js/user/main.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/admin/slide_show.js"></script>
</body>
</html>

