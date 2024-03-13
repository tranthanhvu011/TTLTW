<%@ page import="java.util.List" %>
<%@ page import="model.ProductVariant" %>
<%@ page import="config.Formater" %>
<%@ page import="model.Product" %>
<%@ page import="model.ProductImage" %>
<%@ page import="config.URLConfig" %>
<%@include file="/common/taglib.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-29
  Time: 3:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Quản lý sản phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
</style>
<body>
<% List<ProductVariant> productVariants = (List<ProductVariant>) request.getAttribute("productVariants");
    String message = (String) session.getAttribute("message");
    Boolean status = (Boolean) session.getAttribute("status");
    int numberPage = (int) request.getAttribute("numberPage");
    int currentIndex = (int) request.getAttribute("currentIndex");
%>
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
        <div class="page-title-area">
            <div class="row align-items-center">
                <div class="col-sm-6">
                    <div class="breadcrumbs-area clearfix">
                        <h4 class="page-title pull-left">Home</h4>
                        <ul class="breadcrumbs pull-left">
                            <li><a href="${pageContext.request.contextPath}/admin/revenue_statistic">Home</a></li>
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
                                class="dropdown-item" href="${pageContext.request.contextPath}/logout">Log Out</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="main-content-inner">
            <!-- Taskbar -->
            <div class="card-body" style="display: flex; justify-content: space-between">
                <form id="formSearch" method="post">
                    <div style="display: flex; padding-right: 15px">
                        <input type="hidden" id="page" name="page" class="form-control">
                        <input type="text" id="keyword" name="keyword"
                               class="form-control" placeholder="Search"
                               style="margin-right: 5px; height: 35px;">
                        <button type="button" id="btnSearch"
                                class="btn btn-flat btn-outline-secondary mb-3" style="" onclick="onSubmitSearch()">
                            Search
                        </button>
                    </div>
                </form>
                <div>
                    <a class="btn btn-primary" style="background-color: lawngreen"
                       href="${pageContext.request.contextPath}/admin/product/add_product">
                        Thêm sản phẩm
                    </a>
                </div>
            </div>
        </div>
        <!-- Table data -->
        <div class="single-table"
             style="margin: 0px 30px; padding-bottom: 15px">
            <div class="table-responsive">
                <table class="table text-center">
                    <thead class="text-uppercase bg-primary">
                    <tr class="text-white">
                        <th scope="col">ID</th>
                        <th scope="col">Tên Sản Phẩm</th>
                        <th scope="col">Giá</th>
                        <th scope="col">Hãng Sản Xuất</th>
                        <th scope="col">Màu sắc</th>
                        <th scope="col">Trạng thái</th>
                        <th scope="col">Ảnh</th>
                        <th scope="col">Dung lượng</th>
                        <th scope="col">Đã bán</th>
                        <th scope="col">Còn lại</th>
                        <th scope="col">Action</th>

                    </tr>
                    </thead>
                    <tbody>
                    <%for (ProductVariant productVariant : productVariants) {%>
                    <%Product product = productVariant.getProduct();%>
                    <tr>
                        <th scope="row"><%=productVariant.getId()%>
                        </th>
                        <td>
                            <%--                                <fmt:setLocale value="vi_VN" scope="session"/> --%>
                            <%--                                <fmt:formatNumber value="${product.price }" type="currency"/>--%>
                            <%=product.getName()%>
                        </td>
                        <td><%=Formater.formatCurrency(productVariant.getPrice())%>
                        </td>
                        <td><%=product.getManufacturer().getNAME()%>
                        </td>
                        <td><%=productVariant.getColor().getName()%>
                        </td>
                        <%if (productVariant.getState() == 1) {%>
                        <td>
                            Còn hàng
                        </td>
                        <%} else {%>
                        <td>
                            Hết hàng
                        </td>
                        <%}%>
                        <%if (!productVariant.getProductImages().isEmpty()) {%>
                        <td>
                            <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                                <div class="carousel-inner">
                                    <%for (ProductImage image : productVariant.getProductImages()) {%>
                                    <div class="carousel-item active">
                                        <img class="d-block w-100"
                                             src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_IMAGE%>/<%=image.getImage_url().trim()%>"
                                             alt="">
                                    </div>
                                    <%}%>
                                </div>
                                <a class="carousel-control-prev" href="#carouselExampleControls" role="button"
                                   data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next" href="#carouselExampleControls" role="button"
                                   data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                        </td>
                        <%} else {%>
                        <td>
                            <img src="${pageContext.request.contextPath}/resources/assets/images/error.jpg"
                                 width="200" height="200">
                        </td>
                        <%}%>
                        <td><%=productVariant.getCapacity().getName()%>
                        </td>
                        <td><%=product.getSellQuantity()%>
                        </td>
                        <td><%=product.getRemaningQuantity()%>
                        </td>
                        <td><a class="btn btn-primary"
                               href="${pageContext.request.contextPath}/admin/product/edit_product?id=<%=productVariant.getProduct().getId()%>"
                               role="button">Sua</a>
                            <button class="btn btn-danger" role="button"
                                    onclick="openModalDeleteUser(<%=productVariant.getId()%>)">
                                Xoa
                            </button>
                        </td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
            </div>
        </div>


        <!-- Modal to notify delete user -->
        <form id="formDeleteUser" method="post">
            <div id="modalDeleteUser" class="modal" style="margin: auto;width: 300px;display: none;align-items: center">
                <div class="modal-content" style="padding: 20px">
                <span style="color: darkred;font-size: 16px">
                    Bạn có chắc chắn muốn xóa sản phẩm này không?
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


        <!-- Paging -->
        <%if (numberPage > 1) {%>
        <div class="row">
            <div class="col-12 d-flex justify-content-center">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li class="page-item">
                            <button id="previousPage" class="page-link" style="<%=currentIndex == 1 ? "pointer-events: none" : ""%>" onclick="pPage(<%=currentIndex%>)">Previous</button>
                        </li>
                        <%
                            for (int i = 1; i <= numberPage; i++) {
                        %>
                        <li class="page-item"><a class="page-link" style="<%=i == currentIndex ? "background-color: blue; color: black" : ""%>"
                                                 href="${pageContext.request.contextPath}/admin/product/manage_product?index=<%=i%>"><%=i%>
                        </a></li>
                        <%}%>
                        <li class="page-item">
                            <button id="nextPage" class="page-link" style="<%=currentIndex == numberPage ? "pointer-events: none" : ""%>" onclick="nPage(<%=currentIndex%>)">Next</button>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
        <%}%>
    </div>

    <!-- main content area end -->
    <!-- footer area start-->
    <%@include file="/common/admin_footer.jsp" %>
</div>
<script>

    function pPage(currentIndex) {
        if (currentIndex > 1) {
            var link = $('#previousPage');
            link.attr('onclick', 'pPage(' + (currentIndex - 1) + ')');
            link.click();
        }
    }

    function nPage(currentIndex) {
        if (currentIndex < <%=numberPage%>) {
            var link = $('#nextPage');
            link.attr('onclick', 'nPage(' + (currentIndex + 1) + ')');
            link.click();
        }
    }


    function onSubmitSearch() {
        var form = $('#formSearch');
        form.action = "/admin/product/manage_product?action=search&keyword=" + $('#keyword').val();
        form.submit();
    }

    function submitFormDelete() {
        var formDeleteUser = document.getElementById("formDeleteUser");
        formDeleteUser.action = "/admin/product/manage_product?action=delete&id=" + document.getElementById("inputSaveIdUser").value;
        formDeleteUser.submit();
    }


    function openModalDeleteUser(x) {
        modalDeleteUser.style.display = "flex";
        document.getElementById("inputSaveIdUser").value = x;
        // console.log(document.getElementById("inputSaveIdUser").value);
    }

    function openModalDeleteContacts(x) {
        modalDeleteUser.style.display = "flex";
        document.getElementById("inputSaveIdUser").value = x;
        // console.log(document.getElementById("inputSaveIdUser").value);
    }

    function closeModalDeleteUser() {
        modalDeleteUser.style.display = "none";
    }

</script>
<%@include file="/common/admin_library_js.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/user/main.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/admin/slide_show.js"></script>
</body>
</html>

