<%@ page import="java.util.List" %>
<%@ page import="model.Contacts" %>
<%@ page import="dao.ContactsDAO" %>
<%@ page import="dao.ProductDeltailDAO" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="modelDB.ProductDB" %><%--
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
    <title>Bình luận Sản Phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/common/admin_library_css.jsp"%>
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
                            NHÓM 4 <i class="fa fa-angle-down"></i>
                        </h4>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Message</a> <a
                                class="dropdown-item" href="${base }/login">Log Out</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <br>
        <br>
        <% ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
            JSONArray jsonArray = productDeltailDAO.getAllCommentProduct();


        %>
        <div class="single-table" style="width: 95%; margin: 0 auto">
            <table id="example" class="table table-striped table-bordered" style="width: 100%">
                <thead >
                <tr>
                    <th scope="col">Tên Người Bình Luận </th>
                    <th scope="col">Số Điện Thoại Liên Hệ</th>
                    <th style="width: 30%" scope="col">Nội Dung</th>
                    <th scope="col">Thời Gian Bình Luận</th>
                    <th scope="col">Sản Phẩm Bình Luận</th>
                    <th scope="col">Phê Duyệt</th>
                    <th scope="col">Chọn Sữ Lý</th>
                    <th scope="col">Chọn Sữ Lý</th>
                </tr>
                </thead>
                <tbody>
                <%     for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject jsonObject = jsonArray.getJSONObject(i);
                %>
                <tr>
                    <td><%= jsonObject.optString("nameComment", "")%></td>
                    <td><%= jsonObject.optString("phoneNumber", "")%></td>
                    <td>
                        <textarea style="width: 100%"><%= jsonObject.optString("content", "")%> </textarea>
                    </td>
                    <td>
                        <%= jsonObject.optString("timestamp", "")%>
                    </td>
                    <td>
                        <% ProductDAO productDAO = new ProductDAO();
                        ProductDB nameProduct = productDAO.findProductById(jsonObject.optInt("idProduct"));%>
                        <%= nameProduct.getName()%></td>
                    <td><% if (jsonObject.optInt("isActive") == 1) {%>
                    Đã Duyệt
                    <% }else{%>
                    Chưa Duyệt
                    <% } %>
                    <td>
                    <a href="${pageContext.request.contextPath}/admin/manage_comment_product_detail?action=active&id=<%=jsonObject.optInt("id")%>&idProduct=<%=jsonObject.optInt("idProduct")%>">
                        <button type="button" class="btn btn-success" >
                        Phê Duyệt
                    </button> </a>

                    </td>
                    <td>
                        <button type="button" class="btn btn-danger" >
                            Xóa Bình Luận
                        </button>

                    </td>
                    <% }%>
                </tr>
                </tbody>
            </table>
        </div>
        <script>
            new DataTable('#example');
        </script>
        <!-- Paging -->
        <div class="row">
            <div class="col-12 d-flex justify-content-center">
                <div id="paging"></div>
            </div>
        </div>
        </form>

    </div>
    <%@include file="/common/admin_footer.jsp" %>
</div>
<%@include file="/common/admin_library_js.jsp" %>


</body>


</html>

