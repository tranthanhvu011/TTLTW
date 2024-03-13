<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-29
  Time: 3:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="sidebar-menu">
    <div class="sidebar-header">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/admin/revenue-statistics"
               style="color: white; font-size: 30px;">NHÓM 4 </a>
        </div>
    </div>
    <div class="main-menu">
        <div class="menu-inner">
            <nav>
                <ul class="metismenu" id="menu">
                    <li>
                        <a href="javascript:void(0)" aria-expanded="true"> <span>
                                    Hệ thống </span>
                        </a>
                        <ul class="collapse">
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/user/manage_user">
                                    <span>Quản Lý Tài Khoản </span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/revenue-statistics"
                           aria-expanded="true"> <span>
                                    Thống Kê Doanh Thu </span>
                        </a>

                    </li>

                    <li>
                        <a href="javascript:void(0)" aria-expanded="true">
                            <span>Liên hệ / Đơn hàng</span>
                        </a>
                        <ul class="collapse">
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/manage_order">
                                    <span>Đơn hàng</span>
                                </a>
                            </li>

                            <li>
                                <a href="${pageContext.request.contextPath}/admin/contacts/manage_contacts">
                                    <span>Liên hệ</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="javascript:void(0)" aria-expanded="true">
                            <span>Sản phẩm</span>
                        </a>
                        <ul class="collapse">
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/product/manage_product">
                                    <span>Quản lý sản phẩm</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/product/add_product">
                                    <span>Thêm sản phẩm</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/manage_manufacturer">
                                    <span>Quản lý hãng sản xuất</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/manage_warranty">
                                    <span>Quản lý chính sách bảo hành</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/manage_discount">
                                    <span>Quản lý giảm giá</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/manage_color">
                                    <span>Quản lý màu sắc</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/manage_capacity">
                                    <span>Quản lý dung lượng</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/manage-news" aria-expanded="true"> <span>
                                  Tin tức   </span>
                        </a>

                    </li>


                </ul>
            </nav>
        </div>
    </div>
</div>