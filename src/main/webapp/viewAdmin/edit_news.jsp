<%@ page import="model.OrderProductVariant" %>
<%@ page import="model.InforTransport" %>
<%@ page import="model.News" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-29
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<% News news = (News) request.getAttribute("data");
//    if (news==null) news = new News(rs.getString("title"), rs.getString("content"), rs.getTimestamp("create_at"), rs.getTimestamp("update_at"), rs.getString("url_image"));

    String getMessage = (String) session.getAttribute("message");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Add-product</title>
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
                        <img class="avatar user-thumb" src="../resourcesAdmin/img/batman.png"
                             alt="avatar">
                        <h4 class="user-name dropdown-toggle" data-toggle="dropdown">
                            NHÓM 4  <i class="fa fa-angle-down"></i>
                        </h4>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Message</a>  <a
                                class="dropdown-item" href="${base }/login">Log Out</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- page title area end -->
        <div class="main-content-inner">
            <!-- sales report area start -->
            <div class="form-search">
                <div class="col-12">
                    <div class="card mt-5">
                        <form class="container" style="margin-top: 10px; margin-bottom: 10px;" action="/update-news" method="post" accept-charset="UTF-8" onsubmit="return validateForm()">
                            <input type="hidden" name="id" value="<%=news.getId()%>" />

                            <label for="title">Tiêu đề</label><br>
                            <input id="title" class="form-control" type="text" name="title" value="<%=news.getTitle()%>" required>
                            <span id="titleError" style="color: red; display: none;">* Không được để trống</span><br>

                            <label for="content">Nội dung</label><br>
                            <input id="content" name="content" class="form-control" type="text" value="<%=news.getContent()%>" required>
                            <span id="contentError" style="color: red; display: none;">* Không được để trống</span><br><br>

                            <label for="image">Ảnh</label> <br>
                            <input id="image" name="image" class="form-control" type="text" value="<%=news.getUrl_image()%>" required>
                            <span id="imageError" style="color: red; display: none;">* Không được để trống</span><br><br>

                            <button type="submit" class="btn btn-primary">Cập nhật</button>

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
    <script>
        function validateForm() {
            var title = document.getElementById("title").value.trim();
            var content = document.getElementById("content").value.trim();
            var image = document.getElementById("image").value.trim();

            var titleError = document.getElementById("titleError");
            var contentError = document.getElementById("contentError");
            var imageError = document.getElementById("imageError");

            if (title === '') {
                titleError.style.display = 'inline';
            } else {
                titleError.style.display = 'none';
            }

            if (content === '') {
                contentError.style.display = 'inline';
            } else {
                contentError.style.display = 'none';
            }

            if (image === '') {
                imageError.style.display = 'inline';
            } else {
                imageError.style.display = 'none';
            }

            return title !== '' && content !== '' && image !== '';
        }
    </script>

</body>

</html>

