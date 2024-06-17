<%@ page import="java.util.Properties" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.io.*" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-21
  Time: 5:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gioi thieu</title>
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
<div class="conteiner">
    <div id="wallpaper">
        <div class="GioiThieu">
            <div class="container">
                <img style="width: 30%;" src="../resources/assets/images/THANHVU.png" alt="">
                <div class="page-info">
                    <p style="font-weight: 500;">Được thành lập năm 2023 nhờ đội ngủ trẻ đa tài nhóm 4 bao gốm Nguyễn
                        Như
                        Toàn, Nguyễn Quốc Trung, Trần Thanh Vũ
                        3 thành viên này đã sáng lập ra 1 thương hiệu điện thoại với sức sáng tạo phải gọi là trên cả
                        tuyệt
                        vời !
                        Trong môn học Lập Trình Web thì 3 bạn nãy đã nghỉ ra ý tưởng là mình sẽ tạo ra 1 cái web bán
                        điện
                        thoại và
                        dùng nó để phát triển 1 công ty riêng mang tên Nhóm 4 Phone Store !
                        Ngày 17/11/2007 bắt đầu khởi chạy trang web mang tên <a href="">${pageContext.request.contextPath}/view/home.jsp</a> chuyên mua
                        bán
                        tất cả các thể loại điện thoại giá thị trường từ thấp đến cao
                        và tất cả các hãng sản xuất liên quan đến điện thoại !
                        Và sau đó là 1 câu chuyện, 1 lịch sữ, 1 huyền thoại mang tên <a href="">${pageContext.request.contextPath}/view/home.jsp</a> được
                        ra
                        đời.
                        Vương tầm quốc tế cùng với 3 nhà sáng lập trẻ. Sự phát triển vượt bật trong nền kinh tết mới của
                        Việt Nam
                    </p>
                    <img style="display: block; margin-left: auto; margin-right: auto; width: 30%;"
                         src="../resources/assets/images/NHUTOAN.png"
                         alt="Nguyễn Như Toàn">
                    <p style="font-weight: 500;">
                        Lĩnh vực hoạt động chính của công ty bao gồm: mua bán sửa chữa các thiết bị liên quan đến điện
                        thoại
                        di động, thiết bị kỹ thuật số và các lĩnh vực liên quan đến thương mại điện tử.Bằng trải nghiệm
                        về
                        thị trường điện thoại di động từ đầu những năm 1990, cùng với việc nghiên cứu kỹ tập quán mua
                        hàng
                        của khách hàng Việt Nam, nhom4store.com đã xây dựng một phương thức kinh doanh chưa từng có ở
                        Việt
                        Nam trước đây. Công ty đã xây dựng được một phong cách tư vấn bán hàng đặc biệt nhờ vào một đội
                        ngũ
                        nhân viên chuyên nghiệp và trang web www.nhom4store.com hỗ trợ như là một cẩm nang về điện thoại
                        di
                        động và một kênh thương mại điện tử hàng đầu tại Việt Nam.Hiện nay, số lượng điện thoại bán ra
                        trung
                        bình tại nhom4store.com khoảng 300.000 máy/tháng chiếm khoảng 15% thị phần điện thoại chính hãng
                        cả
                        nước. Trung bình một tháng bán ra hơn 10.000 laptop trở thành Nhà bán lẻ bán ra số lượng laptop
                        lớn
                        nhất cả nước.Việc bán hàng qua mạng và giao hàng tận nhà trên phạm vi toàn quốc đã được triển
                        khai
                        từ đầu năm 2007, hiện nay lượng khách hàng mua laptop thông qua website www.nhom4store.com và
                        tổng
                        đài 1900.561.292 đã tăng lên đáng kể, trung bình 5.000 - 6.000 đơn hàng mỗi tháng. Đây là một
                        kênh
                        bán hàng tiềm năng và là một công cụ hữu hiệu giúp các khách hàng ở những khu vực xa mua được
                        một
                        sản phẩm ưng ý khi không có điều kiện xem trực tiếp sản phẩm.www.nhom4store.com là website
                        thương
                        mại điện tử lớn nhất Việt Nam với số lượng truy cập hơn 1.200.000 lượt ngày, cung cấp thông tin
                        chi
                        tiết về giá cả, tính năng kĩ thuật của hơn 500 model điện thoại và 200 model laptop của tất cả
                        các
                        nhãn hiệu chính thức tại Việt Nam.
                        nhom4store.com đã nhận được nhiều giải thưởng do người tiêu dùng cũng như các đối tác bình chọn
                        trong nhiều năm liền.
                    </p>
                    <img style="display: block; margin-left: auto; margin-right: 0; width: 33%;"
                         src="../resources/assets/images/trung.png"
                         alt="Nguyễn Quốc Trung">
                    <p>nhom4store.com đã nhận được nhiều giải thưởng do người tiêu dùng cũng như các đối tác bình chọn
                        trong
                        nhiều năm liền. Một số giải thưởng tiêu biểu:
                    <ul>
                        <li> - <em>500 nhà bán lẻ hàng đầu Châu Á - Thái Bình Dương 2010</em></li>
                        <li> - <em>Top 500 Fast VietNam 2010 (nhom4store.com nằm trong top 4)</em></li>
                        <li> - <em>Nhà bán lẻ được tín nhiệm nhất 4 năm liên tiếp 2007, 2008, 2009, 2010 (Vietnam Mobile
                            Awards)</em></li>
                        <li> - <em>Nhà bán lẻ điện thoại di động có đa dạng mặt hàng nhất</em></li>
                        <li> - <em>Nhà bán lẻ ĐTDĐ chăm sóc và hỗ trợ khách hàng tốt nhất</em></li>
                        <li> - <em>Giải thưởng thương hiệu nổi tiếng tại Việt Nam năm 2008 theo nhận biết của người tiêu
                            dùng do Phòng thương mại và công nghiệp Việt Nam cấp</em></li>
                        <li> - <em>Giải thưởng nhà bán lẻ của năm do báo PCWord Việt Nam tổ chức</em></li>
                        <li> - <em>Các bằng khen, chứng nhận của các cơ quan chính quyền trao tặng</em></li>
                    </ul>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="fb-root"></div>
<%@include file="/common/footer.jsp"%>
<script async defer crossorigin="anonymous"
        src="https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v6.0"></script>
<script src="../resources/js/user/main.js"></script>
<%@include file="/common/libraries_js.jsp"%>
</body>
</html>
