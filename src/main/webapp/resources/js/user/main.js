jQuery(document).ready(function ($) {
    $('.bar-menu').click(function (event) {
        $(this).next('.list-child').slideToggle(300);
    });
});

jQuery(document).ready(function ($) {
    var tongSanPham = $('#product-container .item-product').length;
    var soSanPhamTrenTrang = 16;
    var tongSoTrang = Math.ceil(tongSanPham / soSanPhamTrenTrang);
    var trangHienTai = 1;
    var pagination = $('#pagination');
    var trangBatDauHienThi = 1; // Trang bắt đầu hiển thị
    var soTrangHienThi = 10; // Số trang tối đa để hiển thị
    function phanTrang() {
        var html = '';
        var classTrangHienTai = '';
        if (tongSoTrang > 1) {
            html += '<li class="page-item"><a class="page-link trang-truoc" href="#">Trang trước</a></li>';
            for (let i = 1; i <= tongSoTrang; i++) {
                if (trangHienTai == i) {
                    classTrangHienTai = 'active';
                } else {
                    classTrangHienTai = '';
                }
                html += '<li class="page-item ' + classTrangHienTai + '"><a class="page-link chon-trang" data-page="' + i + '" href="#">' + i + '</a></li>';
            }
            html += '<li class="page-item"><a class="page-link trang-sau" href="#">Trang sau</a></li>';
            pagination.find('.pagination').append(html);
        } else {
            pagination.hide();
        }
    }

    phanTrang();
    hienThiSoSanPhamTrenTrang(trangHienTai);
    $(document).on('click', '.chon-trang', function (e) {
        e.preventDefault();
        var self = $(this);
        var soTrang = self.data('page');
        trangHienTai = soTrang;
        self.closest('.page-item').addClass('active').siblings().removeClass('active');
        hienThiSoSanPhamTrenTrang(trangHienTai);
        $('html, body').animate({scrollTop: $(".product-box").offset().top}, '600');
    });

    $(document).on('click', '.trang-truoc', function (e) {
        e.preventDefault();
        var self = $(this);
        if (trangHienTai - 1 < 1) {
            alert('Bạn đang ở trang đầu tiên');
        } else {
            trangHienTai--;
            pagination.find('[data-page="' + trangHienTai + '"]').closest('.page-item').addClass('active').siblings().removeClass('active');
            hienThiSoSanPhamTrenTrang(trangHienTai);
            $('html, body').animate({scrollTop: 0}, '600'); // Thêm dòng này

        }
    });

    $(document).on('click', '.trang-sau', function (e) {
        e.preventDefault();
        var self = $(this);
        if (trangHienTai + 1 > tongSoTrang) {
            alert('Bạn đang ở trang cuối cùng');
        } else {
            trangHienTai++;
            pagination.find('[data-page="' + trangHienTai + '"]').closest('.page-item').addClass('active').siblings().removeClass('active');
            hienThiSoSanPhamTrenTrang(trangHienTai);
            $('html, body').animate({scrollTop: 0}, '600'); // Thêm dòng này

        }
    });

    function hienThiSoSanPhamTrenTrang(soTrang) {
        var dauTrang = (trangHienTai - 1) * soSanPhamTrenTrang;
        $.each($('#product-container .item-product'), function (i, index) {
            if (i >= dauTrang && i < (dauTrang + soSanPhamTrenTrang)) {
                $(index).closest('.col-xs-12').show();
            } else {
                $(index).closest('.col-xs-12').hide();
            }
        });
    }

    hienThiSoSanPhamTrenTrang(1);
    $('.bar-menu').click(function (event) {
        $(this).next('.list-child').slideToggle(300);
    });
});

function customQuantity(quantity) {
    if (quantity === "") {
        return 125;
    } else {
        return (parseInt(quantity));
    }
}


function customSale(price, origin_price) {
    var vPrice = customQuantity(price);
    var vOPrice = customQuantity(origin_price);
    return parseInt(`${100 - ((vPrice * 100) / vOPrice)}`);
}

