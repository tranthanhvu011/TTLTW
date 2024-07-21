<%@ page import="java.util.List" %>
<%@ page import="model.Contacts" %>
<%@ page import="dao.ContactsDAO" %><%--
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
    <title>Contact</title>
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
                                    NHÓM 41 <i class="fa fa-angle-down"></i>
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
                <div class="single-table" style="width: 95%; margin: 0 auto">
                    <table id="example" class="table table-striped table-bordered" style="width: 100%">
                        <thead >
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Họ Và Tên</th>
                            <th scope="col">Địa Chỉ Email</th>
                            <th scope="col">Số Điện Thoại</th>
                            <th scope="col">Tiêu Đề</th>
                            <th scope="col" class="col-3">Nội Dung</th>
                            <th scope="col">Ngày Tạo</th>
                            <th scope="col">Trạng Thái</th>
                            <th scope="col">Hành Động</th>
                        </tr>
                        </thead>
                        <% List<Contacts> contactsList = (List<Contacts>) request.getAttribute("listContact");%>
                        <tbody>
                        <%  for (Contacts contacts: contactsList) { %>
                            <tr>
                                <th scope="row"><%= contacts.getId()%></th>
                                <td><%=contacts.getFullname()%></td>
                                <td><%=contacts.getEmail_address()%></td>
                                <td><%=contacts.getPhone_number()%></td>
                                <td>
                                    <a class="text-danger" href=" ${base}/delete-contact/${contact.id }" role="button">
                                       <%=contacts.getTitle()%>
                                    </a>
                                </td>
                                <td><textarea style="width: 100%"><%=contacts.getContent()%> </textarea></td>
                                <td><%=contacts.getCreate_at()%></td>
                                <td>
                                    <%
                                    if (contacts.getAction() == 0) {
                                    %>
                                    <p style="color: red;width:200px; font-weight: 600">
                                    Đang Xử Lý </p>
                                    <%}else{%>
                                    <p style="color: #4CAF50;width:200px; font-weight: 600 ">
                                    Đã Xử Lý</p>
                                    <%}%>
                                </td>
                                <td>
                                 <a href="/admin/contacts/manage_contacts?action=update&value=<%=contacts.getId()%>"><button class="btn btn-success">
                                     Đã Xử Lý
                                 </button></a>
                                 <a href="/admin/contacts/manage_contacts?action=delete&value=<%=contacts.getId()%>"><button class="btn btn-danger" >
                                     Xóa Liên Hệ
                                 </button></a>
                                </td>
                            </tr>
                           <%}%>
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

