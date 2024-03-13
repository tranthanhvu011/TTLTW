<%@ page import="model.OrderProductVariant" %>
<%@ page import="model.InforTransport" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-29
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String message = (String) session.getAttribute("message");
    message = (message==null)? "": message;
%>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Add-news</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/common/admin_library_css.jsp"%>
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

    .my-table {
        border-collapse: collapse; /* Gộp cạnh của các ô */
        border: none; /* Xóa viền cho toàn bộ bảng */
    }

    .my-table td, .my-table th {
        border: none; /* Xóa viền cho các ô cụ thể */
    }
</style>
<body>
<%if (message!=null){
    session.removeAttribute("message");
}%>
<div id="preloader">
    <div class="loader">
    </div>
</div>
<div class="page-container">
    <%@include file="/common/admin_sidebar.jsp"%>
    <div class="main-content">
        <!-- header area start -->
        <div class="header-area">
            <div class="row align-items-center">
                <!-- nav and search button -->
                <div class="col-md-6 col-sm-8 clearfix">
                    <div class="nav-btn pull-left">
                        <span></span> <span></span> <span></span>
                    </div>
               
                </div>
                <!-- profile info & task notification -->
                <div class="col-md-6 col-sm-4 clearfix">
                    <ul class="notification-area pull-right">
                    </ul>
                </div>
            </div>
        </div>

        <!-- header area end -->
        <!-- page title area start -->

        <div class="page-title-area">
            <div class="row align-items-center">
                <div class="col-sm-6">
                    <div class="breadcrumbs-area clearfix">
                        <h4 class="page-title pull-left">Home</h4>
                        <ul class="breadcrumbs pull-left">
                            <li><a href="${base }/admin">Home</a></li>
                            <li><span>Home</span></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-6 clearfix">
                    <div class="user-profile pull-right">
                        <img class="avatar user-thumb" src="${base }/resourcesAdmin/img/batman.png"
                             alt="avatar">
                        <h4 class="user-name dropdown-toggle" data-toggle="dropdown">
                            NHÓM 4  <i class="fa fa-angle-down"></i>
                        </h4>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Message</a>  <a
                                class="dropdown-item" href="${base}/login">Log Out</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div><p style="color: red;text-align: center;margin-top: 20px;"><%=message%></p></div>
        <!-- page title area end -->
        <div class="main-content-inner">
            <!-- sales report area start -->
            <div class="form-search">
                <div class="col-12">
                    <div class="card mt-5">
                        <form class="container" style="margin-top: 10px;margin-bottom: 10px;" action="/manage-news?action=add" method="post" accept-charset="UTF-8">
                            <label >Tiêu đề</label><br>
                            <input name="title" class="form-control" type="text" value="" ><br><br>
                            <label >Nội dung</label><br>
                            <input name="content" class="form-control" type="text" value="" ><br><br>
                            <label >Ảnh</label> <br>
                            <input name="image" class="form-control" type="file" value="" ><br><br>
                            <button type="submit" class="btn btn-primary">Thêm</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="/common/admin_footer.jsp"%>
    </div>
    <%@include file="/common/admin_library_js.jsp"%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#validationCustom05').summernote();
        });
    </script>
</body>

</html>

