<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="modelDB.ProductDB" %>
<%@ page import="dao.ProductVariantDAO" %>
<%@ page import="config.URLConfig" %><%--
  Created by IntelliJ IDEA.
  Date: 2023-11-29
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%

    List<Integer> listId = (List<Integer>) request.getAttribute("listIdProduct");
    if (listId == null) listId = new ArrayList<>();
    ProductVariantDAO productVariantDAO = new ProductVariantDAO();
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
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
            <div>
                <button id="openAddPopup" style="margin-bottom: 20px;">Nhập lô hàng mới</button>
                <div class="table-responsive">
                    <!-- Table -->
                    <table id="table_inventory" class="table text-center">
                        <thead class="text-uppercase bg-primary">
                        <tr class="text-white">
                            <th scope="col">ID</th>
                            <th scope="col">Tên sản phẩm</th>
                            <th scope="col">Màu sắc</th>
                            <th scope="col">Dung lượng</th>
                            <th scope="col">Ảnh đại diện</th>
                            <th scope="col">Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Integer idProduct : listId) { %>
                        <tr id="<%=idProduct%>">
                            <td><%=idProduct%>
                            </td>
                            <td><%=productVariantDAO.getProductNameByVariantId(idProduct)%>
                            </td>


                            <%ProductVariant productVariant = ProductVariantDAO.getColorAndCapacityProductVariantByID(idProduct);%>
                            <td><%=productVariant.getNameCapacity()%>
                            </td>
                            <td><%=productVariant.getNameColor()%>
                            </td>
                            <td>


                                                   <div>
                                                       <%String url = productVariantDAO.getThumbnailUrlByProductId(productVariantDAO.getProductIdByVariantId(idProduct));%>
                                                            <img src="..\resources\assets\images\thumball\<%=url.trim()%>" width="50px" height="50px">
                                                      </div>

                            </td>
                            <td><input type="checkbox" value="<%=idProduct%>"></td>
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

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        new DataTable('#table_inventory');
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const openAddPopupButton = document.getElementById("openAddPopup");

            openAddPopupButton.addEventListener("click", function () {
                const selectedCheckboxes = document.querySelectorAll("#table_inventory input[type='checkbox']:checked");
                const selectedIds = Array.from(selectedCheckboxes).map(checkbox => checkbox.value);

                if (selectedIds.length > 0) {
                    fetch('/admin/manage_import', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({ids: selectedIds})
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.status === 'success') {
                                // Chuyển hướng đến servlet khác sau khi xử lý thành công
                                window.location.href = '/admin/manage_getlistimport';
                            } else {
                                alert('Có lỗi xảy ra. Vui lòng thử lại.');
                            }
                        })
                        .catch((error) => {
                            console.error('Error:', error);
                        });
                } else {
                    alert("Chưa chọn sản phẩm nào.");
                }
            });
        });
    </script>


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

