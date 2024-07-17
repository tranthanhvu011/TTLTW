<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-21
  Time: 5:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập</title>
    <link href="../resources/libs/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="../resources/css/user/main.css" rel="stylesheet" media="all">
    <link rel="stylesheet" href="../resources/css/admin/default-css.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,300i,400,400i,500,500i">
    <link rel="stylesheet" href="../resources/libs/bootstrap-4.6.2-dist/css/bootstrap-grid.min.css">
    <link rel="stylesheet" href="../resources/libs/bootstrap-4.6.2-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/libs/bootstrap-4.6.2-dist/css/bootstrap-reboot.min.css">
    <link rel="stylesheet" href="../resources/libs/fontawesome-free-6.4.2-web/css/fontawesome.min.css">
    <link rel="stylesheet" href="../resources/libs/fontawesome-free-6.4.2-web/css/all.min.css">
    <link rel="stylesheet" href="../resources/libs/fontawesome-free-6.4.2-web/css/brands.min.css">
    <link rel="stylesheet" href="../resources/libs/fontawesome-free-6.4.2-web/css/regular.min.css">
    <link rel="stylesheet" href="../resources/libs/fontawesome-free-6.4.2-web/css/solid.min.css">
    <link rel="stylesheet" href="../resources/css/user/responsive.css">
    <link rel="stylesheet" href="../resources/css/user/mainheader.css">
    <link rel="stylesheet" href="../resources/css/user/fontstyle.css">
    <link href="${pageContext.request.contextPath}/resources/css/user/toast.css" rel="stylesheet" media="all">
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
</style>
<% String count =(String)  session.getAttribute("countLoginFaild");

%>
<body>
<%@include file="/common/header.jsp" %>
<%
    String error = (String) request.getAttribute("error") == null ? "" : (String) request.getAttribute("error");
    String message = (String) session.getAttribute("message");
    Boolean status = (Boolean) session.getAttribute("status");
    String notLoginMessage = (String) request.getAttribute("notLogin");
%>
<% if (notLoginMessage != null && !notLoginMessage.isEmpty()) {%>
<div class="toast">
    <div class="toast-content">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
             class="bi bi-exclamation-circle-fill" viewBox="0 0 20 20">
            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4m.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2"/>
        </svg>
        <div class="message">
            <span class="text text-1 text-danger">Thất bại</span>
            <span class="text text-2 text-danger"><%= notLoginMessage %></span>
        </div>
    </div>
    <i class="fa-solid fa-xmark close"></i>
    <div class="progress"></div>
</div>
<%} else if (status != null && status) {%>
<div class="toast">
    <div class="toast-content">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-check-circle"
             viewBox="0 0 20 20">
            <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
            <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05"/>
        </svg>
        <div class="message">
            <span class="text text-1" style="color: greenyellow">Thành công</span>
            <span class="text text-2" style="color: greenyellow"><%= message %></span>
        </div>
    </div>
    <i class="fa-solid fa-xmark close"></i>
    <div class="progress"></div>
</div>
<%} else if (message != null) {%>
<div class="toast">
    <div class="toast-content">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
             class="bi bi-exclamation-circle-fill" viewBox="0 0 20 20">
            <path d="M16 8A8 8 0 1 1 0 8 a8 8 0 0 1 16 0M8 4 a.905.905 0 0 0-.9.995 l.35 3.507 a.552.552 0 0 0 1.1 0 l.35-3.507 A.905.905 0 0 0 8 4 m.002 6 a1 1 0 1 0 0 2 1 1 0 0 0 0-2"/>
        </svg>
        <div class="message">
            <span class="text text-1 text-danger">Thất bại</span>
            <span class="text text-2 text-danger"><%= message %></span>
        </div>
    </div>
    <i class="fa-solid fa-xmark close"></i>
    <div class="progress"></div>
</div>
<%}%>
<script src="${pageContext.request.contextPath}/resources/js/user/toast.js"></script>
<%if (message != null || notLoginMessage != null) {%>
<script>
    showToast();
    setTimeout(() => document.querySelector(".toast").style.display = "none", 5000);
</script>
<%
    session.removeAttribute("message");
    session.removeAttribute("status");
%>
<%}%>

<div class="container" style="margin-bottom: 50px;margin-top: 50px">
    <div class="card card-4" style="width: 550px">
        <div class="card-body">
            <fmt:setLocale value="${lang}" scope="session" />
            <fmt:bundle basename="messages">
            <h2 class="title" style="background-color: white"><fmt:message key="Login"/></h2>
            <form id="login-form" method="post" action="${pageContext.request.contextPath}/login">
                <div class="row row-space">

                    <div class="input-group" style="width: 100%">
                        <label class="label"><fmt:message key="username"/></label>
                        <input class="input--style-4" type="text" name="email" id="email" required>
                    </div>
                </div>
                <div class="row row-space">
                    <div class="input-group" style="width: 100%">
                        <label class="label"><fmt:message key="Password"/></label>
                        <input class="input--style-4 mb-1" type="password" id="pass" name="password" required
                               style="width: 100%">
                        <span class="error" id="er-login" style="color: red;font-size: 13px"><%=error%></span>
                    </div>
                </div>
                <input type="hidden" id="myAddress" name="myAddress" value="0">
                <div class="g-recaptcha" data-sitekey="6LcZpdcpAAAAAC2ZB7LeRbXmpF0u3yImAdVuxnJC"></div>
                <div style="color: red" id="captchaError"></div>
                <div class="forgot-password" style="width: 100%;margin-bottom: 15px">
                    <a href="${pageContext.request.contextPath}/forgot_password?action=forgot_password" class="txt1"><fmt:message key="Forgotpassword"/></a>
                </div>
                <div class="p-t-15">
                    <button class="btn btn--radius-2 btn--blue" type="button" onclick="checkCaptcha()" onclick="find()" style="width: 100%"><fmt:message key="Login"/></button>
                </div>
            </form>
            <% List<String> errorMessage = (List<String>) request.getAttribute("errors");
                if (errorMessage != null) {
                    for (String eString : errorMessage) {
            %>
            <h4 style="background: transparent"><%=eString%></h4>
            <%
                    }
                }%>
            <div>
                <div class="row-space" style="display: flex;align-items: center;padding-bottom: 14px;margin-top: 25px">
                    <div class="line"></div>
                    <span class="txt1" style="margin: 0px 20px 0px 20px;color: #dbdbdb"><fmt:message key="Or"/></span>
                    <div class="line"></div>
                </div>
                <div class="row" style="margin-top: 20px;justify-content: space-between">
                    <div class="col-4">
                        <button class="btn-face m-b-20" id="facebook">
                            <i class="fa fa-facebook-official"></i>
                            Facebook
                        </button>
                    </div>
                    <div class="col-4">
<%--                        <button href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/LoginGoogleHandle&response_type=code&client_id=477605457331-8ljhvdmosltg10etjnj7rd5ltjn43j5f.apps.googleusercontent.com&approval_prompt=force" class="btn-google m-b-20" id="google">--%>
<%--                            Google--%>
<%--                        </button>--%>
    <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/LoginGoogleHandle&response_type=code&client_id=477605457331-8ljhvdmosltg10etjnj7rd5ltjn43j5f.apps.googleusercontent.com&approval_prompt=force">
        <img style="width: 50%" src="../resources/assets/icon/google_icon.png" alt="GOOGLE"></a>
                    </div>
                </div>
            </div>
            <div class="p-t-55" style="width: 100%">
                <span class="txt1" style="float: unset;font-size: 16px"><fmt:message key="Donothaveanaccount?Registernow"/></span>
                <a href="${pageContext.request.contextPath}/register?action=register" class="txt1"
                   style="float: unset;font-size: 16px;text-decoration: underline"><fmt:message key="Registernow"/>
                    </a>
            </div>
            </fmt:bundle>
        </div>
    </div>
</div>
<script type="text/javascript">
    function checkCaptcha(){
        var form = document.getElementById("login-form");
        var captchaError = document.getElementById("captchaError");
        const response = grecaptcha.getResponse();
        if(response){
            form.submit();
        } else{
            captchaError.textContent = "Vui lòng xác thực reCAPTCHA!";
        }
    }
</script>
<script>
    const http = new XMLHttpRequest();
    const bdcAPI = 'https://api.bigdatacloud.net/data/reverse-geocode-client';
    var myAddr = document.getElementById('myAddress');
    function findMyAddress(){
        http.open("GET", bdcAPI);
        http.send();
        http.onreadystatechange = function (){
            if (this.readyState == 4 && this.status == 200){
            const results = JSON.parse(this.responseText);
            myAddr.value = results.locality + ', ' + results.city;
            }
        }
    }

</script>
<%@include file="/common/footer.jsp" %>
<%@include file="/common/libraries_js.jsp" %>
</body>
</html>
