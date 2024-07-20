<%@ page import="java.util.List" %>
<%@ page import="model.Contacts" %>
<%@ page import="dao.ContactsDAO" %>
<%@ page import="dao.ProductDeltailDAO" %>
<%@ page import="com.google.gson.JsonArray" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="modelDB.ProductDB" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-29
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!doctype html>
<html class="no-js" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Bình luận Sản Phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/common/admin_library_css.jsp" %>
    <link href="${pageContext.request.contextPath}/resources/css/admin/model.css" rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath}/resources/libs/datepicker/css/bootstrap/zebra_datepicker.css"
          rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath}/resources/libs/datepicker/css/bootstrap/zebra_datepicker.min.css"
          rel="stylesheet" media="all">
    <link href="${pageContext.request.contextPath}/resources/css/user/toast.css" rel="stylesheet" media="all">
    <%@include file="/common/libraries.jsp" %>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/v/bs4-4.6.0/jq-3.7.0/dt-2.0.8/datatables.min.css" rel="stylesheet">

    <script src="https://cdn.datatables.net/v/bs4-4.6.0/jq-3.7.0/dt-2.0.8/datatables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
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
    .modal {
        display: none; /* Ẩn modal mặc định */
        position: fixed; /* Cố định modal */
        z-index: 1; /* Hiển thị trên cùng */
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgb(0,0,0); /* Màu nền đen với độ mờ */
        background-color: rgba(0,0,0,0.4); /* Độ mờ */
    }

    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 500px;
        text-align: center;
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    .modal-buttons {
        margin-top: 20px;
    }

    .btn {
        padding: 10px 20px;
        border: none;
        cursor: pointer;
    }

    .btn-danger {
        background-color: #d9534f;
        color: white;
    }

    .btn-secondary {
        background-color: #6c757d;
        color: white;
    }
</style>
<body>
<div id="preloader">
    <div class="loader">
    </div>
</div>
<% String message = (String) session.getAttribute("message");
    Boolean status = true;%>
<!-- Toast -->
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
                            <li><a href="${pageContext.request.contextPath}/admin/revenue-statistics">Home</a></li>
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
                            NHÓM 41 <i class="fa fa-angle-down"></i>
                        </h4>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="#">Message</a> <a
                                class="dropdown-item" href="${base }/login">Log Out</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br>
        <br>
        <br>
        <% ProductDeltailDAO productDeltailDAO = new ProductDeltailDAO();
            JSONArray jsonArray = productDeltailDAO.getAllCommentProduct();


        %>
        <div class="single-table" style="width: 100%; margin: 0 auto">
            <table id="example" class="table table-striped table-bordered" style="width: 100%">
                <thead >
                <tr>
                    <th scope="col">Tên Người Bình Luận </th>
                    <th scope="col">Số Điện Thoại Liên Hệ</th>
                    <th style="width: 30%" scope="col">Nội Dung</th>
                    <th scope="col">Thời Gian Bình Luận</th>
                    <th scope="col">Sản Phẩm Bình Luận</th>
                    <th scope="col">Phê Duyệt</th>
                    <th scope="col">Hành Động</th>
                    <th scope="col">Trả lời</th>
                    <th scope="col">Hành Động</th>
                </tr>
                </thead>
                <tbody>
                <%     for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject jsonObject = jsonArray.getJSONObject(i);
                %>
                <tr>
                    <td><%= jsonObject.optString("nameComment", "")%></td>
                    <td><%= jsonObject.optString("phoneNumber", "")%></td>
                    <td>
                        <textarea style="width: 100%"><%= jsonObject.optString("content", "")%> </textarea>
                    </td>
                    <td>
                        <%= jsonObject.optString("timestamp", "")%>
                    </td>
                    <td>
                        <% ProductDAO productDAO = new ProductDAO();
                        ProductDB nameProduct = productDAO.findProductById(jsonObject.optInt("idProduct"));%>
                        <%= nameProduct.getName()%></td>
                    <td><% if (jsonObject.optInt("isActive") == 1) {%>
                    Đã Duyệt
                    <% }else{%>
                    Chưa Duyệt
                    <% } %>
                    <td>
                    <% if (jsonObject.optInt("isActive") == 1) {%>
                    <button type="button" class="btn btn-warning" onclick="showModal('notActive', <%=jsonObject.optInt("id")%>, <%=jsonObject.optInt("idProduct")%>)">
                        Tắt Phê Duyệt
                    </button>
                    <% }else{%>
                    <button type="button" class="btn btn-success" onclick="showModal('active', <%=jsonObject.optInt("id")%>, <%=jsonObject.optInt("idProduct")%>)">
                        Phê Duyệt
                    </button>
                    <% } %>
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary" onclick="showReplyModal(<%=jsonObject.optInt("id")%>, <%=jsonObject.optInt("idProduct")%>)">
                            Trả Lời
                        </button>
                    </td>
                    <td>
                        <button type="button" class="btn btn-danger" onclick="showModal('delete', <%=jsonObject.optInt("id")%>, <%=jsonObject.optInt("idProduct")%>)">
                            Xóa Bình Luận
                        </button>

                    </td>
                    <% }%>
                </tr>
                </tbody>
            </table>
        </div>
        <!-- Modal dialog cho trả lời -->
        <div id="replyModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeReplyModal()">&times;</span>
                <p>Trả lời bình luận</p>
                <form id="replyForm" method="post" action="${pageContext.request.contextPath}/admin/manage_comment_product_detail?action=reply">
                    <div class="form-group">
                        <label>Họ và tên quản trị viên</label>
                        <input type="text" class="form-control" name="nameQTV" aria-describedby="emailHelp" placeholder="Họ và tên quản trị viên">
                    </div>
                    <div class="form-group">
                    <textarea id="replyContent" name="replyContent" rows="4" cols="60"></textarea>
                    <input type="hidden" id="replyCommentId" name="idComment">
                    <input type="hidden" id="replyProductId" name="idProduct">
                    </div>
                    <div class="modal-buttons">
                        <button type="submit" class="btn btn-primary">Gửi</button>
                        <button type="button" class="btn btn-secondary" onclick="closeReplyModal()">Hủy</button>
                    </div>
                </form>
            </div>
        </div>
        <div id="confirmModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <p id="modalMessage">Bạn có chắc chắn muốn thực hiện hành động này?</p>
                <div class="modal-buttons">
                    <button id="confirmBtn" class="btn btn-danger">Xác Nhận</button>
                    <button class="btn btn-secondary" onclick="closeModal()">Hủy</button>
                </div>
            </div>
        </div>
        <script>
            function showModal(action, idComment, idProduct) {
                var modal = document.getElementById("confirmModal");
                var modalMessage = document.getElementById("modalMessage");
                var confirmBtn = document.getElementById("confirmBtn");

                if (action === 'delete') {
                    modalMessage.textContent = "Bạn có chắc chắn muốn xóa bình luận này?";
                    confirmBtn.className = "btn btn-danger";
                    confirmBtn.textContent = "Xóa";
                    confirmBtn.onclick = function() {
                        window.location.href = "${pageContext.request.contextPath}/admin/manage_comment_product_detail?action=delete&id=" + idComment + "&idProduct=" + idProduct;
                    };
                } else if (action === 'active') {
                    modalMessage.textContent = "Bạn có chắc chắn muốn phê duyệt bình luận này?";
                    confirmBtn.className = "btn btn-success";
                    confirmBtn.textContent = "Duyệt";
                    confirmBtn.onclick = function() {
                        window.location.href = "${pageContext.request.contextPath}/admin/manage_comment_product_detail?action=active&id=" + idComment + "&idProduct=" + idProduct;
                    };
                }else if (action === 'notActive') {
                    modalMessage.textContent = "Bạn có chắc chắn muốn tắt phê duyệt bình luận này?";
                    confirmBtn.className = "btn btn-warning";
                    confirmBtn.textContent = "Duyệt";
                    confirmBtn.onclick = function() {
                        window.location.href = "${pageContext.request.contextPath}/admin/manage_comment_product_detail?action=notActive&id=" + idComment + "&idProduct=" + idProduct;
                    };
                }
                modal.style.display = "block";
            }
            // Hiển thị modal trả lời
            function showReplyModal(idComment, idProduct) {
                var modal = document.getElementById("replyModal");
                document.getElementById("replyCommentId").value = idComment;
                document.getElementById("replyProductId").value = idProduct;
                modal.style.display = "block";
            }
            function closeReplyModal() {
                var modal = document.getElementById("replyModal");
                modal.style.display = "none";
            }


            function closeModal() {
                var modal = document.getElementById("confirmModal");
                modal.style.display = "none";
            }

            window.onclick = function(event) {
                var modal = document.getElementById("confirmModal");
                var replyModal = document.getElementById("replyModal");
                if (event.target == modal) {
                    modal.style.display = "none";
                }
                if (event.target == replyModal) {
                    replyModal.style.display = "none";
                }
            }
        </script>
        <script>
            new DataTable('#example');
        </script>
        <!-- Paging -->
        <div class="row">
            <div class="col-12 d-flex justify-content-center">
                <div id="paging"></div>
            </div>
        </div>
        </form>

    </div>
    <%@include file="/common/admin_footer.jsp" %>
</div>
<%@include file="/common/admin_library_js.jsp" %>


</body>


</html>

