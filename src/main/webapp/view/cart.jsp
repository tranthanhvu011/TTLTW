<%@ page import="model.Account" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-21
  Time: 5:14 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="../resources/css/user/cart.css">
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
</style>
<body>
<%@include file="/common/header.jsp" %>
<%
    Account loggedInUser = (Account)session.getAttribute("account");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<section class="h-100 h-custom">
    <div class="container py-5 h-100 d-flex" style="justify-content: space-between">
        <div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12">
            <div class="col pt-2">
                <div class="card" style="border-radius: 10px">
                    <div class="card-body p-4">
                        <div class="col-lg-12">
                            <div class="mt-3 mb-3 flex" style="display: flex;justify-content: space-between">
                                <div class="card" style="border-radius: 12px">
                                    <div class="checkbox_image" style="border-radius: 7px;background-color: white;position: absolute;
                                    padding: 6px;height: 30px;width:28px;margin-top: 5px;margin-left: 5px">
                                        <input type="checkbox" id="check1"
                                               style="width: 100%;height: 100%;accent-color: red;"
                                               onclick="totalPrice1(price1,quantity1)">
                                    </div>
                                    <img
                                            src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-shopping-carts/img1.webp"
                                            class="img-fluid rounded-3" alt="Shopping item"
                                            style="width: 85px;
                                            margin: 12px 7px 12px 7px ">
                                </div>
                                <div class="flex-1 content"
                                     style="justify-content: space-between;padding: 0 0 0 12px;width: 70%">
                                    <div class="d-flex content1" style="justify-content: space-between">
                                        <h6 class="black_14_400">Samsung Galaxy A05 128GB 128GB Đen
                                            SM-A055FZKGXXV</h6>
                                        <i class="fas fa-trash-alt"></i>
                                    </div>
                                    <div class="mt-2 d-flex " style="justify-content: space-between">
                                        <div class="row"
                                             style="display: flex;justify-content: space-between;width: 50%">
                                            <div class="col-md-6">
                                                <div><p class="grey_10_400"
                                                        style="font-size: 14px;color: rgb(120, 120, 120);display: inline-block;">
                                                    Màu
                                                    sắc</p></div>
                                                <div class=""
                                                     style="border: solid darkgrey 1px;text-align: center;border-radius: 5px">
                                                    <input style="width: 100%;text-align: center;border: none;padding: 2px 0 2px 0"
                                                           value="Red" type="text" disabled>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div>
                                                    <p class="text-text-secondary mb-3 text-sm md:text-base grey_10_400"
                                                       style="font-size: 14px;color: rgb(120, 120, 120);display: inline-block;">
                                                        Số lượng</p>
                                                    <div class="" style="display: flex">
                                                        <button style="border: solid darkgrey 1px;background-color: white;border-radius: 5px 0 0 5px "
                                                                onclick="increaseQuantity('quantity1',quantity1)">
                                                            <i
                                                                    class="fa fa-plus"></i></button>
                                                        <input class="quantity" style="width: 40px;text-align: center"
                                                               id="quantity1" min="0" name="form-0-quantity"
                                                               value="1" type="number">
                                                        <button class=""
                                                                onclick="decreaseQuantity('quantity1',quantity1)"
                                                                style="border: solid darkgrey 1px;background-color: white;border-radius: 0 5px 5px 0">
                                                            <i class="fa fa-minus"
                                                               style="width: 15px;height: 15px;"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="red_22_400_total_price price" id="price"
                                             style="align-items: center;">
                                            <script>
                                                var element = document.getElementById("price");
                                                let html = '';
                                                html += `<p class="" style="color: red;font-size: 20px" >` + formatter.format(price1) + `</p>`;
                                                element.innerHTML = html;
                                            </script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-3 black_14_400" style="margin-bottom: 5px">
                                Khuyến mãi theo sản phẩm
                            </div>
                            <div class="card">
                                <div class="card-body" style="padding: 0px;">
                                    <div style="margin: 5px 10px 5px 10px;display: flex;justify-content: space-between">
                                        <div class="" style="padding-top: 5px;display: flex">
                                            <img src="https://salt.tikicdn.com/ts/upload/73/4d/f7/f86e767bffc14aa3d6abed348630100b.png"
                                                 style="width: 30px;height: 30px;display: inline-block;vertical-align: middle">
                                            <div style="padding-top: 5px;margin-left: 30px">
                                                <p class="black_12_400" style="margin-top: 0">Giảm đến 400k với thẻ
                                                    TiKiCard.</p>
                                            </div>
                                        </div>
                                        <div style="margin-right: 30px">
                                            <div class="round" style="margin-top: 5px">
                                                <input type="checkbox" checked id="checkbox1" style="margin-left: 3px"/>
                                                <label for="checkbox1"
                                                       style="width: 25px;height: 25px;margin-left: 3px"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body" style="padding: 0px;">
                                    <div style="margin: 5px 10px 5px 10px;display: flex;justify-content: space-between">
                                        <div class="" style="padding-top: 5px;display: flex">
                                            <img src="https://salt.tikicdn.com/ts/upload/2a/27/6a/7bbba1f6c93a1a42a3c314e7b5825f4c.png"
                                                 style="width: 30px;height: 30px;display: inline-block;vertical-align: middle">
                                            <div style="padding-top: 5px;margin-left: 30px">
                                                <p class="black_12_400" style="margin-top: 0">Mua trước trả sau.</p>
                                            </div>
                                        </div>
                                        <div style="margin-right: 30px">
                                            <div class="round" style="margin-top: 5px">
                                                <input type="checkbox" checked id="checkbox2" style="margin-left: 3px"/>
                                                <label for="checkbox2"
                                                       style="width: 25px;height: 25px;margin-left: 3px"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body" style="padding: 0px;height: 50px">
                                    <div style="margin: 5px 10px 10px;display: flex;justify-content: space-between">
                                        <div class="" style="padding-top: 5px;display: flex">
                                            <img src="https://salt.tikicdn.com/ts/upload/39/c5/e5/da087b9fd6fa5cf4c5aa0d6d2eb454df.png"
                                                 style="width: 30px;height: 30px;display: inline-block;vertical-align: middle">
                                            <div style="padding-top: 5px;margin-left: 30px">
                                                <p class="black_12_400" style="margin-top: 0">Trả góp từ 1.082.500 <sup><small>₫</small></sup>/tháng.
                                                </p>
                                            </div>
                                        </div>
                                        <div style="margin-right: 30px">
                                            <div class="round" style="margin-top: 5px">
                                                <input type="checkbox" checked id="checkbox3" style="margin-left: 3px"/>
                                                <label for="checkbox3"
                                                       style="width: 25px;height: 25px;margin-left: 3px"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col pt-2">
                <div class="card" style="border-radius: 10px">
                    <div class="card-body p-4">
                        <div class="col-lg-12">
                            <div class="mt-3 mb-3 flex" style="display: flex;justify-content: space-between">
                                <div class="card" style="border-radius: 12px">
                                    <div class="checkbox_image" style="border-radius: 7px;background-color: white;position: absolute;
                                    padding: 6px;height: 30px;width:28px;margin-top: 5px;margin-left: 5px">
                                        <input type="checkbox" id="check2"
                                               style="width: 100%;height: 100%;accent-color: red"
                                               onclick="totalPrice2(price2,quantity2)">
                                    </div>
                                    <img
                                            src="https://salt.tikicdn.com/cache/280x280/ts/product/fa/1d/33/98a0ed962d4b27b6526a93fac7aab192.png"
                                            class="img-fluid rounded-3" alt="Shopping item"
                                            style="width: 85px;
                                            margin: 12px 7px 12px 7px ">
                                </div>
                                <div class="flex-1 content"
                                     style="justify-content: space-between;padding: 0 0 0 12px;width: 70%">
                                    <div class="d-flex content1" style="justify-content: space-between">
                                        <h6 class="black_14_400">Apple iPhone 15 Pro Max</h6>
                                        <i class="fas fa-trash-alt"></i>
                                    </div>
                                    <div class="mt-2 d-flex " style="justify-content: space-between">
                                        <div class="row"
                                             style="display: flex;justify-content: space-between;width: 50%">
                                            <div class="col-md-6">
                                                <div><p class="grey_10_400"
                                                        style="font-size: 14px;color: rgb(120, 120, 120);display: inline-block;">
                                                    Màu
                                                    sắc</p></div>
                                                <div class=""
                                                     style="border: solid darkgrey 1px;text-align: center;border-radius: 5px">
                                                    <input style="width: 100%;text-align: center;border: none;padding: 2px 0 2px 0"
                                                           value="Black" type="text" disabled>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div>
                                                    <p class="text-text-secondary mb-3 text-sm md:text-base grey_10_400"
                                                       style="font-size: 14px;color: rgb(120, 120, 120);display: inline-block;">
                                                        Số lượng</p>
                                                    <div class="" style="display: flex">
                                                        <button class=""
                                                                onclick="increaseQuantity('quantity2',quantity2)"
                                                                style="border: solid darkgrey 1px;background-color: white;border-radius: 5px 0 0 5px ">
                                                            <i
                                                                    class="fa fa-plus"></i></button>
                                                        <input class="quantity" id="quantity2"
                                                               style="width: 40px;text-align: center"
                                                               min="0" name="form-0-quantity"
                                                               value="1" type="number">
                                                        <button class=""
                                                                onclick="decreaseQuantity('quantity2',quantity2)"
                                                                style="border: solid darkgrey 1px;background-color: white;border-radius: 0 5px 5px 0">
                                                            <i class="fa fa-minus"
                                                               style="width: 15px;height: 15px;"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="red_22_400_total_price " id="price1"
                                             style="align-items: center;">
                                            <script>
                                                var element = document.getElementById("price1");
                                                let html1 = '';
                                                html1 += `<p class="" style="color: red;font-size: 20px" >${formatter.format(33490000)}</p>`;
                                                element.innerHTML = html1;
                                            </script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-3 black_14_400" style="margin-bottom: 5px">
                                Khuyến mãi theo sản phẩm
                            </div>
                            <div class="card">
                                <div class="card-body" style="padding: 0px;">
                                    <div style="margin: 5px 10px 5px 10px;display: flex;justify-content: space-between">
                                        <div class="" style="padding-top: 5px;display: flex">
                                            <img src="https://salt.tikicdn.com/ts/upload/73/4d/f7/f86e767bffc14aa3d6abed348630100b.png"
                                                 style="width: 30px;height: 30px;display: inline-block;vertical-align: middle">
                                            <div style="padding-top: 5px;margin-left: 30px">
                                                <p class="black_12_400" style="margin-top: 0">Giảm đến 400k với thẻ
                                                    TiKiCard.</p>
                                            </div>
                                        </div>
                                        <div style="margin-right: 30px">
                                            <div class="round" style="margin-top: 5px">
                                                <input type="checkbox" checked id="checkbox4" style="margin-left: 3px"/>
                                                <label for="checkbox4"
                                                       style="width: 25px;height: 25px;margin-left: 3px"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body" style="padding: 0px;">
                                    <div style="margin: 5px 10px 5px 10px;display: flex;justify-content: space-between">
                                        <div class="" style="padding-top: 5px;display: flex">
                                            <img src="https://salt.tikicdn.com/ts/upload/2a/27/6a/7bbba1f6c93a1a42a3c314e7b5825f4c.png"
                                                 style="width: 30px;height: 30px;display: inline-block;vertical-align: middle">
                                            <div style="padding-top: 5px;margin-left: 30px">
                                                <p class="black_12_400" style="margin-top: 0">Mua trước trả sau.</p>
                                            </div>
                                        </div>
                                        <div style="margin-right: 30px">
                                            <div class="round" style="margin-top: 5px">
                                                <input type="checkbox" checked id="checkbox5" style="margin-left: 3px"/>
                                                <label for="checkbox5"
                                                       style="width: 25px;height: 25px;margin-left: 3px"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body" style="padding: 0px;height: 50px">
                                    <div style="margin: 5px 10px 10px;display: flex;justify-content: space-between">
                                        <div class="" style="padding-top: 5px;display: flex">
                                            <img src="https://salt.tikicdn.com/ts/upload/39/c5/e5/da087b9fd6fa5cf4c5aa0d6d2eb454df.png"
                                                 style="width: 30px;height: 30px;display: inline-block;vertical-align: middle">
                                            <div style="padding-top: 5px;margin-left: 30px">
                                                <p class="black_12_400" style="margin-top: 0">Trả góp từ 1.082.500 <sup><small>₫</small></sup>/tháng.
                                                </p>
                                            </div>
                                        </div>
                                        <div style="margin-right: 30px">
                                            <div class="round" style="margin-top: 5px">
                                                <input type="checkbox" checked id="checkbox6" style="margin-left: 3px"/>
                                                <label for="checkbox6"
                                                       style="width: 25px;height: 25px;margin-left: 3px"></label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
            <div class="card mb-4 mt-2">
                <div class="card-body" style="border-radius: 15px">
                    <div class="card-header py-3" style="background-color: white">
                        <h5 class="mb-0 black_14_400">Tạm tính</h5>
                    </div>
                    <div class="card-header py-3"
                         style="display: flex;justify-content: space-between;background-color: white">
                        <p class="black_14_400" style="margin-top: 5px">Tổng tiền</p>
                        <p class="red_22_400_total_price" id="total1">0đ</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/view/payment.jsp">
                        <div class="py-3">
                            <button type="button" class="btn btn-primary btn-lg btn-block">
                                Thanh toán
                            </button>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="/common/footer.jsp" %>
<%@include file="/common/libraries_js.jsp" %>
</body>
</html>
