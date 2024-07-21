<%@ page import="java.util.List" %>
<%@ page import="model.Discount" %>
<%@ page import="service.NumberUtils" %>
<%@include file="/common/taglib.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2024-01-07
  Time: 10:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Quản lý dung lượng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--link den css-->
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
<%
    List<Discount> discounts = (List<Discount>) request.getAttribute("discounts");
    String message = (String) session.getAttribute("message");
    Boolean status = (Boolean) session.getAttribute("status");
    Discount discountEdit = (Discount) request.getAttribute("discount");
%>
<body>

<%if(discountEdit == null){%>
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
                            NHÓM 41 <i class="fa fa-angle-down"></i>
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

                <div>
                    <button type="button" class="btn btn-primary" style="background-color: lawngreen"
                            data-toggle="modal" data-target="#modalRegisterManufacturer" onclick="openModalRegister()">
                        Thêm Mới
                    </button>
                </div>
        </div>


        <!-- Modal to register -->
        <div class="modal" id="modalRegisterManufacturer" style="display: none" role="dialog" data-backdrop="false"
             aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Them mau sac cho san pham</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="formAddManufacturer" method="post"
                              action="${pageContext.request.contextPath}/admin/manage_discount?action=add">
                            <div class="row row-space">
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="name" class="label">Tên</label>
                                        <input class="input--style-4" type="text" name="name_discount"
                                               id="name">
                                        <span class="error" id="nameEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="cost" class="label">Phí</label>
                                        <input class="input--style-4" type="text" name="cost"
                                               id="cost">
                                        <span class="error" id="costEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="code" class="label">Mã</label>
                                        <input class="input--style-4" type="text" name="code"
                                               id="code">
                                        <span class="error" id="codeEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="is_active" class="label">Trạng thái</label>
                                        <input class="input--style-4" type="text" name="is_active"
                                               id="is_active">
                                        <span class="error" id="isActiveEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="start_at" class="label">Ngày bắt đầu</label>
                                        <input class="input--style-4 js-datepicker" type="text" name="start_at"
                                               id="start_at">
                                        <span class="error" id="startAtEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="end_at" class="label">Ngày kết thúc</label>
                                        <input class="input--style-4 js-datepicker" type="text" name="end_at"
                                               id="end_at">
                                        <span class="error" id="endAtEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" id="onSubmitAdd" name="submit"
                                class="btn btn-primary" onclick="submitAddManufacturer()">
                            Thêm
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dark table start -->
        <div class="single-table" style="width: 95%; margin: 0 auto">
            <table id="example" class="table table-striped table-bordered" style="width: 100%">
                    <thead class="text-uppercase bg-primary">
                    <tr class="text-white">
                        <th scope="col">ID</th>
                        <th scope="col">Phí</th>
                        <th scope="col">Tên</th>
                        <th scope="col">Mã</th>
                        <th scope="col">Trạng thái</th>
                        <th scope="col">Ngày bắt đầu</th>
                        <th scope="col">Ngày kết thúc</th>
                        <th scope="col">HÀNH ĐỘNG</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Discount discount : discounts) {%>
                    <tr>
                        <th scope="row"><%=discount.getId()%>
                        </th>
                        <td><%=NumberUtils.formatNumberWithCommas(discount.getCost())+ "VNĐ"%>
                        </td>
                        <td><%=discount.getName()%>
                        </td>
                        <td><%=discount.getCode()%>
                        </td>
                        <td><%=discount.getIs_active()%>
                        </td>
                        <td><%=discount.getStart_at()%>
                        </td>
                        <td><%=discount.getEnd_at()%>
                        </td>
                        <td>
                            <a href="/admin/manage_discount?action=showEdit&id=<%=discount.getId()%>"
                               class="btn btn-primary">
                                Sửa
                            </a>
                            <button class="btn btn-danger" onclick="openModalDeleteUser(<%=discount.getId()%>)">
                                Xóa
                            </button>
                        </td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
        </div>
        <script>
            new DataTable('#example');
        </script>


        <!-- Modal to alter user -->
        <% if (discountEdit != null) {%>
        <div class="modal" id="modalAlterManufacturer" role="dialog" data-backdrop="false"
             aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModal">Quản lý giảm giá</h5>
                    </div>
                    <div class="modal-body">
                        <form method="post" id="formEditDiscount"
                              action="/admin/manage_discount?id=<%=discountEdit.getId()%>&action=edit">
                            <div class="row row-space">
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="name" class="label">Tên</label>
                                        <input class="input--style-4" type="text" name="name_color"
                                               id="name" value="<%=discountEdit.getName()%>">
                                        <span class="error" id="nameEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="cost" class="label">Phí</label>
                                        <input class="input--style-4" type="text" name="cost"
                                               id="cost" value="<%=discountEdit.getCost()%>">
                                        <span class="error" id="costEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="code" class="label">Mã</label>
                                        <input class="input--style-4" type="text" name="code"
                                               id="code" value="<%=discountEdit.getCode()%>">
                                        <span class="error" id="codeEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="is_active" class="label">Trạng thái</label>
                                        <input class="input--style-4" type="text" name="is_active"
                                               id="is_active" value="<%=discountEdit.getIs_active()%>">
                                        <span class="error" id="isActiveEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row row-space">
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="start_at" class="label">Ngày bắt đầu</label>
                                        <input class="input--style-4 js-datepicker" type="text" name="start_at"
                                               id="start_at" value="<%=discountEdit.getStart_at()%>">
                                        <span class="error" id="startAtEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group">
                                        <label for="end_at" class="label">Ngày kết thúc</label>
                                        <input class="input--style-4 js-datepicker" type="text" name="end_at"
                                               id="end_at" value="<%=discountEdit.getEnd_at()%>">
                                        <span class="error" id="endAtEr"
                                              style="color: red;font-size: 10px"></span>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal"
                                onclick="closeModalAlter()">Đóng
                        </button>
                        <button type="button" name="submit"
                                class="btn btn-primary" onclick="submitAlterDiscount()">
                            Cập nhập
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <%}%>


        <!-- Modal to notify delete user -->
        <form id="formDeleteUser" method="post">
            <div id="modalDeleteUser" class="modal" style="margin: auto;width: 300px;display: none;align-items: center">
                <div class="modal-content" style="padding: 20px">
                <span style="color: darkred;font-size: 16px">
                    Bạn có chắc chắn muốn xóa chương trình giảm giá này không?
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
        <div class="row">
            <div class="col-12 d-flex justify-content-center">
                <div id="paging"></div>
            </div>
        </div>
    </div>
    <%@include file="/common/admin_footer.jsp" %>
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

    function submitAlterDiscount() {
        var form = document.getElementById("formEditDiscount");
        form.submit();
    }

    function onSubmitSearch() {
        var page = document.getElementById('formSearch');
        page.action = '/admin/manage_discount?action=search&keyword=' + document.getElementById('keyword').value;
        page.submit();
    }

    function closeModalAddManufacturer() {
        modalRegisterManufacturer.style.display = "none";
    }


    function openModalRegister() {
        modalRegisterManufacturer.style.display = "flex";
    }


    function submitFormDelete() {
        var formDeleteUser = document.getElementById("formDeleteUser");
        formDeleteUser.action = "/admin/manage_discount?action=delete&id=" + document.getElementById("inputSaveIdUser").value;
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

    function openModalAlter() {
        modalAlterManufacturer.style.display = "block";
    }

    function closeModalAlter() {
        modalAlterManufacturer.style.display = "none";
    }
</script>
<%@include file="/common/admin_library_js.jsp" %>
<%@include file="/common/libraries_js.jsp" %>
<script src="${pageContext.request.contextPath}/resources/libs/datepicker/zebra_datepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/libs/datepicker/zebra_datepicker.src.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/user/datepicker.js"></script>
</body>
</html>
