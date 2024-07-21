<%@ page import="java.util.List" %>
<%@ page import="model.ProductVariant" %>
<%@ page import="config.Formater" %>
<%@ page import="model.Product" %>
<%@ page import="model.ProductImage" %>
<%@ page import="config.URLConfig" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="modelDB.ProductDB" %>
<%@ page import="dao.ManufacturerDAO" %>
<%@include file="/common/taglib.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-29
  Time: 3:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Quản lý sản phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
</style>
<body>
<%
    String message = (String) session.getAttribute("message");
    Boolean status = (Boolean) session.getAttribute("status");
%>
<div id="preloader">
    <div class="loader">
    </div>
</div>
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
                            <li><a href="${pageContext.request.contextPath}/admin/revenue_statistic">Home</a></li>
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
                            NHÓM 4 <i class="fa fa-angle-down"></i>
                        </h4>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Message</a> <a
                                class="dropdown-item" href="${pageContext.request.contextPath}/logout">Log Out</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="main-content-inner">
            <!-- Taskbar -->
            <a class="btn btn-primary" style="background-color: lawngreen"
               href="${pageContext.request.contextPath}/admin/product/add_product">
                Thêm sản phẩm
            </a>
        </div>

        <!-- Table data -->
        <div class="single-table" style="width: 95%; margin: 0 auto">
            <table id="example" class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col" style="width: 20%">Tên Sản Phẩm</th>
                    <th scope="col">Giá</th>
                    <th scope="col">Hãng Sản Xuất</th>
                    <th scope="col">Ảnh</th>
                    <th scope="col">Action</th>
                </tr>
                </thead>
                <tbody>
                <% ProductDAO productDAO = new ProductDAO();
                List<ProductDB> productDBList = productDAO.findAllProduct();
                    ManufacturerDAO manufacturerDAO = new ManufacturerDAO();%>
                <% for (ProductDB productDB : productDBList) {%>
                <tr>
                    <th scope="row"><%=productDB.getId()%></th>
                    <td style="max-width: 100px"><%=productDB.getName()%></td>
                    <td><%=productDB.getPrice()%></td>
                    <td>
                        <img style="width: 100px; height: 100px" src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_THUMBALL%>/<%=productDB.getThumbnail_url().trim()%>" alt="">
                    </td>
                    <td><%=manufacturerDAO.findManufacturerById(productDB.getManufacturer_id()).getNAME()%></td>
                    <td>
                        <a href="/admin/edit_product_home?idProduct=<%=productDB.getId()%>"><button>Sửa Và Xem</button></a>
                        <button class="btn btn-danger" role="button">Xóa</button>
                    </td>
                </tr>
                <% }%>

                </tbody>
            </table>
        </div>
        <script>
            new DataTable('#example');
        </script>

        <%@include file="/common/admin_footer.jsp" %>
    </div>

    <%@include file="/common/admin_library_js.jsp" %>
    <script src="${pageContext.request.contextPath}/resources/js/user/main.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/admin/slide_show.js"></script>
</body>
</html>

