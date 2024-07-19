<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-19
  Time: 11:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng ký</title>
    <link href="../resources/css/user/main.css" rel="stylesheet" media="all">
    <link href="../resources/libs/datepicker/css/bootstrap/zebra_datepicker.css" rel="stylesheet" media="all">
    <link href="../resources/libs/datepicker/css/bootstrap/zebra_datepicker.min.css" rel="stylesheet" media="all">
    <%@include file="/common/libraries.jsp" %>
    <script src="<c:url value="../resources/js/user/auth/register.js"/>"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<style>
    body {
        background-color: #F5F5FA;
    }

    * {
        font-size: 14px;
        font-family: Inter, Helvetica, Arial, sans-serif;
    }

    #onSubmit:hover {
        color: red;
    }
</style>
<body>
<%@include file="/common/header.jsp" %>
<%
    String message = (String) request.getAttribute("message") == null ? "" : (String) request.getAttribute("message");
%>
<div class="container" style="margin-bottom: 40px">
    <div class="card card-4">
        <div class="card-body">
            <h2 class="title" style="background-color: white">Đăng ký</h2>
            <c:if test="${not empty requestScope.emailNotNull}">
                <div class="error error-message text-center" style="color: red">${requestScope.emailNotNull}</div>
            </c:if>
            <c:if test="${not empty requestScope.getDOB}">
                <div class="error error-message text-center" style="color: red">${requestScope.getDOB}</div>
            </c:if>
            <c:if test="${not empty requestScope.address}">
                <div class="error error-message text-center" style="color: red">${requestScope.address}</div>
            </c:if>
            <c:if test="${not empty requestScope.lastName}">
                <div class="error error-message text-center" style="color: red">${requestScope.lastName}</div>
            </c:if>
            <c:if test="${not empty requestScope.firstName}">
                <div class="error error-message text-center" style="color: red">${requestScope.firstName}</div>
            </c:if>

            <form method="post" action="/register" id="formRegister">
                <div class="row row-space">
                    <div class="col-6">
                        <div class="input-group">
                            <label class="label">Họ</label>
                            <input class="input--style-4" type="text" name="first_name" id="f_name">
                            <span class="error" id="er-f-name" style="color: red;font-size: 10px"></span>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="input-group">
                            <label class="label">Tên</label>
                            <input class="input--style-4" type="text" name="last_name" id="l-name">
                            <span class="error" id="er-l-name" style="color: red;font-size: 10px"></span>
                        </div>
                    </div>
                </div>
                <div class="row row-space">
                    <div class="col-6">
                        <div class="input-group">
                            <label class="label">Ngày sinh</label>
                            <div class="input-group-icon" style="width: 100%">
                                <input class="input--style-4" type="date" name="dob" id="dob" style="width: 100%;">
                            </div>
                            <span class="error" id="er-dob" style="color: red;font-size: 10px"></span>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="input-group" style="width: 50%">
                            <label class="label">Giới tính</label>
                            <div class="p-t-10">
                                <label class="radio-container m-r-45">Nam
                                    <input type="radio" checked="checked" value="1" name="gender">
                                    <span class="checkmark"></span>
                                </label>
                                <label class="radio-container">Nữ
                                    <input type="radio" value="0" name="gender">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row row-space">
                    <div class="col-6">
                        <div class="input-group">
                            <label class="label">Email</label>
                            <input class="input--style-4" id="email" name="email">
                            <span class="error" id="er-email" style="color: red;font-size: 10px"><%=message%></span>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="input-group">
                            <label class="label">Số điện thoại</label>
                            <input class="input--style-4" id="phone" name="phone_number">
                            <span class="error" id="er-phone" style="color: red;font-size: 10px"></span>
                        </div>
                    </div>
                </div>
                <div class="row row-space">
                    <div class="col-6">
                        <div class="input-group">
                            <label class="label">Mật khẩu</label>
                            <input class="input--style-4" type="password" name="password" id="pass">
                            <span class="error" id="er-pass" style="color: red;font-size: 10px"></span>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="input-group">
                            <label class="label">Nhập lại mật khẩu</label>
                            <input class="input--style-4" type="password" name="re-password" id="re-pass">
                            <span class="error" id="er-re-pass" style="color: red;font-size: 10px"></span>
                        </div>
                    </div>
                </div>

                <div class="row row-space">
                    <div class="form-group">
                        <label for="provinceSelect">Chọn Tỉnh/ Thành Phố:</label>
                        <select name="tinhThanh" style="height: 100%
    " class="form-control" id="provinceSelect" onchange="loadDistricts()">
                            <option value="">Chọn Tỉnh/ Thành Phố</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="districtSelect">Chọn Huyện:</label>
                        <select name="huyen" style="height: 100%
    " class="form-control" id="districtSelect" onchange="loadWards()">
                            <option value="">Chọn Huyện</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="wardSelect">Chọn Xã:</label>
                        <select name="xa" style="height: 100%
    " class="form-control" id="wardSelect">
                            <option value="">Chọn Xã</option>
                        </select>
                    </div>
                    <%--                    <input class="input--style-4" type="text" name="address"--%>
                    <%--                           style="width: 100%;margin-left: 15px;margin-right: 15px" id="address">--%>
                    <%--                    <span class="error" id="er-address"--%>
                    <%--                          style="color: red;font-size: 10px;margin-top: 5px;padding-left: 10px"></span>--%>
                </div>
                <br>
                <br>
                <div class="g-recaptcha" data-sitekey="6LcZpdcpAAAAAC2ZB7LeRbXmpF0u3yImAdVuxnJC"></div>
                <div style="color: red" id="captchaError"></div>
                <div class="btn btn--radius-2 btn--blue pt-2"
                     style="width: 100%;background-color: #3868cd;margin-top: 20px">
                    <button id="onSubmit" value="Register" type="submit" onclick="checkCaptcha()">Đăng ký</button>
                </div>
            </form>
            <% List<String> errors = (List<String>) request.getAttribute("errors");
                if (errors != null && !errors.isEmpty()) {
                    for (String error : errors) {
            %>
            <h4 style="background: transparent"><%= error%>
            </h4>
            <%
                    }
                }%>
        </div>
    </div>
</div>
<script type="text/javascript">
    function checkCaptcha() {
        var form = document.getElementById("login-form");
        var captchaError = document.getElementById("captchaError");
        const response = grecaptcha.getResponse();
        if (response) {
            form.submit();
        } else {
            captchaError.textContent = "Vui lòng xác thực reCAPTCHA!";
        }
    }
</script>
<script>
    window.onload = function () {
        loadData('ProvinceServlet', 'provinceSelect', 'name_with_type');
    };

    function loadData(servletName, selectId, textProperty) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", servletName, true);
        xhr.onload = function () {
            if (xhr.status >= 200 && xhr.status < 300) {
                try {
                    const data = JSON.parse(xhr.responseText);
                    if (Array.isArray(data)) {
                        populateDropdown(selectId, data, textProperty);
                    } else {
                        console.error('Expected an array but got: ', data);
                    }
                } catch (e) {
                    console.error('Failed to parse JSON: ', e);
                }
            } else {
                console.error('Failed to fetch data: ', xhr.statusText);
            }
        };
        xhr.onerror = function () {
            console.error('Request error.');
        };
        xhr.send();
    }

    function populateDropdown(selectId, data, textProperty) {
        let select = document.getElementById(selectId);
        select.innerHTML = `<option value="">Chọn Tỉnh/ Thành Phố ${selectId.replace('Select', '')}</option>`; // Reset
        data.forEach(item => {
            let option = new Option(item[textProperty], item.code);
            select.appendChild(option);
        });
    }

    function loadDistricts() {
        const provinceCode = document.getElementById('provinceSelect').value;
        if (provinceCode) {
            loadData('DistrictServlet?provinceCode=' + provinceCode, 'districtSelect', 'name_with_type');
        }
    }

    function loadWards() {
        const districtCode = document.getElementById('districtSelect').value;
        if (districtCode) {
            loadData('WardServlet?districtCode=' + districtCode, 'wardSelect', 'name_with_type');
        }
    }

</script>
<%@include file="/common/footer.jsp" %>
<%@include file="/common/libraries_js.jsp" %>
<script src="../resources/libs/datepicker/zebra_datepicker.min.js"></script>
<script src="../resources/libs/datepicker/zebra_datepicker.src.js"></script>
<script src="../resources/js/user/datepicker.js"></script>
</body>
</html>
