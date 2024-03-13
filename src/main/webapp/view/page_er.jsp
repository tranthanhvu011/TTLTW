<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-23
  Time: 3:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông Báo Chưa Đăng Nhập</title>
    <style>
        body {
            font-family: 'Inter', 'Helvetica', 'Arial', sans-serif;
        }

        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        #dialog {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }

        #dialog img {
            width: 50px;
            height: 50px;
            margin-bottom: 15px;
        }

        #dialog p {
            color: red;
            font-size: 16px;
        }

        #buttons {
            margin-top: 20px;
        }

        button {
            padding: 10px 20px;
            margin: 0 10px;
            cursor: pointer;
        }

        #loginBtn {
            background-color: green;
            color: white;
        }

        #cancelBtn {
            background-color: grey;
            color: white;
        }
    </style>
</head>
<body>

<div id="overlay">
    <div id="dialog">
        <img src="../resources/assets/images/error.jpg" alt="Notification Image">
        <p>Bạn chưa đăng nhập!</p>
        <div id="buttons">
            <button id="loginBtn" onclick="redirectToLogin()">OK</button>
            <button id="cancelBtn" onclick="redirectToHome()">Cancel</button>
        </div>
    </div>
</div>

<script>
    function showOverlay() {
        document.getElementById('overlay').style.display = 'flex';
    }

    function hideOverlay() {
        document.getElementById('overlay').style.display = 'none';
    }

    function redirectToLogin() {
    }

    function redirectToHome() {
        window.location.href = 'index.html';
    }
</script>

<!-- Kích hoạt hiển thị dialog khi trang web được tải -->
<script>
    window.onload = showOverlay;
</script>

</body>
</html>
