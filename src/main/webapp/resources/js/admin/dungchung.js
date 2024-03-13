document.addEventListener('DOMContentLoaded', function () {
    var modal = document.getElementById('orderDetailModal');
    var btns = document.getElementsByClassName('view-detail-btn');
    var span = document.getElementsByClassName('close')[0];

    Array.from(btns).forEach(function(btn) {
        btn.onclick = function() {
            var orderId = this.getAttribute('data-order-id');
            // Bạn có thể thêm mã AJAX ở đây để lấy thông tin chi tiết dựa trên orderId
            document.getElementById('orderDetails').innerHTML = 'Thông tin chi tiết cho đơn hàng #' + orderId;
            modal.style.display = "block";
        }
    });

    // span.onclick = function() {
    //     modal.style.display = "none";
    // }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});
