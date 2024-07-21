<%@ page import="model.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderProductVariant" %>
<%@ page import="service.NumberUtils" %>
<%@ page import="config.URLConfig" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-21
  Time: 5:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%  List<OrderProductVariant> listor = (List<OrderProductVariant>) request.getAttribute("order_Account");
    String message = (String) session.getAttribute("message");
    Boolean status = (Boolean) session.getAttribute("status");
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <link href="https://cdn.datatables.net/v/bs4-4.6.0/jq-3.7.0/dt-2.0.8/datatables.min.css" rel="stylesheet">
    <meta charset="utf-8">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.1.0/css/dataTables.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.1.0/js/dataTables.min.js">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đơn hàng</title>
    <link href="../resources/libs/datepicker/daterangepicker.css" rel="stylesheet" media="all">
    <link rel="stylesheet" href="../resources/css/user/profile.css">
    <link href="../resources/css/user/main.css" rel="stylesheet" media="all">
    <%@include file="/common/libraries.jsp" %>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/v/bs4-4.6.0/jq-3.7.0/dt-2.0.8/datatables.min.css" rel="stylesheet">

    <script src="https://cdn.datatables.net/v/bs4-4.6.0/jq-3.7.0/dt-2.0.8/datatables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
    <link href="https://cdn.datatables.net/v/bs4-4.6.0/jq-3.7.0/dt-2.0.8/datatables.min.css" rel="stylesheet">
<%--    toast--%>
    <link href="${pageContext.request.contextPath}/resources/css/user/toast.css" rel="stylesheet" media="all">
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
<%@include file="/common/header.jsp" %>
<div class="container" style="margin-bottom: 30px;">
    <div style="margin-top: 20px;" class="table-responsive">
        <table id="table_inventory" class="table text-center">
            <thead class="text-uppercase bg-primary">
            <tr class="text-white">
                <th scope="col">ID</th>
                <th scope="col">Tên sản phẩm</th>
                <th scope="col">Hình ảnh</th>
                <th scope="col">Màu sắc</th>
                <th scope="col">Dung lượng</th>
                <th scope="col">Số lượng</th>
                <th scope="col">Giá tiền</th>
                <th scope="col">Trạng thái đơn hàng</th>
                <th scope="col">Hành động</th>
            </tr>
            </thead>
            <tbody>
            <% for (OrderProductVariant o : listor) { %>
            <tr>
                <td><%= o.getId() %></td>
                <td><%= o.getProductVariant().getProduct().getName() %></td>
                <td>
                    <img
                            src="${pageContext.request.contextPath}/<%= URLConfig.URL_SAVE_IMAGE %>/<%= o.getProductVariant().getProductImages().get(0).getImage_url() %>"
                            class="img-fluid rounded-3"
                            alt="Shopping item"
                            style="width: 85px; margin: 12px 7px; border: 0.5px solid gainsboro; padding: 1px;"
                    />
                </td>
                <td><%= o.getProductVariant().getColor().getName() %></td>
                <td><%= o.getProductVariant().getCapacity().getName() %></td>
                <td><%= o.getQuantity() %></td>
                <td><%= NumberUtils.formatNumberWithCommas(o.getProductVariant().getPrice()) %></td>
                <td>
                    <%
                        int statuss = o.getStatus();
                        String statusText;
                        switch (statuss) {
                            case 0:
                                statusText = "Đã hủy";
                                break;
                            case 1:
                                statusText = "Đơn hàng đang đợi duyệt";
                                break;
                            case 2:
                                statusText = "Đang chuẩn bị hàng";
                                break;
                            case 3:
                                statusText = "Đã gửi cho đơn vị vận chuyển";
                                break;
                            case 4:
                                statusText = "Đã đến kho gần bạn";
                                break;
                            case 5:
                                statusText = "Shipper đang giao hàng";
                                break;
                            case 6:
                                statusText = "Đã giao hàng thành công";
                                break;
                            default:
                                statusText = "Không xác định";
                        }
                    %>
                    <%= statusText %>
                </td>

                <td style="display: flex; justify-content: space-around;">
                    <button class="reviewButton btn btn-primary" data-status="<%=o.getStatus()%>" data-id="<%= o.getProductVariant().getProduct().getId() %>" type="button" data-toggle="modal" data-target="#reviewModal<%= o.getProductVariant().getProduct().getId() %>">
                        Đánh giá
                    </button>

                    <div class="modal fade" id="reviewModal<%= o.getProductVariant().getProduct().getId() %>" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true" style="margin-top: 100px">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="reviewModalLabel">Đánh giá sản phẩm</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="${pageContext.request.contextPath}/user/rate" method="post">
                                        <input name="status" value="<%=o.getStatus()%>" type="hidden">
                                        <input name="id" value="<%=o.getProductVariant().getProduct().getId()%>" type="hidden">
                                        <label>Nhận xét</label>
                                        <input type="text" name="comment" placeholder="Nhận xét của bạn" class="form-control" required><br>
                                        <label>Chất lượng sản phẩm ở mức nào?</label>
                                        <select name="star" id="star">
                                            <option value="1">1 sao</option>
                                            <option value="2">2 sao</option>
                                            <option value="3">3 sao</option>
                                            <option value="4">4 sao</option>
                                            <option value="5">5 sao</option>
                                        </select> <br>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                            <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                  <a href="/user/cancel_order?id=<%=o.getId()%>"><button class="btn btn-danger cancel-order" data-status="<%=o.getStatus()%>" data-id="<%= o.getId() %>">Hủy đơn</button></a>
                    <a href="${pageContext.request.contextPath}/product-detail?id=<%=o.getProductVariant().getProduct().getId()%>">
                        <button class="btn btn-primary" type="button" style="margin-left: 5px;">Mua lại</button>
                    </a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>




    </div>
</div>


<%@include file="/common/footer.jsp" %>
<%@include file="/common/libraries_js.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    new DataTable('#table_inventory');
</script>
<script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var reviewButtons = document.querySelectorAll('.reviewButton');
        var cancelButtons = document.querySelectorAll('.cancel-order');
        reviewButtons.forEach(function(button) {
            var status = parseInt(button.getAttribute('data-status'), 10);
            if (status !== 6) {
                button.disabled = true;

            }
        });
        cancelButtons.forEach(function(button) {
            var status = parseInt(button.getAttribute('data-status'), 10);
            if (status === 6) {
                button.disabled = true;
            }
        });
    });
</script>



</body>
</html>