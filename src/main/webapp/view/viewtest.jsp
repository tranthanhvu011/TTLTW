<%@ page import="java.util.Map" %>
<%@ page import="model.CartProduct" %>
<%@ page import="model.Cart" %>
<%@ page import="service.NumberUtils" %>
<%@ page import="model.Account" %>
<%@ page import="config.URLConfig" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 1/14/2024
  Time: 12:23 AM
  To change this template use File | Settings | File Templates.
--%>
<%
    Account account = (Account) session.getAttribute("account");
    double total = 0;
    String message = (String) session.getAttribute("message");
    message = (message == null) ? "" : message;
//    Cart cart = (Cart) session.getAttribute("cart");
//    if (cart == null) cart = new Cart();
%>
<%@include file="/common/taglib.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <%@include file="/common/libraries.jsp" %>
    <title>Title</title>
    <style>
        #messagePopup {
            display: block;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(255, 255, 255, 0.9); /* Độ mờ và màu nền */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); /* Đổ bóng */
            z-index: 1;
        }

        #messagePopup h2 {
            color: #333; /* Màu chữ */
            margin-bottom: 20px;
        }

        #messagePopup a {
            margin-right: 10px;
        }

        #okButton {
            background-color: #28a745; /* Màu nền nút Ok */
            color: #fff; /* Màu chữ nút Ok */
            border: none;
        }

        #okButton:hover {
            background-color: #218838; /* Màu nền khi hover nút Ok */
        }

    </style>
</head>
<body>
<%@include file="/common/header.jsp" %>
<%if (message != null) {%>
<%session.removeAttribute("message");%>
<%}%>
<div class="container">
    <div class="row">
        <%
            if (account == null) {
        %>
        <div id="messagePopup" style="text-align: center;top: 25%"
        >
            <%
                if (account == null) {
            %><h2>Bạn chưa đăng nhập!</h2><%
        } else {
        %> <h2><%=message%><%
            }
        %>

        </h2>
            <a href="${pageContext.request.contextPath}/login">
                <button class="btn btn-success">Đăng nhập</button>
            </a>
            <a>
                <button id="okButton" class="btn btn-success">Ok, tôi hiểu</button>
            </a>
        </div>
        <%
            }
        %>
        <h2 style="color: red;margin-left: 15px;margin-top: 10px;"><%=message%>
        </h2>
        <%
            if (cart.getData().isEmpty()) {
        %>
        <h2 style="color: red;margin-left: 15px;margin-top: 10px;">Không có sản phẩm nào trong giỏ hàng!!</h2>
        <div class="col-sm-12 col-md-10 col-md-offset-1">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th style="text-align: center">Sản phẩm</th>
                    <th style="text-align: center">Số lượng</th>
                    <th class="text-center">Giá</th>
                    <th class="text-center">Tổng cộng</th>
                    <th> </th>
                </tr>
                </thead>
                <tbody>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>
                    <a href="${pageContext.request.contextPath}/home">
                        <button type="button" class="btn btn-success">
                            <span class="glyphicon glyphicon-shopping-cart"></span> Quay lại
                        </button>
                    </a>
                </td>

                </tr>
                </tbody>
            </table>
        </div>
        <%
        } else {
        %>
        <div class="col-sm-12 col-md-10 col-md-offset-1">
            <table class="table table-hover" style=" border-collapse: collapse; width: 100%;
        border: 1px solid #ddd;margin-top: 10px;">
                <thead>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th class="text-center">Price</th>
                    <th class="text-center">Total</th>
                    <th> </th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Map.Entry<Integer, CartProduct> entry : cart.getData().entrySet()) {
                        Integer key = entry.getKey(); // Lấy key
                        CartProduct cartProduct = entry.getValue(); // Lấy value (CartProduct)
                        total += cartProduct.getQuantity() + cartProduct.getProductVariant().getPrice();
                %>
                <tr>
                    <td class="col-sm-8 col-md-6 tensp" data-masp="<%=cartProduct.getProductVariant().getId()%>">
                        <div class="media" style="margin-left: 10px;">
                            <img class="media-object"
                                 src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_IMAGE%>/<%=cartProduct.getProductVariant().getProductImages().get(0).getImage_url()%>"
                                 style="width: 72px; height: 100%;">
                            <div class="media-body" style="margin-left: 8px;">
                                <h4 class="media-heading"><a
                                        href="${pageContext.request.contextPath}/product-detail?id=<%=cartProduct.getProductVariant().getProduct().getId()%>"><%=cartProduct.getProductVariant().getProduct().getName()%>
                                </a></h4>
                                <h6 class="media-heading"> Màu: <a
                                ><%=cartProduct.getProductVariant().getColor().getName()%>
                                </a></h6>
                                <h6 class="media-heading"> Dung lượng:
                                    <a><%=cartProduct.getProductVariant().getCapacity().getName()%></a>
                                </h6>
                                <span>Trạng thái: </span><span class="text-success"><strong>Còn hàng</strong></span>
                            </div>
                        </div>
                    </td>
                    <td class="col-sm-1 col-md-1" style="text-align: center">
                        <input type="number" class="quantity" min="1"
                               id="quantity_<%=cartProduct.getProductVariant().getId()%>"
                               value="<%=cartProduct.getQuantity()%>">
                    </td>
                    <td class="col-sm-1 col-md-1 text-center">
                        <strong><a
                                id="price"><%= NumberUtils.formatNumberWithCommas(cartProduct.getProductVariant().getPrice()) %>
                        </a></strong>
                    </td>
                    <td>
                        <strong><a class="total" data-price="<%=cartProduct.getProductVariant().getPrice()%>"
                                   data-id="<%=cartProduct.getProductVariant().getId()%>">
                            <%= NumberUtils.formatNumberWithCommas(cartProduct.getProductVariant().getPrice() * cartProduct.getQuantity()) %>
                        </a></strong>
                    </td>

                    <td class="col-sm-1 col-md-1">
                        <a href="${pageContext.request.contextPath}/cart?action=delete&id=<%=cartProduct.getProductVariant().getId()%>">
                            <button type="submit" class="btn btn-danger">
                                <span class="glyphicon glyphicon-remove"></span> Remove
                            </button>
                        </a>
                    </td>
                    <td><input type="checkbox" class="checkbox-class"
                               value="<%=cartProduct.getProductVariant().getId()%>"></td>
                </tr>
                <% }%>


                <tr>
                    <td>  </td>
                    <td>  </td>
                    <td>  </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/home">
                            <button type="button" class="btn btn-default">
                                <span class="glyphicon glyphicon-shopping-cart"></span> Tiếp tục mua sắm
                            </button>
                        </a>
                    </td>
                    <td>
                        <form action="${pageContext.request.contextPath}/submitProductFromCart" method="post">
                            <input id="input-hidden" type="hidden" value="" name="selectedProductIds">
                            <button id="paymentButton" type="button" class="btn btn-success">
                                Thanh toán <span class="glyphicon glyphicon-play"></span>
                            </button>
                        </form>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <%
            }
        %>

    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        $(".quantity").change(function () {
            var soluong = $(this).val();
            var totalElement = $(this).closest("tr").find(".total");
            var giaGoc = totalElement.data("price");
            var id = totalElement.data("id");

            if (giaGoc === undefined) {
                giaGoc = parseFloat(totalElement.text().replace(/[^0-9.-]+/g, ""));
            } else {
                giaGoc = parseFloat(giaGoc);
            }

            var tongtienmoi = soluong * giaGoc;
            // Update the total element with the formatted currency
            totalElement.text(formatCurrency(tongtienmoi));
            // Update the total amount
            totalAmount = calculateTotalAmount();
            // Log the values for debugging
            console.log("ID: " + id);
            console.log("Số lượng: " + soluong);
            console.log("Giá gốc: " + giaGoc);
            console.log("Tổng tiền mới: " + tongtienmoi);
            console.log("Tổng tiền: " + totalAmount);
            $.ajax({
                type: 'GET',
                url: '${pageContext.request.contextPath}/cart',
                data: {
                    action: 'update-quantity',
                    quantity: soluong,
                    idP: id,
                },
            })
        });
    });

    // Function to format a number as currency with commas
    function formatCurrency(value) {
        var formattedValue = value.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2});

        // Remove trailing ",00" or ".00" if present
        formattedValue = formattedValue.replace(/(\.00|,00)$/, '');

        return formattedValue;
    }

    // Xu ly checkbox
    var checkboxes = document.querySelectorAll('.checkbox-class');
    checkboxes.forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            // Lọc ra những checkbox được chọn
            var selectedCheckboxes = Array.from(checkboxes).filter(function (checkbox) {
                return checkbox.checked;
            });

            // Lấy giá trị của các checkbox được chọn
            var selectedIds = selectedCheckboxes.map(function (checkbox) {
                return checkbox.value;
            });

            // In giá trị ra console để kiểm tra
            console.log('Selected Product IDs:', selectedIds);

            // Đặt giá trị vào input hidden
            $("#input-hidden").val(JSON.stringify(selectedIds));
        });
    });

    var paymentButton = document.getElementById('paymentButton');
    paymentButton.addEventListener('click', function () {
        // Kiểm tra xem có checkbox nào được chọn hay không
        if ($("#input-hidden").val().length > 0) {
            // Gửi dữ liệu đến server hoặc thực hiện các xử lý khác
            $("form").submit();
        } else {
            alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán.');
        }
    });

    function calculateTotalAmount() {
        var totalAmount = 0;
        $(".total").each(function () {
            totalAmount += parseFloat($(this).text().replace(/[^0-9.-]+/g, ""));
        });
        return totalAmount;
    }

</script>
<footer>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <div class="box-footer info-contact">
                    <h3 class="white_16_500">Thông tin liên hệ</h3>
                    <div class="content-contact">
                        <p class="white_13_400" style="font-size: 17px">Website chuyên cung cấp thiết bị điện tử hàng
                            đầu Việt Nam</p>
                        <p>
                            <strong class="white_13_400">Địa chỉ:</strong> 203 Linh Trung, Thủ Đức, Tp.HCM
                        </p>
                        <p>
                            <strong class="white_13_400">Email: </strong> nhom41store@gmail.com
                        </p>
                        <p>
                            <strong class="white_13_400">Điện thoại: </strong> 0836452145
                        </p>
                        <p>
                            <strong class="white_13_400">Website: </strong> https://nhom41store.com
                        </p>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <div class="box-footer info-contact">
                    <h3 class="white_16_500">Thông tin khác</h3>
                    <div class="content-list">
                        <ul>
                            <li><a href="#"><i class="fa fa-angle-double-right"></i> Chính sách bảo hành</a></li>
                            <li><a href="#"><i class="fa fa-angle-double-right"></i> Chính sách đổi trả</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <div class="box-footer info-contact">
                    <h3 class="white_16_500">THÔNG TIN PHẢN HỒI</h3>
                    <div class="content-contact">
                        <div>
                            <div class="row">
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <input type="text" name="" id="full_name" class="form-control"
                                           placeholder="Họ và Tên">
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
                                    <input type="email" name="" id="email" class="form-control"
                                           placeholder="Địa chỉ mail">
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
                                    <input type="text" name="" id="phone" class="form-control"
                                           placeholder="Số điện thoại">
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <input type="text" name="" id="title_report" class="form-control"
                                           placeholder="Tiêu đề">
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <textarea name="" id="submit_form" cols="30" rows="10"
                                              class="form-control"></textarea>
                                </div>
                            </div>
                            <button type="button" class="btn-contact">Liên hệ ngay</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>

<script>
    document.getElementById('okButton').addEventListener('click', function () {
        var messagePopup = document.getElementById('messagePopup');
        messagePopup.style.display = 'none';
    });
</script>
<%@include file="/common/libraries_js.jsp" %>
</body>
</html>
<%--$.ajax({--%>
<%--    type: 'POST',--%>
<%--    url: '${pageContext.request.contextPath}/payment',--%>
<%--    data: {--%>
<%--        action: 'get-product',--%>
<%--        ids: selectedIds--%>
<%--    },--%>
<%--});--%>