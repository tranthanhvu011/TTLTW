<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="dao.OrderProductVariantDAO" %>
<%@ page import="modelDB.OrderProductVariantDB" %>
<%@ page import="modelDB.ProductVariantDB" %>
<%@ page import="dao.ProductVariantDAO" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="config.Formater" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2024-01-21
  Time: 11:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Thong ke doanh so</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/common/admin_library_css.jsp" %>
    <link href="${pageContext.request.contextPath}/resources/css/admin/model.css" rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath}/resources/libs/datepicker/css/bootstrap/zebra_datepicker.css"
          rel="stylesheet" media="all">
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
        display: none; /* Ẩn modal mặc định */
        position: fixed; /* Cố định modal */
        z-index: 3; /* Hiển thị trên cùng */
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgb(0,0,0); /* Màu nền đen với độ mờ */
        background-color: rgba(0,0,0,0.4); /* Độ mờ */
    }

    .modal-content {
        background-color: #fefefe;
        margin: 10% auto; /* Giảm margin-top để tránh bị tràn khi modal lớn */
        padding: 10px;
        border: 1px solid #888;
        width: 50%; /* Tăng kích thước width */
        max-width: none; /* Xóa max-width để cho phép modal mở rộng hơn */
        text-align: center;
    }

    /* Tăng kích thước font cho tất cả phần tử trong modal */
    .modal-content * {
        font-size: 14px; /* Tăng kích thước font gấp ba */
    }


    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    .modal-buttons {
        margin-top: 20px;
    }

    .btn {
        padding: 10px 20px;
        border: none;
        cursor: pointer;
    }

    .btn-danger {
        background-color: #d9534f;
        color: white;
    }

    .btn-secondary {
        background-color: #6c757d;
        color: white;
    }
     .table-cell {
         padding: 10px 20px; /* Tăng khoảng cách giữa các ô */
         text-align: left; /* Canh lề trái */
     }
    .table-cell:nth-child(3) { /* Tùy chỉnh riêng cho cột Giới Tính */
        text-align: center; /* Canh giữa */
    }
</style>
<%
    List<Manufacturer> manufacturers = (List<Manufacturer>) request.getAttribute("manufacturers");
    List<OrderProductVariant> orderProductVariants = (List<OrderProductVariant>) request.getAttribute("orderProductVariants");
    int totalNumber = (int) request.getAttribute("totalNumber");
    double totalMoney = (double) request.getAttribute("totalPrice");
    Boolean status = (Boolean) session.getAttribute("status");
    String message = (String) session.getAttribute("message");
%>
<body>

<div id="preloader">
    <div class="loader">
    </div>
</div>
<!-- Toast -->
<% if (status != null && status) {%>
<div class="toast">
    <div class="toast-content">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-circle"
             viewBox="0 0 20 20">
            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
            <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05"/>
        </svg>
        <div class="message">
            <span class="text text-1" style="color: greenyellow">Thành công</span>
            <span class="text text-2" style="color: greenyellow"><%=message%></span>
        </div>
    </div>
    <i class="fa-solid fa-xmark close"></i>
    <div class="progress"></div>
</div>
<%} else {%>
<div class="toast">
    <div class="toast-content">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
             class="bi bi-exclamation-circle-fill" viewBox="0 0 20 20">
            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4m.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2"/>
        </svg>
        <div class="message">
            <span class="text text-1 text-danger">Thất bại</span>
            <span class="text text-2 text-danger"><%=message%></span>
        </div>
    </div>
    <i class="fa-solid fa-xmark close"></i>
    <div class="progress"></div>
</div>
<%}%>
<script src="${pageContext.request.contextPath}/resources/js/user/toast.js"></script>
<%if (message != null) {%>
<script>
    showToast();
    setTimeout(() => document.querySelector(".toast").style.display = "none", 5000);
</script>
<%
    session.removeAttribute("message");
    session.removeAttribute("status");
%>
<%}%>
<div class="page-container">
    <%@include file="/common/admin_sidebar.jsp" %>
    <div class="col-md-6 col-sm-8 clearfix">
        <div class="nav-btn pull-left">
            <span></span> <span></span> <span></span>
        </div>
    </div>
    <div class="main-content">
        <!-- header area start -->
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
        <div class="header-area">
            <div class="row align-items-center">
                <!-- nav and search button -->
                <div class="col-md-12 col-sm-12 clearfix">
                    <form method="post" id="formFilter">
                        <div class="row">
                            <label for="filter" style="display: none"></label>
                            <select class="form-control col-md-2" id="filter" name="filter" onchange="showChange()">
                                <option value="date">Ngay thang</option>
                                <option value="manufacturer">Hang san xuat</option>
                            </select>
                            <div class="col-md-2" id="box_start_date" style="display: none">
                                <div class="input-group">
                                    <input type="date" class="form-control" id="datepicker1" name="batdau" value="">
                                </div>
                            </div>
                            <div class="col-md-2" id="box_end_date" style="display: none">
                                <div class="input-group">
                                    <input type="date" class="form-control" id="datepicker2" name="ketthuc" value="">
                                </div>
                            </div>
                            <div class="col-md-2" id="box_manufacturer" style="display: none">
                                <label for="manufacturer" style="display: none"></label>
                                <select class="form-control" id="manufacturer" name="manufacturer">
                                    <%for (Manufacturer manufacturer : manufacturers) {%>
                                    <option value="<%=manufacturer.getId()%>">
                                        <%=manufacturer.getNAME()%>
                                    </option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-primary" onclick="submitFormFilter()">Lọc</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <% OrderProductVariantDAO orderProductVariantDAO = new OrderProductVariantDAO();
        int sumQuantity = orderProductVariantDAO.sumQuantity();
        Double sumTotalPrice = orderProductVariantDAO.sumTotalPrice();%>
        <div class="container">
            <div style=" padding: 20px; text-align: center; font-weight: 900; font-size: 18px;" class="row">
                <div class="col-md-6">
                    TỔNG SỐ LƯỢNG ĐÃ BÁN
                    <div class="text-danger"><%=sumQuantity%> SẢN PHẨM</div>
                </div>
                <div class="col-md-6">
                    TỔNG DOANH THU ĐÃ BÁN
                    <div class="text-danger"><%=Formater.formatCurrency(sumTotalPrice)%></div>
                </div>
            </div>
        </div>
        <div class="single-table" style="width: 95%; margin: 0 auto">

                <table id="example" class="table table-striped table-bordered" style="width: 100%">
                    <thead>
                    <tr>
                        <th scope="col">Mã đơn Hàng</th>
                        <th scope="col">Tên sản phẩm</th>
                        <th scope="col">Màu Sắc</th>
                        <th scope="col">Dung Lượng</th>
                        <th scope="col">Giá sản phẩm</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Ngày Mua</th>
                        <th scope="col">Tổng tiền</th>
                        <th scope="col">Trang thai</th>
                        <th scope="col">Chi Tiết</th>
                    </tr>
                    </thead>
                    <tbody>
<%--                    <% if (orderProductVariants != null) {--%>
<%--                        for (OrderProductVariant o : orderProductVariants) {--%>
<%--                            ProductVariant productVariant = o.getProductVariant();--%>
<%--                            Order order = o.getOrder();--%>
<%--                            InforTransport inforTransport = o.getInforTransport();--%>
<%--                    %>--%>
<% List<OrderProductVariantDB> productVariantDBList = orderProductVariantDAO.orderProductVariantDBList();
    ProductVariantDAO productVariantDAO = new ProductVariantDAO();
    ProductVariant productVariants = new ProductVariant();
    ProductDAO productDAO = new ProductDAO();
for (OrderProductVariantDB productVariant: productVariantDBList) {
    productVariants = productVariantDAO.getColorAndCapacityProductVariantByID(productVariant.getProduct_variant_id());
    if (productVariant.getStatus() < 3) {
        continue;
    }
%>
<input id="idOder" type="hidden" value="<%=productVariant.getOrder_id()%>">
<input id="idTransport" type="hidden" value="<%=productVariant.getTransport_id()%>">
                    <tr>
                        <td id="getId" class="text-center"><%= productVariant.getId() %>
                        </td>

                        <td class="text-center" id="id_product_variant">
                            <%= productVariants.getNameProduct()%>
                        </td>
                        <td class="text-center"><%= productVariants.getNameColor()%>
                        </td>
                        <td class="text-center"><%= productVariants.getNameCapacity()%>
                        </td>
                        <td class="text-center"><%=Formater.formatCurrency(productVariants.getPrice())%>
                        </td>
                        <td class="text-center"><%= productVariant.getQuantity()%>
                        </td>
                        <td class="text-center"><%=productVariant.getBuy_at()%>
                        </td>
                        <td class="text-center"><%=Formater.formatCurrency(productVariant.getTotal_price()) %>
                        <td>
                        <% if (productVariant.getStatus() == 6) {%>
                        Đã Giao Hàng Thành Công
                        <% }%>
                        </td>
                        <td class="text-center" style="display: flex">
                            <button id="idOderProductVariant" class="btn btn-primary" type="button" onclick="showShowReplyModal(<%=productVariant.getId()%>, <%=productVariant.getOrder_id()%>, <%=productVariant.getTransport_id()%>)">
                                Chi Tiết
                            </button>
                        </td>
                        <% } %>
                    </tr>

                    </tbody>
                </table>
            <div id="showReplyModal" class="modal">
                <input type="hidden" id="showReplyCommentId" name="idComment">
                <input type="hidden" id="showReplyProductId" name="idProduct">
                <div class="modal-content" id="modal-content">
                    <span class="close" onclick="closeShowReplyModal()">&times;</span>
                    <p>Trả lời về bình luận</p>
                    <h4 id="replyMessage" class=text-success></h4>
                    <form id="showReplyForm">
                        <table class="table-show">
                            <thead>
                            <tr>
                                <th scope="col-md-2 text-right">Mã đơn hàng</th>
                                <th scope="col-md-2 text-right" >Tên Người Mua</th>
                                <th scope="col-md-2 text-right" >Giới Tính</th>
                                <th scope="col-md-2 text-right">SĐT</th>
                                <th scope="col-md-2 text-right">Địa Chỉ</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">2</th>
                                <td ><textarea id="showRepLyTextArea" style="width: 100%">fasfasfasfasfasfasfasf</textarea></td>
                                <td>Thornton</td>
                                <td></td>
                                <td></td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="modal-buttons">
                            <button type="button" class="btn btn-secondary" onclick="closeShowReplyModal()">Hủy</button>
                        </div>
                    </form>
                </div>
            </div>
            <script>
                new DataTable('#example');
            </script>
            <script>
                function showShowReplyModal(idOderProductVariant, idOder, idTransport) {
                    console.log(idTransport);
                    console.log(idOderProductVariant);
                    console.log(idOder);
                    document.getElementById("idOderProductVariant").value = idOderProductVariant;
                    var modal = document.getElementById("showReplyModal");
                    modal.style.display = "block";
                    getDataRevenue(idOderProductVariant,idOder,idTransport);
                }
                function getDataRevenue(idOrderVariant, idOrder, idTransport) {
                    var url = '/admin/revenue-statistics?action=AccountOder&idOrderVariant=' + idOrderVariant + '&idOrder=' + idOrder + '&idTransport=' + idTransport;
                    fetch(url)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok.');
                            }
                           return response.json();
                        })
                        .then(data => {
                            console.log(data);
                            updateModalContent(data);
                        })
                        .catch(error => console.error('Error fetching replies:', error));
                }
                function updateModalContent(data) {
                    const repliesContainer = document.querySelector('#showReplyForm tbody');
                    repliesContainer.innerHTML = '';

                    const idOrder = data.id || 'N/A';
                    const name = data.firstName + data.lastName || 'Unknown';
                    const gioitinh = data.gioiTinh || 'No content available';
                    var stringGioiTinh = '';
                    if (gioitinh === 1) {
                        stringGioiTinh = 'Nam';
                    }else{
                        stringGioiTinh = 'Nu';
                    }
                    const sdt = data.sdt || 'No timestamp available';
                    const diaChi = data.diachi || 'No address available';
                    let row = '<tr>' +
                        '<th scope="row" class="col-md-2 text-left">' + idOrder + '</th>' +
                        '<td class="col-md-2 text-left">' + name + '</td>' +
                        '<td class="col-md-2 text-left">' + stringGioiTinh + '</td>' +
                        '<td class="col-md-2 text-left">' + sdt + '</td>' +
                        '<td class="col-md-2 text-left">' + diaChi + '</td>' +
                        '</tr>';

                    repliesContainer.innerHTML += row;
                }
                function closeShowReplyModal() {
                    var modal = document.getElementById("showReplyModal");
                    modal.style.display = "none";
                }
                window.onclick = function(event) {
                    var modal = document.getElementById("confirmModal");
                    var replyModal = document.getElementById("replyModal");
                    var showReplyModal = document.getElementById("showReplyModal");
                    if (event.target == modal) {
                        modal.style.display = "none";
                    }
                    if (event.target == replyModal) {
                        replyModal.style.display = "none";
                    }
                    if (event.target == showReplyModal) {
                        showReplyModal.style.display = "none";
                    }
                }
            </script>
            </div>
        </div>
</div>
<%@include file="/common/admin_footer.jsp" %>
<%@include file="/common/admin_library_js.jsp" %>
<script>

    function showChange() {
        var x = document.getElementById("filter").value;
        if (x === "date") {
            showFilterDate();
        } else {
            showFilterManu();
        }
    }

    function showFilterDate() {
        document.getElementById("box_start_date").style.display = "block";
        document.getElementById("box_end_date").style.display = "block";
        document.getElementById("box_manufacturer").style.display = "none";
    }

    function showFilterManu() {
        document.getElementById("box_start_date").style.display = "none";
        document.getElementById("box_end_date").style.display = "none";
        document.getElementById("box_manufacturer").style.display = "block";
    }

    function submitFormFilter() {
        var e = document.getElementById("formFilter");
        e.action = "${pageContext.request.contextPath}/admin/revenue-statistics?action=" + document.getElementById("filter").value;
        e.submit();
    }
</script>
<script src="${pageContext.request.contextPath}/resources/js/user/main.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/admin/slide_show.js"></script>
</body>
</html>