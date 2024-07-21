<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="modelDB.ProductDB" %><%--
  Created by IntelliJ IDEA.
  Date: 2023-11-29
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%
    List<KhoHang> list = (List<KhoHang>) request.getAttribute("inventory");
    if (list == null) list = new ArrayList<>();
//    List<Integer> listId = (List<Integer>) request.getAttribute("listId");
//    if (list == null) list = new ArrayList<>();
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
    <link href="${pageContext.request.contextPath}/resources/libs/datepicker/css/bootstrap/zebra_datepicker.min.css"
          rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath}/resources/css/user/toast.css" rel="stylesheet" media="all">
    <%@include file="/common/libraries.jsp" %>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/v/bs4-4.6.0/jq-3.7.0/dt-2.0.8/datatables.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
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
    /* Popup styling */
    .popup {
        display: none; /* Ẩn popup theo mặc định */
        width: 500px;
        max-width: 90%; /* Đảm bảo popup không quá rộng trên màn hình nhỏ */
        background-color: #fff; /* Màu nền trắng cho popup */
        border-radius: 8px; /* Bo tròn các góc */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Hiệu ứng đổ bóng */
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%); /* Căn giữa popup */
        padding: 20px;
        z-index: 1000; /* Đặt trên các phần tử khác */
        overflow: auto;
    }

    /* Button styling */
    .btn-close {
        background-color: #dc3545; /* Màu nền đỏ cho nút đóng */
        color: #fff; /* Màu chữ trắng */
        border: none; /* Xóa viền */
        border-radius: 4px; /* Bo tròn các góc */
        padding: 10px 15px; /* Khoảng cách bên trong nút */
        cursor: pointer; /* Con trỏ chuột thay đổi khi di chuột qua nút */
        font-size: 16px; /* Kích thước chữ */
        margin-bottom: 15px; /* Khoảng cách dưới nút */
    }

    /* Submit button styling */
    .btn-submit {
        background-color: #007bff; /* Màu nền xanh cho nút cập nhật */
        color: #fff; /* Màu chữ trắng */
        border: none; /* Xóa viền */
        border-radius: 4px; /* Bo tròn các góc */
        padding: 10px 15px; /* Khoảng cách bên trong nút */
        cursor: pointer; /* Con trỏ chuột thay đổi khi di chuột qua nút */
        font-size: 16px; /* Kích thước chữ */
    }

    /* Form group styling */
    .form-group {
        margin-bottom: 15px;
    }

    /* Label styling */
    .popup label {
        display: block; /* Hiển thị label trên một dòng */
        font-weight: bold; /* Chữ đậm */
        margin-bottom: 5px; /* Khoảng cách dưới label */
    }

    /* Form control styling */
    .form-control {
        width: 100%; /* Chiếm toàn bộ chiều rộng của phần tử chứa */
        padding: 10px; /* Khoảng cách bên trong */
        border-radius: 4px; /* Bo tròn các góc */
        border: 1px solid #ccc; /* Viền xám nhạt */
        font-size: 16px; /* Kích thước chữ */
    }

    /* Input styling */
    .popup input[type="text"] {
        width: 100%; /* Chiếm toàn bộ chiều rộng của phần tử chứa */
        padding: 10px; /* Khoảng cách bên trong */
        border-radius: 4px; /* Bo tròn các góc */
        border: 1px solid #ccc; /* Viền xám nhạt */
        font-size: 16px; /* Kích thước chữ */
    }

</style>
<body>
<%--<%if (message != null) {%>--%>
<%--<script>--%>
<%--    showToast();--%>
<%--    setTimeout(() => document.querySelector(".toast").style.display = "none", 5000);--%>
<%--</script>--%>
<%--<%session.removeAttribute("message");%>--%>
<%--<%}%>--%>
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


                <div>
                </div>

                <%--                <p style="color: red; text-align: center;margin-right: 20px;"><%= message %>--%>
                </p>
            </div>
        </div>
        <!-- Dark table start -->
        <!-- Dark table end -->

        <div class="single-table"
             style="margin: 0px 30px; padding-bottom: 15px">
            <button id="openAddPopup" style="margin-bottom: 20px;">Thêm kho hàng</button>
            <div class="table-responsive">
                <!-- Table -->
                <table id="table_inventory" class="table text-center">
                    <thead class="text-uppercase bg-primary">
                    <tr class="text-white">
                        <th scope="col">ID</th>
                        <th scope="col">Tên kho</th>
                        <th scope="col">Địa chỉ kho</th>
                        <th scope="col">Số điện thoại</th>
                        <th scope="col">Email</th>
                        <th scope="col">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (KhoHang khoHang : list) { %>
                    <tr id="log-<%=khoHang.getId()%>">

                        <td><%=khoHang.getId()%></td>
                        <td><%=khoHang.getNameKho()%></td>
                        <td><%=khoHang.getDiaChiKho()%></td>
                        <td><%=khoHang.getSdtKho()%></td>
                        <td><%=khoHang.getEmailKho()%></td>
                        <td style="display: flex">
                           <button class="edit" data-id="<%=khoHang.getId()%>">Sửa</button>
                            <button style="margin-left: 5px;" type="button" class="btn btn-primary delete-inventory" data-id="<%=khoHang.getId()%>">Xóa</button>

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
<div id="popup" class="popup">
    <form action="/admin/manage_inventory?action=edit" method="post" id="inventoryForm">
        <div class="form-group">
            <label for="name">Tên kho hàng</label>
            <input type="text" id="name" name="name" required placeholder="Nhập tên kho hàng">
            <span id="nameError" class="error-message"></span>
        </div>
        <div class="form-group">
            <label for="address">Địa chỉ kho</label>
            <input type="text" id="address" name="address" required placeholder="Nhập địa chỉ kho">
            <span id="addressError" class="error-message"></span>
        </div>
        <div class="form-group">
            <label for="phone">Số điện thoại</label>
            <input type="tel" id="phone" name="phone" required pattern="[0-9]{10,15}" placeholder="Nhập số điện thoại" title="Số điện thoại từ 10 đến 15 chữ số">
            <span id="phoneError" class="error-message"></span>
        </div>
        <div class="form-group">
            <label for="mail">Email</label>
            <input type="email" id="mail" name="mail" required placeholder="Nhập email" title="Email hợp lệ">
            <span id="mailError" class="error-message"></span>
        </div>
        <input type="hidden" id="editId" name="id">

        <button type="button" id="closePopup">Đóng</button>
        <button type="submit">Cập nhật</button>
    </form>
</div>

<style>
    .error-message {
        color: red;
        font-size: 0.875em;
    }
    /* Các style khác cho popup */
</style>

<script>
    document.getElementById('inventoryForm').addEventListener('submit', function(event) {
        let valid = true;

        // Kiểm tra tên kho hàng
        const name = document.getElementById('name').value;
        if (!name) {
            document.getElementById('nameError').textContent = 'Tên kho hàng không được để trống.';
            valid = false;
        } else {
            document.getElementById('nameError').textContent = '';
        }

        // Kiểm tra địa chỉ kho
        const address = document.getElementById('address').value;
        if (!address) {
            document.getElementById('addressError').textContent = 'Địa chỉ kho không được để trống.';
            valid = false;
        } else {
            document.getElementById('addressError').textContent = '';
        }

        // Kiểm tra số điện thoại
        const phone = document.getElementById('phone').value;
        const phonePattern = /^[0-9]{10,15}$/;
        if (!phonePattern.test(phone)) {
            document.getElementById('phoneError').textContent = 'Số điện thoại phải từ 10 đến 15 chữ số.';
            valid = false;
        } else {
            document.getElementById('phoneError').textContent = '';
        }

        // Kiểm tra email
        const email = document.getElementById('mail').value;
        if (!email) {
            document.getElementById('mailError').textContent = 'Email không được để trống.';
            valid = false;
        } else {
            document.getElementById('mailError').textContent = '';
        }

        if (!valid) {
            event.preventDefault();
        }
    });
</script>


<!-- Add Inventory Popup -->
<div id="addPopup" class="popup">
    <form action="/admin/manage_inventory" method="post" id="addInventoryForm">
        <input type="hidden" name="action" value="add">
        <div class="form-group">
            <label >Tên kho hàng</label>
            <input type="text" name="name" required placeholder="Nhập tên kho hàng">
            <span id="nameAddError" class="error-message"></span>
        </div>
        <div class="form-group">
            <label for="address">Địa chỉ kho</label>
            <input type="text" name="address" required placeholder="Nhập địa chỉ kho">
            <span id="addressAddError" class="error-message"></span>
        </div>
        <div class="form-group">
            <label for="phone">Số điện thoại</label>
            <input type="tel"  name="phone" required pattern="[0-9]{10,15}" placeholder="Nhập số điện thoại" title="Số điện thoại từ 10 đến 15 chữ số">
            <span id="phoneAddError" class="error-message"></span>
        </div>
        <div class="form-group">
            <label for="mail">Email</label>
            <input type="email"  name="mail" required placeholder="Nhập email" title="Email hợp lệ">
            <span id="mailAddError" class="error-message"></span>
        </div>
        <button type="button" id="closeAddPopup" class="btn-close">Đóng</button>
        <button type="submit" class="btn-submit">Thêm</button>
    </form>
</div>

<style>
    .error-message {
        color: red;
        font-size: 0.875em;
    }
    /* Các style khác cho popup */
</style>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var openAddPopupButton = document.getElementById('openAddPopup');
        var addPopup = document.getElementById('addPopup');
        var closeAddPopupButton = document.getElementById('closeAddPopup');

        // Open the add inventory popup
        openAddPopupButton.addEventListener('click', function() {
            addPopup.style.display = 'block';
        });

        // Close the add inventory popup
        closeAddPopupButton.addEventListener('click', function() {
            addPopup.style.display = 'none';
        });
    });

</script>
<script>
    $(document).ready(function() {
        // Hiển thị popup khi nhấp vào nút "Sửa"
        $('.edit').click(function() {
            var id = $(this).data('id');
            $('#editId').val(id); // Lưu ID vào trường ẩn
            $('#popup').show(); // Hiển thị popup
        });

        // Ẩn popup khi nhấp vào nút "Đóng"
        $('#closePopup').click(function() {
            $('#popup').hide(); // Ẩn popup
        });
    });
</script>


<script>
    new DataTable('#table_inventory');
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function(){
        $('.delete-inventory').click(function(){
            var khoHangId = $(this).data('id');
                $.ajax({
                    url: '/admin/manage_inventory',
                    type: 'POST',
                    data: {
                        action: 'delete',
                        id: khoHangId
                    },
                    success: function(response){
                        if(response === 'success'){
                            $('#log-' + khoHangId).remove();
                        } else {
                            alert('Xóa không thành công');
                        }
                    },
                    error: function(){
                        alert('Có lỗi xảy ra');
                    }
                });
        });
    });
</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>

