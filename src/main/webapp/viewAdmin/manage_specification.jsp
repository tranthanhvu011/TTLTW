<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-29
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Add-product</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/common/admin_library_css.jsp" %>
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
                            <li><a href="${pageContext.request.contextPath}/admin">Home</a></li>
                            <li><span>Home</span></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-6 clearfix">
                    <div class="user-profile pull-right">
                        <img class="avatar user-thumb" src="../resources/assets/images/batman.png">
                        alt="avatar">
                        <h4 class="user-name dropdown-toggle" data-toggle="dropdown">
                            NHÓM 41 <i class="fa fa-angle-down"></i>
                        </h4>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Message</a> <a
                                class="dropdown-item" href="${pageContext.request.contextPath}/login?action=logout">Log Out</a>
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
                        <form style="padding: 10px">
                            <label>Nhập tên sản phẩm</label><br>
                            <input class="form-control" type="text">
                            <div style="margin-top: 10px;" class="form-group">
                                <label>Nhập thông số kĩ thuật</label>
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td>Dung lượng pin</td>
                                        <td><input type="text" class="form-control" id="info1" placeholder=""></td>
                                    </tr>
                                    <tr>
                                        <td>Thương hiệu</td>
                                        <td><input type="text" class="form-control" id="info2" placeholder=""></td>
                                    </tr>
                                    <tr>
                                        <td>Chip</td>
                                        <td><input type="text" class="form-control" id="info3" placeholder=""></td>
                                    </tr>
                                    <tr>
                                        <td>Hàng chính hãng</td>
                                        <td><input type="text" class="form-control" id="info4" placeholder=""></td>
                                    </tr>
                                    <tr>
                                        <td>Số sim</td>
                                        <td><input type="text" class="form-control" id="info5" placeholder=""></td>
                                    </tr>
                                    <tr>
                                        <td>RAM</td>
                                        <td><input type="text" class="form-control" id="info6" placeholder=""></td>
                                    </tr>
                                    <tr>
                                        <td>ROM</td>
                                        <td><input type="text" class="form-control" id="info7" placeholder=""></td>
                                    </tr>
                                    <tr>
                                        <td>Sản phẩm có được bảo hành không?</td>
                                        <td><input type="text" class="form-control" id="info8" placeholder=""></td>
                                    </tr>
                                    <tr>
                                        <td>Có thuế VAT?</td>
                                        <td><input type="text" class="form-control" id="info9" placeholder=""></td>
                                    </tr>
                                    <tr>
                                        <td>Hình thức bảo hành</td>
                                        <td><input type="text" class="form-control" id="info10" placeholder=""></td>
                                    </tr>
                                    <tr>
                                        <td>Thời gian bảo hành</td>
                                        <td><input type="text" class="form-control" id="info11" placeholder=""></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <button style="width: 200px;" type="submit" class="btn btn-primary">Gửi</button>
                        </form>


                    </div>
                </div>
            </div>
        </div>
        <%@include file="/common/admin_footer.jsp" %>
    </div>
    <%@include file="/common/admin_library_js.jsp" %>
    <!-- internal javascript -->
    <script type="text/javascript">
        $(document).ready(function () {
            $('#validationCustom05').summernote();
        });
    </script>
</body>

</html>

