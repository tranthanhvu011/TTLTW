<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="config.Formater" %>
<%@ page import="config.URLConfig" %>
<%@ page import="dao.ProductDAO" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-20
  Time: 3:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Website bán hàng đơn giản</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/trangchu.css"/>
    <%--        <%@include file="/common/libraries.jsp" %>--%>
    <link href="${pageContext.request.contextPath}/resources/css/user/toast.css" rel="stylesheet" media="all">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/libs/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/libs/font-awesome/css/font-awesome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/mainheader.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/responsive.css">
    <script src="${pageContext.request.contextPath}/resources/libs/jquery-3.4.1.min.js"></script>
</head>
<style>
    body {
        background-color: #F5F5FA;
    }

    * {
        font-size: 14px;
        font-family: Inter, Helvetica, Arial, sans-serif;
    }
    .pagination {
        display: flex;
        justify-content: center;
        padding: 1rem 0;
    }

    .page-item {
        margin: 0 0.25rem;
    }

    .page-item .page-link {
        color: #007bff;
        border-radius: 0.25rem;
        padding: 0.5rem 0.75rem;
        text-decoration: none;
    }

    .page-item.active .page-link {
        background-color: #007bff;
        color: white;
        border-color: #007bff;
    }

    .page-item.disabled .page-link {
        color: #6c757d;
        pointer-events: none;
        cursor: not-allowed;
        background-color: #e9ecef;
        border-color: #dee2e6;
    }

</style>
<%
    Boolean status = (Boolean) session.getAttribute("status");
    String message = (String) session.getAttribute("message");
%>
<body>
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
<%@include file="/common/header.jsp" %>
<div id="content">
    <div class="container">
        <div class="slider">
            <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/assets/images/banner-01.png" alt="First slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/assets/images/baner-02.png" alt="Second slide">
                    </div>
                </div>
                <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="container-Img">
            <div class="row">
                <div class="col-1">
                    <img style="background-color: white;"
                         src="${pageContext.request.contextPath}/resources/assets/images/company/Apple.png"
                         alt="Image 1" class="img-Company" data-id="1"/>

                </div>
                <div class="col-1">
                    <img src="${pageContext.request.contextPath}/resources/assets/images/company/Coolpad.png"
                         alt="Image 2" class="img-Company" data-id="8"/>

                </div>
                <div class="col-1">
                    <img src="${pageContext.request.contextPath}/resources/assets/images/company/HTC.jpg"
                         alt="Image 3" class="img-Company" data-id="8"/>

                </div>
                <div class="col-1">
                    <img src="${pageContext.request.contextPath}/resources/assets/images/company/Huawei.jpg"
                         alt="Image 4" class="img-Company" data-id="3"/>

                </div>
                <div class="col-1">
                    <img src="${pageContext.request.contextPath}/resources/assets/images/company/Itel.jpg"
                         alt="Image 5" class="img-Company" data-id="16"/>

                </div>
                <div class="col-1">
                    <img src="${pageContext.request.contextPath}/resources/assets/images/company/Mobell.jpg"
                         alt="Image 6" class="img-Company" data-id="8"/>

                </div>
                <div class="w-100"></div> <!-- Kết thúc hàng và bắt đầu hàng mới -->
                <br>
                <div class="col-1">
                    <img src="${pageContext.request.contextPath}/resources/assets/images/company/Mobiistar.jpg"
                         alt="Image 7" class="img-Company" data-id="8"/>

                </div>
                <div class="col-1">
                    <img src="${pageContext.request.contextPath}/resources/assets/images/company/Motorola.jpg"
                         alt="Image 8" class="img-Company" data-id="8"/>

                </div>
                <div class="col-1">
                    <img src="${pageContext.request.contextPath}/resources/assets/images/company/Nokia.jpg"
                         alt="Image 9" class="img-Company" data-id="8">
                </div>
                <div class="col-1">
                    <img src="${pageContext.request.contextPath}/resources/assets/images/company/Oppo.jpg"
                         alt="Image 10" class="img-Company" data-id="4">
                </div>
                <div class="col-1">
                    <img src="${pageContext.request.contextPath}/resources/assets/images/company/Philips.jpg"
                         alt="Image 11" class="img-Company" data-id="8">
                </div>
                <div class="col-1">
                    <img src="${pageContext.request.contextPath}/resources/assets/images/company/Realme.png"
                         alt="Image 12" class="img-Company" data-id="9">
                </div>
            </div>
        </div>
    </div>
    <% List<Product> products = (List<Product>) request.getAttribute("products");%>
 <script>
     $(document).ready(function ($) {
         var soSanPhamTrenTrang = 16;
         var trangHienTai = 1;
         var pagination = $('#pagination');

         function updatePagination(tongSanPham) {
             var tongSoTrang = Math.ceil(tongSanPham / soSanPhamTrenTrang);
             pagination.find('.pagination').empty(); // Clear existing pagination

             if (tongSoTrang > 1) {
                 var html = '';

                 html += '<li class="page-item ' + (trangHienTai === 1 ? 'disabled' : '') + '">';
                 html += '<a class="page-link trang-truoc" href="#" aria-label="Previous">';
                 html += '<span aria-hidden="true">&laquo;</span>';
                 html += '<span class="sr-only">Previous</span>';
                 html += '</a></li>';

                 for (let i = 1; i <= tongSoTrang; i++) {
                     html += '<li class="page-item ' + (i === trangHienTai ? 'active' : '') + '">';
                     html += '<a class="page-link chon-trang" data-page="' + i + '" href="#">' + i + '</a>';
                     html += '</li>';
                 }

                 html += '<li class="page-item ' + (trangHienTai === tongSoTrang ? 'disabled' : '') + '">';
                 html += '<a class="page-link trang-sau" href="#" aria-label="Next">';
                 html += '<span aria-hidden="true">&raquo;</span>';
                 html += '<span class="sr-only">Next</span>';
                 html += '</a></li>';

                 pagination.find('.pagination').html(html);
                 pagination.show();
             } else {
                 pagination.hide();
             }
         }
         function hienThiSoSanPhamTrenTrang() {
             var startIndex = (trangHienTai - 1) * soSanPhamTrenTrang;
             var endIndex = startIndex + soSanPhamTrenTrang;
             $('#product-container .item-product').hide().slice(startIndex, endIndex).show();
         }
         function handleSearch(data) {
             var s = '';
             $.each(data, function (i, item) {
                 s += buildProductHTML(item);
             });
             $('#product-container').html(s);
             updatePagination(data.length);
             hienThiSoSanPhamTrenTrang();
         }


         function buildProductHTML(item) {
             var s = '';
             s += '<div class="col-xs-12 col-md-3 col-lg-3 col-sm-6">';
             s += '<div class="item-product" style="background-color: white; padding: 5px; border-radius: 7px">';
             s += '<div class="thumb">';
             s += '<a href="${pageContext.request.contextPath}/product-detail?id=' + item.id + '">';
             s += '<img src="${pageContext.request.contextPath}/resources/assets/images/thumball/' + item.thumbnailURL + '" alt=""></a>';
             s += '<div class="action">';
             s += '<a href="${pageContext.request.contextPath}/payment" class="buy"><i class="fa fa-cart-plus"></i> Mua ngay</a>';
             s += '<a href="${pageContext.request.contextPath}/cart" class="like black_14_400"><i class="fa fa-heart"></i> Yêu thích</a>';
             s += '<div class="clear"></div>';
             s += '</div>';
             s += '</div>';
             s += '<div class="info-product">';
             s += '<h4><a>' + item.name + '</a></h4>';
             s += '<h6> Số Lượng Đã Bán: ' + item.sellQuantity + '</h6>';
             s += '<div class="price">';
             s += '<span class="price-current">' + item.priceNew + '&#x20AB;</span>';
             if (item.priceNew != item.price) {
                 s += '<span class="price-old">' + item.price + '&#x20AB;</span>';
             }
             s += '</div>'; // Close price
             s += '<a href="${pageContext.request.contextPath}/product-detail?id=' + item.id + '" class="view-more">Xem chi tiết</a>';
             s += '</div>';
             s += '</div>';
             s += '</div>';
             return s;
         }


         $(document).on('click', '.page-link', function (e) {
             e.preventDefault();
             var $this = $(this);
             var newPage = parseInt($this.data('page'));

             if ($this.hasClass('trang-truoc')) {
                 newPage = Math.max(1, trangHienTai - 1);
             } else if ($this.hasClass('trang-sau')) {
                 var maxPage = Math.ceil($('#product-container .item-product').length / soSanPhamTrenTrang);
                 newPage = Math.min(maxPage, trangHienTai + 1);
             }

             if (newPage !== trangHienTai) {
                 trangHienTai = newPage;
                 updatePagination($('#product-container .item-product').length);
                 hienThiSoSanPhamTrenTrang();
                 $('html, body').animate({ scrollTop: $('#product-container').offset().top }, '600'); // Scroll to the top of the product container

             }
         });
         var dataAll = $('#product-container .item-product').length;
         updatePagination(dataAll);
         hienThiSoSanPhamTrenTrang();
         $('input[name="price"], input[name="brand"], .img-Company').click(function () {
             var value = $(this).val() || $(this).attr('data-id');
             var url = $(this).hasClass('img-Company') ? 'searchByBrand' : ($(this).attr('name') === 'price' ? 'searchByPrice' : 'searchByBrand');
             trangHienTai = 1;
             $.ajax({
                 type: 'GET',
                 url: url,
                 data: { value: value },
                 success: function (data) {
                     handleSearch(data);
                     $('html, body').animate({ scrollTop: $('#product-container').offset().top }, '600'); // Scroll to the top of the product container

                 }
             });
         });

         $('.bar-menu').click(function (event) {
             $(this).next('.list-child').slideToggle(300);
         });
     });

 </script>

    <div class="product-box">
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-2 order-lg-0 order-1">
                    <div class="sidebar" style="background-color: white;padding: 7px;border-radius: 5px">
                        <div class="category-box">
                            <h3>Hãng sản xuất</h3>
                            <div class="filter-by-hangsx row">
                                <div class="col-lg-12 col-md-12">
                                    <div class="apple">
                                        <input type="radio" name="brand" value="-1">
                                        <label>Tất cả</label>
                                    </div>
                                    <div class="apple">
                                        <input type="radio" name="brand" value="1">
                                        <label>Apple</label>
                                    </div>
                                    <div class="apple">
                                        <input type="radio" name="brand" value="2">
                                        <label>Samsung</label>
                                    </div>
                                    <div class="apple">
                                        <input type="radio" name="brand" value="4">
                                        <label>Oppo</label>
                                    </div>
                                    <div class="apple">
                                        <input type="radio" name="brand" value="6">
                                        <label>Xiaomi</label>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-md-12" name="brand">
                                    <div class="apple">
                                        <input type="radio" name="brand"  value="10">
                                        <label>Honor</label>
                                    </div>
                                    <div class="apple">
                                        <input type="radio" name="brand" value="9">
                                        <label>Realme</label>
                                    </div>
                                    <div class="apple">
                                        <input type="radio" name="brand" value="7">
                                        <label>Vivo</label>
                                    </div>

                                    <div class="apple">
                                        <input type="radio" name="brand" value="3">
                                        <label>Asus</label>
                                    </div>
                                    <div class="apple">
                                        <input type="radio" name="brand" value="8">
                                        <label>Nokia</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr style="border-top: black 1px solid">
                        <div class="category-box">
                            <h3>
                                Mức giá
                            </h3>
                            <div class="filter-by-price">
                                <div class="mucgia">
                                    <input type="radio" name="price" value="1">
                                    <label>Dưới 2 triệu</label>
                                </div>
                                <div class="mucgia">
                                    <input type="radio" name="price" value="2">
                                    <label>Từ 2 - 4 triệu</label>
                                </div>
                                <div class="mucgia">
                                    <input type="radio" name="price" value="3">
                                    <label>Từ 4 - 7 triệu</label>
                                </div>
                                <div class="mucgia">
                                    <input type="radio" name="price" value="4">
                                    <label>Từ 7 - 13 triệu</label>
                                </div>
                                <div class="mucgia">
                                    <input type="radio" name="price" value="5">
                                    <label>Trên 13 triệu</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="widget" style="margin-top: 30px">
                        <h3>
                            <i class="fa fa-bars"></i>
                            Quảng cáo
                        </h3>
                        <div class="content-banner">
                            <a href="#">
                                <img src="${pageContext.request.contextPath}/resources/assets/images/banner.png" alt="">
                            </a>
                        </div>
                    </div>

                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-10 order-lg-1 order-0">
                    <div class="product-section">
                        <h2 class="title-product">
                            <a href="#" class="title">Tất Cả Sản Phẩm / <a href="#" class="title text-danger"> Sản
                                Phẩm Nổi Bật / </a> <a style="color: chocolate;" href="#" class="title "> Giảm Giá
                                Cực Mạnh</a></a>
                            <div class="bar-menu"><i class="fa fa-bars"></i></div>
                            <div class="clear"></div>
                        </h2>
                        <div class="content-product-box">
                            <% ProductDAO productDAO = new ProductDAO();%>
                            <div class="row" id="product-container">
                                <!-- Sản phẩm sẽ được thêm vào đây -->
                                <%for (Product p : products) {%>
                                <% productDAO.updateNewPrice(p.getPriceNew(), p.getId());%>
                                <div class="col-xs-12 col-md-3 col-lg-3 col-sm-6">
                                    <div class="item-product"
                                         style="background-color: white;padding: 5px;border-radius: 7px">
                                        <div class="thumb">
                                            <a href="${pageContext.request.contextPath}/product-detail?id=<%= p.getId() %>">
                                                <img src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_THUMBALL%>/<%=p.getThumbnailURL().trim()%>" alt="">
                                            </a>
                                            <%if (p.getPercentDiscount() != 0) {%>
                                            <span class="sale">Giảm <br><%=p.getPercentDiscount()%>%</span>
                                            <%}%>
                                            <div class="action">
                                                <a href="${pageContext.request.contextPath}/payment" class="buy"><i
                                                        class="fa fa-cart-plus"></i> Mua
                                                    ngay</a>
                                                <a href="${pageContext.request.contextPath}/cart"
                                                   class="like black_14_400"><i
                                                        class="fa fa-heart"></i> Yêu thích</a>
                                                <div class="clear"></div>
                                            </div>
                                        </div>
                                        <div class="info-product">
                                            <h4><a><%=p.getName()%>
                                            </a></h4>
                                            <h6> Số Lượng Đã Bán: <%=p.getSellQuantity()%>
                                            </h6>
                                            <div class="price">
                                                <span class="price-current"><%=Formater.formatCurrency(p.getPriceNew())%>&#x20AB;</span>
                                                <%if (!(p.getPriceNew() == p.getPrice())) {%>
                                                <span class="price-old"><%=Formater.formatCurrency(p.getPrice())%>&#x20AB;</span>
                                                <%}%>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/product-detail?id=<%= p.getId() %>"
                                               class="view-more">Xem chi tiết</a>
                                        </div>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                            <div id="pagination" class="mb-3">
                                <!-- Các nút phân trang sẽ được thêm vào đây -->
                                <nav aria-label="Page navigation">
                                    <ul class="pagination">
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="fb-root"></div>
<%@include file="/common/footer.jsp" %>
<script async defer crossorigin="anonymous"
        src="https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v6.0"></script>
<%@include file="/common/libraries_js.jsp" %>
</body>
</html>
