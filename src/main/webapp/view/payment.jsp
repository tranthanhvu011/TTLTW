<%@ page import="model.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.CartProduct" %>
<%@ page import="service.NumberUtils" %>
<%@ page import="model.InforTransport" %>
<%@ page import="dao.TransportDAO" %>
<%@ page import="java.util.Date" %>
<%@ page import="config.URLConfig" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-21
  Time: 5:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<% double total =0;%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thanh toán</title>
    <link rel="stylesheet" href="../resources/css/user/product-detail.css">
    <link rel="stylesheet" href="../resources/css/user/trangchu.css">
    <link rel="stylesheet" href="../resources/css/user/payment.css">
    <%@include file="/common/libraries.jsp" %>
</head>
<%
    // Lấy thời gian hiện tại
    java.util.Date currentDate = new java.util.Date();
    java.util.Calendar calendar = java.util.Calendar.getInstance();
    calendar.setTime(currentDate);
// Thêm 7 ngày vào thời gian hiện tại
    calendar.add(java.util.Calendar.DATE, 7);
    java.util.Date deliveryDate = calendar.getTime();
// Định dạng ngày giờ
    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
    String formattedDeliveryDate = dateFormat.format(deliveryDate);
%>
<style>
    body {
        background-color: #F5F5FA;
    }

    * {
        font-size: 14px;
        font-family: Inter, Helvetica, Arial, sans-serif;
    }
    #changeForm {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: rgba(255, 255, 255, 0.9);
        z-index: 1;
        display: flex;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        flex-direction: column;
        align-items: center;
    }

    #changeProfileForm {
        text-align: center;
        padding: 20px;
        background-color: #b7b1b1;
        width: 300px; /* Đặt chiều rộng của form nếu cần thiết */
    }

    #changeProfileForm label,
    #changeProfileForm input {
        margin-bottom: 10px;
    }

    #changeProfileForm label {
        display: inline-block;
        text-align: left;
        width: 100px; /* Đặt chiều rộng của label, bạn có thể điều chỉnh tùy theo nhu cầu */
    }

    #changeProfileForm input {
        width: calc(100% - 20px); /* Đặt chiều rộng của input để điền hết phần còn lại của form */
    }

    #changeProfileForm button {
        margin-top: 10px;
    }



</style>
<body>
<%@include file="/common/header.jsp" %>
<%--<%--%>
<%--    Account loggedInUser = (Account)session.getAttribute("account");--%>
<%--    if (loggedInUser == null) {--%>
<%--        response.sendRedirect("login.jsp");--%>
<%--        return;--%>
<%--    }--%>
<%--%>--%>
<%
    InforTransport inforTransport = (InforTransport) request.getAttribute("infortransport");
    List<Integer> listID = (List<Integer>) session.getAttribute("selectedProductIds");
    Account account = (Account) session.getAttribute("account");
    String message = (String) session.getAttribute("message");
    message = (message == null) ? "" : message;
    String messagediscount = (String) session.getAttribute("message-discount");
    messagediscount = (messagediscount==null) ? "" : messagediscount;

%>
<%if (message != null) {%>
<%session.removeAttribute("message");
session.removeAttribute("message-discount");
%>
<%}%>
<%if (messagediscount != null) {%>
<%session.removeAttribute("message");
    session.removeAttribute("message-discount");
%>
<%}%>
<div class="container">
    <h2 style="color: red;padding-top: 10px;padding-left: 15px;top: 17%;text-align: center;position: absolute;left: 30%;"><%=message%></h2>
<%--    <h2 style="color: red;padding-top: 10px;padding-left: 15px;top: 17%;text-align: center;position: absolute;left: 30%;"><%=messagediscount%></h2>--%>
    <div class="gutters" style="display: flex;justify-content: space-evenly;margin-bottom: 40px">
        <div class="col-xl-9 col-lg-9 col-md-12 col-sm-12 col-12 ">
            <div class="payment_methods border_gr_bg_white" style="padding: 10px;border-radius: 7px">
                <h3 class="black_18_700" style="margin-top: 5px;font-weight: 550">Chọn hình thức giao hàng</h3>
                <div class="payment">
                    <div style="display: flex;justify-content: space-between">
                        <div class="col-md-5 col-lg-5 col-sm-12 col-xl-5 border_blue_bg_blue" style="display: flex">
                            <div>
                                <input style="width: 20px; height: 20px" type="radio" id="giao_hang_tiet_kiem" name="fav_language" value="">
                            </div>
                            <div style="margin-left: 10px">
                                <label for="giao_hang_tiet_kiem" class="black_14_400">Giao hàng tiết kiệm</label>
                            </div>
                            <div>
                                <p id="giao_hang_tiet_kiem_fee" class="black_14_400" style="font-size: 12px; color: greenyellow;border-radius: 5px;margin-left: 10px;padding: 1px 3px 1px 3px">-30K</p>
                            </div>
                        </div>
                        <div class="col-md-5 col-lg-5 col-sm-12 col-xl-5 border_blue_bg_blue" style="display: flex">
                            <div>
                                <input style="width: 20px; height: 20px" type="radio" id="giao_hang_buu_dien" name="fav_language" value="">
                            </div>
                            <div style="margin-left: 10px">
                                <label for="giao_hang_buu_dien" class="black_14_400">Giao hàng qua bưu điện</label>
                            </div>
                            <div>
                                <p id="giao_hang_buu_dien_fee" class="black_14_400" style="font-size: 12px; color: greenyellow;border-radius: 5px;margin-left: 10px;padding: 1px 3px 1px 3px">-42K</p>
                            </div>
                        </div>
                    </div>
                </div>

<%-- do du lieu tu cart qua payment--%>
                <%
                    for (int id : listID
                    ) {
                %>
                <%
                    }%>

                <%
                    // Lấy danh sách ID từ session

                    // Kiểm tra xem danh sách có tồn tại hay không
                    if (listID != null && !listID.isEmpty()) {
                        // Lặp qua dữ liệu trong cart
                        for (Map.Entry<Integer, CartProduct> entry : cart.getData().entrySet()) {
                            Integer key = entry.getKey(); // Lấy key

                            // Kiểm tra xem key có tồn tại trong danh sách ID hay không
                            if (listID.contains(key)) {
                                CartProduct cartProduct = entry.getValue(); // Lấy value (CartProduct)

                                double price = cartProduct.getProductVariant().getPrice()*cartProduct.getQuantity();
                                total += price;
                %>

                <div class="payment border_gr_bg_white" style="margin-top: 20px;padding: 10px">
                    <div style="display: flex;width: 50%;justify-content: space-between">
                        <div>
                            <span class="price-current"
                                  style="color: #e00;font-size: 12px;font-weight: 500;text-align: left;line-height: 150%;">
                                    12.000 đ
                            </span>
                            <span class="price-old"
                                  style="color: lightgrey;font-weight: 100;
                                  text-decoration: line-through;line-height: 150%;margin-left: 5px;font-size: 12px">
                                    42.000đ
                            </span>
                        </div>
                    </div>
                    <div class="mt-2 mb-1" style="display: flex;">
                        <img
                                src="${pageContext.request.contextPath}/<%=URLConfig.URL_SAVE_IMAGE%>/<%=cartProduct.getProductVariant().getProductImages().get(0).getImage_url()%>"
                                class="img-fluid rounded-3" alt="Shopping item"
                                style="width: 40px;"/>
                        <div class=""
                             style="padding: 0 0 0 12px">
                            <div class=""
                                 style="display: flex;flex-direction: column;align-items: flex-start;justify-content: space-between;font-size: 13px;">
                                <h6 class="grey_10_400" style="background-color: white;font-size: 15px"><%=cartProduct.getProductVariant().getProduct().getName()%></h6>
                                <h6 class="grey_10_400" style="background-color: white;margin-top: 10px;font-size: 13px">SL: <%=cartProduct.getQuantity()%></h6>
                            </div>
                        </div>
                        <div style="padding: 0 0 0 30px">
                            <h6 class="grey_10_400"
                                style="background-color: white;color: black;margin-top: 25px;font-weight: 600;font-size: 25px;">
                                <%=NumberUtils.formatNumberWithCommas(cartProduct.getProductVariant().getPrice()*cartProduct.getQuantity())%></h6>
                        </div>
                        <div style="padding: 0 0 0 30px">
                            <h6 class="grey_10_400" style="background-color: white;font-size: 15px; color: lawngreen; margin-top: 22px; font-weight: 500; font-size: 12px">
                                Thời gian nhận hàng: trước ngày <%= formattedDeliveryDate %>
                            </h6>
                        </div>
                    </div>
                    <div style="margin-top: 20px;display: flex">
                        <p class="black_14_400" style="font-size: 12px">Mã giảm giá</p>
                        <form action="/add-discount" method="post" style="display: flex;height: 40px;width: 265px;">
                            <input name="id" type="hidden" value="<%=cartProduct.getProductVariant().getId()%>">
                            <input name="code" class="grey_10_400"
                                   style="padding-left:10px ;width: 100%;border-radius: 2px;border: solid lightgrey 1px;margin-left: 10px"
                                 placeholder="Nhập code khuyến mãi"   required>
                            <button style="width: 130px;margin-left: 10px;" class="btn btn-success" type="submit">Xác nhận</button>

                        </form>
                    </div>

                    <a id="discountMessage_<%=cartProduct.getProductVariant().getId()%>"
                       style="margin-top: 5px; color: red; margin-left: 75px;"><%=messagediscount%></a>
                </div>
                <script>
                    document.querySelector('form').addEventListener('submit', function (event) {
                        event.preventDefault();
                        var productId = "<%=cartProduct.getProductVariant().getId()%>";
                        var discountMessage = document.getElementById('discountMessage_' + productId);
                        discountMessage.innerHTML = "Thông báo cho sản phẩm " + productId + ": Mã giảm giá đã được xác nhận!";
                    });
                </script>
                <script>
                    document.getElementById('value_total_price').innerText = <%=NumberUtils.formatNumberWithCommas(total)%>;
                </script>
                <%
                        }
                    }

                } else {
                %>

                <h2>No selected products</h2>
                <%
                    }
                %>


            </div>
            <div class="payment_methods border_gr_bg_white" style="padding: 10px;border-radius: 7px">
                <h3 class="black_18_700" style="margin-top: 5px;font-weight: 550">Chọn hình thức thanh toán</h3>
                <div class="payment">
                    <form method="post" action="/checkout">
                    <div class="form-check">
                        <input onclick="hideVisaForm()" class="form-check-input" type="radio"
                               name="flexRadioDefault" id="flexRadioDefault2"
                               checked>
                        <label class="black_14_400">
                            Thanh toán trực tiếp khi nhận hàng
                        </label>
                        </input>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio"
                               name="flexRadioDefault" id="flexRadioDefault" value="optionVisa"
                               onclick="showVisaForm()">
                        <label class="black_14_400" for="flexRadioDefault">
                            Thanh toán bằng Visa
                            <img style="width: 40px;margin-left: 10px" src="../resources/assets/images/visa.png" alt="">
                        </label>
                        </input>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" value="optionPaypal"
                               name="flexRadioDefault" id="flexRadioDefault1" onclick="showVisaForm()">
                        <label class="form-check-label" for="flexRadioDefault1" >
                            Thanh toán bằng Paypal
                            <img style="width: 40px;margin-left: 10px" src="../resources/assets/images/paypal.png" alt="">
                        </label>
                        </input>
                    </div>

                    <div id="visaForm" style="display: none ">
                        <div class="card" style="margin: 30px 0 0 0">
                            <div id="collapseOne" class="collapse show"
                                 aria-labelledby="headingOne"
                                 data-parent="#accordionExample">
                                <div class="card-body payment-card-body">
                                    <span class="black_14_400" style="margin-right: 10px">Card Number</span>
                                    <i class="fa fa-credit-card"></i>
                                    <input id="cardNumberVisa" type="text"
                                           class="form-control black_14_400"
                                           placeholder="0000 0000 0000 0000" style="margin-top: 5px">
                                    <span style="font-size: 14px" id="erroNumberVisa"
                                          class="error-message">Vui lòng không để trống thông tin</span>
                                    <div class="row mt-3">
                                        <div class="col-md-6">
                                            <span class="black_14_400" style="margin-right: 10px">Expiry Date</span>
                                            <i class="fa fa-calendar"></i>
                                            <input type="text" class="form-control black_14_400"
                                                   id="numberDate"
                                                   placeholder="MM/YY">
                                            <span style="font-size: 14px" id="errorNumberDate"
                                                  class="error-message">Vui lòng không để trống thông tin</span>
                                        </div>
                                        <div class="col-md-6">
                                            <span class="black_14_400" style="margin-right: 10px">CVC/CVV</span>
                                            <i class="fa fa-lock"></i>
                                            <input type="text" class="form-control black_14_400" id="cvv"
                                                   placeholder="000">
                                            <span style="font-size: 14px" id="cvvError"
                                                  class="error-message">Vui lòng không để trống thông tin</span>
                                        </div>
                                    </div>
                                    <div style="margin-top: 10px">
                                            <span class=" black_14_400 text-muted certificate-text"><i
                                                    class="fa fa-lock" style="margin-right: 10px"></i> Your transaction is secured with ssl certificate</span>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                        <input type="submit" value="Select" class="btn-order" style="color: white;" />
                    </form>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
            <div id="profileInfo" class="payment_methods border_gr_bg_white" style="padding: 10px;border-radius: 7px">
                <div  style="display: flex;justify-content: space-between">
                    <p class="grey_10_400" style="font-size: 12px">Giao tới</p>
                    <a class="grey_10_400" style="color: #2c6ed5; font-size: 12px; cursor: pointer" onclick="showChangeForm()">
                        Thay đổi
                    </a>
                </div>

                <div style="display: flex;margin-top: 5px">
                    <p id="name" style="font-size: 12px;color: black;font-weight: 600;margin-right: 10px"><%=inforTransport.getName_reciver()%> </p>
                    <p id="phone"
                       style="font-size: 12px;color: black;font-weight: 600;border-left: lightgrey solid 1px;padding-left: 10px">
                        <%=inforTransport.getPhone_reciver()%></p>
                </div>
                <div id="address" style="color: grey;font-size: 12px">
                    <span style="color: black;font-size: 12px">Địa chỉ:</span>
                    <%=inforTransport.getAddress_reciver()%>
                </div>
            </div>

            <div class="payment_methods border_gr_bg_white" style="padding: 10px;border-radius: 7px">
                <div style="display: flex;justify-content: space-between">
                    <p class="grey_10_400" style="font-size: 12px">Đơn hàng</p>
                    <a class="grey_10_400" style="color: #2c6ed5;font-size: 12px;cursor: pointer"
                       href="${pageContext.request.contextPath}/cart?action=view-cart">
                        Thay đổi
                    </a>
                </div>
                <hr style="width: 100%;margin-top: 10px;margin-bottom: 10px">
                <div style="display: flex;justify-content: space-between">
                    <p id="price" class="grey_10_400">Tạm tính</p>
                    <p id="value_price" class="grey_10_400" name="value_price"><%=NumberUtils.formatNumberWithCommas(total)%></p>
                </div>
                <div style="display: flex;justify-content: space-between">
                    <p id="transport_fee" class="grey_10_400">Phí vận chuyển</p>
                    <p id="value_transport_fee" name="value_transport_fee" class="grey_10_400">42.000 đ</p>
                </div>
                <div style="display: flex;justify-content: space-between">
                    <p id="discount_ts_fee" class="grey_10_400">Giảm giá vận chuyển</p>
                    <p id="value_discount_ts_fee" name="value_discount_ts_fee" class="grey_10_400">12.000 đ</p>
                </div>
                <hr style="width: 100%;margin-top: 10px;margin-bottom: 10px">
                <div style="display: flex;justify-content: space-between">
                    <p id="total_price" class="grey_10_400">Tổng tiền</p>
                    <p id="value_total_price" name="value_total_price" class="grey_10_400" style="font-size: 18px;color: red"><%=NumberUtils.formatNumberWithCommas(total)%></p>
                </div>
<%--                <div>--%>
<%--                    <button type="submit" onclick="validateForm()" class="btn-order" style="margin-top: 10px">--%>
<%--                        <a id="page_order" href="${pageContext.request.contextPath}/checkout" style="color: white">Đặt hàng</a>--%>
<%--                    </button>--%>
<%--                </div>--%>
            </div>
        </div>
    </div>
</div>
<%@include file="/common/footer.jsp" %>
<script src="../resources/js/user/payment.js"></script>
<%@include file="/common/libraries_js.jsp" %>
<script>
    function isNumeric(value) {
        return /^\d+$/.test(value);
    }

    function showChangeForm() {
        document.getElementById('profileInfo').style.display = 'none';
        document.getElementById('changeForm').style.display = 'block';
    }

    function validatePhoneNumber() {
        var phoneNumberInput = document.getElementById('newPhoneNumber');
        var phoneNumber = phoneNumberInput.value;
        var errorSpan = document.getElementById('phoneNumberError');

        if (!isNumeric(phoneNumber)) {
            errorSpan.textContent = 'Số điện thoại phải là kiểu số.';
            phoneNumberInput.classList.add('error');
            return false;
        } else {
            errorSpan.textContent = '';
            phoneNumberInput.classList.remove('error');
            return true;
        }
    }

    function submitForm() {
        if (validatePhoneNumber()) {
            var currentPhoneNumber = '<%=inforTransport.getPhone_reciver()%>';
            var newPhoneNumber = document.getElementById('newPhoneNumber').value;

            if (newPhoneNumber !== currentPhoneNumber) {
                // Handle form submission logic here
                console.log('Submit form with new phone number:', newPhoneNumber);

                // Display the updated information
                document.getElementById('profileInfo').style.display = 'block';
                document.getElementById('changeForm').style.display = 'none';
            } else {
                console.log('Số điện thoại không thay đổi.');
            }
        } else {
            console.log('Validation failed. Please correct the errors.');
        }
    }



    function changPhiVanChuyen() {
        // Additional code to update transport fee based on the selected option
        var transportFeeElement = document.getElementById('value_transport_fee');

        function updateTransportFee() {
            var selectedOption = document.querySelector('input[name="fav_language"]:checked');
            if (selectedOption) {
                if (selectedOption.id === 'giao_hang_tiet_kiem') {
                    transportFeeElement.innerText = '12.000 đ'; // Adjust the value accordingly
                } else if (selectedOption.id === 'giao_hang_buu_dien') {
                    transportFeeElement.innerText = '42.000 đ'; // Adjust the value accordingly
                }
            }
        }

        // Add event listeners to update transport fee when the radio buttons are clicked
        var radioButtons = document.querySelectorAll('input[name="fav_language"]');
        radioButtons.forEach(function (radioButton) {
            radioButton.addEventListener('click', updateTransportFee);
        });

        // Set the initial transport fee on page load
        updateTransportFee();
    }

    // Ensure this function is called on page load to set the initial transport fee
    document.addEventListener('DOMContentLoaded', changPhiVanChuyen);

</script>

<div id="changeForm" style="display: none;">
    <!-- Form để nhập thông tin mới -->
    <form style="     background-color: #c2dcf8;" action="${pageContext.request.contextPath}/update-infor-transport" method="post" id="changeProfileForm" onsubmit="submitForm();">
        <label style="text-align: center" for="newName">Tên:</label>
        <input  type="text" id="newName" name="newName" value="<%=inforTransport.getName_reciver()%>" required>
        <label style="text-align: center" for="newPhoneNumber">Số điện thoại:</label>
        <input  type="text" id="newPhoneNumber" name="newPhoneNumber" value="<%=inforTransport.getPhone_reciver()%>" required oninput="validatePhoneNumber()">
        <span id="phoneNumberError" style="color: red;"></span>
        <label style="text-align: center" for="newAddress">Địa chỉ:</label>
        <input type="text" id="newAddress" name="newAddress" value="<%=inforTransport.getAddress_reciver()%>" required>
        <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
    </form>
</div>

</body>
</html>
