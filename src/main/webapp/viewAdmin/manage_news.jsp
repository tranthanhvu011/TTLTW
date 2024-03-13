<%@ page import="java.util.List" %>
<%@ page import="model.OrderProductVariant" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.News" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-29
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<% List<News> list = (List<News>) request.getAttribute("datanew");
    if (list == null) list = new ArrayList<>();
    List<News> listNewsAlter = (List<News>) request.getAttribute("listNewsAlter");
    String message = (String) session.getAttribute("message");
    message = (message == null) ? "" : message;
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>User</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="../common/admin_library_css.jsp" %>

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
<%if (message != null) {%>
<script>
    showToast();
    setTimeout(() => document.querySelector(".toast").style.display = "none", 5000);
</script>
<%session.removeAttribute("message");%>
<%}%>
<div id="preloader">
    <div class="loader">
    </div>
</div>
<div class="page-container">
    <%@include file="/common/admin_sidebar.jsp" %>
    <div class="main-content">
        <!-- header area start -->
        <div class="header-area">
            <div class="row align-items-center">
                <!-- nav and search button -->
                <div class="col-md-6 col-sm-8 clearfix">
                    <div class="nav-btn pull-left">
                        <span></span> <span></span> <span></span>
                    </div>
                    <div class="search-box pull-left">
                        <form action="#">
                            <input type="text" name="search" placeholder="Search..." required>
                            <i class="fas fa-search"></i>
                        </form>
                    </div>
                </div>
                <!-- profile info & task notification -->
                <div class="col-md-6 col-sm-4 clearfix">
                    <ul class="notification-area pull-right">
                    </ul>
                </div>
            </div>
        </div>
        <div class="page-title-area">
            <div class="row align-items-center">
                <div class="col-sm-6">
                    <div class="breadcrumbs-area clearfix">
                        <h4 class="page-title pull-left">Home</h4>
                        <ul class="breadcrumbs pull-left">
                            <li><a href="revenue-statistics.html">Home</a></li>
                            <li><span>Home</span></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-6 clearfix">
                    <div class="user-profile pull-right">
                        <img class="avatar user-thumb" src="../resources/assets/images/batman.png"
                             alt="avatar">
                        <h4 class="user-name dropdown-toggle" data-toggle="dropdown">
                            Admin <i class="fa fa-angle-down"></i>
                        </h4>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Message</a> <a
                                class="dropdown-item" href="#">Log Out</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- header area end -->
        <!-- page title area start -->
        <div class="main-content-inner">
            <!-- sales report area start -->

            <div class="card-body"
                 style="display: flex; justify-content: space-between">
                <form method="post">
                    <div style="display: flex; padding-right: 15px">
                        <input type="hidden" id="page" name="page" class="form-control">
                        <input type="text" id="keyword" name="keyword"
                               class="form-control" placeholder="Search"
                               value=" "
                               style="margin-right: 5px; height: 46px;">
                        <button type="submit" id="btnSearch" name="btnSearch"
                                value="Search" class="btn btn-flat btn-outline-secondary mb-3"><a href="/manage-news?action=search">
                            Search
                        </a>
                        </button>
                    </div>
                </form>

                <div>
                </div>

                <p style="color: red; text-align: center;margin-right: 20px;"><%= message %>
                </p>
                <button style="margin-left: 5px;" type="button" class="btn btn-primary">
                    <a style="color: white" href="add-news">Thêm tin tức</a>
                </button>
            </div>
        </div>
        <!-- Dark table start -->
        <!-- Dark table end -->

        <div class="single-table"
             style="margin: 0px 30px; padding-bottom: 15px">
            <div class="table-responsive">
                <table class="table text-center">
                    <thead class="text-uppercase bg-primary">
                    <tr class="text-white">
                        <th scope="col">ID</th>
                        <th scope="col">Title</th>
                        <th scope="col">Content</th>
                        <th scope="col">Create at</th>
                        <th scope="col">Update at</th>
                        <th scope="col">Image</th>
                        <th scope="col">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (News n : list) { %>
                    <tr>
                        <td><%= n.getId() %>
                        </td>
                        <td><%=n.getTitle()%>
                        </td>
                        <td><%= n.getContent() %>
                        </td>
                        <td><%=n.getCreate_at() %>
                        </td>
                        <td><%=n.getUpdate_at() %>
                        </td>
                        <td>
                            <img style="width: 100px;height: 100px;" src="<%=n.getUrl_image()%>">
                        </td>

                        <td style="display: flex">
                            <button style="margin-left: 5px;" type="button" class="btn btn-primary">
                                <a style="color: white" href="manage-news?id=<%=n.getId()%>&action=delete">Xóa</a>
                            </button>
                            <button style="margin-left: 5px;" type="button" class="btn btn-primary ">
                                <a style="color: white" href="manage-news?id=<%=n.getId()%>&action=edit">Sửa</a>
                            </button>
                        </td>

                    </tr>
                    <% } %>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>
<!-- Paging -->
<div class="row">
    <div class="col-12 d-flex justify-content-center">
        <div id="paging1"></div>
    </div>
</div>
<%@include file="../common/admin_footer.jsp" %>
<%@include file="../common/admin_library_js.jsp" %>
</body>
</html>

