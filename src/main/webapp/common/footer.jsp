<%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-22
  Time: 5:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<footer>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <div class="box-footer info-contact">
                    <fmt:setLocale value="${lang}" scope="session" />
                    <fmt:bundle basename="messages">
                    <h3 class="white_16_500"><fmt:message key="CONTACTINFO"/></h3>
                    <div class="content-contact">
                        <p class="white_13_400" style="font-size: 17px"><fmt:message key="WebsitespecializinginprovidingleadingelectronicequipmentinVietnam"/></p>
                        <p>
                            <strong class="white_13_400"><fmt:message key="Address"/>: </strong> 203 Linh Trung, Thủ Đức, Tp.HCM
                        </p>
                        <p>
                            <strong class="white_13_400">Email: </strong> nhom4store@gmail.com
                        </p>
                        <p>
                            <strong class="white_13_400"><fmt:message key="Phone"/>: </strong> 0836452145
                        </p>
                        <p>
                            <strong class="white_13_400">Website: </strong> https://nhom4store.com
                        </p>


                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <div class="box-footer info-contact">
                    <h3 class="white_16_500"><fmt:message key="OTHERINFORMATION"/></h3>
                    <div class="content-list">
                        <ul>
                            <li><a href="#"><i class="fa fa-angle-double-right"></i> <fmt:message key="WarrantyPolicy"/></a></li>
                            <li><a href="#"><i class="fa fa-angle-double-right"></i> <fmt:message key="Returnpolicy"/></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <div class="box-footer info-contact">
                    <h3 class="white_16_500"><fmt:message key="FEEDBACK"/></h3>
                    <div class="content-contact">
                        <form action="/" method="GET" role="form">
                            <div class="row">
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <input type="text" name="" id="full_name" class="form-control" placeholder="Họ và Tên" style="color: white;">
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
                                    <input type="email" name="" id="email" class="form-control" placeholder="Địa chỉ mail" style="color: white">
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
                                    <input type="text" name="" id="phone" class="form-control" placeholder="Số điện thoại" style="color: white">
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <input type="text" name="" id="title_report" class="form-control" placeholder="Tiêu đề" style="color: white" >
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <textarea name="" id="submit_form" cols="30" rows="10" class="form-control" style="color: white"></textarea>
                                </div>

                            </div>
                            <button type="submit" class="btn-contact"><fmt:message key="Contactnow"/></button>
                            </fmt:bundle>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>
