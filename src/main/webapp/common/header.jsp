<%@ page import="model.Cart" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-22
  Time: 5:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%Cart cart = (Cart) session.getAttribute("cart");
if (cart==null) cart = new Cart();
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header>
    <%
        String lang = "vi"; // Ngôn ngữ mặc định
        if (session.getAttribute("lang") != null) {
            lang = (String) session.getAttribute("lang");
        }
        request.setAttribute("javax.servlet.jsp.jstl.fmt.locale.request", lang);
    %>
    <script>
        var contextPath = "${pageContext.request.contextPath}";
        $(document).ready(function () {
            $('#autocomplete').autocomplete({
                source: '${pageContext.request.contextPath}/autocomplete',
                select: function (event, ui) {
                    //$( "#autocomplete" ).val( ui.item.id + ' - ' +  ui.item.name);
                    return false;
                }
            })
                .autocomplete("instance")._renderItem = function (ul, item) {
                return $("<li style='background-color: white; width: 420px;'>")
                    .append("<div><a style='color: black;' href='${pageContext.request.contextPath}/product-detail?id=" + item.id + " '> <img src='" + contextPath + "/resources/assets/images/thumball/" + item.thumbnail_url + "' height='50' width='50'> &nbsp;" + item.name + " </a></div>")
                    .appendTo(ul);
            };
        });

    </script>
    <div class="main-header" style="background-color: white">

        <div class="container">
            <div class="row">
                <div class="col-6 col-xs-6 col-sm-5 col-md-3 col-lg-3 order-md-0 order-0">
                    <div class="logo">
                        <a href="${pageContext.request.contextPath}/home"><img src="../resources/assets/images/logo.png" alt=""></a>
                        <fmt:setLocale value="${lang}" scope="session" />
                        <fmt:bundle basename="messages">
                            <h1>
                                <fmt:message key="website" /></h1>
                        </fmt:bundle>
                    </div>
                </div>
                <div class="col-12 col-xs-12 col-sm-12 col-md-6 col-lg-6 order-md-1 order-2">
                    <div class="form-seach-product">
                        <form> <!-- Mở thẻ form ở đây -->
                            <div class="input-seach">
                                <input id="autocomplete" class="form-control"
                                       placeholder="Nhập tên điện thoại cần tìm">
                                <button type="submit" class="btn-search-pro" style="display: flex;margin-left: 0;align-items: center;justify-content: center;"><i class="fa fa-search"></i></button>
                            </div>
                        </form>
                        <div class="clearfix"></div> <!-- Đã thay đổi class để clear float -->
                    </div>
                </div>
                <div class="col-6 col-xs-6 col-sm-6 col-md-3 col-lg-3 order-md-2 order-1"
                     style="text-align: right; display: flex; align-items: flex-end; right: 0;">
                    <a style="display: flex;flex-direction: column"
                       href="${pageContext.request.contextPath}/cart?action=view-cart" class="icon-cart">
                        <div class="icon">
                            <i class="fa fa-shopping-cart" aria-hidden="true" style="color: #808089; font-size: 20px;"></i>
                            <span id="quantity-cart"><%=cart.getTotal()%></span>
                        </div>
                        <div style="width: 80px;text-align: center" class="info-cart">
                            <fmt:setLocale value="${lang}" scope="session" />
                            <fmt:bundle basename="messages">
                                <p id="gioHang" style="color: #808089; font-weight: 400; font-size: 14px; line-height: 150%; background-color: unset">
                                    <fmt:message key="cart" /></p>
                            </fmt:bundle>
                        </div>
                    </a>
                    <a style="display: flex; flex-direction: column"
                       href="${pageContext.request.contextPath}/user/info-account" class="icon-cart">
                        <div class="icon">
                            <i class="fa fa-user" aria-hidden="true" style="color: #808089; font-size: 20px"></i>
                        </div>
                        <%
                            String accountName = (String) session.getAttribute("nameAccount");
                        %>
                        <div style="width: 80px; text-align: center" class="info-cart">
                            <% if (accountName == null) { %>

                            <fmt:setLocale value="${lang}" scope="session" />
                            <fmt:bundle basename="messages">
                                <p  style="color: #808089; font-weight: 400; font-size: 14px; line-height: 150%; background-color: unset">
                                    <fmt:message key="account" /></p>
                            </fmt:bundle>
                            <% } else { %>
                            <p id="taiKhoan"
                               style="color: #808089; font-weight: 400; font-size: 14px; line-height: 150%; background-color: unset">
                                <%=accountName%>
                            </p>
                            <% } %>
                        </div>
                    </a>
                    <a style="display: flex;flex-direction: column"
                       href="${pageContext.request.contextPath}/home?lang=en" class="icon-cart">
                        <div class="icon">
                           <img style="width: 20px; height: 20px " src="../resources/assets/icon/5619782.png">
                        </div>
                        <div style="width: 80px;text-align: center" class="info-cart">
                            <p id="english"
                               style="color: #808089;font-weight: 400;font-size: 14px;line-height: 150%;background-color: unset">
                                English</p>
                        </div>
                    </a>
                    <a style="display: flex;flex-direction: column"
                       href="${pageContext.request.contextPath}/home?lang=vi" class="icon-cart">
                        <div class="icon">
                            <img style="width: 20px; height: 20px " src="../resources/assets/icon/323319.png">
                        </div>
                        <div style="width: 80px;text-align: center" class="info-cart">
                            <fmt:setLocale value="${lang}" scope="session" />
                            <fmt:bundle basename="messages">
                                <p  id="vietnamese" style="color: #808089; font-weight: 400; font-size: 14px; line-height: 150%; background-color: unset">
                                    <fmt:message key="language" /></p>
                            </fmt:bundle>
                        </div>
                    </a>
                </div>

            </div>

        </div>
    </div>
    <div class="main-menu-header">
        <div class="container">
            <div id="nav-menu">
                <ul>
                    <li>
                        <fmt:setLocale value="${lang}" scope="session" />
                        <fmt:bundle basename="messages">
                            <a href="/home" >
                                <fmt:message key="home" /></a>
                        </fmt:bundle>
                    <li>
                    <fmt:setLocale value="${lang}" scope="session" />
                    <fmt:bundle basename="messages">
                        <a href="${pageContext.request.contextPath}/view/introduce.jsp">
                            <fmt:message key="introduce" /></a>
                    </fmt:bundle>
                </li>
                    <li>
                        <fmt:setLocale value="${lang}" scope="session" />
                        <fmt:bundle basename="messages">
                            <a>
                                <fmt:message key="product" /></a>
                        </fmt:bundle>
                        <ul>
                            <li>
                                <fmt:setLocale value="${lang}" scope="session" />
                                <fmt:bundle basename="messages">
                                    <a>
                                        <fmt:message key="newproductlaunch" /></a>
                                </fmt:bundle>
                            </li>
                            <li>
                                <fmt:setLocale value="${lang}" scope="session" />
                                <fmt:bundle basename="messages">
                                    <a>
                                        <fmt:message key="promotionalproducts" /></a>
                                </fmt:bundle>
                            </li>
                            <li>  <fmt:setLocale value="${lang}" scope="session" />
                                <fmt:bundle basename="messages">
                                    <a>
                                        <fmt:message key="discountproducts" /></a>
                                </fmt:bundle></li>
                        </ul>
                    </li>
                    <li>
                        <fmt:setLocale value="${lang}" scope="session" />
                        <fmt:bundle basename="messages">
                            <a href="${pageContext.request.contextPath}/page/news">
                                <fmt:message key="news" /></a>
                        </fmt:bundle>
                      </li>
                    <li>
                        <fmt:setLocale value="${lang}" scope="session" />
                        <fmt:bundle basename="messages">
                            <a href="${pageContext.request.contextPath}/view/contact.jsp">
                                <fmt:message key="contact"/></a>
                        </fmt:bundle>
                    </li>
                </ul>
                <div class="clear"></div>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
            const currentPath = window.location.pathname.split('/').pop();
            const menuItems = document.querySelectorAll('#nav-menu ul li a');

            menuItems.forEach(item => {
                if (item.getAttribute('href') === currentPath) {
                    menuItems.forEach(el => el.parentElement.classList.remove('current-menu-item'));

                    item.parentElement.classList.add('current-menu-item');
                }
            });
        });
    </script>

</header>
