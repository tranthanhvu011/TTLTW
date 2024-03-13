<%@ page import="java.util.List" %>
<%@ page import="model.OrderProductVariant" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.ProductVariant" %>
<%@ page import="modelDB.ProductVariantDB" %>
<%@ page import="model.Order" %>
<%@ page import="model.InforTransport" %>
<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-29
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%
    List<OrderProductVariant> list = (List<OrderProductVariant>) request.getAttribute("dataOrder");
    if (list == null) list = new ArrayList<>();
    String message = (String) session.getAttribute("message");
    Boolean status = (Boolean) session.getAttribute("status");
    OrderProductVariant orderProductVariant = (OrderProductVariant) request.getAttribute("orderProductVariant");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Quản lý dung lượng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--link den css-->
    <%@include file="/common/admin_library_css.jsp" %>
    <link href="${pageContext.request.contextPath}/resources/css/user/main.css" rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath}/resources/libs/datepicker/css/bootstrap/zebra_datepicker.css"
          rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath}/resources/libs/datepicker/css/bootstrap/zebra_datepicker.min.css"
          rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath}/resources/css/user/toast.css" rel="stylesheet" media="all">
    <%@include file="/common/libraries.jsp" %>

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

    .popup {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: white;
        padding: 20px;
        border: 1px solid #ccc;
        z-index: 9999;
    }

    .popup-content {
        text-align: center;
    }

    /* Style cho nút OK */
    #okBtn {
        padding: 8px 16px;
        margin-top: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
    }
</style>
<body>
<%if (orderProductVariant == null) {%>
<div id="preloader">
    <div class="loader"></div>
</div>
<%}%>

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
                                class="dropdown-item" href="${pageContext.request.contextPath}/login?action=logout">Log
                            Out</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- taskbar -->
        <div class="main-content-inner">
            <div class="card-body" style="display: flex; justify-content: space-between">
                <form id="formSearch" method="post">
                    <div style="display: flex; padding-right: 15px">
                        <input type="hidden" id="page" name="page" class="form-control">
                        <label for="keyword" style="display: none"></label>
                        <input type="text" id="keyword" name="keyword"
                               class="form-control" placeholder="Search"
                               style="margin-right: 5px; height: 35px;">
                        <button type="button" id="btnSearch"
                                class="btn btn-flat btn-outline-secondary mb-3" style="" onclick="onSubmitSearch()">
                            Search
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Table -->
        <div class="single-table"
             style="margin: 0px 30px; padding-bottom: 15px">
            <div class="table-responsive">
                <table class="table text-center">
                    <thead class="text-uppercase bg-primary">
                    <tr class="text-white">
                        <th scope="col">ID</th>
                        <th scope="col">ID Sản phẩm</th>
                        <th scope="col">ID đơn hàng</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Thông tin giao hàng</th>
                        <th scope="col">Ngày mua</th>
                        <th scope="col">Tổng tiền</th>
                        <th scope="col">Trạng thái</th>
                        <th scope="col">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (OrderProductVariant o : list) {
                        ProductVariant productVariant = o.getProductVariant();
                        Order order = o.getOrder();
                        InforTransport inforTransport = o.getInforTransport();
                    %>
                    <form id="formEditStatus" method="post">
                        <tr>
                            <td><%= o.getId() %>
                            </td>
                            <td id="id_product_variant">
                                <%= productVariant.getId()%>
                            </td>
                            <td><%= order.getId()%>
                            </td>
                            <td><%= o.getQuantity()%>
                            </td>
                            <td><%= inforTransport.getId()%>
                            </td>
                            <td><%= o.getBuy_at()%>
                            </td>
                            <td><%= o.getTotal_price()%>
                            </td>
                            <td>
                                <label for="status" style="display: none"></label>
                                <select class="form-control" name="status" id="status">
                                    <option value="0">
                                        Đã hủy
                                    </option>
                                    <option value="1">
                                        Đang chuẩn bị hàng
                                    </option>
                                    <option value="2">
                                        Đang giao hàng
                                    </option>
                                    <option value="3">
                                        Đã giao hàng
                                    </option>
                                </select>
                            </td>
                            <script>
                                document.getElementById('status').value =
                                <%= o.getStatus()%>
                            </script>
                            <td style="display: flex">
                                <button type="button" class="btn btn-danger" style="margin-right: 5px"
                                        onclick="openModalDeleteUser(<%=o.getId()%>)">Xoá
                                </button>
                                <button style="margin-right: 5px" class="btn btn-primary" type="button"
                                        onclick="editStatus(<%=o.getId()%>)">
                                    Cập nhật trạng thái
                                </button>
                                <button class="btn btn-primary" type="button" onclick="showDetail(<%=o.getId()%>)">
                                    Chi tiet
                                </button>
                            </td>
                        </tr>
                    </form>
                    <%}%>
                    </tbody>
                </table>
            </div>
        </div>


        <!-- Modal to notify delete order -->
        <form id="formDeleteUser" method="post">
            <div id="modalDeleteUser" class="modal" style="margin: auto;width: 300px;display: none;align-items: center">
                <div class="modal-content" style="padding: 20px">
                <span style="color: darkred;font-size: 16px">
                    Xoa mau sac se xoa toan bo nhung thong tin su dung mau sac nay, ban co muon xoa?
                </span>
                    <div class="row gutters" style="margin-top: 20px;justify-content: space-between">
                        <button type="button" class="btn btn-secondary" onclick="closeModalDeleteUser()">
                            Hủy
                        </button>
                        <input name="inputSaveIdUser" id="inputSaveIdUser" type="hidden">
                        <button type="submit" class="btn btn-danger" onclick="submitFormDelete()">
                            Xóa
                        </button>
                    </div>
                </div>
            </div>
        </form>


        <!-- Modal show detail order -->
        <%
            if (orderProductVariant != null) {
                ProductVariant productVariant = orderProductVariant.getProductVariant();
                Order order = orderProductVariant.getOrder();
                InforTransport inforTransport = orderProductVariant.getInforTransport();
        %>
        <div class="modal" id="modalRegisterManufacturer" role="dialog" data-backdrop="false"
             aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Them mau sac cho san pham</h5>
                        <button style="font-size: 40px;color: red" type="button"
                                onclick="closeModalRegisterManufacturer()"
                                class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>Chi tiet san pham</p>
                        <p>Ten:<%=productVariant.getProduct().getName()%>
                        </p>
                        <p>Mau:<%=productVariant.getColor().getName()%>
                        </p>
                        <p>Dung luong:<%=productVariant.getCapacity().getName()%>
                        </p>
                        <p>Gia tien:<%=productVariant.getPrice()%>
                        </p>
                        <p>Thonh tin giao hang</p>
                        <p>Hinh thuc giao hang:<%=inforTransport.getName()%>
                        <p>Nguoi nhan:<%=inforTransport.getName_reciver()%>
                        <p>Dia chi:<%=inforTransport.getAddress_reciver()%>
                        <p>So dien thoai:<%=inforTransport.getPhone_reciver()%>

                    </div>
                </div>
            </div>
        </div>
        <%}%>


    </div>
</div>
<!-- Paging -->
<div class="row">
    <div class="col-12 d-flex justify-content-center">
        <div id="paging1"></div>
    </div>
</div>
<script>
    var modalAlterManufacturer = document.getElementById("modalAlterManufacturer");
    var selectedButton = document.getElementById("selectedButton");
    var modalDeleteUser = document.getElementById("modalDeleteUser");
    var modalRegisterManufacturer = document.getElementById("modalRegisterManufacturer");

    function submitAddManufacturer() {
        // let isHaveEr = validateRegister();
        // if (!isHaveEr) {
        var form = document.getElementById("formAddManufacturer");
        form.submit();
        // }
    }

    function editStatus(x) {
        var form = document.getElementById("formEditStatus");
        form.action = "/admin/manage_order?action=editStatus&id=" + x;
        form.submit();
    }

    function showDetail(x) {
        var form = document.getElementById("formEditStatus");
        form.action = "/admin/manage_order?action=showDetail&id=" + x;
        form.submit();
    }

    function onSubmitSearch() {
        var page = document.getElementById('formSearch');
        page.action = '/admin/manage_order?action=search&keyword=' + document.getElementById('keyword').value;
        page.submit();
    }


    function submitFormDelete() {
        var formDeleteUser = document.getElementById("formDeleteUser");
        formDeleteUser.action = "/admin/manage_order?action=delete&id=" + document.getElementById("inputSaveIdUser").value;
        formDeleteUser.submit();
    }


    function openModalDeleteUser(x) {
        modalDeleteUser.style.display = "flex";
        document.getElementById("inputSaveIdUser").value = x;
        console.log(document.getElementById("inputSaveIdUser").value);
    }

    function closeModalDeleteUser() {
        modalDeleteUser.style.display = "none";
    }

    function closeModalRegisterManufacturer() {
        modalRegisterManufacturer.style.display = "none";
    }

</script>
<%@include file="../common/admin_footer.jsp" %>
<%@include file="../common/admin_library_js.jsp" %>
<script src="${pageContext.request.contextPath}/resources/libs/datepicker/zebra_datepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/libs/datepicker/zebra_datepicker.src.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/user/datepicker.js"></script>
</body>
</html>

