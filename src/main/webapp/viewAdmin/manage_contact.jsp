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
                            <li><a href="${base }/admin">Home</a></li>
                            <li><span>Home</span></li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-6 clearfix">
                    <div class="user-profile pull-right">
                        <img class="avatar user-thumb" src="../resources/assets/images/batman.png"
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
        <form class="list" action="${base }/admin/contacts/manage_contacts" method="get">
            <div class="main-content-inner">

                <div class="card-body"
                     style="display: flex; justify-content: space-between">
                    <div style="display: flex; padding-right: 15px">
                        <input type="hidden" id="page" name="page" class="form-control">
                        <input type="text" id="keyword" name="keyword"
                               class="form-control" placeholder="Search"
                               value=""
                               style="margin-right: 5px; height: 46px;">


                        <button type="submit" id="btnSearch" name="btnSearch"
                                value="Search" class="btn btn-flat btn-outline-secondary mb-3">Search
                        </button>
                    </div>
                </div>
            </div>
            <div class="single-table"
                 style="margin: 0px 30px; padding-bottom: 15px">
                <div class="table-responsive">
                    <table class="table text-center">
                        <thead class="text-uppercase bg-primary">
                        <tr class="text-white">
                            <th scope="col">ID</th>
                            <th scope="col">Họ Và Tên</th>
                            <th scope="col">Địa Chỉ Email</th>
                            <th scope="col">Số Điện Thoại</th>
                            <th scope="col">Tiêu Đề</th>
                            <th scope="col">Nội Dung</th>
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
                                <td><%=contacts.getContent()%></td>
                                <td><%=contacts.getCreate_at()%></td>
                                <td>
                                    <%
                                    if (contacts.getAction() == 0) {
                                    %>
                                    <p style="color: red;width:200px; font-weight: 600">
                                    Đang sữ lý </p>
                                    <%}else{%>
                                    <p style="color: #4CAF50;width:200px; font-weight: 600 ">
                                    Đã sữ lý</p>
                                    <%}%>
                                </td>
                                <td>
                                    <button class="btn-process" data-id="<%= contacts.getId() %>"style="width: 150px; border: 2px solid #0c5460; border-radius: 5px; background-color: yellow" >
                                        Đã Xữ lý
                                    </button>
                                    <button class="btn-delete" data-id="<%= contacts.getId() %>" style="width: 150px; border: 2px solid #0c5460; border-radius: 5px; background-color: red ">
                                        Xóa Liên Hệ
                                    </button>
                                </td>
                            </tr>
                           <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- Paging -->
            <div class="row">
                <div class="col-12 d-flex justify-content-center">
                    <div id="paging"></div>
                </div>
            </div>
        </form>
        <script>
            document.querySelectorAll('.btn-process').forEach(function(button) {
                button.addEventListener('click', function() {
                    var contactId = this.getAttribute('data-id');
                    fetch('/admin/contacts/manage_contacts?action=update&value=' + contactId)
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // Cập nhật trạng thái của hàng hoặc nút
                                buttonElement.textContent = 'Đã cập nhật';
                                // Có thể thay đổi màu sắc hoặc thêm thông báo tại đây
                            } else {
                                // Hiển thị thông báo lỗi
                            }                        });
                });
            });

            document.querySelectorAll('.btn-delete').forEach(function(button) {
                button.addEventListener('click', function() {
                    var contactId = this.getAttribute('data-id');
                    fetch('/admin/contacts/manage_contacts?action=delete&value=' + contactId)
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // Xóa hàng từ bảng
                                rowElement.remove();
                                // Hiển thị thông báo xóa thành công
                            } else {
                                // Hiển thị thông báo lỗi
                            }
                        });
                });
            });
        </script>
    </div>
    <%@include file="/common/admin_footer.jsp" %>
</div>
<%@include file="/common/admin_library_js.jsp" %>


</body>


</html>

