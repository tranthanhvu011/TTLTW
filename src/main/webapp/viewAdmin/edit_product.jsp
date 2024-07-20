<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="config.Formater" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="config.URLConfig" %>
<%@ page import="model.Color" %>
<%@include file="/common/taglib.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-12-24
  Time: 1:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Sửa sản phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/common/admin_library_css.jsp" %>
    <link href="${pageContext.request.contextPath}/resources/css/admin/model.css" rel="stylesheet" media="all">
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

    .my-table {
        border-collapse: collapse; /* Gộp cạnh của các ô */
        border: none; /* Xóa viền cho toàn bộ bảng */
    }

    .my-table td, .my-table th {
        border: none; /* Xóa viền cho các ô cụ thể */
    }
</style>
<body>
<%
    String message = (String) session.getAttribute("message");
    Boolean status = (Boolean) session.getAttribute("status");
    Product product = request.getAttribute("product") == null ? null : (Product) request.getAttribute("product");
    if (product != null) {
        System.out.println(product.toString());
    }
    List<Manufacturer> manufacturers = (List<Manufacturer>) request.getAttribute("manufacturers");
    List<Discount> discounts = (List<Discount>) request.getAttribute("discounts");
    List<InfoWarranty> infoWarranties = (List<InfoWarranty>) request.getAttribute("warranties");
    List<Color> colors = (List<Color>) request.getAttribute("colors");
    List<Capacity> capacities = (List<Capacity>) request.getAttribute("capacities");
    List<ProductVariant> productVariants = request.getAttribute("productVariants") == null ? new ArrayList<>() : (List<ProductVariant>) request.getAttribute("productVariants");
%>
<div id="preloader">
    <div class="loader">
    </div>
</div>
<% if (status != null && status) {%>
<div class="toast">
    <div class="toast-content">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-circle"
             viewBox="0 0 20 20">
            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"></path>
            <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05"></path>
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
            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4m.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2"></path>
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
                            <li><a href="${pageContext.request.contextPath}/admin">Home</a></li>
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
        <!-- page title area end -->
        <div class="main-content-inner">
            <!-- sales report area start -->
            <div class="form-search">
                <div class="col-12">
                    <div class="mt-5">
                        <div class="card-body">
                            <h4 class="header-title" style="margin-top: 10px">Thông tin chung của sản phẩm</h4>
                            <form method="post" id="formAddProduct"
                                  action="${pageContext.request.contextPath}/admin/product/edit_product?action=editParentProduct"
                                  enctype="multipart/form-data">
                                <div class="form-row">
                                    <%--Hang san xuat--%>
                                    <div class="col-md-4 mb-3">
                                        <label for="manufacturer">Hãng sản xuất</label>
                                        <select class="form-control" name="manufacturer" id="manufacturer">
                                            <%for (Manufacturer manufacturer : manufacturers) {%>
                                            <option value="<%=manufacturer.getId()%>">
                                                <%=manufacturer.getNAME()%>
                                            </option>
                                            <%}%>
                                        </select>
                                        <script>
                                            document.getElementById('manufacturer').value = <%=product.getManufacturer().getId()%>;
                                        </script>
                                    </div>
                                    <%--Ten san pham--%>
                                    <div class="col-md-8 mb-3">
                                        <label for="tensp-text">Tên sản phẩm</label>
                                        <input style="width: 100%;" type="text" name="tensp-text" id="tensp-text"
                                               class="form-control" value="<%=product.getName()%>">
                                    </div>
                                    <%-- Con lai--%>
                                    <div class="col-md-6 mb-3">
                                        <label for="remain_quantity">Còn lại</label>
                                        <input class="form-control" style="width: 100%" type="number"
                                               name="remain_quantity"
                                               id="remain_quantity"
                                               value="<%=product.getRemaningQuantity()%>">
                                    </div>
                                    <%--Da ban--%>
                                    <div class="col-md-6 mb-3">
                                        <label for="sell_quantity">Đã bán</label>
                                        <input class="form-control" style="width: 100%" type="number"
                                               name="sell_quantity"
                                               id="sell_quantity"
                                               value="<%=product.getSellQuantity()%>">
                                    </div>
                                    <%--Chinh sach giam gia--%>
                                    <div class="col-md-6 mb-3" style="display: flex">
                                        <div>
                                            <label for="discount">CT giam gia</label>
                                            <select class="form-control" name="discount" id="discount">
                                                <%
                                                    for (Discount discount : product.getDiscounts()) {
                                                %>
                                                <option value="<%=discount.getId()%>">
                                                    Name:<%=discount.getName()%>,Code:<%=discount.getCode()%>
                                                    ,Cost:<%=Formater.formatCurrency(discount.getCost())%>
                                                </option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>
                                        <div class="dropdown" style="margin-top: 29px;margin-left: 15px">
                                            <button class="btn btn-secondary dropdown-toggle" type="button"
                                                    id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true"
                                                    aria-expanded="false">
                                                Thêm
                                            </button>
                                            <input type="hidden" name="idDisCount" id="idDisCount" value="0">
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                <%for (Discount discount : discounts) {%>
                                                <button type="button" class="dropdown-item"
                                                        onclick="innerValueForDiscount('Name:<%=discount.getName()%>,Code:<%=discount.getCode()%>,Cost:<%=Formater.formatCurrency(discount.getCost())%>',<%=discount.getId()%>)">
                                                    Name:<%=discount.getName()%>,Code:<%=discount.getCode()%>
                                                    ,Cost:<%=Formater.formatCurrency(discount.getCost())%>
                                                </button>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                    <%--Chinh sach bao hanh--%>
                                    <div class="col-md-6 mb-3">
                                        <label for="warranty">CT bao hanh</label>
                                        <select class="form-control" name="warranty" id="warranty">
                                            <%for (InfoWarranty infoWarranty : infoWarranties) {%>
                                            <option value="<%=infoWarranty.getId()%>">
                                                Hình thức bảo hành:<%=infoWarranty.getTerm_waranty()%>
                                                ,Thời gian bảo hành:<%=infoWarranty.getTime_warranty()%>
                                                ,Địa chỉ bảo hành:<%=infoWarranty.getAddress_warranty()%>
                                            </option>
                                            <%}%>
                                        </select>
                                        <script>
                                            document.getElementById('warranty').value = <%=product.getInfoWarranty().getId()%>;
                                        </script>
                                    </div>
                                    <%--Anh dai dien--%>
                                    <div class="col-md-3 mb-3">
                                        <label for="productAvatar">Ảnh đại diện</label>
                                        <input type="file" class="form-control" name="productAvatar"
                                               id="productAvatar"/>
                                    </div>
                                    <div class="col-md-9 mb-3">
                                        <img src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_THUMBALL%>/<%=product.getThumbnailURL().trim()%>"
                                             width="100px" height="100px">
                                    </div>
                                    <%--Mo ta--%>
                                    <div class="col-md-7 mb-3">
                                        <label for="description">Mô Tả</label>
                                        <textarea class="form-control" style="width: 100%;height: 95%" type="text"
                                                  id="description" name="description">
                                            <%=product.getDescription()%>
                                    </textarea>
                                    </div>
                                    <%--THong so ki thuat--%>
                                    <%
                                        Specification specification = product.getSpecification();
                                    %>
                                    <input value="<%=specification.getId()%>" name="idSpecification" type="hidden"/>
                                    <div class="col-md-5 mb-3" style="padding-left: 10px">
                                        <label>Thông số kĩ thuật</label><br>
                                        <div>
                                            <table class="my-table" style="width: 100%">
                                                <tr>
                                                    <td>Bluetooth</td>
                                                    <td>
                                                        <input name="bluetooth" id="bluetooth"
                                                               value="<%=specification.getBluetooth()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Camera trước</td>
                                                    <td>
                                                        <input name="bcamera" id="bcamera"
                                                               value="<%=specification.getCamera_before()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Camera sau</td>
                                                    <td>
                                                        <input name="acamera" id="acamera"
                                                               value="<%=specification.getCamera_after()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Dung lượng pin</td>
                                                    <td>
                                                        <input name="battery" id="battery"
                                                               value="<%=specification.getBattery_capacity()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Thẻ nhớ</td>
                                                    <td>
                                                        <input name="memory" id="memory"
                                                               value="<%=specification.getCart_slot()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Chipset</td>
                                                    <td>
                                                        <input name="chipset" id="chipset"
                                                               value="<%=specification.getChip_set()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Tốc độ CPU</td>
                                                    <td>
                                                        <input name="cpu_speed" id="cpu"
                                                               value="<%=specification.getCpu_speed()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Kích thước</td>
                                                    <td>
                                                        <input name="dimensions" id="dimensions"
                                                               value="<%=specification.getDimensions()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Loại màn hình</td>
                                                    <td>
                                                        <input name="screen_type" id="screen_type"
                                                               value="<%=specification.getDisplay_type()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Cổng sạc</td>
                                                    <td>
                                                        <input name="charging_port" id="charging_port"
                                                               value="<%=specification.getPort_sac()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>RAM</td>
                                                    <td>
                                                        <input name="ram" id="ram" value="<%=specification.getRam()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>ROM</td>
                                                    <td>
                                                        <input name="rom" id="rom" value="<%=specification.getRom()%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Thẻ sim</td>
                                                    <td>
                                                        <input name="sim" id="sim"
                                                               value="<%=specification.getThe_sim()%>"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-12 mb-3 text-left">
                                        <label for="price">Giá</label>
                                        <input class="form-control" style="width: 100%"
                                               name="price"
                                               id="price"
                                               value="<%=Formater.formatCurrency(product.getPrice())%>">
                                    </div>
                                    <div class="col-md-12 text-left">
                                        <button style="width: 100px;margin-top: 5px;" class="btn btn-primary"
                                                type="submit">
                                            Xác nhận
                                        </button>
                                    </div>
                                </div>
                            </form>
                            <h4 class="header-title" style="margin-top: 15px">Thông tin chi tiết sản phẩm</h4>
                            <div id="card-container">
                                <%for (ProductVariant productVariant : productVariants) {%>
                                <form action="/admin/product/edit_product?action=editSubProduct&id=<%=product.getId()%>&idProductVariant=<%=productVariant.getId()%>"
                                      method="post"
                                      enctype="multipart/form-data">
                                    <div class="row mb-1 mt-4">
                                        <div class="col-md-2">
                                            <label for="color"> Màu Sắc </label>
                                            <select name="color" class="form-control" id="color">
                                                <%for (Color color : colors) {%>
                                                <option value="<%=color.getId()%>">
                                                    <%=color.getName()%>
                                                </option>
                                                <%}%>
                                            </select>
                                            <script>
                                                var color = document.getElementById('color');
                                                color.value =
                                                <%=productVariant.getColor().getId()%>
                                            </script>
                                        </div>
                                        <div class="col-md-2">
                                            <label for="capacityId">Dung Lượng</label>
                                            <select name="capacityId" id="capacityId" class="form-control">
                                                <%for (Capacity capacity : capacities) {%>
                                                <option value="<%=capacity.getId()%>">
                                                    <%=capacity.getName()%>
                                                </option>
                                                <%}%>
                                            </select>
                                            <script>
                                                var capacity = document.getElementById('capacityId');
                                                capacity.value =
                                                <%=productVariant.getCapacity().getId()%>
                                            </script>
                                        </div>
                                        <div class="col-md-2">
                                            <label for="priceVariant"> Giá Tiền</label>
                                            <input name="priceVariant"
                                                   id="priceVariant"
                                                   class="form-control" placeholder="Giá Tiền"
                                                   value="<%=Formater.formatCurrency(productVariant.getPrice())%>"/>
                                        </div>
                                        <div class="col-md-2">
                                            <p style="margin-bottom: 7px">Ảnh Sản Phẩm</p>
                                            <input type="file" class="form-control"
                                                   name="productPictures"
                                                   id = "productPictures"
                                                   enctype="multipart/form-data" multiple/>
                                        </div>
                                        <div class="col-md-2">
                                            <div id="slideshow">
                                                <%for (ProductImage image : productVariant.getProductImages()) {%>
                                                <div class="slide">
                                                    <img src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_IMAGE%>/<%=image.getImage_url().trim()%>"
                                                         alt="">
                                                </div>
                                                <%}%>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            <label for="state"> Trạng Thái </label>
                                            <select name="state" id="state" class="form-control">
                                                <option value="1">Còn Hàng</option>
                                                <option value="0">Hết Hàng</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn btn-primary" type="submit"
                                                style="background-color: lawngreen">
                                            Cập nhật
                                        </button>
                                    </div>
                                </form>
                                <%}%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="/common/admin_footer.jsp" %>
</div>
<%@include file="/common/admin_library_js.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/admin/slide_show.js"></script>
<script>
    function selectElement(id, valueToSelect) {
        var element = document.getElementById(id);
        element.value = valueToSelect;
    }

    function innerValueForDiscount(value, idDiscount) {
        var element = document.getElementById('dropdownMenuButton');
        element.innerHTML = value;
        selectElement('idDisCount', idDiscount)
    }
</script>
</body>
</html>

