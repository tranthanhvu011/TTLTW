function footer() {
    document.write(`
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                    <div class="box-footer info-contact">
                        <h3 class="white_16_500">Thông tin liên hệ</h3>
                    <div class="content-contact">
                        <p class="white_13_400" style="font-size: 17px">Website chuyên cung cấp thiết bị điện tử hàng đầu Việt Nam</p>
                        <p>
                            <strong class="white_13_400">Địa chỉ:</strong> 203 Linh Trung, Thủ Đức, Tp.HCM
                        </p>
                        <p>
                            <strong class="white_13_400">Email: </strong> nhom41store@gmail.com
                        </p>
                        <p>
                            <strong class="white_13_400">Điện thoại: </strong> 0836452145
                        </p>
                        <p>
                            <strong class="white_13_400">Website: </strong> https://nhom41store.com
                        </p>
                    </div>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                    <div class="box-footer info-contact">
                        <h3 class="white_16_500">Thông tin khác</h3>
                        <div class="content-list">
                            <ul>
                                <li><a href="#"><i class="fa fa-angle-double-right"></i> Chính sách bảo hành</a></li>
                                <li><a href="#"><i class="fa fa-angle-double-right"></i> Chính sách đổi trả</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                    <div class="box-footer info-contact">
                        <h3 class="white_16_500">THÔNG TIN PHẢN HỒI</h3>
                        <div class="content-contact">
                            <form action="/" method="GET" role="form">
                                <div class="row">
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <input type="text" name="" id="full_name" class="form-control" placeholder="Họ và Tên">
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
                                    <input type="email" name="" id="email_report" class="form-control" placeholder="Địa chỉ mail">
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-6">
                                    <input type="text" name="" id="phone_report" class="form-control" placeholder="Số điện thoại">
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <input type="text" name="" id="title_report" class="form-control" placeholder="Tiêu đề">
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <textarea name="" id="submit_form" cols="30" rows="10" class="form-control"></textarea>
                                </div>
                            </div>
                                <button type="submit" class="btn-contact">Liên hệ ngay</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </footer>
`)
}