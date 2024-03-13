<%@ page import="java.util.List" %>
<%@ page import="model.CartProduct" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Cart" %>
<%@ page import="java.util.Map" %>
<%@ page import="service.NumberUtils" %>
<%@ page import="model.Account" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 1/20/2024
  Time: 12:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) cart = new Cart();
    List<Integer> listID = (List<Integer>) session.getAttribute("selectedProductIds");
    Account account = (Account) session.getAttribute("account");

%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%--<h2><%=account.getEmail()%></h2>--%>
<%--<h2><%=account.getAddress()%></h2>--%>
<%--<h2><%=account.getId()%></h2>--%>
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
%>
<h2><%=cartProduct.getProductVariant().getId()%></h2>
<h2><%=cartProduct.getProductVariant().getProduct().getName()%></h2>
<h2><%=NumberUtils.formatNumberWithCommas(cartProduct.getProductVariant().getPrice())%></h2>
<h2><%=cartProduct.getProductVariant().getColor().getName()%></h2>
<!-- Hiển thị các thông tin khác của sản phẩm nếu cần -->
<%
        }
    }
} else {
    // Hiển thị thông báo nếu danh sách ID rỗng
%>
<h2>No selected products</h2>
<%
    }
%>


</body>
</html>
