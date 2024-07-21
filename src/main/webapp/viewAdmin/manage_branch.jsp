<%@ page import="java.util.List" %>
<%@ page import="model.OrderProductVariant" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.News" %>
<%@ page import="model.Log" %>
<%@ page import="model.ChiNhanh" %><%--
  Created by IntelliJ IDEA.
  Date: 2023-11-29
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%
    List<ChiNhanh> list = (List<ChiNhanh>) request.getAttribute("listBranches");
    if (list == null) list = new ArrayList<>();
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
    /* Popup styling */
    .popup {
        display: none; /* Ẩn popup theo mặc định */
        width: 400px; /* Chiều rộng popup */
        max-width: 90%; /* Đảm bảo popup không quá rộng trên màn hình nhỏ */
        background-color: #fff; /* Màu nền trắng */
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

    /* Form group styling */
    .form-group {
        margin-bottom: 15px;
    }

    /* Label styling */
    .form-group label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
    }

    /* Input styling */
    .form-group input[type="text"] {
        width: 100%;
        padding: 10px;
        border-radius: 4px;
        border: 1px solid #ccc;
        font-size: 16px;
    }

    /* Close button styling */
    .btn-close {
        background-color: #dc3545; /* Màu nền đỏ */
        color: #fff; /* Màu chữ trắng */
        border: none;
        border-radius: 4px;
        padding: 10px 15px;
        cursor: pointer;
        font-size: 16px;
        margin-right: 10px; /* Khoảng cách bên phải */
    }

    /* Submit button styling */
    .btn-submit {
        background-color: #007bff; /* Màu nền xanh */
        color: #fff; /* Màu chữ trắng */
        border: none;
        border-radius: 4px;
        padding: 10px 15px;
        cursor: pointer;
        font-size: 16px;
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
            <button id="openAddPopup" style="margin-bottom: 20px;">Thêm Chi Nhánh</button>
            <div class="table-responsive">
                <table id="table_branch" class="table text-center">
                    <thead class="text-uppercase bg-primary">
                    <tr class="text-white">
                        <th scope="col">ID</th>
                        <th scope="col">Tên chi nhánh</th>
                        <th scope="col">Địa chỉ chi nhánh</th>
                        <th scope="col">Số điện thoại</th>
                        <th scope="col">Email</th>
                        <th scope="col">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (ChiNhanh cn : list) { %>
                    <tr id="log-<%=cn.getId()%>">
                        <td><%=cn.getId()%></td>
                        <td><%=cn.getName()%></td>
                        <td><%=cn.getDiaChiChiNhanh()%></td>
                        <td><%=cn.getSdtChiNhanh()%></td>
                        <td><%=cn.getEmailChiNhanh()%></td>
                        <td style="display: flex">
                            <button type="button" class="btn btn-primary edit-button" data-id="<%= cn.getId() %>"  >Sửa</button>
                            <button style="margin-left: 5px;" type="button" class="btn btn-primary delete-branch" data-id="<%= cn.getId() %>">Xóa</button>
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
<script>
    new DataTable('#table_branch');
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
        $('.delete-branch').click(function() {
            var branchId = $(this).data('id');
            $.ajax({
                url: '/admin/manage_branch',
                type: 'POST',
                data: {
                    action: 'delete',
                    id: branchId
                },
                success: function(response) {
                    if (response.trim() === 'success') {
                        // Xóa dòng chi nhánh khỏi bảng nếu xóa thành công
                        $('[data-id="' + branchId + '"]').closest('tr').remove();
                    } else {
                        alert('Xóa chi nhánh không thành công. Vui lòng thử lại.');
                    }
                },
                error: function() {
                    alert('Có lỗi xảy ra. Vui lòng thử lại.');
                }
            });
        });
    });
</script>
<%--popup sửa--%>
<div id="editPopup" class="popup">
    <form action="/admin/manage_branch?action=edit" method="post">
        <div class="form-group">
            <label for="name">Tên chi nhánh</label>
            <input type="hidden" id="editId" name="id">
            <input type="text" id="name" name="name" required placeholder="Nhập tên chi nhánh">
            <span id="nameEditError" class="error-message"></span>
        </div>
        <div class="form-group">
            <label for="address">Địa chỉ chi nhánh</label>
            <input type="text" id="address" name="address" required placeholder="Nhập địa chỉ chi nhánh">
            <span id="addressEditError" class="error-message"></span>
        </div>
        <div class="form-group">
            <label for="phone">Số điện thoại</label>
            <input type="tel" id="phone" name="phone" required pattern="[0-9]{10,15}" placeholder="Nhập số điện thoại" title="Số điện thoại từ 10 đến 15 chữ số">
            <span id="phoneEditError" class="error-message"></span>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required placeholder="Nhập email" title="Email hợp lệ">
            <span id="emailEditError" class="error-message"></span>
        </div>
        <button type="button" id="closeEditPopup" class="btn-close">Đóng</button>
        <button type="submit" class="btn-submit">Cập nhật</button>
    </form>
</div>

<%--popup thêm chi nhánh--%>
<!-- Popup Thêm Chi Nhánh -->
<div id="addPopup" class="popup">
    <form action="/admin/manage_branch" method="post" id="addBranchForm">
        <input type="hidden" name="action" value="add">

        <div class="form-group">
            <label for="branchName">Tên chi nhánh</label>
            <input type="text" id="branchName" name="name" required placeholder="Nhập tên chi nhánh">
            <span id="branchNameAddError" class="error-message"></span>
        </div>

        <div class="form-group">
            <label for="branchAddress">Địa chỉ chi nhánh</label>
            <input type="text" id="branchAddress" name="address" required placeholder="Nhập địa chỉ chi nhánh">
            <span id="branchAddressAddError" class="error-message"></span>
        </div>

        <div class="form-group">
            <label for="branchPhone">Số điện thoại</label>
            <input type="tel" id="branchPhone" name="phone" required pattern="[0-9]{10,15}" placeholder="Nhập số điện thoại" title="Số điện thoại từ 10 đến 15 chữ số">
            <span id="branchPhoneAddError" class="error-message"></span>
        </div>

        <div class="form-group">
            <label for="branchEmail">Email</label>
            <input type="email" id="branchEmail" name="email" required placeholder="Nhập email" title="Email hợp lệ">
            <span id="branchEmailAddError" class="error-message"></span>
        </div>

        <button type="button" id="closeAddPopup" class="btn-close">Đóng</button>
        <button type="submit" class="btn-submit">Thêm</button>
    </form>
</div>

<script>// js mở nút sửa
const editButtons = document.querySelectorAll('.edit-button');
const editPopup = document.getElementById('editPopup');
const closeEditPopup = document.getElementById('closeEditPopup');

// Lắng nghe sự kiện click cho các nút sửa
editButtons.forEach(button => {
    button.addEventListener('click', () => {
        // Lấy thông tin từ data attributes của nút
        const id = button.getAttribute('data-id');
        const name = button.getAttribute('data-name');

        // Cập nhật giá trị của các input trong popup
        document.getElementById('editId').value = id;
        document.getElementById('name').value = name;

        // Hiển thị popup
        editPopup.style.display = 'block';
    });
});

// Lắng nghe sự kiện click cho nút đóng trong popup
closeEditPopup.addEventListener('click', () => {
    // Ẩn popup
    editPopup.style.display = 'none';
});
</script>
<%--js mở nút thêm mới --%>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var openAddPopupButton = document.getElementById("openAddPopup");
        var closeAddPopupButton = document.getElementById("closeAddPopup");
        var addPopup = document.getElementById("addPopup");

        // Mở popup
        openAddPopupButton.addEventListener("click", function() {
            addPopup.style.display = "block";
        });

        // Đóng popup
        closeAddPopupButton.addEventListener("click", function() {
            addPopup.style.display = "none";
        });

        // Đóng popup khi nhấn ngoài popup
        window.addEventListener("click", function(event) {
            if (event.target === addPopup) {
                addPopup.style.display = "none";
            }
        });
    });

</script>
</body>
</html>

