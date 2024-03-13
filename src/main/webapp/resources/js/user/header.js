
function header() {
    document.write(`
    <header>
    <div class="main-header" style="background-color: white">
        <div class="container">
            <div class="row">
                <div class="col-6 col-xs-6 col-sm-6 col-md-3 col-lg-3 order-md-0 order-0">
                    <div class="logo">
                        <a href="./index.html"><img src="./images/logo.png" alt=""></a>
                        <h1>Website bán hàng</h1>
                    </div>
                </div>
                <div class="col-12 col-xs-12 col-sm-12 col-md-6 col-lg-6 order-md-1 order-2">
                    <div class="form-seach-product">
                        <form> <!-- Mở thẻ form ở đây -->
                            <div class="input-seach">
                                <input type="text" name="s" id="" class="form-control"
                                       placeholder="Nhập tên điện thoại cần tìm">
                                <button type="submit" class="btn-search-pro"><i class="fa fa-search"></i></button>
                            </div>
                        </form>
                        <div class="clearfix"></div> <!-- Đã thay đổi class để clear float -->
                    </div>
                </div>
                <div class="col-6 col-xs-6 col-sm-6 col-md-3 col-lg-3 order-md-2 order-1"
                     style="text-align: right; display: flex;">
                    <a style="display: flex;flex-direction: column" href="./cart_giohang.html" class="icon-cart">
                        <div class="icon">
                            <i class="fa fa-shopping-cart" aria-hidden="true" style="color: #808089"></i>
                            <span>3</span>
                        </div>
                        <div style="width: 80px;text-align: center" class="info-cart">
                            <p id="gioHang"
                               style="color: #808089;font-weight: 400;font-size: 14px;line-height: 150%;background-color: unset">
                                Giỏ hàng</p>
                        </div>
                    </a>
                    <a style="display: flex;flex-direction: column" href="./profile.html" class="icon-cart" onclick="">
                        <div class="icon">
                            <i class="fa fa-user" aria-hidden="true" style="color: #808089"></i>
                        </div>
                        <div style="width: 80px;text-align: center" class="info-cart ">
                            <p id="taiKhoan"
                               style="color: #808089;font-weight: 400;font-size: 14px;line-height: 150%;background-color: unset">
                                Tài Khoản</p>
                        </div>
                    </a>
                    <span class="clear"></span>
                    </a>

                </div>
            </div>
        </div>
    </div> 
    `);
}
function menuHeader() {
    document.write(`
    <div class="main-menu-header">
    <div class="container">
    <div id="nav-menu">
        <ul>
            <li><a href="index.html">Trang chủ</a></li>
            <li><a href="gioiThieu.html">Giới Thiệu</a></li>
            <li>
            <a href="#">Sản phẩm</a>
            <ul>
                <li><a href="#">Sản Phẩm Mới Ra Mắt</a></li>
                <li><a href="#">Sản Phẩm Đang Khuyễn Mãi</a></li>
                <li><a href="#">Sản Phẩm Giảm Giá</a></li>
            </ul>
        </li>
        <li><a href="news.html">Tin tức</a></li>
        <li><a href="contacts.html">Liên hệ</a></li>
<!--        <li><a href="./viewAdmin/user.html">Quản trị</a></li>-->
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
`)
}