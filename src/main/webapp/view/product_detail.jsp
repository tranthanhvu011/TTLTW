<%@page import="java.text.NumberFormat" %>
<%@page import="dao.ColorDAO" %>
<%@page import="dao.ProductVariantDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="model.*" %>
<%@ page import="config.URLConfig" %>
<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-21
  Time: 10:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="/common/taglib.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi tiết sản phẩm</title>
    <link href="${pageContext.request.contextPath}/resources/css/user/main.css" rel="stylesheet" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/product-detail.css">
    <%@include file="/common/libraries.jsp" %>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<style>
    body {
        background-color: #F5F5FA;
    }

    * {
        font-size: 14px;
        font-family: Inter, Helvetica, Arial, sans-serif;
    }
    .article {
        margin: 0 auto; /* Giúp căn giữa phần tử */
        padding: 1rem; /* Đảm bảo không có padding quá lớn */
        width: 100%; /* Đảm bảo chiều rộng phù hợp */
        max-width: 800px; /* Đặt chiều rộng tối đa nếu cần */
    }

    .p {
        margin: 0 0 1rem 0; /* Đảm bảo margin dưới phù hợp */
        padding: 0; /* Đảm bảo không có padding không cần thiết */
    }

</style>
<body>
<%@include file="/common/header.jsp" %>

<div class="container">
    <div class="gutters"
         style=" display: flex;justify-content: space-evenly;margin-top: 30px;margin-bottom: 40px">
        <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12 ">
            <%
                Locale localeVN = new Locale("vi", "VN");

                // Tạo một đối tượng NumberFormat với locale là tiếng Việt
                NumberFormat numberFormatVN = NumberFormat.getNumberInstance(localeVN);

                // Định dạng số

                String productID = request.getParameter("id");

                int productID1 = Integer.parseInt(productID);
                ProductVariantDAO productVariantDAO = new ProductVariantDAO();

                List<ProductVariant> listproduct = (List<ProductVariant>) request.getAttribute("productVariant");
                if (listproduct != null && !listproduct.isEmpty()) {
                    ProductVariant firstVariant = listproduct.get(0); // Assuming you want the first variant's images
                    List<ProductImage> images = firstVariant.getProductImages();
                    if (images != null && !images.isEmpty()) {
                        // Display the first image
                        ProductImage firstImage = images.get(0);
            %>
            <script>
                $(document).ready(function () {
                    var srcMain = $('#image-main').attr('src');
                    $('.img_Order').on('click', function () {
                        var src_order = $(this).attr('src');
                        console.log(src_order);
                        $('#image-main').attr('src', src_order);
                    });
                });
            </script>
            <input type="hidden" id="firstProductVariant" value="<%= listproduct.get(0).getId() %>">
            <div class="image-product border_gr_bg_white" style="padding: 10px" id="productImages">
                <div class="thumbnail" style="border-radius: 10px;border: solid lightgrey 1px;height: 280px">
                    <img src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_IMAGE%>/<%=firstImage.getImage_url().trim()%>"
                         id="image-main"
                         alt="ảnh iphone 15 promax" style="margin: 10px 0 10px 0">
                </div>
                <div class="imageProductOrder">
                    <%
                        // Start from index 1 since the first image is already displayed
                        for (int i = 1; i < images.size(); i++) {
                            ProductImage image = images.get(i);
                    %>
                    <div class="imageOrder">
                        <img class="img_Order"
                             src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_IMAGE%>/<%=image.getImage_url()%>"
                             alt="">
                    </div>
                    <%
                        } // End of image loop
                    %>

                </div>
            </div>
            <%
                    } // End of images check
                } // End of product variants check
            %>
            <div class="border_gr_bg_white danhgia" style="margin-top: 20px; ">
                <p class="black_14_600_none_align">Đánh giá sản phẩm</p>
                <div class="">
                    <div class="soluong-sao">
                        <p class="black_14_400">5</p>
                        <i class="fa-solid fa-star icon-star" style="margin: 3px 3px 0 3px"></i>
                        <div class="progress" style="margin: 3px 5px 0 3px">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 80%"
                                 aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p class="black_14_400">80</p>
                    </div>
                    <div class="soluong-sao">
                        <p class="black_14_400">4</p>
                        <i class="fa-solid fa-star icon-star" style="margin: 3px 3px 0 3px"></i>
                        <div class="progress" style="margin: 3px 5px 0 3px">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 10%"
                                 aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p class="black_14_400">10</p>
                    </div>
                    <div class="soluong-sao">
                        <p class="black_14_400">3</p>
                        <i class="fa-solid fa-star icon-star" style="margin: 3px 3px 0 3px"></i>
                        <div class="progress" style="margin: 3px 5px 0 3px">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 5%"
                                 aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p class="black_14_400">5</p>
                    </div>
                    <div class="soluong-sao">
                        <p class="black_14_400">2</p>
                        <i class="fa-solid fa-star icon-star" style="margin: 3px 3px 0 3px"></i>
                        <div class="progress" style="margin: 3px 5px 0 3px">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 3%"
                                 aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p class="black_14_400">3</p>
                    </div>
                    <div class="soluong-sao">
                        <p class="black_14_400">1</p>
                        <i class="fa-solid fa-star icon-star" style="margin: 3px 3px 0 3px"></i>
                        <div class="progress" style="margin: 3px 5px 0 3px">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 2%"
                                 aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <p class="black_14_400">2</p>
                    </div>
                </div>
            </div>
        </div>
        <% ProductVariant firstVariant = listproduct.get(0);%>
        <div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12" style="">
            <div class="titleproduct border_gr_bg_white" style="padding-bottom: 10px">
                <p style="margin-bottom: 0px" class="black_18_700"><%= firstVariant.getProduct().getName()%>
                </p>
                <div class="danhgia-sao" style="margin-top: 0px">
                    <div class="ratedanhgia ">
                        <p>4.8</p>
                    </div>
                    <div class="star-icon">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                    </div>
                </div>
                <div class="buy-product">
                    <div class="product-price">
                        <p id="price"><%= numberFormatVN.format(firstVariant.getPrice()) %>
                        </p>
                    </div>
                </div>

                <div class="chonmau">
                    <p style="font-size: 15px">Màu sắc:</p>
                    <div class="mau" style="cursor: pointer;">
                        <%
                            ColorDAO colorDAO = new ColorDAO();
                            Map<String, String> colorImageMap = (Map<String, String>) request.getAttribute("colorImageMap");
                            for (Map.Entry<String, String> entry : colorImageMap.entrySet()) {
                                String colorName = entry.getKey();
                                String imageUrl = entry.getValue();

                        %>
                        <div class="hinhanh">
                            <span id="colorID" hidden="hidden"><%= colorDAO.findColorByName(colorName).getId()%></span>
                            <input type="hidden" value="<%= productID1 %>" id="productID">
                            <img style="height: 20px"
                                 src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_IMAGE%>/<%=imageUrl.trim()%>"
                                 alt="<%= colorName %>">
                            <span class="black_14_400" style="font-size: 12px;margin-left: 5px"> <%= colorName %></span>
                        </div>
                        <% } %>
                    </div>
                    <div class="chonDungluong"
                         style="height: 50px; display: flex;align-items:center;justify-content: left">
                        <form style="display: flex;margin-top: 10px;  align-items: center;justify-content: center ">
                            <% List<String> capacities = (List<String>) request.getAttribute("capacities");
                                for (String capa : capacities) {
                            %>
                            <div class="dl 64gb">
                                <input type="radio" id="option1" name="options" value="<%=capa%>">
                                <label for="option1"><%=capa%>
                                </label>
                            </div>
                            <% }%>
                        </form>
                    </div>
                </div>
            </div>
<%--            <script>--%>
<%--                $(document).ready(function() {--%>
<%--                    $("input[name='options']:eq(0)").prop("checked", true);--%>
<%--                    $('.hinhanh:eq(0)').css('border', '3px solid #F3B95F');--%>
<%--                    var colorID = $('.hinhanh:eq(0)').find('#colorID').html();--%>
<%--                    var productID = $('.hinhanh:eq(0)').find('#productID').val();--%>
<%--                    // console.log(colorID + '-' +productID);--%>
<%--                    $('.hinhanh').click(function() {--%>
<%--                        $('.hinhanh').css('border', '');--%>
<%--                        $(this).css('border', '2px solid blue');--%>
<%--                    });--%>

<%--                    $('.hinhanh').on('click', function() {--%>
<%--                        $('#soluong').val('1');--%>
<%--                        var colorID = $(this).find('#colorID').html();--%>
<%--                        var productID = $(this).find('#productID').val();--%>
<%--                        var colorName = $(this).find('img').attr('alt');--%>
<%--                        var colorSrc = $(this).find('img').attr('src');--%>
<%--                        var s = '';--%>
<%--                        $("input[name='options']:eq(0)").prop("checked", true);--%>

<%--                        // console.log(colorID + '-' + productID + '-' + colorSrc);--%>
<%--                        $.ajax({--%>
<%--                            type: 'GET',--%>
<%--                            url: '${pageContext.request.contextPath}/product-detail',--%>
<%--                            data: {--%>
<%--                                action: 'productvariant',--%>
<%--                                productID : productID,--%>
<%--                                colorID : colorID--%>
<%--                            },--%>
<%--                            success: function(data) {--%>
<%--                                var productvariant = data.productVariant;--%>
<%--                                var first = data.first;--%>
<%--                                var last = data.last;--%>
<%--                                const formattedNumber = productvariant.price.toLocaleString('vi-VN');--%>
<%--                                $('#price').html(formattedNumber);--%>
<%--                                $('#price1').html(formattedNumber);--%>
<%--                                $('#currentColor').html(colorName);--%>
<%--                                $('#currentImage').attr('src', colorSrc);--%>
<%--                                s+= ' <div class="thumbnail" style="border-radius: 10px;border: solid lightgrey 1px;height: 280px">';--%>
<%--                                s+= '<img src="${pageContext.request.contextPath}/resources/assets/images/product/' + first.image_url +'" id="image-main"alt="ảnh iphone 15 promax" style="margin: 10px 0 10px 0">';--%>
<%--                                s+= '</div>';--%>
<%--                                s+= '<div class="imageProductOrder">';--%>
<%--                                for (var i = 1; i < last.length; i++) {--%>
<%--                                    s+= '<div class="imageOrder">';--%>
<%--                                    s+= '<img class="img_Order" <img class="img_Order" src="${pageContext.request.contextPath}/resources/assets/images/product/' + last[i].image_url +'" alt="">';--%>
<%--                                    s+= '</div>';--%>
<%--                                }--%>
<%--                                s+= '</div>';--%>
<%--                                $('#productImages').html(s);--%>
<%--                                $('.img_Order').on('click', function () {--%>
<%--                                    var src_order = $(this).attr('src');--%>
<%--                                    console.log(src_order);--%>
<%--                                    $('#image-main').attr('src', src_order);--%>
<%--                                });--%>

<%--                            }--%>

<%--                        });--%>

<%--                    });--%>
<%--                    $('input[name="options"]').change(function(){--%>
<%--                        $('#soluong').val('1');--%>
<%--                        var capacityID = $('input[name="options"]:checked').next('label').html();--%>
<%--                        $.ajax({--%>
<%--                            type: 'GET',--%>
<%--                            url: '${pageContext.request.contextPath}/product-detail',--%>
<%--                            data: {--%>
<%--                                action: 'productvariantcapacity',--%>
<%--                                productID : productID,--%>
<%--                                colorID : colorID,--%>
<%--                                capacityID : capacityID--%>
<%--                            },--%>
<%--                            success: function(data) {--%>
<%--                                const formattedNumber = data.price.toLocaleString('vi-VN');--%>
<%--                                $('#price').html(formattedNumber);--%>
<%--                                $('#price1').html(formattedNumber);--%>

<%--                            }--%>
<%--                        });--%>
<%--                    });--%>

<%--                });--%>

<%--            </script>--%>
            <div class="khuyenmai border_gr_bg_white" style="margin-top: 10px;">
                <p class="khuyenmai-text">Khuyến mãi</p>
                <div class="chitietkhuyemai">
                    <i class="fa-solid fa-circle-check"></i>
                    <p>Khách hàng có thể mua trả góp sản phẩm với lãi suất 0% với thời hạn 6 tháng kể từ khi mua
                        hàng.</p>
                </div>
                <div class="chitietkhuyemai">
                    <i class="fa-solid fa-circle-check"></i>
                    <p>Trong hộp có: Sạc, Tai nghe, Sách hướng dẫn, Cây lấy sim, Ốp lưng</p>
                </div>
                <div class="chitietkhuyemai">
                    <i class="fa-solid fa-circle-check"></i>
                    <p>Bảo hành chính hãng 12 tháng.</p>
                </div>
                <div class="chitietkhuyemai">
                    <i class="fa-solid fa-circle-check"></i>
                    <p>1 đổi 1 trong 1 tháng nếu lỗi, đổi sản phẩm tại nhà trong 1 ngày.</p>
                </div>
            </div>
            <div class="warranty_info border_gr_bg_white" style="padding: 10px;margin-top: 10px">
                <p class="black_14_600_none_align">Thông tin bảo hành</p>
                <div style="display: flex">
                    <p class="black_14_400" style="margin: 0">Thời gian bảo hành</p>
                    <p class="black_14_400"
                       style="margin: 0 0 0 15px"><%=firstVariant.getProduct().getInfoWarranty().getTime_warranty()%>
                    </p>
                </div>
                <hr style="width: 100%;margin: 5px 0 5px 0">
                <div style="display: flex">
                    <p class="black_14_400" style="margin: 0">Hình thức bảo hành</p>
                    <p class="black_14_400"
                       style="margin: 0 0 0 15px"><%=firstVariant.getProduct().getInfoWarranty().getTerm_waranty()%>
                    </p>
                </div>
                <hr style="width: 100%;margin: 5px 0 5px 0">
                <div style="display: flex">
                    <p class="black_14_400" style="margin: 0">Nơi bảo hành</p>
                    <p class="black_14_400"
                       style="margin: 0 0 0 15px"><%=firstVariant.getProduct().getInfoWarranty().getAddress_warranty()%>
                    </p>
                </div>
            </div>
            <div class="thongsokythuat border_gr_bg_white" style="margin-top: 10px">
                <p class="black_14_600_none_align" style="margin-top: 10px;margin-left: 10px;">Thông số kĩ thuật</p>
                <table class="" style="padding-left: 10px;padding-right: 10px;border: none">
                    <tr>
                        <td>Dung lượng pin</td>
                        <td>
                            <%=firstVariant.getProduct().getSpecification().getBattery_capacity()%>
                        </td>
                    </tr>
                    <tr>
                        <td>Bluetooh</td>
                        <td>
                            <%=firstVariant.getProduct().getSpecification().getBluetooth()%>
                        </td>
                    </tr>
                    <tr>
                        <td>Camera Selfie</td>
                        <td><%=firstVariant.getProduct().getSpecification().getCamera_before()%>
                        </td>
                    </tr>
                    <tr>
                        <td>Thương hiệu</td>
                        <td><%=firstVariant.getProduct().getManufacturer().getNAME()%>
                        </td>
                    <tr>
                        <td>Camera sau</td>
                        <td><%=firstVariant.getProduct().getSpecification().getCamera_after()%>
                        </td>
                    </tr>
                    <tr>
                        <td>Camera trước</td>
                        <td><%=firstVariant.getProduct().getSpecification().getCamera_before()%>
                        </td>
                    </tr>
                    <tr>
                        <td>Chip set</td>
                        <td><%=firstVariant.getProduct().getSpecification().getChip_set()%>
                        </td>
                    </tr>
                    <tr>
                        <td>ROM</td>
                        <td><%=firstVariant.getProduct().getSpecification().getRom()%>
                        </td>
                    </tr>

                    <tr>
                        <td>Tốc độ CPU</td>
                        <td><%=firstVariant.getProduct().getSpecification().getCpu_speed()%>
                        </td>
                    </tr>
                    <tr>
                        <td>Loại/ Công nghệ màn hình</td>
                        <td><%=firstVariant.getProduct().getSpecification().getDisplay_type()%>
                        </td>
                    </tr>
                    <tr>
                        <td>Kích thước màn hình</td>
                        <td><%=firstVariant.getProduct().getSpecification().getDimensions()%>
                        </td>
                    </tr>
                    <tr>
                        <td>Hỗ trợ thẻ tối đa</td>
                        <td><%=firstVariant.getProduct().getSpecification().getThe_sim()%>
                        </td>

                    </tr>
                    <tr>
                        <td>Wifi</td>
                        <td>
                            Có
                        </td>
                    </tr>
                    <tr>
                        <td>Sản phẩm có được bảo hành không?</td>
                        <td>
                            Có
                        </td>
                    </tr>

                    <tr>
                        <td>Hình thức bảo hành</td>
                        <td>
                            Điện tử
                        </td>
                    </tr>
                    <tr>
                        <td>Thời gian bảo hành</td>
                        <td><%=firstVariant.getProduct().getInfoWarranty().getTime_warranty()%>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="uudaikhac border_gr_bg_white" style="margin-top: 10px;">
                <p style="font-size: 14px;line-height: 150%;font-weight: 600;margin-left: 10px;padding-top: 10px;">Ưu
                    đãi khác</p>
                <div class="uudaii" style="padding-bottom: 10px;">
                    <span style="margin-left: 10px;font-size: 20px">2 mã giảm giá</span>
                    <div class="magiamgia">
                        <div class="magiam">Giảm 5%</div>
                        <div class="magiam " style="">Giảm 10k</div>
                    </div>
                </div>
            </div>
            <div class="motachitiet border_gr_bg_white" style="padding: 10px;margin-top: 10px;background-color: white">
                <div class="container">
                    <%= firstVariant.getProduct().getDescription()%>
                </div>
            </div>
        </div>
        <div class="contai-right col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12 border_gr_bg_white h-100">
            .
            <div class="hinhanh" style="border: none;height: 150%;">

                <img id="currentImage" style="width: 50px; height: 50px;"
                     src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_IMAGE%>/<%=firstVariant.getProductImages().get(0).getImage_url() %>"
                     alt="">
                <span id="currentColor"
                      style="margin-top: 15%;margin-left: 5px;"> <%= firstVariant.getColor().getName() %></span>
            </div>
            <input type="hidden" id="quantity" value="<%=listproduct.get(0).getProduct().getRemaningQuantity()%>">
            <div class="soluong">
                <p style="margin-top: 10px;font-weight: 500;font-size: 15px">Số lượng:</p>
                <div class="input-group" style="width: 130px">
                    <button class="btn btn-minus actionButton">-</button>
                    <input id="soluong" type="text" class="form-control quantity-input" name="quantity" value="1">
                    <button class="btn btn-plus actionButton">+</button>
                </div>
                <script>

                    $(document).ready(function () {
                        var quantityInput = $('#soluong'); // Lấy giá trị số lượng ban đầu
// Hàm lấy số lượng sau khi thay đổi
                        function getUpdatedQuantity() {
                            return parseInt($('#soluong').val());
                        }

// Sự kiện click nút '+'
                        $('.btn-plus').on('click', function () {

                            var currentValue = parseInt($('#soluong').val());
                            $('#soluong').val(currentValue + 1);
                            quantityInput = getUpdatedQuantity(); // Lấy số lượng sau khi thay đổi
                            console.log($('#price1').text());
                        });

// Sự kiện click nút '-'
                        $('.btn-minus').on('click', function () {
                            var currentValue = parseInt($('#soluong').val());
                            if (currentValue > 1) {
                                $('#soluong').val(currentValue - 1);
                                quantityInput = getUpdatedQuantity(); // Lấy số lượng sau khi thay đổi
                                console.log(quantityInput); // Hiển thị giá trị số lượng trong console
                                // Gọi hàm hoặc thực hiện các công việc khác ở đây sau khi cập nhật số lượng
                                console.log($('#price1').text());
                            }
                        });

                        $('#buynow').attr("href", "${pageContext.request.contextPath}/cart?action=buynow&id=" + $('#firstProductVariant').val());
                        $('#addToCart').attr("href", "${pageContext.request.contextPath}/cart?action=add-cart&id=" + $('#firstProductVariant').val());
                        $("input[name='options']:eq(0)").prop("checked", true);
                        $('.hinhanh:eq(0)').css('border', '2px solid blue');
                        var colorID = $('.hinhanh:eq(0)').find('#colorID').html();
                        var productID = $('.hinhanh:eq(0)').find('#productID').val();
                        console.log(colorID + '-' + productID);
                        $('.hinhanh').click(function () {
                            $('.hinhanh').css('border', '');
                            $(this).css('border', '2px solid blue');
                        });

                        $('.hinhanh').click(function () {
                            $('#soluong').val('1');
                            colorID = $(this).find('#colorID').html();
                            var productID = $(this).find('#productID').val();
                            var colorName = $(this).find('img').attr('alt');
                            var colorSrc = $(this).find('img').attr('src');
                            var s = '';
                            $("input[name='options']:eq(0)").prop("checked", true);

                            console.log(colorID + '-' + productID + '-' + colorSrc);
                            $.ajax({
                                type: 'GET',
                                url: '${pageContext.request.contextPath}/product-detail',
                                data: {
                                    action: 'productvariant',
                                    productID: productID,
                                    colorID: colorID
                                },
                                success: function (data) {
                                    var productvariant = data.productVariant;
                                    console.log(productvariant.id);
                                    $('#buynow').attr("href", "${pageContext.request.contextPath}/cart?action=buynow&id=" + productvariant.id);
                                    $('#addToCart').attr("href", "${pageContext.request.contextPath}/cart?action=add-cart&id=" + productvariant.id);
                                    var first = data.first;
                                    var last = data.last;
                                    const formattedNumber = productvariant.price.toLocaleString('vi-VN');
                                    $('#price').html(formattedNumber);
                                    $('#price1').html(formattedNumber);
                                    $('#currentColor').html(colorName);
                                    $('#currentImage').attr('src', colorSrc);
                                    s += ' <div class="thumbnail" style="border-radius: 10px;border: solid lightgrey 1px;height: 280px">';
                                    s += '<img src="${pageContext.request.contextPath}/resources/assets/images/product/' + first.image_url + '" id="image-main"alt="ảnh iphone 15 promax" style="margin: 10px 0 10px 0">';
                                    s += '</div>';
                                    s += '<div class="imageProductOrder">';
                                    for (var i = 1; i < last.length; i++) {
                                        s += '<div class="imageOrder">';
                                        s += '<img class="img_Order" <img class="img_Order" src="${pageContext.request.contextPath}/resources/assets/images/product/' + last[i].image_url + '" alt="">';
                                        s += '</div>';
                                    }
                                    s += '</div>';
                                    $('#productImages').html(s);


                                }

                            });

                        });
                        $('input[name="options"]').change(function () {
                            quantityInput = $('#soluong').val('1');
                            var capacityID = $('input[name="options"]:checked').next('label').html();
                            console.log(capacityID);
                            $.ajax({
                                type: 'GET',
                                url: '${pageContext.request.contextPath}/product-detail',
                                data: {
                                    action: 'productvariantcapacity',
                                    productID: productID,
                                    colorID: colorID,
                                    capacityID: capacityID.trim()
                                },
                                success: function (data) {
                                    console.log("Số lượng sau khi thay đổi lựa chọn: " + quantityInput);
                                    $('#buynow').attr("href", "${pageContext.request.contextPath}/cart?action=buynow&id=" + data.id);
                                    $('#addToCart').attr("href", "${pageContext.request.contextPath}/cart?action=add-cart&id=" + data.id);
                                    const formattedNumber = data.price.toLocaleString('vi-VN');
                                    $('#price').html(formattedNumber);
                                    $('#price1').html(formattedNumber);

                                }
                            });
                        });
                        $('#addToCart').click(function () {
                            var attrSoluong = $('#addToCart').attr('href');
                            $('#addToCart').attr('href', attrSoluong + '&quantity=' + $('#soluong').val());

                            // console.log(attrSoluong);
                            // console.log($('#addToCart').attr('href'));
                        });
                        $('#buynow').click(function () {
                            var attrMuangay = $('#buynow').attr('href');
                            $('#buynow').attr('href', attrMuangay + '&quantity=' + $('#soluong').val())
                        })
                        $('.btn-plus').on('click', function () {
                            var currentQuantity = parseInt($('#soluong').val());
                            var currentValue = parseFloat($('#price').text());
                            var newPrice = currentQuantity * currentValue;
                            var multipliedValue = newPrice * 1000000;

                            // Kiểm tra giá trị tối thiểu, ví dụ: 500000
                            var minValue = parseFloat("1000000");
                            if (multipliedValue < minValue) {
                                multipliedValue = newPrice * 0.01;
                            }

                            $('#price1').text(multipliedValue.toLocaleString('vi-VN', {
                                style: 'currency',
                                currency: 'VND'
                            }));
                            console.log(multipliedValue.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'}));
                        });

// Sự kiện click nút '-'
                        $('.btn-minus').on('click', function () {
                            var currentQuantity = parseInt($('#soluong').val());
                            var currentValue = parseFloat($('#price').text());
                            console.log("currendVal" + currentValue);
                            var newPrice = currentQuantity * currentValue;
                            var multipliedValue = newPrice * 1000000;

                            // Kiểm tra giá trị tối thiểu, ví dụ: 500000
                            var minValue = parseFloat("1000000");
                            if (multipliedValue < minValue) {
                                multipliedValue = newPrice * 0.01;
                            }

                            $('#price1').text(multipliedValue.toLocaleString('vi-VN', {
                                style: 'currency',
                                currency: 'VND'
                            }));
                            console.log(multipliedValue.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'}));
                        });
                    });
                </script>


            </div>
            <p id="giatamtinh" style="font-size: 20px;font-weight: 500">Tạm tính</p>
            <p id="price1"><%= numberFormatVN.format(firstVariant.getPrice()) %>
            </p>

            <p id="tamtinh" style="font-size: 25px;font-weight: 600"></p>

            <div class="button-buy">
                <a id="buynow" href="#">
                    <button class="muatructiep-btn">
                        <span>Mua ngay</span>
                    </button>
                </a>
                <a href="#" id="addToCart">
                    <button class="themgiohang-btn">
                        <span class="them"><i class="fa-solid fa-cart-shopping"></i><p
                                style=" background-color: transparent;">Thêm vào giỏ hàng</p></span>
                    </button>
                </a>
            </div>
        </div>
    </div>
</div>
<%@include file="/common/footer.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/user/main.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/user/productDetails.js"></script>
<%--<%@include file="/resources/js/user/productDetails.js" %>--%>
<%@include file="/common/libraries_js.jsp" %>
</body>
</html>