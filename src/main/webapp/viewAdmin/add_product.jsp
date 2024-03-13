<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="config.Formater" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="config.URLConfig" %>
<%@ page import="java.awt.*" %>
<%@ page import="model.Color" %>
<%@include file="/common/taglib.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-29
  Time: 3:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!doctype html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Thêm sản phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/common/admin_library_css.jsp" %>
    <link href="${pageContext.request.contextPath}/resources/css/user/main.css" rel="stylesheet" media="all">
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
    Product product = session.getAttribute("product") == null ? null : (Product) session.getAttribute("product");
    List<Manufacturer> manufacturers = (List<Manufacturer>) request.getAttribute("manufacturers");
    List<Discount> discounts = (List<Discount>) request.getAttribute("discounts");
    List<InfoWarranty> infoWarranties = (List<InfoWarranty>) request.getAttribute("warranties");
    List<Color> colors = (List<Color>) request.getAttribute("colors");
    List<Capacity> capacities = (List<Capacity>) request.getAttribute("capacities");
    List<ProductVariant> productVariants = request.getAttribute("products") == null ? new ArrayList<>() : (List<ProductVariant>) request.getAttribute("products");
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

        <div class="main-content-inner">
            <!-- sales report area start -->
            <div class="form-search">
                <div class="col-12">
                    <div class="mt-5">
                        <div class="card-body">
                            <h4 class="header-title" style="margin-top: 10px">Thông tin chung của sản phẩm</h4>
                            <form method="post" id="formAddProduct"
                                  action="${pageContext.request.contextPath}/admin/product/add_product?action=addParentProduct"
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
                                    </div>
                                    <%--Ten san pham--%>
                                    <div class="col-md-8 mb-3">
                                        <label for="tensp-text">Tên sản phẩm</label>
                                        <input style="width: 100%;" type="text" name="tensp-text" id="tensp-text"
                                               class="form-control">
                                    </div>
                                    <%-- Con lai--%>
                                    <div class="col-md-6 mb-3">
                                        <label for="remain_quantity">Còn lại</label>
                                        <input class="form-control" style="width: 100%" type="number"
                                               name="remain_quantity"
                                               id="remain_quantity">
                                    </div>
                                    <%--Da ban--%>
                                    <div class="col-md-6 mb-3">
                                        <label for="sell_quantity">Đã bán</label>
                                        <input class="form-control" style="width: 100%" type="number"
                                               name="sell_quantity"
                                               id="sell_quantity">
                                    </div>
                                    <%--Chinh sach giam gia--%>
                                    <div class="col-md-6 mb-3">
                                        <label for="discount">Giảm Giá</label>
                                        <select class="form-control" name="discount" id="discount">
                                            <%
                                                for (Discount discount : discounts) {
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
                                    <%--Chinh sach bao hanh--%>
                                    <div class="col-md-6 mb-3">
                                        <label for="warranty">Gói Bảo Hành</label>
                                        <select class="form-control" name="warranty" id="warranty">
                                            <%for (InfoWarranty infoWarranty : infoWarranties) {%>
                                            <option value="<%=infoWarranty.getId()%>">
                                                Hình thức bảo hành:<%=infoWarranty.getTerm_waranty()%>
                                                ,Thời gian bảo hành:<%=infoWarranty.getTime_warranty()%>
                                                ,Địa chỉ bảo hành:<%=infoWarranty.getAddress_warranty()%>
                                            </option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <%--Anh dai dien--%>
                                    <div class="col-md-3 mb-3">
                                        <label for="productAvatar">Ảnh đại diện</label>
                                        <input type="file" class="form-control" name="productAvatar"
                                               id="productAvatar"/>
                                    </div>
                                    <div class="col-md-9 mb-3">
<%--                                        <%if(product != null){%>--%>
<%--                                            <img src="<%=URLConfig.FULL_URL_SAVE_IMAGE%><%=product.getThumbnailURL()%>" width="100px" height="100px">--%>
<%--                                        <%}%>--%>
                                    </div>
                                    <%--Mo ta--%>
                                    <div class="col-md-7 mb-3">
                                        <label for="description">Mô Tả</label>
                                        <textarea class="form-control" style="width: 100%;height: 95%" type="text"
                                                  id="description" name="description">
                                    </textarea>
                                    </div>
                                    <%--THong so ki thuat--%>
                                    <div class="col-md-5 mb-3" style="padding-left: 10px">
                                        <label>Thông số kĩ thuật</label><br>
                                        <div>
                                            <table class="my-table" style="width: 100%">
                                                <tr>
                                                    <td>Bluetooth</td>
                                                    <td>
                                                        <input name="bluetooth" id="bluetooth"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Camera trước</td>
                                                    <td>
                                                        <input name="bcamera" id="bcamera"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Camera sau</td>
                                                    <td>
                                                        <input name="acamera" id="acamera"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Dung lượng pin</td>
                                                    <td>
                                                        <input name="battery" id="battery"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Thẻ nhớ</td>
                                                    <td>
                                                        <input name="memory" id="memory"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Chipset</td>
                                                    <td>
                                                        <input name="chipset" id="chipset"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Tốc độ CPU</td>
                                                    <td>
                                                        <input name="cpu_speed" id="cpu"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Kích thước</td>
                                                    <td>
                                                        <input name="dimensions" id="dimensions"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Loại màn hình</td>
                                                    <td>
                                                        <input name="screen_type" id="screen_type"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Cổng sạc</td>
                                                    <td>
                                                        <input name="charging_port" id="charging_port"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>RAM</td>
                                                    <td>
                                                        <input name="ram" id="ram"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>ROM</td>
                                                    <td>
                                                        <input name="rom" id="rom"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Thẻ sim</td>
                                                    <td>
                                                        <input name="sim" id="sim"/>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="col-md-12 mb-3 text-left">
                                        <label for="price">Giá</label>
                                        <input class="form-control" style="width: 100%" type="number"
                                               name="price"
                                               id="price">
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
                            <%
                                if (product != null) {
                                    Manufacturer manufacturer = product.getManufacturer();
                                    InfoWarranty infoWarranty = product.getInfoWarranty();
                                    Specification specification = product.getSpecification();
                            %>
                            <script>
                                document.getElementById("manufacturer").value = <%=manufacturer.getId()%>;
                                document.getElementById("warranty").value = <%=infoWarranty.getId()%>;
                                document.getElementById("tensp-text").value = <%=product.getName()%>;
                                document.getElementById("remain_quantity").innerHTML = <%=product.getRemaningQuantity()%>;
                                document.getElementById("sell_quantity").value = <%=product.getSellQuantity()%>;
                                document.getElementById("description").value = <%=product.getDescription()%>;
                                document.getElementById("price").value = <%=product.getPrice()%>;
                                document.getElementById("bluetooth").value = "<%=specification.getBluetooth()%>";
                                document.getElementById("bcamera").value = "<%=specification.getCamera_before()%>";
                                document.getElementById("acamera").value = "<%=specification.getCamera_after()%>";
                                document.getElementById("battery").value = "<%=specification.getBattery_capacity()%>";
                                document.getElementById("memory").value = <%=specification.getCart_slot()%>;
                                document.getElementById("chipset").value = "<%=specification.getChip_set()%>";
                                document.getElementById("cpu").value = "<%=specification.getCpu_speed()%>";
                                document.getElementById("dimensions").value = "<%=specification.getDimensions()%>";
                                document.getElementById("screen_type").value = "<%=specification.getDisplay_type()%>";
                                document.getElementById("charging_port").value = "<%=specification.getPort_sac()%>";
                                document.getElementById("ram").value = "<%=specification.getRam()%>";
                                document.getElementById("rom").value = "<%=specification.getRom()%>";
                                <%--document.getElementById("sim").value = "<%=specification.getThe_sim()%>";--%>
<%--                                &lt;%&ndash;$('#sim').val(<%=specification.getThe_sim()%>);&ndash;%&gt;--%>
<%--                                selectElement('manufacturer', <%=manufacturer.getId()%>);--%>
<%--                                selectElement('warranty', <%=infoWarranty.getId()%>);--%>
<%--                                selectElement('tensp-text', <%=product.getName()%>);--%>
                            </script>
                            <%}%>
                            <%if (product != null) {%>
                            <div id="card-container">
                                <%for (ProductVariant productVariant : productVariants) {%>
                                <div class="row mb-1 mt-4" style="pointer-events: none;opacity: 0.4">
                                    <div class="col-md-1">
                                        <label for="color"> Màu Sắc </label>
                                        <select name="color" class="form-control">
                                            <option>
                                                <%=productVariant.getColor().getName()%>
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="capacityId">Dung Lượng</label>
                                        <select name="capacityId" class="form-control">
                                            <option>
                                                <%=productVariant.getCapacity().getName()%>
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-1">
                                        <label for="priceVariant"> Giá Tiền</label>
                                        <input name="priceVariant"
                                               class="form-control" placeholder="Giá Tiền"
                                               value="<%=Formater.formatCurrency(productVariant.getPrice())%>"/>
                                    </div>
                                    <div class="col-md-1">
                                        <p>Ảnh Sản Phẩm</p>
                                        <input type="file" class="form-control"
                                               name="productPictures"
                                               enctype="multipart/form-data" multiple/>
                                    </div>
                                    <div class="col-md-5">
                                        <%for(ProductImage image : productVariant.getProductImages()){%>
                                            <img src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_IMAGE%>/<%=image.getImage_url()%>">
                                        <%}%>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="state"> Trạng Thái </label>
                                        <select name="state" class="form-control">
                                            <%if (productVariant.getState() == 1) {%>
                                            <option value="1">Còn Hàng</option>
                                            <%} else {%>
                                            <option value="0">Hết Hàng</option>
                                            <%}%>
                                        </select>
                                    </div>
                                </div>
                                <%}%>
                                <form method="post"
                                      action="${pageContext.request.contextPath}/admin/product/add_product?action=addChildProduct&productId=<%=product.getId()%>" enctype="multipart/form-data">
                                    <div class="row mb-1 mt-4">
                                        <div class="col-md-1">
                                            <label for="color"> Màu Sắc </label>
                                            <select name="color" id="color" class="form-control">
                                                <%for (Color color : colors) {%>
                                                <option value="<%=color.getId()%>">
                                                    <%=color.getName()%>
                                                </option>
                                                <%}%>
                                            </select>
                                        </div>
                                        <div class="col-md-1">
                                            <label for="capacityId">Dung Lượng</label>
                                            <select name="capacityId" id="capacityId" class="form-control">
                                                <%for (Capacity capacity : capacities) {%>
                                                <option value="<%=capacity.getId()%>">
                                                    <%=capacity.getName()%>
                                                </option>
                                                <%}%>
                                            </select>
                                        </div>
                                        <div class="col-md-1">
                                            <label for="priceVariant"> Giá Tiền</label>
                                            <input type="number" name="priceVariant" id="priceVariant"
                                                   class="form-control" placeholder="Giá Tiền"/>
                                        </div>
                                        <div class="col-md-7">
                                            <p>Ảnh Sản Phẩm</p>
                                            <input type="file" class="form-control"
                                                   name="productPictures" id="productPictures"
                                                   multiple/>
                                        </div>
                                        <div class="col-md-1">
                                            <label for="state"> Trạng Thái </label>
                                            <select name="state" id="state" class="form-control">
                                                <option value="1">Còn Hàng</option>
                                                <option value="0">Hết Hàng</option>
                                            </select>
                                        </div>
                                        <div class="col-md-1   d-flex align-items-end">
                                            <button id="btn-add" type="submit" class="btn btn-success">Thêm</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <%} else {%>
                            <div class="row mb-1 mt-4" style="pointer-events: none;opacity: 0.4">
                                <div class="col-md-1">
                                    <label for="color"> Màu Sắc </label>
                                    <select name="color" class="form-control">
                                        <%for (Color color : colors) {%>
                                        <option value="<%=color.getId()%>">
                                            <%=color.getName()%>
                                        </option>
                                        <%}%>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label for="capacityId">Dung Lượng</label>
                                    <select name="capacityId" class="form-control">
                                        <%for (Capacity capacity : capacities) {%>
                                        <option value="<%=capacity.getId()%>">
                                            <%=capacity.getName()%>
                                        </option>
                                        <%}%>
                                    </select>
                                </div>
                                <div class="col-md-1">
                                    <label for="priceVariant"> Giá Tiền</label>
                                    <input type="number" name="priceVariant"
                                           class="form-control" placeholder="Giá Tiền"/>
                                </div>
                                <div class="col-md-5">
                                    <p>Ảnh Sản Phẩm</p>
                                    <input type="file" class="form-control"
                                           name="productPictures"
                                           multiple="multiple"/>
                                </div>
                                <div class="col-md-2">
                                    <label for="state"> Trạng Thái </label>
                                    <select name="state" class="form-control">
                                        <option value="1">Còn Hàng</option>
                                        <option value="0">Hết Hàng</option>
                                    </select>
                                </div>

                                <div class="col-md-1 d-flex align-items-end">
                                    <button type="button" class="btn btn-success">Thêm</button>
                                </div>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="/common/admin_footer.jsp" %>
</div>
<%@include file="/common/admin_library_js.jsp" %>
<script>
    function selectElement(id, valueToSelect) {
        let element = document.getElementById(id);
        element.value = valueToSelect;
    }
</script>
</body>
</html>
