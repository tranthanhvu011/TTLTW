<%@page import="java.text.NumberFormat" %>
<%@page import="dao.ColorDAO" %>
<%@page import="dao.ProductVariantDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="model.*" %>
<%@ page import="config.URLConfig" %>
<%@ page import="dao.ProductDeltailDAO" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="service.UserService" %>
<%
    List<Rate> rateList = (List<Rate>) request.getAttribute("rates");
    if (rateList == null) rateList = new ArrayList<>();
%>
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
    <link href="${pageContext.request.contextPath}/resources/css/user/main.css" rel="stylesheet" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/product-detail.css">
    <link href="${pageContext.request.contextPath}/resources/css/user/toast.css" rel="stylesheet" media="all">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<%--    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i">--%>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/libs/bootstrap/css/bootstrap.min.css">--%>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/libs/font-awesome/css/font-awesome.css">--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/mainheader.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/user/responsive.css">
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

    #comments{
        background-color: white;
        border-radius: 10px;
    }
    h5{
        background-color: #F5F5FA;
        padding: 10px;
        margin-bottom: 0;
    }
    .comment_avatar{
        border-radius: 50%;
        max-width: 100%;
        height: 50px;
        width: 50px;
        object-fit: cover;
    }
    #comment_textarea{
        width: 100%;
        min-height: 100px;
        border-radius: 10px;
        padding: 5px;
    }
    #comment_submit{
        margin: 5px 0px;
        padding: 3px;
        width: 80px;
    }
    .comment_item{
        padding: 15px;
        border-radius: 10px;
        border: #00000063 solid 1px;
        margin-bottom: 10px;
    }
    .comment_item > p:first-child {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 5px;
    }
    .comment_item > p:first-child a{
        display: flex;
        gap: 20px;
        align-items: center;
        font-weight: bold;
    }
    .hinhanh{
        height: 70px;
        padding: 5px;
        border: 1px solid #989696;
        border-radius: 3px;
        display: flex;
        flex-direction: column;
        margin-right: 5px;
        align-items: center;
        justify-content: center;
        /* align-content: center; */
        flex-wrap: nowrap;
    }
</style>
<%
    Boolean status = (Boolean) session.getAttribute("status");
    if (status == null) {
        status = true;
    }
    String message = (String) session.getAttribute("message");
    if (message  == null) {
    }
%>

<body>
<%@include file="/common/header.jsp" %>
<div class="toast">
    <div class="toast-content">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-circle"
             viewBox="0 0 20 20">
            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
            <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05"/>
        </svg>
        <% if (message != null ) {%>
        <% if (status == true) {%>
        <div class="message">
            <span class="text text-1" style="color: greenyellow">Thành công</span>
            <span class="text text-2" style="color: greenyellow"><%=message%></span>
        </div>
        <% }else{%>
        <div class="message">
            <span class="text text-1 text-danger">Thất bại</span>
            <span class="text text-2 text-danger"><%=message%></span>
        </div>
        <%}%>
        <%    session.removeAttribute("message");
            session.removeAttribute("status");%>
        <% } else{%>
        <div class="message">
            <span class="text text-1" style="color: greenyellow">Thành công</span>
            <span class="text text-2" style="color: greenyellow">Thêm vào giỏ hàng thành công</span>
        </div>
        <% }%>
    </div>
    <i class="fa-solid fa-xmark close"></i>
    <div class="progress"></div>
</div>
<%--<div class="toast">--%>
<%--    <div class="toast-content">--%>
<%--        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"--%>
<%--             class="bi bi-exclamation-circle-fill" viewBox="0 0 20 20">--%>
<%--            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4m.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2"/>--%>
<%--        </svg>--%>
<%--        <div class="message">--%>
<%--            <span class="text text-1 text-danger">Thất bại</span>--%>
<%--            <span class="text text-2 text-danger"><%=message%></span>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <i class="fa-solid fa-xmark close"></i>--%>
<%--    <div class="progress"></div>--%>
<%--</div>--%>
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
<div class="container">
<%--    <% if (session.getAttribute("messages") != null) { %>--%>
<%--    <div class="alert alert-success" role="alert">--%>
<%--        <%= session.getAttribute("messages") %>--%>
<%--    </div>--%>
<%--    <% session.removeAttribute("messages"); %>--%>
<%--    <% } %>--%>

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
            <fmt:setLocale value="${lang}" scope="session" />
            <fmt:bundle basename="messages">
            <div class="border_gr_bg_white danhgia" style="margin-top: 20px; ">
                <p class="black_14_600_none_align"><fmt:message key="ProductReviews"/></p>
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
                <!-- Nút để mở modal -->
                <!-- Button trigger modal -->
                <button style="background-color: #fa7d11; margin-left: 10px; width: 90%;" type="button" class="btn btn-primary" data-toggle="modal" data-target="#modelrate" data-product-id="<%=productID%>">
                    <fmt:message key="Seereviews"/>
                </button>
                </fmt:bundle>

                <!-- Modal -->
                <div class="modal fade" id="modelrate" tabindex="-1" role="dialog"
                     aria-labelledby="modelrateLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content" style="height: 600px; margin-top: 40px;">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modelrateLabel" style="margin-left: 20px;">Đánh giá sản phẩm</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" style="max-height: 600px; overflow: auto">
                                <%
                                    UserDAO userDAO = new UserDAO();
                                    for (Rate rate : rateList) {
                                        Account account = userDAO.getUserById(rate.getAccount_id());
                                %>
                                <div style="border: 1px solid #ddd; background-color: #f9f9f9; padding: 15px; margin-bottom: 15px; display: flex; flex-direction: column;">
                                    <p style="font-weight: bold; margin-bottom: 8px;"><%= "Tên người dùng: " + account.getFirst_name() + " " + account.getLast_name() %></p>
                                    <p style="margin-bottom: 8px;">Chất lượng: <%= rate.getNumber_rate() %> sao
                                        <% for (int i = 0; i < rate.getNumber_rate(); i++) { %>
                                        <i class="fa-solid fa-star icon-star" style="color: #ffc107; font-size: 18px;"></i>
                                        <% } %>
                                    </p>
                                    <p style="color: #555;"><%= "Nhận xét: " + rate.getComment() %></p>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
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
                <fmt:setLocale value="${lang}" scope="session" />
                <fmt:bundle basename="messages">
                <button class="btn" data-bs-toggle="modal" data-bs-target="#exampleModal" style="padding-left: 0; padding-right: 0; color: red">
                    <fmt:message key="Seeiftheproductisstillavailableinstore"/>
                </button>
                <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" style="width: fit-content">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="exampleModalLabel">Danh sách cửa hàng</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
<%--                            Danh sách chi nhánh ở đây--%>
                            <div class="modal-body" id="listStore">
                                <div class="store">
                                    <div>Chi nhánh: 123, Linh Trung, Thủ Đức</div><div>còn <span>6</span> sản phẩm</div>
                                </div>
                                <div class="store">
                                    <div>Chi nhánh: 123, Linh Trung, Thủ Đức</div>
                                    <div>còn <span>8</span> sản phẩm</div>
                                </div>
                                <div class="store">
                                    <div>Chi nhánh: 123, Linh Trung, Thủ Đức</div>
                                    <div>còn <span>16</span> sản phẩm</div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            </div>
                        </div>
                    </div>
                </div>
<%--               --%>

                <div class="chonmau">
                    <p style="font-size: 15px"><fmt:message key="Color"/></p>
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
                            <img style="height: 40px"
                                 src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_IMAGE%>/<%=imageUrl.trim()%>"
                                 alt="<%= colorName %>">
                            <span class="black_14_400" style="font-size: 12px;margin-left: 0px"><%=colorName%></span>
                        </div>
                        <% } %>
                    </div>
                    <div class="chonDungluong"
                         style="height: 50px; display: flex;align-items:center;justify-content: left">
                        <form style="display: flex;margin-top: 10px;  align-items: center;justify-content: center ">
                            <% List<String> capacities = (List<String>) request.getAttribute("capacities");
                                for (String capa : capacities) {
                            %>
                            <div class="dl 64gb" style="display: flex; background-color: #dcd9d9; border-radius: 5px; padding: 5px; margin-right: 5px; align-items: center;">
                                <input type="radio" id="option1" name="options" value="<%=capa%>">
                                <label for="option1" style="margin-bottom: 0px; margin-right: 10px"><%=capa%>
                                </label>
                            </div>
                            <% }%>
                        </form>
                    </div>
                </div>
            </div>

            <div class="khuyenmai border_gr_bg_white" style="margin-top: 10px;">
                <p class="khuyenmai-text">                    <fmt:message key="Promotion"/>
                </p>
                <div class="chitietkhuyemai">
                    <i class="fa-solid fa-circle-check"></i>
                    <p> <fmt:message key="Customerscanbuyproductsininstallmentswith0%interestratefor6monthsfromthedateofpurchase."/></p>
                </div>
                <div class="chitietkhuyemai">
                    <i class="fa-solid fa-circle-check"></i>
                    <p> <fmt:message key="IntheboxChargerHeadphonesUsermanualSIMejectorpinCase"/></p>
                </div>
                <div class="chitietkhuyemai">
                    <i class="fa-solid fa-circle-check"></i>
                    <p> <fmt:message key="12monthgenuinewarranty"/></p>
                </div>
                <div class="chitietkhuyemai">
                    <i class="fa-solid fa-circle-check"></i>
                    <p> <fmt:message key="1for1exchangewithin1monthifdefective,productexchangeathomewithin1day."/></p>
                </div>
            </div>
            <div class="warranty_info border_gr_bg_white" style="padding: 10px;margin-top: 10px">
                <p class="black_14_600_none_align"><fmt:message key="Warrantyinformation"/></p>
                <div style="display: flex">
                    <p class="black_14_400" style="margin: 0"><fmt:message key="Warrantyperiod"/></p>
                    <p class="black_14_400"
                       style="margin: 0 0 0 15px"><%=firstVariant.getProduct().getInfoWarranty().getTime_warranty()%>
                    </p>
                </div>
                <hr style="width: 100%;margin: 5px 0 5px 0">
                <div style="display: flex">
                    <p class="black_14_400" style="margin: 0"><fmt:message key="Warrantyform"/></p>
                    <p class="black_14_400"
                       style="margin: 0 0 0 15px"><%=firstVariant.getProduct().getInfoWarranty().getTerm_waranty()%>
                    </p>
                </div>
                <hr style="width: 100%;margin: 5px 0 5px 0">
                <div style="display: flex">
                    <p class="black_14_400" style="margin: 0"><fmt:message key="Warrantylocation"/></p>
                    <p class="black_14_400"
                       style="margin: 0 0 0 15px"><%=firstVariant.getProduct().getInfoWarranty().getAddress_warranty()%>
                    </p>
                </div>
            </div>
            <div class="thongsokythuat border_gr_bg_white" style="margin-top: 10px">
                <p class="black_14_600_none_align" style="margin-top: 10px;margin-left: 10px;"><fmt:message key="Specifications"/></p>
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
                <p style="font-size: 14px;line-height: 150%;font-weight: 600;margin-left: 10px;padding-top: 10px; border-top-right-radius: 15px;">Ưu
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
            <div class="">
                <div class="">
                    <h5 class="card-title">Bình luận</h5>
                    <form action="/product-detail" method="post" id="myForm">
                        <div class="form-group">
                            <textarea name="content" class="form-control" rows="3" placeholder="Nhận xét về sản phẩm"></textarea>
                        </div>
                        <div class="form-row">
                            <div class="col">
                                <input name="nameComment" type="text" class="form-control" placeholder="Họ và tên">
                            </div>
                            <div class="col">
                                <input name="phoneNumber" type="text" class="form-control" placeholder="Số điện thoại">
                            </div>
                            <input name="idProduct" type="text" class="form-control" placeholder="Số điện thoại" value="<%= productID %>" hidden>
                            <input type="hidden" id="timestamp" name="timestamp" value="">

                        </div>
                        <button type="submit" class="btn btn-danger mt-3">Gửi</button>
                    </form>
                </div>
            </div>
            </fmt:bundle>

            <script>
                document.getElementById('myForm').onsubmit = function() {
                    var date = new Date();
                    var formattedDateTime = date.toLocaleString(); // Định dạng ngày giờ dễ đọc
                    document.getElementById('timestamp').value = formattedDateTime; // Cập nhật trường ẩn
                };
            </script>
<% ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
    JSONArray jsonArray = productDeltailDAO.getActiveCommentsByProductId(Integer.parseInt(productID));%>
            <% for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);%>
            <div class="media mt-4">
                <img style="width: 60px; height: 50px" src="../resources/assets/images/nguoidung.jpg"
                     class="mr-3 rounded-circle" alt="User Avatar">
                <div class="media-body">
                    <h6 class="mt-0"><%= jsonObject.optString("nameComment")%> <small class="text-muted"><%= jsonObject.optString("timestamp")%></small></h6>
                    <%= jsonObject.optString("content")%>
                    <% JSONArray jsonArray1 = productDeltailDAO.getReplyByComment(Integer.parseInt(productID), jsonObject.optInt("id"));%>
                    <% for (int j = 0; j < jsonArray1.length(); j++) {
                        JSONObject jsonObject1 = jsonArray1.getJSONObject(j);%>
                    <div class="media mt-3">
                        <img style="width: 60px; height: 50px" src="../resources/assets/images/qtv.webp" class="mr-3 rounded-circle" alt="Admin Avatar">
                        <div class="media-body">
                            <h6 class="mt-0">Quản Trị Viên: <%=jsonObject1.optString("nameComment")%> <small class="text-muted"><%= jsonObject1.optString("timestamp")%></small></h6>
                                <%=jsonObject1.optString("content")%>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>

        <div class="contai-right col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12 border_gr_bg_white h-100">
            .
            <div class="hinhanh" style="border: none;height: 150%;">

                <img id="currentImage" style="height: 100px;"
                     src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_IMAGE%>/<%=firstVariant.getProductImages().get(0).getImage_url() %>"
                     alt="">
                <span id="currentColor"
                      style="margin-top: 15%;margin-left: 0px;"> <%= firstVariant.getColor().getName() %></span>
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

                            // var attrSoluong = $('#addToCart').attr('href');
                            // $('#addToCart').attr('href', attrSoluong + '&quantity=' + $('#soluong').val());
                            event.preventDefault(); // Ngăn chặn hành vi mặc định của thẻ a
                            var quantity = $('#soluong').val();
                            var addToCartUrl = $(this).attr('href');
                            addToCartUrl += '&quantity=' + quantity;
                            $.ajax({
                                type: 'GET',
                                url: addToCartUrl,
                                success: function (response) {
                                    $('#quantity-cart').text(response.total);
                                    showToast();
                                    setTimeout(() => document.querySelector(".toast").style.display = "none", 5000);
                                },
                                error: function (xhr, status, error) {
                                    console.error('Failed to add product to cart:', error);

                                }
                            });

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
            <fmt:setLocale value="${lang}" scope="session" />
            <fmt:bundle basename="messages">
            <p id="giatamtinh" style="font-size: 20px;font-weight: 500"><fmt:message key="Provisional"/></p>
            <p id="price1"><%= numberFormatVN.format(firstVariant.getPrice()) %>
            </p>

            <p id="tamtinh" style="font-size: 25px;font-weight: 600"></p>

            <div class="button-buy">
                <a id="buynow" href="#">
                    <button class="muatructiep-btn">
                        <span><fmt:message key="buynow"/></span>
                    </button>
                </a>
                <a href="#" id="addToCart">
                    <button class="themgiohang-btn">
                        <span class="them"><i class="fa-solid fa-cart-shopping"></i>
                            <p style=" background-color: transparent; margin-bottom: 0"><fmt:message key="Addtocart"/></p></span>
                    </button>
                    </fmt:bundle>

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